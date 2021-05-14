IMPORT SALT37;
EXPORT hygiene(dataset(layout_eCrash_MBSAgency) h) := MODULE
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_agency_id_pcnt := AVE(GROUP,IF(h.agency_id = (TYPEOF(h.agency_id))'',0,100));
    maxlength_agency_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_id)));
    avelength_agency_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_id)),h.agency_id<>(typeof(h.agency_id))'');
    populated_agency_name_pcnt := AVE(GROUP,IF(h.agency_name = (TYPEOF(h.agency_name))'',0,100));
    maxlength_agency_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_name)));
    avelength_agency_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_name)),h.agency_name<>(typeof(h.agency_name))'');
    populated_source_id_pcnt := AVE(GROUP,IF(h.source_id = (TYPEOF(h.source_id))'',0,100));
    maxlength_source_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_id)));
    avelength_source_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_id)),h.source_id<>(typeof(h.source_id))'');
    populated_agency_state_abbr_pcnt := AVE(GROUP,IF(h.agency_state_abbr = (TYPEOF(h.agency_state_abbr))'',0,100));
    maxlength_agency_state_abbr := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_state_abbr)));
    avelength_agency_state_abbr := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_state_abbr)),h.agency_state_abbr<>(typeof(h.agency_state_abbr))'');
    populated_agency_ori_pcnt := AVE(GROUP,IF(h.agency_ori = (TYPEOF(h.agency_ori))'',0,100));
    maxlength_agency_ori := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_ori)));
    avelength_agency_ori := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.agency_ori)),h.agency_ori<>(typeof(h.agency_ori))'');
    populated_allow_open_search_pcnt := AVE(GROUP,IF(h.allow_open_search = (TYPEOF(h.allow_open_search))'',0,100));
    maxlength_allow_open_search := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.allow_open_search)));
    avelength_allow_open_search := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.allow_open_search)),h.allow_open_search<>(typeof(h.allow_open_search))'');
    populated_append_overwrite_flag_pcnt := AVE(GROUP,IF(h.append_overwrite_flag = (TYPEOF(h.append_overwrite_flag))'',0,100));
    maxlength_append_overwrite_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.append_overwrite_flag)));
    avelength_append_overwrite_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.append_overwrite_flag)),h.append_overwrite_flag<>(typeof(h.append_overwrite_flag))'');
    populated_drivers_exchange_flag_pcnt := AVE(GROUP,IF(h.drivers_exchange_flag = (TYPEOF(h.drivers_exchange_flag))'',0,100));
    maxlength_drivers_exchange_flag := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.drivers_exchange_flag)));
    avelength_drivers_exchange_flag := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.drivers_exchange_flag)),h.drivers_exchange_flag<>(typeof(h.drivers_exchange_flag))'');
    populated_source_start_date_pcnt := AVE(GROUP,IF(h.source_start_date = (TYPEOF(h.source_start_date))'',0,100));
    maxlength_source_start_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_start_date)));
    avelength_source_start_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_start_date)),h.source_start_date<>(typeof(h.source_start_date))'');
    populated_source_end_date_pcnt := AVE(GROUP,IF(h.source_end_date = (TYPEOF(h.source_end_date))'',0,100));
    maxlength_source_end_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_end_date)));
    avelength_source_end_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_end_date)),h.source_end_date<>(typeof(h.source_end_date))'');
    populated_source_termination_date_pcnt := AVE(GROUP,IF(h.source_termination_date = (TYPEOF(h.source_termination_date))'',0,100));
    maxlength_source_termination_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_termination_date)));
    avelength_source_termination_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_termination_date)),h.source_termination_date<>(typeof(h.source_termination_date))'');
    populated_source_resale_allowed_pcnt := AVE(GROUP,IF(h.source_resale_allowed = (TYPEOF(h.source_resale_allowed))'',0,100));
    maxlength_source_resale_allowed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_resale_allowed)));
    avelength_source_resale_allowed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_resale_allowed)),h.source_resale_allowed<>(typeof(h.source_resale_allowed))'');
    populated_source_auto_renew_pcnt := AVE(GROUP,IF(h.source_auto_renew = (TYPEOF(h.source_auto_renew))'',0,100));
    maxlength_source_auto_renew := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_auto_renew)));
    avelength_source_auto_renew := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_auto_renew)),h.source_auto_renew<>(typeof(h.source_auto_renew))'');
    populated_source_allow_sale_of_component_data_pcnt := AVE(GROUP,IF(h.source_allow_sale_of_component_data = (TYPEOF(h.source_allow_sale_of_component_data))'',0,100));
    maxlength_source_allow_sale_of_component_data := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_allow_sale_of_component_data)));
    avelength_source_allow_sale_of_component_data := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_allow_sale_of_component_data)),h.source_allow_sale_of_component_data<>(typeof(h.source_allow_sale_of_component_data))'');
    populated_source_allow_extract_of_vehicle_data_pcnt := AVE(GROUP,IF(h.source_allow_extract_of_vehicle_data = (TYPEOF(h.source_allow_extract_of_vehicle_data))'',0,100));
    maxlength_source_allow_extract_of_vehicle_data := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_allow_extract_of_vehicle_data)));
    avelength_source_allow_extract_of_vehicle_data := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.source_allow_extract_of_vehicle_data)),h.source_allow_extract_of_vehicle_data<>(typeof(h.source_allow_extract_of_vehicle_data))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_agency_id_pcnt *   0.00 / 100 + T.Populated_agency_name_pcnt *   0.00 / 100 + T.Populated_source_id_pcnt *   0.00 / 100 + T.Populated_agency_state_abbr_pcnt *   0.00 / 100 + T.Populated_agency_ori_pcnt *   0.00 / 100 + T.Populated_allow_open_search_pcnt *   0.00 / 100 + T.Populated_append_overwrite_flag_pcnt *   0.00 / 100 + T.Populated_drivers_exchange_flag_pcnt *   0.00 / 100 + T.Populated_source_start_date_pcnt *   0.00 / 100 + T.Populated_source_end_date_pcnt *   0.00 / 100 + T.Populated_source_termination_date_pcnt *   0.00 / 100 + T.Populated_source_resale_allowed_pcnt *   0.00 / 100 + T.Populated_source_auto_renew_pcnt *   0.00 / 100 + T.Populated_source_allow_sale_of_component_data_pcnt *   0.00 / 100 + T.Populated_source_allow_extract_of_vehicle_data_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'agency_id','agency_name','source_id','agency_state_abbr','agency_ori','allow_open_search','append_overwrite_flag','drivers_exchange_flag','source_start_date','source_end_date','source_termination_date','source_resale_allowed','source_auto_renew','source_allow_sale_of_component_data','source_allow_extract_of_vehicle_data');
  SELF.populated_pcnt := CHOOSE(C,le.populated_agency_id_pcnt,le.populated_agency_name_pcnt,le.populated_source_id_pcnt,le.populated_agency_state_abbr_pcnt,le.populated_agency_ori_pcnt,le.populated_allow_open_search_pcnt,le.populated_append_overwrite_flag_pcnt,le.populated_drivers_exchange_flag_pcnt,le.populated_source_start_date_pcnt,le.populated_source_end_date_pcnt,le.populated_source_termination_date_pcnt,le.populated_source_resale_allowed_pcnt,le.populated_source_auto_renew_pcnt,le.populated_source_allow_sale_of_component_data_pcnt,le.populated_source_allow_extract_of_vehicle_data_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_agency_id,le.maxlength_agency_name,le.maxlength_source_id,le.maxlength_agency_state_abbr,le.maxlength_agency_ori,le.maxlength_allow_open_search,le.maxlength_append_overwrite_flag,le.maxlength_drivers_exchange_flag,le.maxlength_source_start_date,le.maxlength_source_end_date,le.maxlength_source_termination_date,le.maxlength_source_resale_allowed,le.maxlength_source_auto_renew,le.maxlength_source_allow_sale_of_component_data,le.maxlength_source_allow_extract_of_vehicle_data);
  SELF.avelength := CHOOSE(C,le.avelength_agency_id,le.avelength_agency_name,le.avelength_source_id,le.avelength_agency_state_abbr,le.avelength_agency_ori,le.avelength_allow_open_search,le.avelength_append_overwrite_flag,le.avelength_drivers_exchange_flag,le.avelength_source_start_date,le.avelength_source_end_date,le.avelength_source_termination_date,le.avelength_source_resale_allowed,le.avelength_source_auto_renew,le.avelength_source_allow_sale_of_component_data,le.avelength_source_allow_extract_of_vehicle_data);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.agency_id),TRIM((SALT37.StrType)le.agency_name),TRIM((SALT37.StrType)le.source_id),TRIM((SALT37.StrType)le.agency_state_abbr),TRIM((SALT37.StrType)le.agency_ori),TRIM((SALT37.StrType)le.allow_open_search),TRIM((SALT37.StrType)le.append_overwrite_flag),TRIM((SALT37.StrType)le.drivers_exchange_flag),TRIM((SALT37.StrType)le.source_start_date),TRIM((SALT37.StrType)le.source_end_date),TRIM((SALT37.StrType)le.source_termination_date),TRIM((SALT37.StrType)le.source_resale_allowed),TRIM((SALT37.StrType)le.source_auto_renew),TRIM((SALT37.StrType)le.source_allow_sale_of_component_data),TRIM((SALT37.StrType)le.source_allow_extract_of_vehicle_data)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.agency_id),TRIM((SALT37.StrType)le.agency_name),TRIM((SALT37.StrType)le.source_id),TRIM((SALT37.StrType)le.agency_state_abbr),TRIM((SALT37.StrType)le.agency_ori),TRIM((SALT37.StrType)le.allow_open_search),TRIM((SALT37.StrType)le.append_overwrite_flag),TRIM((SALT37.StrType)le.drivers_exchange_flag),TRIM((SALT37.StrType)le.source_start_date),TRIM((SALT37.StrType)le.source_end_date),TRIM((SALT37.StrType)le.source_termination_date),TRIM((SALT37.StrType)le.source_resale_allowed),TRIM((SALT37.StrType)le.source_auto_renew),TRIM((SALT37.StrType)le.source_allow_sale_of_component_data),TRIM((SALT37.StrType)le.source_allow_extract_of_vehicle_data)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.agency_id),TRIM((SALT37.StrType)le.agency_name),TRIM((SALT37.StrType)le.source_id),TRIM((SALT37.StrType)le.agency_state_abbr),TRIM((SALT37.StrType)le.agency_ori),TRIM((SALT37.StrType)le.allow_open_search),TRIM((SALT37.StrType)le.append_overwrite_flag),TRIM((SALT37.StrType)le.drivers_exchange_flag),TRIM((SALT37.StrType)le.source_start_date),TRIM((SALT37.StrType)le.source_end_date),TRIM((SALT37.StrType)le.source_termination_date),TRIM((SALT37.StrType)le.source_resale_allowed),TRIM((SALT37.StrType)le.source_auto_renew),TRIM((SALT37.StrType)le.source_allow_sale_of_component_data),TRIM((SALT37.StrType)le.source_allow_extract_of_vehicle_data)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'agency_id'}
      ,{2,'agency_name'}
      ,{3,'source_id'}
      ,{4,'agency_state_abbr'}
      ,{5,'agency_ori'}
      ,{6,'allow_open_search'}
      ,{7,'append_overwrite_flag'}
      ,{8,'drivers_exchange_flag'}
      ,{9,'source_start_date'}
      ,{10,'source_end_date'}
      ,{11,'source_termination_date'}
      ,{12,'source_resale_allowed'}
      ,{13,'source_auto_renew'}
      ,{14,'source_allow_sale_of_component_data'}
      ,{15,'source_allow_extract_of_vehicle_data'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_agency_id((SALT37.StrType)le.agency_id),
    Fields.InValid_agency_name((SALT37.StrType)le.agency_name),
    Fields.InValid_source_id((SALT37.StrType)le.source_id),
    Fields.InValid_agency_state_abbr((SALT37.StrType)le.agency_state_abbr),
    Fields.InValid_agency_ori((SALT37.StrType)le.agency_ori),
    Fields.InValid_allow_open_search((SALT37.StrType)le.allow_open_search),
    Fields.InValid_append_overwrite_flag((SALT37.StrType)le.append_overwrite_flag),
    Fields.InValid_drivers_exchange_flag((SALT37.StrType)le.drivers_exchange_flag),
    Fields.InValid_source_start_date((SALT37.StrType)le.source_start_date),
    Fields.InValid_source_end_date((SALT37.StrType)le.source_end_date),
    Fields.InValid_source_termination_date((SALT37.StrType)le.source_termination_date),
    Fields.InValid_source_resale_allowed((SALT37.StrType)le.source_resale_allowed),
    Fields.InValid_source_auto_renew((SALT37.StrType)le.source_auto_renew),
    Fields.InValid_source_allow_sale_of_component_data((SALT37.StrType)le.source_allow_sale_of_component_data),
    Fields.InValid_source_allow_extract_of_vehicle_data((SALT37.StrType)le.source_allow_extract_of_vehicle_data),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_agency_id','Unknown','invalid_source_id','invalid_agency_state_abbr','invalid_agency_ori','invalid_allow_open_search','invalid_append_overwrite_flag','invalid_drivers_exchange_flag','invalid_date','invalid_date','invalid_date_time','invalid_resale_allowed','invalid_auto_renew','invalid_Allow_Sale_Of_Component_Data','invalid_Allow_Extract_Of_Vehicle_Data');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_agency_id(TotalErrors.ErrorNum),Fields.InValidMessage_agency_name(TotalErrors.ErrorNum),Fields.InValidMessage_source_id(TotalErrors.ErrorNum),Fields.InValidMessage_agency_state_abbr(TotalErrors.ErrorNum),Fields.InValidMessage_agency_ori(TotalErrors.ErrorNum),Fields.InValidMessage_allow_open_search(TotalErrors.ErrorNum),Fields.InValidMessage_append_overwrite_flag(TotalErrors.ErrorNum),Fields.InValidMessage_drivers_exchange_flag(TotalErrors.ErrorNum),Fields.InValidMessage_source_start_date(TotalErrors.ErrorNum),Fields.InValidMessage_source_end_date(TotalErrors.ErrorNum),Fields.InValidMessage_source_termination_date(TotalErrors.ErrorNum),Fields.InValidMessage_source_resale_allowed(TotalErrors.ErrorNum),Fields.InValidMessage_source_auto_renew(TotalErrors.ErrorNum),Fields.InValidMessage_source_allow_sale_of_component_data(TotalErrors.ErrorNum),Fields.InValidMessage_source_allow_extract_of_vehicle_data(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
