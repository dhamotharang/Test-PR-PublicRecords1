IMPORT SALT39,STD;
EXPORT NAC_hygiene(dataset(NAC_layout_NAC) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_SearchAddress1StreetAddress1_cnt := COUNT(GROUP,h.SearchAddress1StreetAddress1 <> (TYPEOF(h.SearchAddress1StreetAddress1))'');
    populated_SearchAddress1StreetAddress1_pcnt := AVE(GROUP,IF(h.SearchAddress1StreetAddress1 = (TYPEOF(h.SearchAddress1StreetAddress1))'',0,100));
    maxlength_SearchAddress1StreetAddress1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1StreetAddress1)));
    avelength_SearchAddress1StreetAddress1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1StreetAddress1)),h.SearchAddress1StreetAddress1<>(typeof(h.SearchAddress1StreetAddress1))'');
    populated_SearchAddress1StreetAddress2_cnt := COUNT(GROUP,h.SearchAddress1StreetAddress2 <> (TYPEOF(h.SearchAddress1StreetAddress2))'');
    populated_SearchAddress1StreetAddress2_pcnt := AVE(GROUP,IF(h.SearchAddress1StreetAddress2 = (TYPEOF(h.SearchAddress1StreetAddress2))'',0,100));
    maxlength_SearchAddress1StreetAddress2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1StreetAddress2)));
    avelength_SearchAddress1StreetAddress2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1StreetAddress2)),h.SearchAddress1StreetAddress2<>(typeof(h.SearchAddress1StreetAddress2))'');
    populated_SearchAddress1City_cnt := COUNT(GROUP,h.SearchAddress1City <> (TYPEOF(h.SearchAddress1City))'');
    populated_SearchAddress1City_pcnt := AVE(GROUP,IF(h.SearchAddress1City = (TYPEOF(h.SearchAddress1City))'',0,100));
    maxlength_SearchAddress1City := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1City)));
    avelength_SearchAddress1City := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1City)),h.SearchAddress1City<>(typeof(h.SearchAddress1City))'');
    populated_SearchAddress1State_cnt := COUNT(GROUP,h.SearchAddress1State <> (TYPEOF(h.SearchAddress1State))'');
    populated_SearchAddress1State_pcnt := AVE(GROUP,IF(h.SearchAddress1State = (TYPEOF(h.SearchAddress1State))'',0,100));
    maxlength_SearchAddress1State := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1State)));
    avelength_SearchAddress1State := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1State)),h.SearchAddress1State<>(typeof(h.SearchAddress1State))'');
    populated_SearchAddress1Zip_cnt := COUNT(GROUP,h.SearchAddress1Zip <> (TYPEOF(h.SearchAddress1Zip))'');
    populated_SearchAddress1Zip_pcnt := AVE(GROUP,IF(h.SearchAddress1Zip = (TYPEOF(h.SearchAddress1Zip))'',0,100));
    maxlength_SearchAddress1Zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1Zip)));
    avelength_SearchAddress1Zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress1Zip)),h.SearchAddress1Zip<>(typeof(h.SearchAddress1Zip))'');
    populated_SearchAddress2StreetAddress1_cnt := COUNT(GROUP,h.SearchAddress2StreetAddress1 <> (TYPEOF(h.SearchAddress2StreetAddress1))'');
    populated_SearchAddress2StreetAddress1_pcnt := AVE(GROUP,IF(h.SearchAddress2StreetAddress1 = (TYPEOF(h.SearchAddress2StreetAddress1))'',0,100));
    maxlength_SearchAddress2StreetAddress1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2StreetAddress1)));
    avelength_SearchAddress2StreetAddress1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2StreetAddress1)),h.SearchAddress2StreetAddress1<>(typeof(h.SearchAddress2StreetAddress1))'');
    populated_SearchAddress2StreetAddress2_cnt := COUNT(GROUP,h.SearchAddress2StreetAddress2 <> (TYPEOF(h.SearchAddress2StreetAddress2))'');
    populated_SearchAddress2StreetAddress2_pcnt := AVE(GROUP,IF(h.SearchAddress2StreetAddress2 = (TYPEOF(h.SearchAddress2StreetAddress2))'',0,100));
    maxlength_SearchAddress2StreetAddress2 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2StreetAddress2)));
    avelength_SearchAddress2StreetAddress2 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2StreetAddress2)),h.SearchAddress2StreetAddress2<>(typeof(h.SearchAddress2StreetAddress2))'');
    populated_SearchAddress2City_cnt := COUNT(GROUP,h.SearchAddress2City <> (TYPEOF(h.SearchAddress2City))'');
    populated_SearchAddress2City_pcnt := AVE(GROUP,IF(h.SearchAddress2City = (TYPEOF(h.SearchAddress2City))'',0,100));
    maxlength_SearchAddress2City := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2City)));
    avelength_SearchAddress2City := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2City)),h.SearchAddress2City<>(typeof(h.SearchAddress2City))'');
    populated_SearchAddress2State_cnt := COUNT(GROUP,h.SearchAddress2State <> (TYPEOF(h.SearchAddress2State))'');
    populated_SearchAddress2State_pcnt := AVE(GROUP,IF(h.SearchAddress2State = (TYPEOF(h.SearchAddress2State))'',0,100));
    maxlength_SearchAddress2State := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2State)));
    avelength_SearchAddress2State := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2State)),h.SearchAddress2State<>(typeof(h.SearchAddress2State))'');
    populated_SearchAddress2Zip_cnt := COUNT(GROUP,h.SearchAddress2Zip <> (TYPEOF(h.SearchAddress2Zip))'');
    populated_SearchAddress2Zip_pcnt := AVE(GROUP,IF(h.SearchAddress2Zip = (TYPEOF(h.SearchAddress2Zip))'',0,100));
    maxlength_SearchAddress2Zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2Zip)));
    avelength_SearchAddress2Zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchAddress2Zip)),h.SearchAddress2Zip<>(typeof(h.SearchAddress2Zip))'');
    populated_SearchCaseId_cnt := COUNT(GROUP,h.SearchCaseId <> (TYPEOF(h.SearchCaseId))'');
    populated_SearchCaseId_pcnt := AVE(GROUP,IF(h.SearchCaseId = (TYPEOF(h.SearchCaseId))'',0,100));
    maxlength_SearchCaseId := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchCaseId)));
    avelength_SearchCaseId := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SearchCaseId)),h.SearchCaseId<>(typeof(h.SearchCaseId))'');
    populated_enduserip_cnt := COUNT(GROUP,h.enduserip <> (TYPEOF(h.enduserip))'');
    populated_enduserip_pcnt := AVE(GROUP,IF(h.enduserip = (TYPEOF(h.enduserip))'',0,100));
    maxlength_enduserip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.enduserip)));
    avelength_enduserip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.enduserip)),h.enduserip<>(typeof(h.enduserip))'');
    populated_CaseID_cnt := COUNT(GROUP,h.CaseID <> (TYPEOF(h.CaseID))'');
    populated_CaseID_pcnt := AVE(GROUP,IF(h.CaseID = (TYPEOF(h.CaseID))'',0,100));
    maxlength_CaseID := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.CaseID)));
    avelength_CaseID := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.CaseID)),h.CaseID<>(typeof(h.CaseID))'');
    populated_ClientFirstName_cnt := COUNT(GROUP,h.ClientFirstName <> (TYPEOF(h.ClientFirstName))'');
    populated_ClientFirstName_pcnt := AVE(GROUP,IF(h.ClientFirstName = (TYPEOF(h.ClientFirstName))'',0,100));
    maxlength_ClientFirstName := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientFirstName)));
    avelength_ClientFirstName := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientFirstName)),h.ClientFirstName<>(typeof(h.ClientFirstName))'');
    populated_ClientMiddleName_cnt := COUNT(GROUP,h.ClientMiddleName <> (TYPEOF(h.ClientMiddleName))'');
    populated_ClientMiddleName_pcnt := AVE(GROUP,IF(h.ClientMiddleName = (TYPEOF(h.ClientMiddleName))'',0,100));
    maxlength_ClientMiddleName := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientMiddleName)));
    avelength_ClientMiddleName := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientMiddleName)),h.ClientMiddleName<>(typeof(h.ClientMiddleName))'');
    populated_ClientLastName_cnt := COUNT(GROUP,h.ClientLastName <> (TYPEOF(h.ClientLastName))'');
    populated_ClientLastName_pcnt := AVE(GROUP,IF(h.ClientLastName = (TYPEOF(h.ClientLastName))'',0,100));
    maxlength_ClientLastName := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientLastName)));
    avelength_ClientLastName := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientLastName)),h.ClientLastName<>(typeof(h.ClientLastName))'');
    populated_ClientPhone_cnt := COUNT(GROUP,h.ClientPhone <> (TYPEOF(h.ClientPhone))'');
    populated_ClientPhone_pcnt := AVE(GROUP,IF(h.ClientPhone = (TYPEOF(h.ClientPhone))'',0,100));
    maxlength_ClientPhone := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientPhone)));
    avelength_ClientPhone := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientPhone)),h.ClientPhone<>(typeof(h.ClientPhone))'');
    populated_ClientEmail_cnt := COUNT(GROUP,h.ClientEmail <> (TYPEOF(h.ClientEmail))'');
    populated_ClientEmail_pcnt := AVE(GROUP,IF(h.ClientEmail = (TYPEOF(h.ClientEmail))'',0,100));
    maxlength_ClientEmail := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientEmail)));
    avelength_ClientEmail := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ClientEmail)),h.ClientEmail<>(typeof(h.ClientEmail))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_SearchAddress1StreetAddress1_pcnt *   0.00 / 100 + T.Populated_SearchAddress1StreetAddress2_pcnt *   0.00 / 100 + T.Populated_SearchAddress1City_pcnt *   0.00 / 100 + T.Populated_SearchAddress1State_pcnt *   0.00 / 100 + T.Populated_SearchAddress1Zip_pcnt *   0.00 / 100 + T.Populated_SearchAddress2StreetAddress1_pcnt *   0.00 / 100 + T.Populated_SearchAddress2StreetAddress2_pcnt *   0.00 / 100 + T.Populated_SearchAddress2City_pcnt *   0.00 / 100 + T.Populated_SearchAddress2State_pcnt *   0.00 / 100 + T.Populated_SearchAddress2Zip_pcnt *   0.00 / 100 + T.Populated_SearchCaseId_pcnt *   0.00 / 100 + T.Populated_enduserip_pcnt *   0.00 / 100 + T.Populated_CaseID_pcnt *   0.00 / 100 + T.Populated_ClientFirstName_pcnt *   0.00 / 100 + T.Populated_ClientMiddleName_pcnt *   0.00 / 100 + T.Populated_ClientLastName_pcnt *   0.00 / 100 + T.Populated_ClientPhone_pcnt *   0.00 / 100 + T.Populated_ClientEmail_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'SearchAddress1StreetAddress1','SearchAddress1StreetAddress2','SearchAddress1City','SearchAddress1State','SearchAddress1Zip','SearchAddress2StreetAddress1','SearchAddress2StreetAddress2','SearchAddress2City','SearchAddress2State','SearchAddress2Zip','SearchCaseId','enduserip','CaseID','ClientFirstName','ClientMiddleName','ClientLastName','ClientPhone','ClientEmail');
  SELF.populated_pcnt := CHOOSE(C,le.populated_SearchAddress1StreetAddress1_pcnt,le.populated_SearchAddress1StreetAddress2_pcnt,le.populated_SearchAddress1City_pcnt,le.populated_SearchAddress1State_pcnt,le.populated_SearchAddress1Zip_pcnt,le.populated_SearchAddress2StreetAddress1_pcnt,le.populated_SearchAddress2StreetAddress2_pcnt,le.populated_SearchAddress2City_pcnt,le.populated_SearchAddress2State_pcnt,le.populated_SearchAddress2Zip_pcnt,le.populated_SearchCaseId_pcnt,le.populated_enduserip_pcnt,le.populated_CaseID_pcnt,le.populated_ClientFirstName_pcnt,le.populated_ClientMiddleName_pcnt,le.populated_ClientLastName_pcnt,le.populated_ClientPhone_pcnt,le.populated_ClientEmail_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_SearchAddress1StreetAddress1,le.maxlength_SearchAddress1StreetAddress2,le.maxlength_SearchAddress1City,le.maxlength_SearchAddress1State,le.maxlength_SearchAddress1Zip,le.maxlength_SearchAddress2StreetAddress1,le.maxlength_SearchAddress2StreetAddress2,le.maxlength_SearchAddress2City,le.maxlength_SearchAddress2State,le.maxlength_SearchAddress2Zip,le.maxlength_SearchCaseId,le.maxlength_enduserip,le.maxlength_CaseID,le.maxlength_ClientFirstName,le.maxlength_ClientMiddleName,le.maxlength_ClientLastName,le.maxlength_ClientPhone,le.maxlength_ClientEmail);
  SELF.avelength := CHOOSE(C,le.avelength_SearchAddress1StreetAddress1,le.avelength_SearchAddress1StreetAddress2,le.avelength_SearchAddress1City,le.avelength_SearchAddress1State,le.avelength_SearchAddress1Zip,le.avelength_SearchAddress2StreetAddress1,le.avelength_SearchAddress2StreetAddress2,le.avelength_SearchAddress2City,le.avelength_SearchAddress2State,le.avelength_SearchAddress2Zip,le.avelength_SearchCaseId,le.avelength_enduserip,le.avelength_CaseID,le.avelength_ClientFirstName,le.avelength_ClientMiddleName,le.avelength_ClientLastName,le.avelength_ClientPhone,le.avelength_ClientEmail);
END;
EXPORT invSummary := NORMALIZE(summary0, 18, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.SearchAddress1StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress1StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress1City),TRIM((SALT39.StrType)le.SearchAddress1State),TRIM((SALT39.StrType)le.SearchAddress1Zip),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress2City),TRIM((SALT39.StrType)le.SearchAddress2State),TRIM((SALT39.StrType)le.SearchAddress2Zip),TRIM((SALT39.StrType)le.SearchCaseId),TRIM((SALT39.StrType)le.enduserip),TRIM((SALT39.StrType)le.CaseID),TRIM((SALT39.StrType)le.ClientFirstName),TRIM((SALT39.StrType)le.ClientMiddleName),TRIM((SALT39.StrType)le.ClientLastName),TRIM((SALT39.StrType)le.ClientPhone),TRIM((SALT39.StrType)le.ClientEmail)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,18,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 18);
  SELF.FldNo2 := 1 + (C % 18);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.SearchAddress1StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress1StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress1City),TRIM((SALT39.StrType)le.SearchAddress1State),TRIM((SALT39.StrType)le.SearchAddress1Zip),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress2City),TRIM((SALT39.StrType)le.SearchAddress2State),TRIM((SALT39.StrType)le.SearchAddress2Zip),TRIM((SALT39.StrType)le.SearchCaseId),TRIM((SALT39.StrType)le.enduserip),TRIM((SALT39.StrType)le.CaseID),TRIM((SALT39.StrType)le.ClientFirstName),TRIM((SALT39.StrType)le.ClientMiddleName),TRIM((SALT39.StrType)le.ClientLastName),TRIM((SALT39.StrType)le.ClientPhone),TRIM((SALT39.StrType)le.ClientEmail)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.SearchAddress1StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress1StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress1City),TRIM((SALT39.StrType)le.SearchAddress1State),TRIM((SALT39.StrType)le.SearchAddress1Zip),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress1),TRIM((SALT39.StrType)le.SearchAddress2StreetAddress2),TRIM((SALT39.StrType)le.SearchAddress2City),TRIM((SALT39.StrType)le.SearchAddress2State),TRIM((SALT39.StrType)le.SearchAddress2Zip),TRIM((SALT39.StrType)le.SearchCaseId),TRIM((SALT39.StrType)le.enduserip),TRIM((SALT39.StrType)le.CaseID),TRIM((SALT39.StrType)le.ClientFirstName),TRIM((SALT39.StrType)le.ClientMiddleName),TRIM((SALT39.StrType)le.ClientLastName),TRIM((SALT39.StrType)le.ClientPhone),TRIM((SALT39.StrType)le.ClientEmail)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),18*18,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'SearchAddress1StreetAddress1'}
      ,{2,'SearchAddress1StreetAddress2'}
      ,{3,'SearchAddress1City'}
      ,{4,'SearchAddress1State'}
      ,{5,'SearchAddress1Zip'}
      ,{6,'SearchAddress2StreetAddress1'}
      ,{7,'SearchAddress2StreetAddress2'}
      ,{8,'SearchAddress2City'}
      ,{9,'SearchAddress2State'}
      ,{10,'SearchAddress2Zip'}
      ,{11,'SearchCaseId'}
      ,{12,'enduserip'}
      ,{13,'CaseID'}
      ,{14,'ClientFirstName'}
      ,{15,'ClientMiddleName'}
      ,{16,'ClientLastName'}
      ,{17,'ClientPhone'}
      ,{18,'ClientEmail'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    NAC_Fields.InValid_SearchAddress1StreetAddress1((SALT39.StrType)le.SearchAddress1StreetAddress1),
    NAC_Fields.InValid_SearchAddress1StreetAddress2((SALT39.StrType)le.SearchAddress1StreetAddress2),
    NAC_Fields.InValid_SearchAddress1City((SALT39.StrType)le.SearchAddress1City),
    NAC_Fields.InValid_SearchAddress1State((SALT39.StrType)le.SearchAddress1State),
    NAC_Fields.InValid_SearchAddress1Zip((SALT39.StrType)le.SearchAddress1Zip),
    NAC_Fields.InValid_SearchAddress2StreetAddress1((SALT39.StrType)le.SearchAddress2StreetAddress1),
    NAC_Fields.InValid_SearchAddress2StreetAddress2((SALT39.StrType)le.SearchAddress2StreetAddress2),
    NAC_Fields.InValid_SearchAddress2City((SALT39.StrType)le.SearchAddress2City),
    NAC_Fields.InValid_SearchAddress2State((SALT39.StrType)le.SearchAddress2State),
    NAC_Fields.InValid_SearchAddress2Zip((SALT39.StrType)le.SearchAddress2Zip),
    NAC_Fields.InValid_SearchCaseId((SALT39.StrType)le.SearchCaseId),
    NAC_Fields.InValid_enduserip((SALT39.StrType)le.enduserip),
    NAC_Fields.InValid_CaseID((SALT39.StrType)le.CaseID),
    NAC_Fields.InValid_ClientFirstName((SALT39.StrType)le.ClientFirstName),
    NAC_Fields.InValid_ClientMiddleName((SALT39.StrType)le.ClientMiddleName),
    NAC_Fields.InValid_ClientLastName((SALT39.StrType)le.ClientLastName),
    NAC_Fields.InValid_ClientPhone((SALT39.StrType)le.ClientPhone),
    NAC_Fields.InValid_ClientEmail((SALT39.StrType)le.ClientEmail),
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
  FieldNme := NAC_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_alphanumeric','invalid_ip','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_phone','invalid_email');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,NAC_Fields.InValidMessage_SearchAddress1StreetAddress1(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress1StreetAddress2(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress1City(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress1State(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress1Zip(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress2StreetAddress1(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress2StreetAddress2(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress2City(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress2State(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchAddress2Zip(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_SearchCaseId(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_enduserip(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_CaseID(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_ClientFirstName(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_ClientMiddleName(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_ClientLastName(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_ClientPhone(TotalErrors.ErrorNum),NAC_Fields.InValidMessage_ClientEmail(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, NAC_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
