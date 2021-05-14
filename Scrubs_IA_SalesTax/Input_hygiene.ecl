IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_IA_SalesTax) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_permit_nbr_cnt := COUNT(GROUP,h.permit_nbr <> (TYPEOF(h.permit_nbr))'');
    populated_permit_nbr_pcnt := AVE(GROUP,IF(h.permit_nbr = (TYPEOF(h.permit_nbr))'',0,100));
    maxlength_permit_nbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.permit_nbr)));
    avelength_permit_nbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.permit_nbr)),h.permit_nbr<>(typeof(h.permit_nbr))'');
    populated_issue_date_cnt := COUNT(GROUP,h.issue_date <> (TYPEOF(h.issue_date))'');
    populated_issue_date_pcnt := AVE(GROUP,IF(h.issue_date = (TYPEOF(h.issue_date))'',0,100));
    maxlength_issue_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.issue_date)));
    avelength_issue_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.issue_date)),h.issue_date<>(typeof(h.issue_date))'');
    populated_owner_name_cnt := COUNT(GROUP,h.owner_name <> (TYPEOF(h.owner_name))'');
    populated_owner_name_pcnt := AVE(GROUP,IF(h.owner_name = (TYPEOF(h.owner_name))'',0,100));
    maxlength_owner_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)));
    avelength_owner_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.owner_name)),h.owner_name<>(typeof(h.owner_name))'');
    populated_business_name_cnt := COUNT(GROUP,h.business_name <> (TYPEOF(h.business_name))'');
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_city_mailing_address_cnt := COUNT(GROUP,h.city_mailing_address <> (TYPEOF(h.city_mailing_address))'');
    populated_city_mailing_address_pcnt := AVE(GROUP,IF(h.city_mailing_address = (TYPEOF(h.city_mailing_address))'',0,100));
    maxlength_city_mailing_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_mailing_address)));
    avelength_city_mailing_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_mailing_address)),h.city_mailing_address<>(typeof(h.city_mailing_address))'');
    populated_mailing_address_cnt := COUNT(GROUP,h.mailing_address <> (TYPEOF(h.mailing_address))'');
    populated_mailing_address_pcnt := AVE(GROUP,IF(h.mailing_address = (TYPEOF(h.mailing_address))'',0,100));
    maxlength_mailing_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_address)));
    avelength_mailing_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_address)),h.mailing_address<>(typeof(h.mailing_address))'');
    populated_state_mailing_address_cnt := COUNT(GROUP,h.state_mailing_address <> (TYPEOF(h.state_mailing_address))'');
    populated_state_mailing_address_pcnt := AVE(GROUP,IF(h.state_mailing_address = (TYPEOF(h.state_mailing_address))'',0,100));
    maxlength_state_mailing_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_mailing_address)));
    avelength_state_mailing_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_mailing_address)),h.state_mailing_address<>(typeof(h.state_mailing_address))'');
    populated_mailing_zip_code_cnt := COUNT(GROUP,h.mailing_zip_code <> (TYPEOF(h.mailing_zip_code))'');
    populated_mailing_zip_code_pcnt := AVE(GROUP,IF(h.mailing_zip_code = (TYPEOF(h.mailing_zip_code))'',0,100));
    maxlength_mailing_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zip_code)));
    avelength_mailing_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mailing_zip_code)),h.mailing_zip_code<>(typeof(h.mailing_zip_code))'');
    populated_location_address_cnt := COUNT(GROUP,h.location_address <> (TYPEOF(h.location_address))'');
    populated_location_address_pcnt := AVE(GROUP,IF(h.location_address = (TYPEOF(h.location_address))'',0,100));
    maxlength_location_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_address)));
    avelength_location_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_address)),h.location_address<>(typeof(h.location_address))'');
    populated_city_of_location_cnt := COUNT(GROUP,h.city_of_location <> (TYPEOF(h.city_of_location))'');
    populated_city_of_location_pcnt := AVE(GROUP,IF(h.city_of_location = (TYPEOF(h.city_of_location))'',0,100));
    maxlength_city_of_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_of_location)));
    avelength_city_of_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city_of_location)),h.city_of_location<>(typeof(h.city_of_location))'');
    populated_state_of_location_cnt := COUNT(GROUP,h.state_of_location <> (TYPEOF(h.state_of_location))'');
    populated_state_of_location_pcnt := AVE(GROUP,IF(h.state_of_location = (TYPEOF(h.state_of_location))'',0,100));
    maxlength_state_of_location := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_of_location)));
    avelength_state_of_location := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_of_location)),h.state_of_location<>(typeof(h.state_of_location))'');
    populated_location_zip_code_cnt := COUNT(GROUP,h.location_zip_code <> (TYPEOF(h.location_zip_code))'');
    populated_location_zip_code_pcnt := AVE(GROUP,IF(h.location_zip_code = (TYPEOF(h.location_zip_code))'',0,100));
    maxlength_location_zip_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_zip_code)));
    avelength_location_zip_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_zip_code)),h.location_zip_code<>(typeof(h.location_zip_code))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_permit_nbr_pcnt *   0.00 / 100 + T.Populated_issue_date_pcnt *   0.00 / 100 + T.Populated_owner_name_pcnt *   0.00 / 100 + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_city_mailing_address_pcnt *   0.00 / 100 + T.Populated_mailing_address_pcnt *   0.00 / 100 + T.Populated_state_mailing_address_pcnt *   0.00 / 100 + T.Populated_mailing_zip_code_pcnt *   0.00 / 100 + T.Populated_location_address_pcnt *   0.00 / 100 + T.Populated_city_of_location_pcnt *   0.00 / 100 + T.Populated_state_of_location_pcnt *   0.00 / 100 + T.Populated_location_zip_code_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'permit_nbr','issue_date','owner_name','business_name','city_mailing_address','mailing_address','state_mailing_address','mailing_zip_code','location_address','city_of_location','state_of_location','location_zip_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_permit_nbr_pcnt,le.populated_issue_date_pcnt,le.populated_owner_name_pcnt,le.populated_business_name_pcnt,le.populated_city_mailing_address_pcnt,le.populated_mailing_address_pcnt,le.populated_state_mailing_address_pcnt,le.populated_mailing_zip_code_pcnt,le.populated_location_address_pcnt,le.populated_city_of_location_pcnt,le.populated_state_of_location_pcnt,le.populated_location_zip_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_permit_nbr,le.maxlength_issue_date,le.maxlength_owner_name,le.maxlength_business_name,le.maxlength_city_mailing_address,le.maxlength_mailing_address,le.maxlength_state_mailing_address,le.maxlength_mailing_zip_code,le.maxlength_location_address,le.maxlength_city_of_location,le.maxlength_state_of_location,le.maxlength_location_zip_code);
  SELF.avelength := CHOOSE(C,le.avelength_permit_nbr,le.avelength_issue_date,le.avelength_owner_name,le.avelength_business_name,le.avelength_city_mailing_address,le.avelength_mailing_address,le.avelength_state_mailing_address,le.avelength_mailing_zip_code,le.avelength_location_address,le.avelength_city_of_location,le.avelength_state_of_location,le.avelength_location_zip_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.permit_nbr),TRIM((SALT311.StrType)le.issue_date),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.city_mailing_address),TRIM((SALT311.StrType)le.mailing_address),TRIM((SALT311.StrType)le.state_mailing_address),TRIM((SALT311.StrType)le.mailing_zip_code),TRIM((SALT311.StrType)le.location_address),TRIM((SALT311.StrType)le.city_of_location),TRIM((SALT311.StrType)le.state_of_location),TRIM((SALT311.StrType)le.location_zip_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.permit_nbr),TRIM((SALT311.StrType)le.issue_date),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.city_mailing_address),TRIM((SALT311.StrType)le.mailing_address),TRIM((SALT311.StrType)le.state_mailing_address),TRIM((SALT311.StrType)le.mailing_zip_code),TRIM((SALT311.StrType)le.location_address),TRIM((SALT311.StrType)le.city_of_location),TRIM((SALT311.StrType)le.state_of_location),TRIM((SALT311.StrType)le.location_zip_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.permit_nbr),TRIM((SALT311.StrType)le.issue_date),TRIM((SALT311.StrType)le.owner_name),TRIM((SALT311.StrType)le.business_name),TRIM((SALT311.StrType)le.city_mailing_address),TRIM((SALT311.StrType)le.mailing_address),TRIM((SALT311.StrType)le.state_mailing_address),TRIM((SALT311.StrType)le.mailing_zip_code),TRIM((SALT311.StrType)le.location_address),TRIM((SALT311.StrType)le.city_of_location),TRIM((SALT311.StrType)le.state_of_location),TRIM((SALT311.StrType)le.location_zip_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'permit_nbr'}
      ,{2,'issue_date'}
      ,{3,'owner_name'}
      ,{4,'business_name'}
      ,{5,'city_mailing_address'}
      ,{6,'mailing_address'}
      ,{7,'state_mailing_address'}
      ,{8,'mailing_zip_code'}
      ,{9,'location_address'}
      ,{10,'city_of_location'}
      ,{11,'state_of_location'}
      ,{12,'location_zip_code'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_permit_nbr((SALT311.StrType)le.permit_nbr),
    Input_Fields.InValid_issue_date((SALT311.StrType)le.issue_date),
    Input_Fields.InValid_owner_name((SALT311.StrType)le.owner_name),
    Input_Fields.InValid_business_name((SALT311.StrType)le.business_name),
    Input_Fields.InValid_city_mailing_address((SALT311.StrType)le.city_mailing_address),
    Input_Fields.InValid_mailing_address((SALT311.StrType)le.mailing_address),
    Input_Fields.InValid_state_mailing_address((SALT311.StrType)le.state_mailing_address),
    Input_Fields.InValid_mailing_zip_code((SALT311.StrType)le.mailing_zip_code),
    Input_Fields.InValid_location_address((SALT311.StrType)le.location_address),
    Input_Fields.InValid_city_of_location((SALT311.StrType)le.city_of_location),
    Input_Fields.InValid_state_of_location((SALT311.StrType)le.state_of_location),
    Input_Fields.InValid_location_zip_code((SALT311.StrType)le.location_zip_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_permit_nbr','invalid_issue_date','invalid_owner_name','invalid_business_name','Unknown','Unknown','invalid_state','invalid_zip','Unknown','Unknown','invalid_state','invalid_zip');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_permit_nbr(TotalErrors.ErrorNum),Input_Fields.InValidMessage_issue_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_owner_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city_mailing_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mailing_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state_mailing_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_mailing_zip_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_location_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_city_of_location(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state_of_location(TotalErrors.ErrorNum),Input_Fields.InValidMessage_location_zip_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IA_SalesTax, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
