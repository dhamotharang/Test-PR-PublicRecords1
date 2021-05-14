IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_Spoke) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_first_name_cnt := COUNT(GROUP,h.first_name <> (TYPEOF(h.first_name))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_last_name_cnt := COUNT(GROUP,h.last_name <> (TYPEOF(h.last_name))'');
    populated_last_name_pcnt := AVE(GROUP,IF(h.last_name = (TYPEOF(h.last_name))'',0,100));
    maxlength_last_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)));
    avelength_last_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_name)),h.last_name<>(typeof(h.last_name))'');
    populated_job_title_cnt := COUNT(GROUP,h.job_title <> (TYPEOF(h.job_title))'');
    populated_job_title_pcnt := AVE(GROUP,IF(h.job_title = (TYPEOF(h.job_title))'',0,100));
    maxlength_job_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.job_title)));
    avelength_job_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.job_title)),h.job_title<>(typeof(h.job_title))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_validation_date_cnt := COUNT(GROUP,h.validation_date <> (TYPEOF(h.validation_date))'');
    populated_validation_date_pcnt := AVE(GROUP,IF(h.validation_date = (TYPEOF(h.validation_date))'',0,100));
    maxlength_validation_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.validation_date)));
    avelength_validation_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.validation_date)),h.validation_date<>(typeof(h.validation_date))'');
    populated_company_street_address_cnt := COUNT(GROUP,h.company_street_address <> (TYPEOF(h.company_street_address))'');
    populated_company_street_address_pcnt := AVE(GROUP,IF(h.company_street_address = (TYPEOF(h.company_street_address))'',0,100));
    maxlength_company_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_street_address)));
    avelength_company_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_street_address)),h.company_street_address<>(typeof(h.company_street_address))'');
    populated_company_city_cnt := COUNT(GROUP,h.company_city <> (TYPEOF(h.company_city))'');
    populated_company_city_pcnt := AVE(GROUP,IF(h.company_city = (TYPEOF(h.company_city))'',0,100));
    maxlength_company_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_city)));
    avelength_company_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_city)),h.company_city<>(typeof(h.company_city))'');
    populated_company_state_cnt := COUNT(GROUP,h.company_state <> (TYPEOF(h.company_state))'');
    populated_company_state_pcnt := AVE(GROUP,IF(h.company_state = (TYPEOF(h.company_state))'',0,100));
    maxlength_company_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_state)));
    avelength_company_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_state)),h.company_state<>(typeof(h.company_state))'');
    populated_company_postal_code_cnt := COUNT(GROUP,h.company_postal_code <> (TYPEOF(h.company_postal_code))'');
    populated_company_postal_code_pcnt := AVE(GROUP,IF(h.company_postal_code = (TYPEOF(h.company_postal_code))'',0,100));
    maxlength_company_postal_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_postal_code)));
    avelength_company_postal_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_postal_code)),h.company_postal_code<>(typeof(h.company_postal_code))'');
    populated_company_phone_number_cnt := COUNT(GROUP,h.company_phone_number <> (TYPEOF(h.company_phone_number))'');
    populated_company_phone_number_pcnt := AVE(GROUP,IF(h.company_phone_number = (TYPEOF(h.company_phone_number))'',0,100));
    maxlength_company_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone_number)));
    avelength_company_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone_number)),h.company_phone_number<>(typeof(h.company_phone_number))'');
    populated_company_annual_revenue_cnt := COUNT(GROUP,h.company_annual_revenue <> (TYPEOF(h.company_annual_revenue))'');
    populated_company_annual_revenue_pcnt := AVE(GROUP,IF(h.company_annual_revenue = (TYPEOF(h.company_annual_revenue))'',0,100));
    maxlength_company_annual_revenue := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_annual_revenue)));
    avelength_company_annual_revenue := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_annual_revenue)),h.company_annual_revenue<>(typeof(h.company_annual_revenue))'');
    populated_company_business_description_cnt := COUNT(GROUP,h.company_business_description <> (TYPEOF(h.company_business_description))'');
    populated_company_business_description_pcnt := AVE(GROUP,IF(h.company_business_description = (TYPEOF(h.company_business_description))'',0,100));
    maxlength_company_business_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_business_description)));
    avelength_company_business_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_business_description)),h.company_business_description<>(typeof(h.company_business_description))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_last_name_pcnt *   0.00 / 100 + T.Populated_job_title_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_validation_date_pcnt *   0.00 / 100 + T.Populated_company_street_address_pcnt *   0.00 / 100 + T.Populated_company_city_pcnt *   0.00 / 100 + T.Populated_company_state_pcnt *   0.00 / 100 + T.Populated_company_postal_code_pcnt *   0.00 / 100 + T.Populated_company_phone_number_pcnt *   0.00 / 100 + T.Populated_company_annual_revenue_pcnt *   0.00 / 100 + T.Populated_company_business_description_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'first_name','last_name','job_title','company_name','validation_date','company_street_address','company_city','company_state','company_postal_code','company_phone_number','company_annual_revenue','company_business_description');
  SELF.populated_pcnt := CHOOSE(C,le.populated_first_name_pcnt,le.populated_last_name_pcnt,le.populated_job_title_pcnt,le.populated_company_name_pcnt,le.populated_validation_date_pcnt,le.populated_company_street_address_pcnt,le.populated_company_city_pcnt,le.populated_company_state_pcnt,le.populated_company_postal_code_pcnt,le.populated_company_phone_number_pcnt,le.populated_company_annual_revenue_pcnt,le.populated_company_business_description_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_first_name,le.maxlength_last_name,le.maxlength_job_title,le.maxlength_company_name,le.maxlength_validation_date,le.maxlength_company_street_address,le.maxlength_company_city,le.maxlength_company_state,le.maxlength_company_postal_code,le.maxlength_company_phone_number,le.maxlength_company_annual_revenue,le.maxlength_company_business_description);
  SELF.avelength := CHOOSE(C,le.avelength_first_name,le.avelength_last_name,le.avelength_job_title,le.avelength_company_name,le.avelength_validation_date,le.avelength_company_street_address,le.avelength_company_city,le.avelength_company_state,le.avelength_company_postal_code,le.avelength_company_phone_number,le.avelength_company_annual_revenue,le.avelength_company_business_description);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.job_title),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.validation_date),TRIM((SALT311.StrType)le.company_street_address),TRIM((SALT311.StrType)le.company_city),TRIM((SALT311.StrType)le.company_state),TRIM((SALT311.StrType)le.company_postal_code),TRIM((SALT311.StrType)le.company_phone_number),TRIM((SALT311.StrType)le.company_annual_revenue),TRIM((SALT311.StrType)le.company_business_description)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.job_title),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.validation_date),TRIM((SALT311.StrType)le.company_street_address),TRIM((SALT311.StrType)le.company_city),TRIM((SALT311.StrType)le.company_state),TRIM((SALT311.StrType)le.company_postal_code),TRIM((SALT311.StrType)le.company_phone_number),TRIM((SALT311.StrType)le.company_annual_revenue),TRIM((SALT311.StrType)le.company_business_description)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.first_name),TRIM((SALT311.StrType)le.last_name),TRIM((SALT311.StrType)le.job_title),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.validation_date),TRIM((SALT311.StrType)le.company_street_address),TRIM((SALT311.StrType)le.company_city),TRIM((SALT311.StrType)le.company_state),TRIM((SALT311.StrType)le.company_postal_code),TRIM((SALT311.StrType)le.company_phone_number),TRIM((SALT311.StrType)le.company_annual_revenue),TRIM((SALT311.StrType)le.company_business_description)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'first_name'}
      ,{2,'last_name'}
      ,{3,'job_title'}
      ,{4,'company_name'}
      ,{5,'validation_date'}
      ,{6,'company_street_address'}
      ,{7,'company_city'}
      ,{8,'company_state'}
      ,{9,'company_postal_code'}
      ,{10,'company_phone_number'}
      ,{11,'company_annual_revenue'}
      ,{12,'company_business_description'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_first_name((SALT311.StrType)le.first_name),
    Input_Fields.InValid_last_name((SALT311.StrType)le.last_name),
    Input_Fields.InValid_job_title((SALT311.StrType)le.job_title),
    Input_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Input_Fields.InValid_validation_date((SALT311.StrType)le.validation_date),
    Input_Fields.InValid_company_street_address((SALT311.StrType)le.company_street_address),
    Input_Fields.InValid_company_city((SALT311.StrType)le.company_city),
    Input_Fields.InValid_company_state((SALT311.StrType)le.company_state),
    Input_Fields.InValid_company_postal_code((SALT311.StrType)le.company_postal_code),
    Input_Fields.InValid_company_phone_number((SALT311.StrType)le.company_phone_number),
    Input_Fields.InValid_company_annual_revenue((SALT311.StrType)le.company_annual_revenue),
    Input_Fields.InValid_company_business_description((SALT311.StrType)le.company_business_description),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_first_name','invalid_last_name','Unknown','invalid_company_name','Unknown','Unknown','Unknown','invalid_company_state','invalid_postal_code','invalid_phone_number','invalid_annual_revenue','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_last_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_job_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Input_Fields.InValidMessage_validation_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_street_address(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_city(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_postal_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_phone_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_annual_revenue(TotalErrors.ErrorNum),Input_Fields.InValidMessage_company_business_description(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Spoke, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
