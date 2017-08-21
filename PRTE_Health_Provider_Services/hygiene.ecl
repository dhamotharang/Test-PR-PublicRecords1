import ut,SALT29;
export hygiene(dataset(layout_HealthProvider) h) := MODULE
//A simple summary record
export Summary(SALT29.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_SNAME_pcnt := AVE(GROUP,IF(h.SNAME = (TYPEOF(h.SNAME))'',0,100));
    maxlength_SNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SNAME)));
    avelength_SNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SNAME)),h.SNAME<>(typeof(h.SNAME))'');
    populated_GENDER_pcnt := AVE(GROUP,IF(h.GENDER = (TYPEOF(h.GENDER))'',0,100));
    maxlength_GENDER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.GENDER)));
    avelength_GENDER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.GENDER)),h.GENDER<>(typeof(h.GENDER))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_V_CITY_NAME_pcnt := AVE(GROUP,IF(h.V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',0,100));
    maxlength_V_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.V_CITY_NAME)));
    avelength_V_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.V_CITY_NAME)),h.V_CITY_NAME<>(typeof(h.V_CITY_NAME))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_CNSMR_SSN_pcnt := AVE(GROUP,IF(h.CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',0,100));
    maxlength_CNSMR_SSN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_SSN)));
    avelength_CNSMR_SSN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_SSN)),h.CNSMR_SSN<>(typeof(h.CNSMR_SSN))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_CNSMR_DOB_pcnt := AVE(GROUP,IF(h.CNSMR_DOB = (TYPEOF(h.CNSMR_DOB))'',0,100));
    maxlength_CNSMR_DOB := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_DOB)));
    avelength_CNSMR_DOB := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_DOB)),h.CNSMR_DOB<>(typeof(h.CNSMR_DOB))'');
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_LIC_STATE_pcnt := AVE(GROUP,IF(h.LIC_STATE = (TYPEOF(h.LIC_STATE))'',0,100));
    maxlength_LIC_STATE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)));
    avelength_LIC_STATE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)),h.LIC_STATE<>(typeof(h.LIC_STATE))'');
    populated_C_LIC_NBR_pcnt := AVE(GROUP,IF(h.C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',0,100));
    maxlength_C_LIC_NBR := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)));
    avelength_C_LIC_NBR := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)),h.C_LIC_NBR<>(typeof(h.C_LIC_NBR))'');
    populated_TAX_ID_pcnt := AVE(GROUP,IF(h.TAX_ID = (TYPEOF(h.TAX_ID))'',0,100));
    maxlength_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)));
    avelength_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)),h.TAX_ID<>(typeof(h.TAX_ID))'');
    populated_BILLING_TAX_ID_pcnt := AVE(GROUP,IF(h.BILLING_TAX_ID = (TYPEOF(h.BILLING_TAX_ID))'',0,100));
    maxlength_BILLING_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_TAX_ID)));
    avelength_BILLING_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_TAX_ID)),h.BILLING_TAX_ID<>(typeof(h.BILLING_TAX_ID))'');
    populated_DEA_NUMBER_pcnt := AVE(GROUP,IF(h.DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',0,100));
    maxlength_DEA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)));
    avelength_DEA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)),h.DEA_NUMBER<>(typeof(h.DEA_NUMBER))'');
    populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)));
    avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
    populated_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',0,100));
    maxlength_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)));
    avelength_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)),h.NPI_NUMBER<>(typeof(h.NPI_NUMBER))'');
    populated_BILLING_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.BILLING_NPI_NUMBER = (TYPEOF(h.BILLING_NPI_NUMBER))'',0,100));
    maxlength_BILLING_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_NPI_NUMBER)));
    avelength_BILLING_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_NPI_NUMBER)),h.BILLING_NPI_NUMBER<>(typeof(h.BILLING_NPI_NUMBER))'');
    populated_UPIN_pcnt := AVE(GROUP,IF(h.UPIN = (TYPEOF(h.UPIN))'',0,100));
    maxlength_UPIN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.UPIN)));
    avelength_UPIN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.UPIN)),h.UPIN<>(typeof(h.UPIN))'');
    populated_DID_pcnt := AVE(GROUP,IF(h.DID = (TYPEOF(h.DID))'',0,100));
    maxlength_DID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DID)));
    avelength_DID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DID)),h.DID<>(typeof(h.DID))'');
    populated_BDID_pcnt := AVE(GROUP,IF(h.BDID = (TYPEOF(h.BDID))'',0,100));
    maxlength_BDID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BDID)));
    avelength_BDID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BDID)),h.BDID<>(typeof(h.BDID))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_SOURCE_RID_pcnt := AVE(GROUP,IF(h.SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',0,100));
    maxlength_SOURCE_RID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SOURCE_RID)));
    avelength_SOURCE_RID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SOURCE_RID)),h.SOURCE_RID<>(typeof(h.SOURCE_RID))'');
    populated_RID_pcnt := AVE(GROUP,IF(h.RID = (TYPEOF(h.RID))'',0,100));
    maxlength_RID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.RID)));
    avelength_RID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.RID)),h.RID<>(typeof(h.RID))'');
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT29.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LNPID;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID),TRIM((SALT29.StrType)le.RID)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT29.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID),TRIM((SALT29.StrType)le.RID)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID),TRIM((SALT29.StrType)le.RID)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'FNAME'}
      ,{2,'MNAME'}
      ,{3,'LNAME'}
      ,{4,'SNAME'}
      ,{5,'GENDER'}
      ,{6,'PRIM_RANGE'}
      ,{7,'PRIM_NAME'}
      ,{8,'SEC_RANGE'}
      ,{9,'V_CITY_NAME'}
      ,{10,'ST'}
      ,{11,'ZIP'}
      ,{12,'SSN'}
      ,{13,'CNSMR_SSN'}
      ,{14,'DOB'}
      ,{15,'CNSMR_DOB'}
      ,{16,'PHONE'}
      ,{17,'LIC_STATE'}
      ,{18,'C_LIC_NBR'}
      ,{19,'TAX_ID'}
      ,{20,'BILLING_TAX_ID'}
      ,{21,'DEA_NUMBER'}
      ,{22,'VENDOR_ID'}
      ,{23,'NPI_NUMBER'}
      ,{24,'BILLING_NPI_NUMBER'}
      ,{25,'UPIN'}
      ,{26,'DID'}
      ,{27,'BDID'}
      ,{28,'SRC'}
      ,{29,'SOURCE_RID'}
      ,{30,'RID'}],SALT29.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT29.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT29.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT29.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_FNAME((SALT29.StrType)le.FNAME),
    Fields.InValid_MNAME((SALT29.StrType)le.MNAME),
    Fields.InValid_LNAME((SALT29.StrType)le.LNAME),
    Fields.InValid_SNAME((SALT29.StrType)le.SNAME),
    Fields.InValid_GENDER((SALT29.StrType)le.GENDER),
    Fields.InValid_PRIM_RANGE((SALT29.StrType)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((SALT29.StrType)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((SALT29.StrType)le.SEC_RANGE),
    Fields.InValid_V_CITY_NAME((SALT29.StrType)le.V_CITY_NAME),
    Fields.InValid_ST((SALT29.StrType)le.ST),
    Fields.InValid_ZIP((SALT29.StrType)le.ZIP),
    Fields.InValid_SSN((SALT29.StrType)le.SSN),
    Fields.InValid_CNSMR_SSN((SALT29.StrType)le.CNSMR_SSN),
    Fields.InValid_DOB((SALT29.StrType)le.DOB),
    Fields.InValid_CNSMR_DOB((SALT29.StrType)le.CNSMR_DOB),
    Fields.InValid_PHONE((SALT29.StrType)le.PHONE),
    Fields.InValid_LIC_STATE((SALT29.StrType)le.LIC_STATE),
    Fields.InValid_C_LIC_NBR((SALT29.StrType)le.C_LIC_NBR),
    Fields.InValid_TAX_ID((SALT29.StrType)le.TAX_ID),
    Fields.InValid_BILLING_TAX_ID((SALT29.StrType)le.BILLING_TAX_ID),
    Fields.InValid_DEA_NUMBER((SALT29.StrType)le.DEA_NUMBER),
    Fields.InValid_VENDOR_ID((SALT29.StrType)le.VENDOR_ID),
    Fields.InValid_NPI_NUMBER((SALT29.StrType)le.NPI_NUMBER),
    Fields.InValid_BILLING_NPI_NUMBER((SALT29.StrType)le.BILLING_NPI_NUMBER),
    Fields.InValid_UPIN((SALT29.StrType)le.UPIN),
    Fields.InValid_DID((SALT29.StrType)le.DID),
    Fields.InValid_BDID((SALT29.StrType)le.BDID),
    Fields.InValid_SRC((SALT29.StrType)le.SRC),
    Fields.InValid_SOURCE_RID((SALT29.StrType)le.SOURCE_RID),
    Fields.InValid_RID((SALT29.StrType)le.RID),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,35,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_SNAME(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_V_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_CNSMR_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_CNSMR_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_LIC_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_C_LIC_NBR(TotalErrors.ErrorNum),Fields.InValidMessage_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_BILLING_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_DEA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_BILLING_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_UPIN(TotalErrors.ErrorNum),Fields.InValidMessage_DID(TotalErrors.ErrorNum),Fields.InValidMessage_BDID(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_SOURCE_RID(TotalErrors.ErrorNum),Fields.InValidMessage_RID(TotalErrors.ErrorNum),'','','','','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have LNPID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT29.MOD_ClusterStats.Counts(h,LNPID);
END;
