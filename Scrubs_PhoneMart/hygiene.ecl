import ut,SALT30;
export hygiene(dataset(layout_PhoneMart) h) := MODULE
//A simple summary record
export Summary(SALT30.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_cid_number_pcnt := AVE(GROUP,IF(h.cid_number = (TYPEOF(h.cid_number))'',0,100));
    maxlength_cid_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cid_number)));
    avelength_cid_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cid_number)),h.cid_number<>(typeof(h.cid_number))'');
    populated_csd_ref_number_pcnt := AVE(GROUP,IF(h.csd_ref_number = (TYPEOF(h.csd_ref_number))'',0,100));
    maxlength_csd_ref_number := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.csd_ref_number)));
    avelength_csd_ref_number := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.csd_ref_number)),h.csd_ref_number<>(typeof(h.csd_ref_number))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_history_flag_pcnt := AVE(GROUP,IF(h.history_flag = (TYPEOF(h.history_flag))'',0,100));
    maxlength_history_flag := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.history_flag)));
    avelength_history_flag := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.history_flag)),h.history_flag<>(typeof(h.history_flag))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
  END;
  RETURN table(h,SummaryLayout);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'phone','did','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','cid_number','csd_ref_number','ssn','address','city','state','zipcode','history_flag','title','fname','mname','lname','name_suffix');
  SELF.populated_pcnt := CHOOSE(C,le.populated_phone_pcnt,le.populated_did_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_record_type_pcnt,le.populated_cid_number_pcnt,le.populated_csd_ref_number_pcnt,le.populated_ssn_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_history_flag_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_phone,le.maxlength_did,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_record_type,le.maxlength_cid_number,le.maxlength_csd_ref_number,le.maxlength_ssn,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_history_flag,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix);
  SELF.avelength := CHOOSE(C,le.avelength_phone,le.avelength_did,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_record_type,le.avelength_cid_number,le.avelength_csd_ref_number,le.avelength_ssn,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_history_flag,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix);
END;
EXPORT invSummary := NORMALIZE(summary0, 20, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.cid_number),TRIM((SALT30.StrType)le.csd_ref_number),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,20,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 20);
  SELF.FldNo2 := 1 + (C % 20);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.cid_number),TRIM((SALT30.StrType)le.csd_ref_number),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.dt_vendor_first_reported),TRIM((SALT30.StrType)le.dt_vendor_last_reported),TRIM((SALT30.StrType)le.dt_first_seen),TRIM((SALT30.StrType)le.dt_last_seen),TRIM((SALT30.StrType)le.record_type),TRIM((SALT30.StrType)le.cid_number),TRIM((SALT30.StrType)le.csd_ref_number),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.address),TRIM((SALT30.StrType)le.city),TRIM((SALT30.StrType)le.state),TRIM((SALT30.StrType)le.zipcode),TRIM((SALT30.StrType)le.history_flag),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),20*20,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'phone'}
      ,{2,'did'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'dt_first_seen'}
      ,{6,'dt_last_seen'}
      ,{7,'record_type'}
      ,{8,'cid_number'}
      ,{9,'csd_ref_number'}
      ,{10,'ssn'}
      ,{11,'address'}
      ,{12,'city'}
      ,{13,'state'}
      ,{14,'zipcode'}
      ,{15,'history_flag'}
      ,{16,'title'}
      ,{17,'fname'}
      ,{18,'mname'}
      ,{19,'lname'}
      ,{20,'name_suffix'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_phone((SALT30.StrType)le.phone),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_dt_vendor_first_reported((SALT30.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT30.StrType)le.dt_vendor_last_reported),
    Fields.InValid_dt_first_seen((SALT30.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT30.StrType)le.dt_last_seen),
    Fields.InValid_record_type((SALT30.StrType)le.record_type),
    Fields.InValid_cid_number((SALT30.StrType)le.cid_number),
    Fields.InValid_csd_ref_number((SALT30.StrType)le.csd_ref_number),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_address((SALT30.StrType)le.address),
    Fields.InValid_city((SALT30.StrType)le.city),
    Fields.InValid_state((SALT30.StrType)le.state),
    Fields.InValid_zipcode((SALT30.StrType)le.zipcode),
    Fields.InValid_history_flag((SALT30.StrType)le.history_flag),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_phone','invalid_number','invalid_date','invalid_date','invalid_date','invalid_date','invalid_record_type','invalid_alpha_numeric','invalid_number','invalid_ssn','Unknown','invalid_alpha','invalid_state','invalid_zip5','invalid_history_flag','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha','invalid_alpha');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_cid_number(TotalErrors.ErrorNum),Fields.InValidMessage_csd_ref_number(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_history_flag(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
