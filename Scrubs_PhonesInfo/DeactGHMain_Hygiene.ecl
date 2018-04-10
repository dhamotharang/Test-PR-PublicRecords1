IMPORT SALT36;
EXPORT DeactGHMain_hygiene(dataset(DeactGHMain_layout_Phonesinfo) h) := MODULE

//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_groupid_pcnt := AVE(GROUP,IF(h.groupid = (TYPEOF(h.groupid))'',0,100));
    maxlength_groupid := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.groupid)));
    avelength_groupid := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.groupid)),h.groupid<>(typeof(h.groupid))'');
    populated_vendor_first_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_first_reported_dt = (TYPEOF(h.vendor_first_reported_dt))'',0,100));
    maxlength_vendor_first_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor_first_reported_dt)));
    avelength_vendor_first_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor_first_reported_dt)),h.vendor_first_reported_dt<>(typeof(h.vendor_first_reported_dt))'');
    populated_vendor_last_reported_dt_pcnt := AVE(GROUP,IF(h.vendor_last_reported_dt = (TYPEOF(h.vendor_last_reported_dt))'',0,100));
    maxlength_vendor_last_reported_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor_last_reported_dt)));
    avelength_vendor_last_reported_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.vendor_last_reported_dt)),h.vendor_last_reported_dt<>(typeof(h.vendor_last_reported_dt))'');
    populated_action_code_pcnt := AVE(GROUP,IF(h.action_code = (TYPEOF(h.action_code))'',0,100));
    maxlength_action_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.action_code)));
    avelength_action_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.action_code)),h.action_code<>(typeof(h.action_code))'');
    populated_timestamp_pcnt := AVE(GROUP,IF(h.timestamp = (TYPEOF(h.timestamp))'',0,100));
    maxlength_timestamp := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.timestamp)));
    avelength_timestamp := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.timestamp)),h.timestamp<>(typeof(h.timestamp))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_phone_swap_pcnt := AVE(GROUP,IF(h.phone_swap = (TYPEOF(h.phone_swap))'',0,100));
    maxlength_phone_swap := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone_swap)));
    avelength_phone_swap := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.phone_swap)),h.phone_swap<>(typeof(h.phone_swap))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
    populated_carrier_name_pcnt := AVE(GROUP,IF(h.carrier_name = (TYPEOF(h.carrier_name))'',0,100));
    maxlength_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_name)));
    avelength_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_name)),h.carrier_name<>(typeof(h.carrier_name))'');
    populated_filedate_pcnt := AVE(GROUP,IF(h.filedate = (TYPEOF(h.filedate))'',0,100));
    maxlength_filedate := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filedate)));
    avelength_filedate := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filedate)),h.filedate<>(typeof(h.filedate))'');
    populated_swap_start_dt_pcnt := AVE(GROUP,IF(h.swap_start_dt = (TYPEOF(h.swap_start_dt))'',0,100));
    maxlength_swap_start_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.swap_start_dt)));
    avelength_swap_start_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.swap_start_dt)),h.swap_start_dt<>(typeof(h.swap_start_dt))'');
    populated_swap_end_dt_pcnt := AVE(GROUP,IF(h.swap_end_dt = (TYPEOF(h.swap_end_dt))'',0,100));
    maxlength_swap_end_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.swap_end_dt)));
    avelength_swap_end_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.swap_end_dt)),h.swap_end_dt<>(typeof(h.swap_end_dt))'');
    populated_deact_code_pcnt := AVE(GROUP,IF(h.deact_code = (TYPEOF(h.deact_code))'',0,100));
    maxlength_deact_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_code)));
    avelength_deact_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_code)),h.deact_code<>(typeof(h.deact_code))'');
    populated_deact_start_dt_pcnt := AVE(GROUP,IF(h.deact_start_dt = (TYPEOF(h.deact_start_dt))'',0,100));
    maxlength_deact_start_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_start_dt)));
    avelength_deact_start_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_start_dt)),h.deact_start_dt<>(typeof(h.deact_start_dt))'');
    populated_deact_end_dt_pcnt := AVE(GROUP,IF(h.deact_end_dt = (TYPEOF(h.deact_end_dt))'',0,100));
    maxlength_deact_end_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_end_dt)));
    avelength_deact_end_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.deact_end_dt)),h.deact_end_dt<>(typeof(h.deact_end_dt))'');
    populated_react_start_dt_pcnt := AVE(GROUP,IF(h.react_start_dt = (TYPEOF(h.react_start_dt))'',0,100));
    maxlength_react_start_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.react_start_dt)));
    avelength_react_start_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.react_start_dt)),h.react_start_dt<>(typeof(h.react_start_dt))'');
    populated_react_end_dt_pcnt := AVE(GROUP,IF(h.react_end_dt = (TYPEOF(h.react_end_dt))'',0,100));
    maxlength_react_end_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.react_end_dt)));
    avelength_react_end_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.react_end_dt)),h.react_end_dt<>(typeof(h.react_end_dt))'');
    populated_is_react_pcnt := AVE(GROUP,IF(h.is_react = (TYPEOF(h.is_react))'',0,100));
    maxlength_is_react := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_react)));
    avelength_is_react := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_react)),h.is_react<>(typeof(h.is_react))'');
    populated_is_deact_pcnt := AVE(GROUP,IF(h.is_deact = (TYPEOF(h.is_deact))'',0,100));
    maxlength_is_deact := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_deact)));
    avelength_is_deact := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.is_deact)),h.is_deact<>(typeof(h.is_deact))'');
    populated_porting_dt_pcnt := AVE(GROUP,IF(h.porting_dt = (TYPEOF(h.porting_dt))'',0,100));
    maxlength_porting_dt := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.porting_dt)));
    avelength_porting_dt := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.porting_dt)),h.porting_dt<>(typeof(h.porting_dt))'');
    populated_pk_carrier_name_pcnt := AVE(GROUP,IF(h.pk_carrier_name = (TYPEOF(h.pk_carrier_name))'',0,100));
    maxlength_pk_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.pk_carrier_name)));
    avelength_pk_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.pk_carrier_name)),h.pk_carrier_name<>(typeof(h.pk_carrier_name))'');
    populated_days_apart_pcnt := AVE(GROUP,IF(h.days_apart = (TYPEOF(h.days_apart))'',0,100));
    maxlength_days_apart := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.days_apart)));
    avelength_days_apart := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.days_apart)),h.days_apart<>(typeof(h.days_apart))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_groupid_pcnt *   0.00 / 100 + T.Populated_vendor_first_reported_dt_pcnt *   0.00 / 100 + T.Populated_vendor_last_reported_dt_pcnt *   0.00 / 100 + T.Populated_action_code_pcnt *   0.00 / 100 + T.Populated_timestamp_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_phone_swap_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100 + T.Populated_carrier_name_pcnt *   0.00 / 100 + T.Populated_filedate_pcnt *   0.00 / 100 + T.Populated_swap_start_dt_pcnt *   0.00 / 100 + T.Populated_swap_end_dt_pcnt *   0.00 / 100 + T.Populated_deact_code_pcnt *   0.00 / 100 + T.Populated_deact_start_dt_pcnt *   0.00 / 100 + T.Populated_deact_end_dt_pcnt *   0.00 / 100 + T.Populated_react_start_dt_pcnt *   0.00 / 100 + T.Populated_react_end_dt_pcnt *   0.00 / 100 + T.Populated_is_react_pcnt *   0.00 / 100 + T.Populated_is_deact_pcnt *   0.00 / 100 + T.Populated_porting_dt_pcnt *   0.00 / 100 + T.Populated_pk_carrier_name_pcnt *   0.00 / 100 + T.Populated_days_apart_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'groupid','vendor_first_reported_dt','vendor_last_reported_dt','action_code','timestamp','phone','phone_swap','filename','carrier_name','filedate','swap_start_dt','swap_end_dt','deact_code','deact_start_dt','deact_end_dt','react_start_dt','react_end_dt','is_react','is_deact','porting_dt','pk_carrier_name','days_apart');
  SELF.populated_pcnt := CHOOSE(C,le.populated_groupid_pcnt,le.populated_vendor_first_reported_dt_pcnt,le.populated_vendor_last_reported_dt_pcnt,le.populated_action_code_pcnt,le.populated_timestamp_pcnt,le.populated_phone_pcnt,le.populated_phone_swap_pcnt,le.populated_filename_pcnt,le.populated_carrier_name_pcnt,le.populated_filedate_pcnt,le.populated_swap_start_dt_pcnt,le.populated_swap_end_dt_pcnt,le.populated_deact_code_pcnt,le.populated_deact_start_dt_pcnt,le.populated_deact_end_dt_pcnt,le.populated_react_start_dt_pcnt,le.populated_react_end_dt_pcnt,le.populated_is_react_pcnt,le.populated_is_deact_pcnt,le.populated_porting_dt_pcnt,le.populated_pk_carrier_name_pcnt,le.populated_days_apart_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_groupid,le.maxlength_vendor_first_reported_dt,le.maxlength_vendor_last_reported_dt,le.maxlength_action_code,le.maxlength_timestamp,le.maxlength_phone,le.maxlength_phone_swap,le.maxlength_filename,le.maxlength_carrier_name,le.maxlength_filedate,le.maxlength_swap_start_dt,le.maxlength_swap_end_dt,le.maxlength_deact_code,le.maxlength_deact_start_dt,le.maxlength_deact_end_dt,le.maxlength_react_start_dt,le.maxlength_react_end_dt,le.maxlength_is_react,le.maxlength_is_deact,le.maxlength_porting_dt,le.maxlength_pk_carrier_name,le.maxlength_days_apart);
  SELF.avelength := CHOOSE(C,le.avelength_groupid,le.avelength_vendor_first_reported_dt,le.avelength_vendor_last_reported_dt,le.avelength_action_code,le.avelength_timestamp,le.avelength_phone,le.avelength_phone_swap,le.avelength_filename,le.avelength_carrier_name,le.avelength_filedate,le.avelength_swap_start_dt,le.avelength_swap_end_dt,le.avelength_deact_code,le.avelength_deact_start_dt,le.avelength_deact_end_dt,le.avelength_react_start_dt,le.avelength_react_end_dt,le.avelength_is_react,le.avelength_is_deact,le.avelength_porting_dt,le.avelength_pk_carrier_name,le.avelength_days_apart);
END;
EXPORT invSummary := NORMALIZE(summary0, 22, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.groupid <> 0,TRIM((SALT36.StrType)le.groupid), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_first_reported_dt), ''),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT36.StrType)le.action_code),TRIM((SALT36.StrType)le.timestamp),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_swap),TRIM((SALT36.StrType)le.filename),TRIM((SALT36.StrType)le.carrier_name),TRIM((SALT36.StrType)le.filedate),IF (le.swap_start_dt <> 0,TRIM((SALT36.StrType)le.swap_start_dt), ''),IF (le.swap_end_dt <> 0,TRIM((SALT36.StrType)le.swap_end_dt), ''),TRIM((SALT36.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT36.StrType)le.deact_start_dt), ''),IF (le.deact_end_dt <> 0,TRIM((SALT36.StrType)le.deact_end_dt), ''),IF (le.react_start_dt <> 0,TRIM((SALT36.StrType)le.react_start_dt), ''),IF (le.react_end_dt <> 0,TRIM((SALT36.StrType)le.react_end_dt), ''),TRIM((SALT36.StrType)le.is_react),TRIM((SALT36.StrType)le.is_deact),IF (le.porting_dt <> 0,TRIM((SALT36.StrType)le.porting_dt), ''),TRIM((SALT36.StrType)le.pk_carrier_name),IF (le.days_apart <> 0,TRIM((SALT36.StrType)le.days_apart), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 22);
  SELF.FldNo2 := 1 + (C % 22);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.groupid <> 0,TRIM((SALT36.StrType)le.groupid), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_first_reported_dt), ''),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT36.StrType)le.action_code),TRIM((SALT36.StrType)le.timestamp),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_swap),TRIM((SALT36.StrType)le.filename),TRIM((SALT36.StrType)le.carrier_name),TRIM((SALT36.StrType)le.filedate),IF (le.swap_start_dt <> 0,TRIM((SALT36.StrType)le.swap_start_dt), ''),IF (le.swap_end_dt <> 0,TRIM((SALT36.StrType)le.swap_end_dt), ''),TRIM((SALT36.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT36.StrType)le.deact_start_dt), ''),IF (le.deact_end_dt <> 0,TRIM((SALT36.StrType)le.deact_end_dt), ''),IF (le.react_start_dt <> 0,TRIM((SALT36.StrType)le.react_start_dt), ''),IF (le.react_end_dt <> 0,TRIM((SALT36.StrType)le.react_end_dt), ''),TRIM((SALT36.StrType)le.is_react),TRIM((SALT36.StrType)le.is_deact),IF (le.porting_dt <> 0,TRIM((SALT36.StrType)le.porting_dt), ''),TRIM((SALT36.StrType)le.pk_carrier_name),IF (le.days_apart <> 0,TRIM((SALT36.StrType)le.days_apart), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.groupid <> 0,TRIM((SALT36.StrType)le.groupid), ''),IF (le.vendor_first_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_first_reported_dt), ''),IF (le.vendor_last_reported_dt <> 0,TRIM((SALT36.StrType)le.vendor_last_reported_dt), ''),TRIM((SALT36.StrType)le.action_code),TRIM((SALT36.StrType)le.timestamp),TRIM((SALT36.StrType)le.phone),TRIM((SALT36.StrType)le.phone_swap),TRIM((SALT36.StrType)le.filename),TRIM((SALT36.StrType)le.carrier_name),TRIM((SALT36.StrType)le.filedate),IF (le.swap_start_dt <> 0,TRIM((SALT36.StrType)le.swap_start_dt), ''),IF (le.swap_end_dt <> 0,TRIM((SALT36.StrType)le.swap_end_dt), ''),TRIM((SALT36.StrType)le.deact_code),IF (le.deact_start_dt <> 0,TRIM((SALT36.StrType)le.deact_start_dt), ''),IF (le.deact_end_dt <> 0,TRIM((SALT36.StrType)le.deact_end_dt), ''),IF (le.react_start_dt <> 0,TRIM((SALT36.StrType)le.react_start_dt), ''),IF (le.react_end_dt <> 0,TRIM((SALT36.StrType)le.react_end_dt), ''),TRIM((SALT36.StrType)le.is_react),TRIM((SALT36.StrType)le.is_deact),IF (le.porting_dt <> 0,TRIM((SALT36.StrType)le.porting_dt), ''),TRIM((SALT36.StrType)le.pk_carrier_name),IF (le.days_apart <> 0,TRIM((SALT36.StrType)le.days_apart), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),22*22,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'groupid'}
      ,{2,'vendor_first_reported_dt'}
      ,{3,'vendor_last_reported_dt'}
      ,{4,'action_code'}
      ,{5,'timestamp'}
      ,{6,'phone'}
      ,{7,'phone_swap'}
      ,{8,'filename'}
      ,{9,'carrier_name'}
      ,{10,'filedate'}
      ,{11,'swap_start_dt'}
      ,{12,'swap_end_dt'}
      ,{13,'deact_code'}
      ,{14,'deact_start_dt'}
      ,{15,'deact_end_dt'}
      ,{16,'react_start_dt'}
      ,{17,'react_end_dt'}
      ,{18,'is_react'}
      ,{19,'is_deact'}
      ,{20,'porting_dt'}
      ,{21,'pk_carrier_name'}
      ,{22,'days_apart'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DeactGHMain_Fields.InValid_groupid((SALT36.StrType)le.groupid),
    DeactGHMain_Fields.InValid_vendor_first_reported_dt((SALT36.StrType)le.vendor_first_reported_dt),
    DeactGHMain_Fields.InValid_vendor_last_reported_dt((SALT36.StrType)le.vendor_last_reported_dt),
    DeactGHMain_Fields.InValid_action_code((SALT36.StrType)le.action_code),
    DeactGHMain_Fields.InValid_timestamp((SALT36.StrType)le.timestamp),
    DeactGHMain_Fields.InValid_phone((SALT36.StrType)le.phone),
    DeactGHMain_Fields.InValid_phone_swap((SALT36.StrType)le.phone_swap),
    DeactGHMain_Fields.InValid_filename((SALT36.StrType)le.filename),
    DeactGHMain_Fields.InValid_carrier_name((SALT36.StrType)le.carrier_name),
    DeactGHMain_Fields.InValid_filedate((SALT36.StrType)le.filedate),
    DeactGHMain_Fields.InValid_swap_start_dt((SALT36.StrType)le.swap_start_dt),
    DeactGHMain_Fields.InValid_swap_end_dt((SALT36.StrType)le.swap_end_dt),
    DeactGHMain_Fields.InValid_deact_code((SALT36.StrType)le.deact_code),
    DeactGHMain_Fields.InValid_deact_start_dt((SALT36.StrType)le.deact_start_dt),
    DeactGHMain_Fields.InValid_deact_end_dt((SALT36.StrType)le.deact_end_dt),
    DeactGHMain_Fields.InValid_react_start_dt((SALT36.StrType)le.react_start_dt),
    DeactGHMain_Fields.InValid_react_end_dt((SALT36.StrType)le.react_end_dt),
    DeactGHMain_Fields.InValid_is_react((SALT36.StrType)le.is_react),
    DeactGHMain_Fields.InValid_is_deact((SALT36.StrType)le.is_deact),
    DeactGHMain_Fields.InValid_porting_dt((SALT36.StrType)le.porting_dt),
    DeactGHMain_Fields.InValid_pk_carrier_name((SALT36.StrType)le.pk_carrier_name),
    DeactGHMain_Fields.InValid_days_apart((SALT36.StrType)le.days_apart),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,22,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := DeactGHMain_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Date','Invalid_Date','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Invalid_Date','Unknown','Unknown','Invalid_DeactCode','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_YN','Invalid_YN','Invalid_Date','Unknown','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DeactGHMain_Fields.InValidMessage_groupid(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_vendor_first_reported_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_vendor_last_reported_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_action_code(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_timestamp(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_phone(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_phone_swap(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_filename(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_carrier_name(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_filedate(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_swap_start_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_swap_end_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_deact_code(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_deact_start_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_deact_end_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_react_start_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_react_end_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_is_react(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_is_deact(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_porting_dt(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_pk_carrier_name(TotalErrors.ErrorNum),DeactGHMain_Fields.InValidMessage_days_apart(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
