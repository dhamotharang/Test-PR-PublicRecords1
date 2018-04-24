IMPORT SALT39,STD;
EXPORT InquiryLogs_hygiene(dataset(InquiryLogs_layout_InquiryLogs) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_Customer_Account_Number_cnt := COUNT(GROUP,h.Customer_Account_Number <> (TYPEOF(h.Customer_Account_Number))'');
    populated_Customer_Account_Number_pcnt := AVE(GROUP,IF(h.Customer_Account_Number = (TYPEOF(h.Customer_Account_Number))'',0,100));
    maxlength_Customer_Account_Number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Account_Number)));
    avelength_Customer_Account_Number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Account_Number)),h.Customer_Account_Number<>(typeof(h.Customer_Account_Number))'');
    populated_Customer_County_cnt := COUNT(GROUP,h.Customer_County <> (TYPEOF(h.Customer_County))'');
    populated_Customer_County_pcnt := AVE(GROUP,IF(h.Customer_County = (TYPEOF(h.Customer_County))'',0,100));
    maxlength_Customer_County := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_County)));
    avelength_Customer_County := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_County)),h.Customer_County<>(typeof(h.Customer_County))'');
    populated_Customer_State_cnt := COUNT(GROUP,h.Customer_State <> (TYPEOF(h.Customer_State))'');
    populated_Customer_State_pcnt := AVE(GROUP,IF(h.Customer_State = (TYPEOF(h.Customer_State))'',0,100));
    maxlength_Customer_State := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_State)));
    avelength_Customer_State := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_State)),h.Customer_State<>(typeof(h.Customer_State))'');
    populated_Customer_Agency_Vertical_Type_cnt := COUNT(GROUP,h.Customer_Agency_Vertical_Type <> (TYPEOF(h.Customer_Agency_Vertical_Type))'');
    populated_Customer_Agency_Vertical_Type_pcnt := AVE(GROUP,IF(h.Customer_Agency_Vertical_Type = (TYPEOF(h.Customer_Agency_Vertical_Type))'',0,100));
    maxlength_Customer_Agency_Vertical_Type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Agency_Vertical_Type)));
    avelength_Customer_Agency_Vertical_Type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Agency_Vertical_Type)),h.Customer_Agency_Vertical_Type<>(typeof(h.Customer_Agency_Vertical_Type))'');
    populated_Customer_Program_cnt := COUNT(GROUP,h.Customer_Program <> (TYPEOF(h.Customer_Program))'');
    populated_Customer_Program_pcnt := AVE(GROUP,IF(h.Customer_Program = (TYPEOF(h.Customer_Program))'',0,100));
    maxlength_Customer_Program := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Program)));
    avelength_Customer_Program := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Customer_Program)),h.Customer_Program<>(typeof(h.Customer_Program))'');
    populated_LexID_cnt := COUNT(GROUP,h.LexID <> (TYPEOF(h.LexID))'');
    populated_LexID_pcnt := AVE(GROUP,IF(h.LexID = (TYPEOF(h.LexID))'',0,100));
    maxlength_LexID := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.LexID)));
    avelength_LexID := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.LexID)),h.LexID<>(typeof(h.LexID))'');
    populated_raw_Full_Name_cnt := COUNT(GROUP,h.raw_Full_Name <> (TYPEOF(h.raw_Full_Name))'');
    populated_raw_Full_Name_pcnt := AVE(GROUP,IF(h.raw_Full_Name = (TYPEOF(h.raw_Full_Name))'',0,100));
    maxlength_raw_Full_Name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_Full_Name)));
    avelength_raw_Full_Name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_Full_Name)),h.raw_Full_Name<>(typeof(h.raw_Full_Name))'');
    populated_raw_First_name_cnt := COUNT(GROUP,h.raw_First_name <> (TYPEOF(h.raw_First_name))'');
    populated_raw_First_name_pcnt := AVE(GROUP,IF(h.raw_First_name = (TYPEOF(h.raw_First_name))'',0,100));
    maxlength_raw_First_name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_First_name)));
    avelength_raw_First_name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_First_name)),h.raw_First_name<>(typeof(h.raw_First_name))'');
    populated_raw_Last_Name_cnt := COUNT(GROUP,h.raw_Last_Name <> (TYPEOF(h.raw_Last_Name))'');
    populated_raw_Last_Name_pcnt := AVE(GROUP,IF(h.raw_Last_Name = (TYPEOF(h.raw_Last_Name))'',0,100));
    maxlength_raw_Last_Name := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_Last_Name)));
    avelength_raw_Last_Name := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.raw_Last_Name)),h.raw_Last_Name<>(typeof(h.raw_Last_Name))'');
    populated_SSN_cnt := COUNT(GROUP,h.SSN <> (TYPEOF(h.SSN))'');
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_Drivers_License_State_cnt := COUNT(GROUP,h.Drivers_License_State <> (TYPEOF(h.Drivers_License_State))'');
    populated_Drivers_License_State_pcnt := AVE(GROUP,IF(h.Drivers_License_State = (TYPEOF(h.Drivers_License_State))'',0,100));
    maxlength_Drivers_License_State := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Drivers_License_State)));
    avelength_Drivers_License_State := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Drivers_License_State)),h.Drivers_License_State<>(typeof(h.Drivers_License_State))'');
    populated_Drivers_License_Number_cnt := COUNT(GROUP,h.Drivers_License_Number <> (TYPEOF(h.Drivers_License_Number))'');
    populated_Drivers_License_Number_pcnt := AVE(GROUP,IF(h.Drivers_License_Number = (TYPEOF(h.Drivers_License_Number))'',0,100));
    maxlength_Drivers_License_Number := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Drivers_License_Number)));
    avelength_Drivers_License_Number := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Drivers_License_Number)),h.Drivers_License_Number<>(typeof(h.Drivers_License_Number))'');
    populated_Street_1_cnt := COUNT(GROUP,h.Street_1 <> (TYPEOF(h.Street_1))'');
    populated_Street_1_pcnt := AVE(GROUP,IF(h.Street_1 = (TYPEOF(h.Street_1))'',0,100));
    maxlength_Street_1 := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Street_1)));
    avelength_Street_1 := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Street_1)),h.Street_1<>(typeof(h.Street_1))'');
    populated_City_cnt := COUNT(GROUP,h.City <> (TYPEOF(h.City))'');
    populated_City_pcnt := AVE(GROUP,IF(h.City = (TYPEOF(h.City))'',0,100));
    maxlength_City := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.City)));
    avelength_City := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.City)),h.City<>(typeof(h.City))'');
    populated_State_cnt := COUNT(GROUP,h.State <> (TYPEOF(h.State))'');
    populated_State_pcnt := AVE(GROUP,IF(h.State = (TYPEOF(h.State))'',0,100));
    maxlength_State := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.State)));
    avelength_State := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.State)),h.State<>(typeof(h.State))'');
    populated_Zip_cnt := COUNT(GROUP,h.Zip <> (TYPEOF(h.Zip))'');
    populated_Zip_pcnt := AVE(GROUP,IF(h.Zip = (TYPEOF(h.Zip))'',0,100));
    maxlength_Zip := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.Zip)));
    avelength_Zip := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.Zip)),h.Zip<>(typeof(h.Zip))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.did)),h.did<>(typeof(h.did))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_Customer_Account_Number_pcnt *   0.00 / 100 + T.Populated_Customer_County_pcnt *   0.00 / 100 + T.Populated_Customer_State_pcnt *   0.00 / 100 + T.Populated_Customer_Agency_Vertical_Type_pcnt *   0.00 / 100 + T.Populated_Customer_Program_pcnt *   0.00 / 100 + T.Populated_LexID_pcnt *   0.00 / 100 + T.Populated_raw_Full_Name_pcnt *   0.00 / 100 + T.Populated_raw_First_name_pcnt *   0.00 / 100 + T.Populated_raw_Last_Name_pcnt *   0.00 / 100 + T.Populated_SSN_pcnt *   0.00 / 100 + T.Populated_Drivers_License_State_pcnt *   0.00 / 100 + T.Populated_Drivers_License_Number_pcnt *   0.00 / 100 + T.Populated_Street_1_pcnt *   0.00 / 100 + T.Populated_City_pcnt *   0.00 / 100 + T.Populated_State_pcnt *   0.00 / 100 + T.Populated_Zip_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'Customer_Account_Number','Customer_County','Customer_State','Customer_Agency_Vertical_Type','Customer_Program','LexID','raw_Full_Name','raw_First_name','raw_Last_Name','SSN','Drivers_License_State','Drivers_License_Number','Street_1','City','State','Zip','did');
  SELF.populated_pcnt := CHOOSE(C,le.populated_Customer_Account_Number_pcnt,le.populated_Customer_County_pcnt,le.populated_Customer_State_pcnt,le.populated_Customer_Agency_Vertical_Type_pcnt,le.populated_Customer_Program_pcnt,le.populated_LexID_pcnt,le.populated_raw_Full_Name_pcnt,le.populated_raw_First_name_pcnt,le.populated_raw_Last_Name_pcnt,le.populated_SSN_pcnt,le.populated_Drivers_License_State_pcnt,le.populated_Drivers_License_Number_pcnt,le.populated_Street_1_pcnt,le.populated_City_pcnt,le.populated_State_pcnt,le.populated_Zip_pcnt,le.populated_did_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_Customer_Account_Number,le.maxlength_Customer_County,le.maxlength_Customer_State,le.maxlength_Customer_Agency_Vertical_Type,le.maxlength_Customer_Program,le.maxlength_LexID,le.maxlength_raw_Full_Name,le.maxlength_raw_First_name,le.maxlength_raw_Last_Name,le.maxlength_SSN,le.maxlength_Drivers_License_State,le.maxlength_Drivers_License_Number,le.maxlength_Street_1,le.maxlength_City,le.maxlength_State,le.maxlength_Zip,le.maxlength_did);
  SELF.avelength := CHOOSE(C,le.avelength_Customer_Account_Number,le.avelength_Customer_County,le.avelength_Customer_State,le.avelength_Customer_Agency_Vertical_Type,le.avelength_Customer_Program,le.avelength_LexID,le.avelength_raw_Full_Name,le.avelength_raw_First_name,le.avelength_raw_Last_Name,le.avelength_SSN,le.avelength_Drivers_License_State,le.avelength_Drivers_License_Number,le.avelength_Street_1,le.avelength_City,le.avelength_State,le.avelength_Zip,le.avelength_did);
END;
EXPORT invSummary := NORMALIZE(summary0, 17, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.Customer_Account_Number),TRIM((SALT39.StrType)le.Customer_County),TRIM((SALT39.StrType)le.Customer_State),TRIM((SALT39.StrType)le.Customer_Agency_Vertical_Type),TRIM((SALT39.StrType)le.Customer_Program),IF (le.LexID <> 0,TRIM((SALT39.StrType)le.LexID), ''),TRIM((SALT39.StrType)le.raw_Full_Name),TRIM((SALT39.StrType)le.raw_First_name),TRIM((SALT39.StrType)le.raw_Last_Name),TRIM((SALT39.StrType)le.SSN),TRIM((SALT39.StrType)le.Drivers_License_State),TRIM((SALT39.StrType)le.Drivers_License_Number),TRIM((SALT39.StrType)le.Street_1),TRIM((SALT39.StrType)le.City),TRIM((SALT39.StrType)le.State),TRIM((SALT39.StrType)le.Zip),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,17,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 17);
  SELF.FldNo2 := 1 + (C % 17);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.Customer_Account_Number),TRIM((SALT39.StrType)le.Customer_County),TRIM((SALT39.StrType)le.Customer_State),TRIM((SALT39.StrType)le.Customer_Agency_Vertical_Type),TRIM((SALT39.StrType)le.Customer_Program),IF (le.LexID <> 0,TRIM((SALT39.StrType)le.LexID), ''),TRIM((SALT39.StrType)le.raw_Full_Name),TRIM((SALT39.StrType)le.raw_First_name),TRIM((SALT39.StrType)le.raw_Last_Name),TRIM((SALT39.StrType)le.SSN),TRIM((SALT39.StrType)le.Drivers_License_State),TRIM((SALT39.StrType)le.Drivers_License_Number),TRIM((SALT39.StrType)le.Street_1),TRIM((SALT39.StrType)le.City),TRIM((SALT39.StrType)le.State),TRIM((SALT39.StrType)le.Zip),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.Customer_Account_Number),TRIM((SALT39.StrType)le.Customer_County),TRIM((SALT39.StrType)le.Customer_State),TRIM((SALT39.StrType)le.Customer_Agency_Vertical_Type),TRIM((SALT39.StrType)le.Customer_Program),IF (le.LexID <> 0,TRIM((SALT39.StrType)le.LexID), ''),TRIM((SALT39.StrType)le.raw_Full_Name),TRIM((SALT39.StrType)le.raw_First_name),TRIM((SALT39.StrType)le.raw_Last_Name),TRIM((SALT39.StrType)le.SSN),TRIM((SALT39.StrType)le.Drivers_License_State),TRIM((SALT39.StrType)le.Drivers_License_Number),TRIM((SALT39.StrType)le.Street_1),TRIM((SALT39.StrType)le.City),TRIM((SALT39.StrType)le.State),TRIM((SALT39.StrType)le.Zip),IF (le.did <> 0,TRIM((SALT39.StrType)le.did), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),17*17,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'Customer_Account_Number'}
      ,{2,'Customer_County'}
      ,{3,'Customer_State'}
      ,{4,'Customer_Agency_Vertical_Type'}
      ,{5,'Customer_Program'}
      ,{6,'LexID'}
      ,{7,'raw_Full_Name'}
      ,{8,'raw_First_name'}
      ,{9,'raw_Last_Name'}
      ,{10,'SSN'}
      ,{11,'Drivers_License_State'}
      ,{12,'Drivers_License_Number'}
      ,{13,'Street_1'}
      ,{14,'City'}
      ,{15,'State'}
      ,{16,'Zip'}
      ,{17,'did'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    InquiryLogs_Fields.InValid_Customer_Account_Number((SALT39.StrType)le.Customer_Account_Number),
    InquiryLogs_Fields.InValid_Customer_County((SALT39.StrType)le.Customer_County),
    InquiryLogs_Fields.InValid_Customer_State((SALT39.StrType)le.Customer_State),
    InquiryLogs_Fields.InValid_Customer_Agency_Vertical_Type((SALT39.StrType)le.Customer_Agency_Vertical_Type),
    InquiryLogs_Fields.InValid_Customer_Program((SALT39.StrType)le.Customer_Program),
    InquiryLogs_Fields.InValid_LexID((SALT39.StrType)le.LexID),
    InquiryLogs_Fields.InValid_raw_Full_Name((SALT39.StrType)le.raw_Full_Name),
    InquiryLogs_Fields.InValid_raw_First_name((SALT39.StrType)le.raw_First_name),
    InquiryLogs_Fields.InValid_raw_Last_Name((SALT39.StrType)le.raw_Last_Name),
    InquiryLogs_Fields.InValid_SSN((SALT39.StrType)le.SSN),
    InquiryLogs_Fields.InValid_Drivers_License_State((SALT39.StrType)le.Drivers_License_State),
    InquiryLogs_Fields.InValid_Drivers_License_Number((SALT39.StrType)le.Drivers_License_Number),
    InquiryLogs_Fields.InValid_Street_1((SALT39.StrType)le.Street_1),
    InquiryLogs_Fields.InValid_City((SALT39.StrType)le.City),
    InquiryLogs_Fields.InValid_State((SALT39.StrType)le.State),
    InquiryLogs_Fields.InValid_Zip((SALT39.StrType)le.Zip),
    InquiryLogs_Fields.InValid_did((SALT39.StrType)le.did),
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
  FieldNme := InquiryLogs_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,InquiryLogs_Fields.InValidMessage_Customer_Account_Number(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Customer_County(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Customer_State(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Customer_Agency_Vertical_Type(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Customer_Program(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_LexID(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_raw_Full_Name(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_raw_First_name(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_raw_Last_Name(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_SSN(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Drivers_License_State(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Drivers_License_Number(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Street_1(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_City(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_State(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_Zip(TotalErrors.ErrorNum),InquiryLogs_Fields.InValidMessage_did(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, InquiryLogs_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
