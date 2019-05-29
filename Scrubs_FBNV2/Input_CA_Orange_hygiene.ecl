IMPORT SALT37;
EXPORT Input_CA_Orange_hygiene(dataset(Input_CA_Orange_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_business_name_pcnt := AVE(GROUP,IF(h.business_name = (TYPEOF(h.business_name))'',0,100));
    maxlength_business_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)));
    avelength_business_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.business_name)),h.business_name<>(typeof(h.business_name))'');
    populated_file_date_pcnt := AVE(GROUP,IF(h.file_date = (TYPEOF(h.file_date))'',0,100));
    maxlength_file_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)));
    avelength_file_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.file_date)),h.file_date<>(typeof(h.file_date))'');
    populated_regis_nbr_pcnt := AVE(GROUP,IF(h.regis_nbr = (TYPEOF(h.regis_nbr))'',0,100));
    maxlength_regis_nbr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.regis_nbr)));
    avelength_regis_nbr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.regis_nbr)),h.regis_nbr<>(typeof(h.regis_nbr))'');
    populated_prep_bus_addr_line1_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line1 = (TYPEOF(h.prep_bus_addr_line1))'',0,100));
    maxlength_prep_bus_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)));
    avelength_prep_bus_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line1)),h.prep_bus_addr_line1<>(typeof(h.prep_bus_addr_line1))'');
    populated_prep_bus_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_bus_addr_line_last = (TYPEOF(h.prep_bus_addr_line_last))'',0,100));
    maxlength_prep_bus_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)));
    avelength_prep_bus_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_bus_addr_line_last)),h.prep_bus_addr_line_last<>(typeof(h.prep_bus_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_first_name_pcnt := AVE(GROUP,IF(h.first_name = (TYPEOF(h.first_name))'',0,100));
    maxlength_first_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)));
    avelength_first_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.first_name)),h.first_name<>(typeof(h.first_name))'');
    populated_middle_name_pcnt := AVE(GROUP,IF(h.middle_name = (TYPEOF(h.middle_name))'',0,100));
    maxlength_middle_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)));
    avelength_middle_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.middle_name)),h.middle_name<>(typeof(h.middle_name))'');
    populated_last_name_company_pcnt := AVE(GROUP,IF(h.last_name_company = (TYPEOF(h.last_name_company))'',0,100));
    maxlength_last_name_company := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name_company)));
    avelength_last_name_company := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.last_name_company)),h.last_name_company<>(typeof(h.last_name_company))'');
    populated_owner_address_pcnt := AVE(GROUP,IF(h.owner_address = (TYPEOF(h.owner_address))'',0,100));
    maxlength_owner_address := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)));
    avelength_owner_address := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_address)),h.owner_address<>(typeof(h.owner_address))'');
    populated_owner_city_pcnt := AVE(GROUP,IF(h.owner_city = (TYPEOF(h.owner_city))'',0,100));
    maxlength_owner_city := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_city)));
    avelength_owner_city := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_city)),h.owner_city<>(typeof(h.owner_city))'');
    populated_owner_state_pcnt := AVE(GROUP,IF(h.owner_state = (TYPEOF(h.owner_state))'',0,100));
    maxlength_owner_state := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_state)));
    avelength_owner_state := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.owner_state)),h.owner_state<>(typeof(h.owner_state))'');
    populated_phone_nbr_pcnt := AVE(GROUP,IF(h.phone_nbr = (TYPEOF(h.phone_nbr))'',0,100));
    maxlength_phone_nbr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone_nbr)));
    avelength_phone_nbr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.phone_nbr)),h.phone_nbr<>(typeof(h.phone_nbr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_business_name_pcnt *   0.00 / 100 + T.Populated_file_date_pcnt *   0.00 / 100 + T.Populated_regis_nbr_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_bus_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_first_name_pcnt *   0.00 / 100 + T.Populated_middle_name_pcnt *   0.00 / 100 + T.Populated_last_name_company_pcnt *   0.00 / 100 + T.Populated_owner_address_pcnt *   0.00 / 100 + T.Populated_owner_city_pcnt *   0.00 / 100 + T.Populated_owner_state_pcnt *   0.00 / 100 + T.Populated_phone_nbr_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'business_name','file_date','regis_nbr','prep_bus_addr_line1','prep_bus_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','cname','first_name','middle_name','last_name_company','owner_address','owner_city','owner_state','phone_nbr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_business_name_pcnt,le.populated_file_date_pcnt,le.populated_regis_nbr_pcnt,le.populated_prep_bus_addr_line1_pcnt,le.populated_prep_bus_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_cname_pcnt,le.populated_first_name_pcnt,le.populated_middle_name_pcnt,le.populated_last_name_company_pcnt,le.populated_owner_address_pcnt,le.populated_owner_city_pcnt,le.populated_owner_state_pcnt,le.populated_phone_nbr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_business_name,le.maxlength_file_date,le.maxlength_regis_nbr,le.maxlength_prep_bus_addr_line1,le.maxlength_prep_bus_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_cname,le.maxlength_first_name,le.maxlength_middle_name,le.maxlength_last_name_company,le.maxlength_owner_address,le.maxlength_owner_city,le.maxlength_owner_state,le.maxlength_phone_nbr);
  SELF.avelength := CHOOSE(C,le.avelength_business_name,le.avelength_file_date,le.avelength_regis_nbr,le.avelength_prep_bus_addr_line1,le.avelength_prep_bus_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_cname,le.avelength_first_name,le.avelength_middle_name,le.avelength_last_name_company,le.avelength_owner_address,le.avelength_owner_city,le.avelength_owner_state,le.avelength_phone_nbr);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.phone_nbr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.phone_nbr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.business_name),TRIM((SALT37.StrType)le.file_date),TRIM((SALT37.StrType)le.regis_nbr),TRIM((SALT37.StrType)le.prep_bus_addr_line1),TRIM((SALT37.StrType)le.prep_bus_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.cname),TRIM((SALT37.StrType)le.first_name),TRIM((SALT37.StrType)le.middle_name),TRIM((SALT37.StrType)le.last_name_company),TRIM((SALT37.StrType)le.owner_address),TRIM((SALT37.StrType)le.owner_city),TRIM((SALT37.StrType)le.owner_state),TRIM((SALT37.StrType)le.phone_nbr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'business_name'}
      ,{2,'file_date'}
      ,{3,'regis_nbr'}
      ,{4,'prep_bus_addr_line1'}
      ,{5,'prep_bus_addr_line_last'}
      ,{6,'prep_owner_addr_line1'}
      ,{7,'prep_owner_addr_line_last'}
      ,{8,'cname'}
      ,{9,'first_name'}
      ,{10,'middle_name'}
      ,{11,'last_name_company'}
      ,{12,'owner_address'}
      ,{13,'owner_city'}
      ,{14,'owner_state'}
      ,{15,'phone_nbr'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_CA_Orange_Fields.InValid_business_name((SALT37.StrType)le.business_name),
    Input_CA_Orange_Fields.InValid_file_date((SALT37.StrType)le.file_date),
    Input_CA_Orange_Fields.InValid_regis_nbr((SALT37.StrType)le.regis_nbr),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line1((SALT37.StrType)le.prep_bus_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_bus_addr_line_last((SALT37.StrType)le.prep_bus_addr_line_last),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_CA_Orange_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    Input_CA_Orange_Fields.InValid_cname((SALT37.StrType)le.cname),
    Input_CA_Orange_Fields.InValid_first_name((SALT37.StrType)le.first_name),
    Input_CA_Orange_Fields.InValid_middle_name((SALT37.StrType)le.middle_name),
    Input_CA_Orange_Fields.InValid_last_name_company((SALT37.StrType)le.last_name_company),
    Input_CA_Orange_Fields.InValid_owner_address((SALT37.StrType)le.owner_address),
    Input_CA_Orange_Fields.InValid_owner_city((SALT37.StrType)le.owner_city),
    Input_CA_Orange_Fields.InValid_owner_state((SALT37.StrType)le.owner_state),
    Input_CA_Orange_Fields.InValid_phone_nbr((SALT37.StrType)le.phone_nbr),
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
  FieldNme := Input_CA_Orange_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_phone');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_CA_Orange_Fields.InValidMessage_business_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_file_date(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_regis_nbr(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_bus_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_cname(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_first_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_middle_name(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_last_name_company(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_owner_address(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_owner_city(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_owner_state(TotalErrors.ErrorNum),Input_CA_Orange_Fields.InValidMessage_phone_nbr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
