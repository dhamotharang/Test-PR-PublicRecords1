IMPORT ut,SALT32;
EXPORT Input_hygiene(dataset(Input_layout_DEA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dea_registration_number_pcnt := AVE(GROUP,IF(h.dea_registration_number = (TYPEOF(h.dea_registration_number))'',0,100));
    maxlength_dea_registration_number := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.dea_registration_number)));
    avelength_dea_registration_number := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.dea_registration_number)),h.dea_registration_number<>(typeof(h.dea_registration_number))'');
    populated_business_activity_code_pcnt := AVE(GROUP,IF(h.business_activity_code = (TYPEOF(h.business_activity_code))'',0,100));
    maxlength_business_activity_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.business_activity_code)));
    avelength_business_activity_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.business_activity_code)),h.business_activity_code<>(typeof(h.business_activity_code))'');
    populated_drug_schedules_pcnt := AVE(GROUP,IF(h.drug_schedules = (TYPEOF(h.drug_schedules))'',0,100));
    maxlength_drug_schedules := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.drug_schedules)));
    avelength_drug_schedules := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.drug_schedules)),h.drug_schedules<>(typeof(h.drug_schedules))'');
    populated_expiration_date_pcnt := AVE(GROUP,IF(h.expiration_date = (TYPEOF(h.expiration_date))'',0,100));
    maxlength_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.expiration_date)));
    avelength_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.expiration_date)),h.expiration_date<>(typeof(h.expiration_date))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_address3_pcnt := AVE(GROUP,IF(h.address3 = (TYPEOF(h.address3))'',0,100));
    maxlength_address3 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address3)));
    avelength_address3 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address3)),h.address3<>(typeof(h.address3))'');
    populated_address4_pcnt := AVE(GROUP,IF(h.address4 = (TYPEOF(h.address4))'',0,100));
    maxlength_address4 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address4)));
    avelength_address4 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address4)),h.address4<>(typeof(h.address4))'');
    populated_address5_pcnt := AVE(GROUP,IF(h.address5 = (TYPEOF(h.address5))'',0,100));
    maxlength_address5 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.address5)));
    avelength_address5 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.address5)),h.address5<>(typeof(h.address5))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_bus_activity_sub_code_pcnt := AVE(GROUP,IF(h.bus_activity_sub_code = (TYPEOF(h.bus_activity_sub_code))'',0,100));
    maxlength_bus_activity_sub_code := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.bus_activity_sub_code)));
    avelength_bus_activity_sub_code := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.bus_activity_sub_code)),h.bus_activity_sub_code<>(typeof(h.bus_activity_sub_code))'');
    populated_exp_of_payment_indicator_pcnt := AVE(GROUP,IF(h.exp_of_payment_indicator = (TYPEOF(h.exp_of_payment_indicator))'',0,100));
    maxlength_exp_of_payment_indicator := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.exp_of_payment_indicator)));
    avelength_exp_of_payment_indicator := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.exp_of_payment_indicator)),h.exp_of_payment_indicator<>(typeof(h.exp_of_payment_indicator))'');
    populated_activity_pcnt := AVE(GROUP,IF(h.activity = (TYPEOF(h.activity))'',0,100));
    maxlength_activity := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.activity)));
    avelength_activity := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.activity)),h.activity<>(typeof(h.activity))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dea_registration_number_pcnt *   0.00 / 100 + T.Populated_business_activity_code_pcnt *   0.00 / 100 + T.Populated_drug_schedules_pcnt *   0.00 / 100 + T.Populated_expiration_date_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_address3_pcnt *   0.00 / 100 + T.Populated_address4_pcnt *   0.00 / 100 + T.Populated_address5_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_bus_activity_sub_code_pcnt *   0.00 / 100 + T.Populated_exp_of_payment_indicator_pcnt *   0.00 / 100 + T.Populated_activity_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dea_registration_number','business_activity_code','drug_schedules','expiration_date','address1','address2','address3','address4','address5','state','zip_code','bus_activity_sub_code','exp_of_payment_indicator','activity','crlf');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dea_registration_number_pcnt,le.populated_business_activity_code_pcnt,le.populated_drug_schedules_pcnt,le.populated_expiration_date_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_address3_pcnt,le.populated_address4_pcnt,le.populated_address5_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_bus_activity_sub_code_pcnt,le.populated_exp_of_payment_indicator_pcnt,le.populated_activity_pcnt,le.populated_crlf_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dea_registration_number,le.maxlength_business_activity_code,le.maxlength_drug_schedules,le.maxlength_expiration_date,le.maxlength_address1,le.maxlength_address2,le.maxlength_address3,le.maxlength_address4,le.maxlength_address5,le.maxlength_state,le.maxlength_zip_code,le.maxlength_bus_activity_sub_code,le.maxlength_exp_of_payment_indicator,le.maxlength_activity,le.maxlength_crlf);
  SELF.avelength := CHOOSE(C,le.avelength_dea_registration_number,le.avelength_business_activity_code,le.avelength_drug_schedules,le.avelength_expiration_date,le.avelength_address1,le.avelength_address2,le.avelength_address3,le.avelength_address4,le.avelength_address5,le.avelength_state,le.avelength_zip_code,le.avelength_bus_activity_sub_code,le.avelength_exp_of_payment_indicator,le.avelength_activity,le.avelength_crlf);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.dea_registration_number),TRIM((SALT32.StrType)le.business_activity_code),TRIM((SALT32.StrType)le.drug_schedules),TRIM((SALT32.StrType)le.expiration_date),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.address3),TRIM((SALT32.StrType)le.address4),TRIM((SALT32.StrType)le.address5),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.bus_activity_sub_code),TRIM((SALT32.StrType)le.exp_of_payment_indicator),TRIM((SALT32.StrType)le.activity),TRIM((SALT32.StrType)le.crlf)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.dea_registration_number),TRIM((SALT32.StrType)le.business_activity_code),TRIM((SALT32.StrType)le.drug_schedules),TRIM((SALT32.StrType)le.expiration_date),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.address3),TRIM((SALT32.StrType)le.address4),TRIM((SALT32.StrType)le.address5),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.bus_activity_sub_code),TRIM((SALT32.StrType)le.exp_of_payment_indicator),TRIM((SALT32.StrType)le.activity),TRIM((SALT32.StrType)le.crlf)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.dea_registration_number),TRIM((SALT32.StrType)le.business_activity_code),TRIM((SALT32.StrType)le.drug_schedules),TRIM((SALT32.StrType)le.expiration_date),TRIM((SALT32.StrType)le.address1),TRIM((SALT32.StrType)le.address2),TRIM((SALT32.StrType)le.address3),TRIM((SALT32.StrType)le.address4),TRIM((SALT32.StrType)le.address5),TRIM((SALT32.StrType)le.state),TRIM((SALT32.StrType)le.zip_code),TRIM((SALT32.StrType)le.bus_activity_sub_code),TRIM((SALT32.StrType)le.exp_of_payment_indicator),TRIM((SALT32.StrType)le.activity),TRIM((SALT32.StrType)le.crlf)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dea_registration_number'}
      ,{2,'business_activity_code'}
      ,{3,'drug_schedules'}
      ,{4,'expiration_date'}
      ,{5,'address1'}
      ,{6,'address2'}
      ,{7,'address3'}
      ,{8,'address4'}
      ,{9,'address5'}
      ,{10,'state'}
      ,{11,'zip_code'}
      ,{12,'bus_activity_sub_code'}
      ,{13,'exp_of_payment_indicator'}
      ,{14,'activity'}
      ,{15,'crlf'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_dea_registration_number((SALT32.StrType)le.dea_registration_number),
    Input_Fields.InValid_business_activity_code((SALT32.StrType)le.business_activity_code),
    Input_Fields.InValid_drug_schedules((SALT32.StrType)le.drug_schedules),
    Input_Fields.InValid_expiration_date((SALT32.StrType)le.expiration_date),
    Input_Fields.InValid_address1((SALT32.StrType)le.address1),
    Input_Fields.InValid_address2((SALT32.StrType)le.address2),
    Input_Fields.InValid_address3((SALT32.StrType)le.address3),
    Input_Fields.InValid_address4((SALT32.StrType)le.address4),
    Input_Fields.InValid_address5((SALT32.StrType)le.address5),
    Input_Fields.InValid_state((SALT32.StrType)le.state),
    Input_Fields.InValid_zip_code((SALT32.StrType)le.zip_code),
    Input_Fields.InValid_bus_activity_sub_code((SALT32.StrType)le.bus_activity_sub_code),
    Input_Fields.InValid_exp_of_payment_indicator((SALT32.StrType)le.exp_of_payment_indicator),
    Input_Fields.InValid_activity((SALT32.StrType)le.activity),
    Input_Fields.InValid_crlf((SALT32.StrType)le.crlf),
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
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanumeric','invalid_alpha','invalid_drug_schedules','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alpha','invalid_numeric','invalid_alphanumeric','invalid_exp_of_payment_indicator','invalid_activity','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_dea_registration_number(TotalErrors.ErrorNum),Input_Fields.InValidMessage_business_activity_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_drug_schedules(TotalErrors.ErrorNum),Input_Fields.InValidMessage_expiration_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_bus_activity_sub_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_exp_of_payment_indicator(TotalErrors.ErrorNum),Input_Fields.InValidMessage_activity(TotalErrors.ErrorNum),Input_Fields.InValidMessage_crlf(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
