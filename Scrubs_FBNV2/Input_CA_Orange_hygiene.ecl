IMPORT SALT311,STD;
EXPORT Input_CA_Orange_hygiene(dataset(Input_CA_Orange_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_REGIS_NBR_cnt := COUNT(GROUP,h.REGIS_NBR <> (TYPEOF(h.REGIS_NBR))'');
    populated_REGIS_NBR_pcnt := AVE(GROUP,IF(h.REGIS_NBR = (TYPEOF(h.REGIS_NBR))'',0,100));
    maxlength_REGIS_NBR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.REGIS_NBR)));
    avelength_REGIS_NBR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.REGIS_NBR)),h.REGIS_NBR<>(typeof(h.REGIS_NBR))'');
    populated_BUSINESS_NAME_cnt := COUNT(GROUP,h.BUSINESS_NAME <> (TYPEOF(h.BUSINESS_NAME))'');
    populated_BUSINESS_NAME_pcnt := AVE(GROUP,IF(h.BUSINESS_NAME = (TYPEOF(h.BUSINESS_NAME))'',0,100));
    maxlength_BUSINESS_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)));
    avelength_BUSINESS_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BUSINESS_NAME)),h.BUSINESS_NAME<>(typeof(h.BUSINESS_NAME))'');
    populated_PHONE_NBR_cnt := COUNT(GROUP,h.PHONE_NBR <> (TYPEOF(h.PHONE_NBR))'');
    populated_PHONE_NBR_pcnt := AVE(GROUP,IF(h.PHONE_NBR = (TYPEOF(h.PHONE_NBR))'',0,100));
    maxlength_PHONE_NBR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.PHONE_NBR)));
    avelength_PHONE_NBR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.PHONE_NBR)),h.PHONE_NBR<>(typeof(h.PHONE_NBR))'');
    populated_FILE_DATE_cnt := COUNT(GROUP,h.FILE_DATE <> (TYPEOF(h.FILE_DATE))'');
    populated_FILE_DATE_pcnt := AVE(GROUP,IF(h.FILE_DATE = (TYPEOF(h.FILE_DATE))'',0,100));
    maxlength_FILE_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_DATE)));
    avelength_FILE_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FILE_DATE)),h.FILE_DATE<>(typeof(h.FILE_DATE))'');
    populated_FIRST_NAME_cnt := COUNT(GROUP,h.FIRST_NAME <> (TYPEOF(h.FIRST_NAME))'');
    populated_FIRST_NAME_pcnt := AVE(GROUP,IF(h.FIRST_NAME = (TYPEOF(h.FIRST_NAME))'',0,100));
    maxlength_FIRST_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIRST_NAME)));
    avelength_FIRST_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FIRST_NAME)),h.FIRST_NAME<>(typeof(h.FIRST_NAME))'');
    populated_MIDDLE_NAME_cnt := COUNT(GROUP,h.MIDDLE_NAME <> (TYPEOF(h.MIDDLE_NAME))'');
    populated_MIDDLE_NAME_pcnt := AVE(GROUP,IF(h.MIDDLE_NAME = (TYPEOF(h.MIDDLE_NAME))'',0,100));
    maxlength_MIDDLE_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MIDDLE_NAME)));
    avelength_MIDDLE_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MIDDLE_NAME)),h.MIDDLE_NAME<>(typeof(h.MIDDLE_NAME))'');
    populated_LAST_NAME_COMPANY_cnt := COUNT(GROUP,h.LAST_NAME_COMPANY <> (TYPEOF(h.LAST_NAME_COMPANY))'');
    populated_LAST_NAME_COMPANY_pcnt := AVE(GROUP,IF(h.LAST_NAME_COMPANY = (TYPEOF(h.LAST_NAME_COMPANY))'',0,100));
    maxlength_LAST_NAME_COMPANY := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.LAST_NAME_COMPANY)));
    avelength_LAST_NAME_COMPANY := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.LAST_NAME_COMPANY)),h.LAST_NAME_COMPANY<>(typeof(h.LAST_NAME_COMPANY))'');
    populated_OWNER_ADDRESS_cnt := COUNT(GROUP,h.OWNER_ADDRESS <> (TYPEOF(h.OWNER_ADDRESS))'');
    populated_OWNER_ADDRESS_pcnt := AVE(GROUP,IF(h.OWNER_ADDRESS = (TYPEOF(h.OWNER_ADDRESS))'',0,100));
    maxlength_OWNER_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ADDRESS)));
    avelength_OWNER_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWNER_ADDRESS)),h.OWNER_ADDRESS<>(typeof(h.OWNER_ADDRESS))'');
    populated_prep_bus_addr_line1_cnt := COUNT(GROUP,h.prep_bus_addr_line1 <> (TYPEOF(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line1_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line1 = (TYPEOF(h.prep_bus_addr_line1))'',0,100));
    maxlength_prep_bus_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line1)));
    avelength_prep_bus_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line1)),h.prep_bus_addr_line1<>(typeof(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line_last_cnt := COUNT(GROUP,h.prep_bus_addr_line_last <> (TYPEOF(h.prep_bus_addr_line_last))'');
    populated_prep_bus_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line_last = (TYPEOF(h.prep_bus_addr_line_last))'',0,100));
    maxlength_prep_bus_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line_last)));
    avelength_prep_bus_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_bus_addr_line_last)),h.prep_bus_addr_line_last<>(typeof(h.prep_bus_addr_line_last))'');
    populated_prep_owner_addr_line1_cnt := COUNT(GROUP,h.prep_owner_addr_line1 <> (TYPEOF(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_cnt := COUNT(GROUP,h.prep_owner_addr_line_last <> (TYPEOF(h.prep_owner_addr_line_last))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_cname_cnt := COUNT(GROUP,h.cname <> (TYPEOF(h.cname))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_REGIS_NBR_pcnt *   0.00 / 100 + T.Populated_BUSINESS_NAME_pcnt *   0.00 / 100 + T.Populated_PHONE_NBR_pcnt *   0.00 / 100 + T.Populated_FILE_DATE_pcnt *   0.00 / 100 + T.Populated_FIRST_NAME_pcnt *   0.00 / 100 + T.Populated_MIDDLE_NAME_pcnt *   0.00 / 100 + T.Populated_LAST_NAME_COMPANY_pcnt *   0.00 / 100 + T.Populated_OWNER_ADDRESS_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'REGIS_NBR','BUSINESS_NAME','PHONE_NBR','FILE_DATE','FIRST_NAME','MIDDLE_NAME','LAST_NAME_COMPANY','OWNER_ADDRESS','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname');
  SELF.populated_pcnt := CHOOSE(C,le.populated_REGIS_NBR_pcnt,le.populated_BUSINESS_NAME_pcnt,le.populated_PHONE_NBR_pcnt,le.populated_FILE_DATE_pcnt,le.populated_FIRST_NAME_pcnt,le.populated_MIDDLE_NAME_pcnt,le.populated_LAST_NAME_COMPANY_pcnt,le.populated_OWNER_ADDRESS_pcnt,le.populated_prep_bus_addr_line1_pcnt,le.populated_prep_bus_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_cname_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_REGIS_NBR,le.maxlength_BUSINESS_NAME,le.maxlength_PHONE_NBR,le.maxlength_FILE_DATE,le.maxlength_FIRST_NAME,le.maxlength_MIDDLE_NAME,le.maxlength_LAST_NAME_COMPANY,le.maxlength_OWNER_ADDRESS,le.maxlength_prep_bus_addr_line1,le.maxlength_prep_bus_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_cname);
  SELF.avelength := CHOOSE(C,le.avelength_REGIS_NBR,le.avelength_BUSINESS_NAME,le.avelength_PHONE_NBR,le.avelength_FILE_DATE,le.avelength_FIRST_NAME,le.avelength_MIDDLE_NAME,le.avelength_LAST_NAME_COMPANY,le.avelength_OWNER_ADDRESS,le.avelength_prep_bus_addr_line1,le.avelength_prep_bus_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_cname);
END;
EXPORT invSummary := NORMALIZE(summary0, 13, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.REGIS_NBR),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.PHONE_NBR),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.FIRST_NAME),TRIM((SALT311.StrType)le.MIDDLE_NAME),TRIM((SALT311.StrType)le.LAST_NAME_COMPANY),TRIM((SALT311.StrType)le.OWNER_ADDRESS),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.cname)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,13,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 13);
  SELF.FldNo2 := 1 + (C % 13);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.REGIS_NBR),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.PHONE_NBR),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.FIRST_NAME),TRIM((SALT311.StrType)le.MIDDLE_NAME),TRIM((SALT311.StrType)le.LAST_NAME_COMPANY),TRIM((SALT311.StrType)le.OWNER_ADDRESS),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.cname)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.REGIS_NBR),TRIM((SALT311.StrType)le.BUSINESS_NAME),TRIM((SALT311.StrType)le.PHONE_NBR),TRIM((SALT311.StrType)le.FILE_DATE),TRIM((SALT311.StrType)le.FIRST_NAME),TRIM((SALT311.StrType)le.MIDDLE_NAME),TRIM((SALT311.StrType)le.LAST_NAME_COMPANY),TRIM((SALT311.StrType)le.OWNER_ADDRESS),TRIM((SALT311.StrType)le.prep_bus_addr_line1),TRIM((SALT311.StrType)le.prep_bus_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last),TRIM((SALT311.StrType)le.cname)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),13*13,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'REGIS_NBR'}
      ,{2,'BUSINESS_NAME'}
      ,{3,'PHONE_NBR'}
      ,{4,'FILE_DATE'}
      ,{5,'FIRST_NAME'}
      ,{6,'MIDDLE_NAME'}
      ,{7,'LAST_NAME_COMPANY'}
      ,{8,'OWNER_ADDRESS'}
      ,{9,'prep_bus_addr_line1'}
      ,{10,'prep_bus_addr_line_last'}
      ,{11,'prep_owner_addr_line1'}
      ,{12,'prep_owner_addr_line_last'}
      ,{13,'cname'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Orange_Fields.InValid_REGIS_NBR((SALT311.StrType)le.REGIS_NBR),
    Input_CA_Orange_Fields.InValid_BUSINESS_NAME((SALT311.StrType)le.BUSINESS_NAME),
    Input_CA_Orange_Fields.InValid_PHONE_NBR((SALT311.StrType)le.PHONE_NBR),
    Input_CA_Orange_Fields.InValid_FILE_DATE((SALT311.StrType)le.FILE_DATE),
    Input_CA_Orange_Fields.InValid_FIRST_NAME((SALT311.StrType)le.FIRST_NAME),
    Input_CA_Orange_Fields.InValid_MIDDLE_NAME((SALT311.StrType)le.MIDDLE_NAME),
    Input_CA_Orange_Fields.InValid_LAST_NAME_COMPANY((SALT311.StrType)le.LAST_NAME_COMPANY),
    Input_CA_Orange_Fields.InValid_OWNER_ADDRESS((SALT311.StrType)le.OWNER_ADDRESS),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line1((SALT311.StrType)le.prep_bus_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line_last((SALT311.StrType)le.prep_bus_addr_line_last),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last),
    Input_CA_Orange_Fields.InValid_cname((SALT311.StrType)le.cname),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,13,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_CA_Orange_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_phone','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Orange_Fields.InValidMessage_REGIS_NBR(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_BUSINESS_NAME(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_PHONE_NBR(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_FILE_DATE(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_FIRST_NAME(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_MIDDLE_NAME(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_LAST_NAME_COMPANY(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_OWNER_ADDRESS(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_cname(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_CA_Orange_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
