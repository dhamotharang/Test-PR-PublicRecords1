import ut,SALT29;
export hygiene(dataset(layout_HealthFacility) h) := MODULE
//A simple summary record
export Summary(SALT29.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_CNAME_pcnt := AVE(GROUP,IF(h.CNAME = (TYPEOF(h.CNAME))'',0,100));
    maxlength_CNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNAME)));
    avelength_CNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNAME)),h.CNAME<>(typeof(h.CNAME))'');
    populated_CNP_NAME_pcnt := AVE(GROUP,IF(h.CNP_NAME = (TYPEOF(h.CNP_NAME))'',0,100));
    maxlength_CNP_NAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_NAME)));
    avelength_CNP_NAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_NAME)),h.CNP_NAME<>(typeof(h.CNP_NAME))'');
    populated_CNP_NUMBER_pcnt := AVE(GROUP,IF(h.CNP_NUMBER = (TYPEOF(h.CNP_NUMBER))'',0,100));
    maxlength_CNP_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_NUMBER)));
    avelength_CNP_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_NUMBER)),h.CNP_NUMBER<>(typeof(h.CNP_NUMBER))'');
    populated_CNP_STORE_NUMBER_pcnt := AVE(GROUP,IF(h.CNP_STORE_NUMBER = (TYPEOF(h.CNP_STORE_NUMBER))'',0,100));
    maxlength_CNP_STORE_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_STORE_NUMBER)));
    avelength_CNP_STORE_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_STORE_NUMBER)),h.CNP_STORE_NUMBER<>(typeof(h.CNP_STORE_NUMBER))'');
    populated_CNP_BTYPE_pcnt := AVE(GROUP,IF(h.CNP_BTYPE = (TYPEOF(h.CNP_BTYPE))'',0,100));
    maxlength_CNP_BTYPE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_BTYPE)));
    avelength_CNP_BTYPE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_BTYPE)),h.CNP_BTYPE<>(typeof(h.CNP_BTYPE))'');
    populated_CNP_LOWV_pcnt := AVE(GROUP,IF(h.CNP_LOWV = (TYPEOF(h.CNP_LOWV))'',0,100));
    maxlength_CNP_LOWV := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_LOWV)));
    avelength_CNP_LOWV := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNP_LOWV)),h.CNP_LOWV<>(typeof(h.CNP_LOWV))'');
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
    populated_TAX_ID_pcnt := AVE(GROUP,IF(h.TAX_ID = (TYPEOF(h.TAX_ID))'',0,100));
    maxlength_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)));
    avelength_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)),h.TAX_ID<>(typeof(h.TAX_ID))'');
    populated_FEIN_pcnt := AVE(GROUP,IF(h.FEIN = (TYPEOF(h.FEIN))'',0,100));
    maxlength_FEIN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.FEIN)));
    avelength_FEIN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.FEIN)),h.FEIN<>(typeof(h.FEIN))'');
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_FAX_pcnt := AVE(GROUP,IF(h.FAX = (TYPEOF(h.FAX))'',0,100));
    maxlength_FAX := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.FAX)));
    avelength_FAX := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.FAX)),h.FAX<>(typeof(h.FAX))'');
    populated_LIC_STATE_pcnt := AVE(GROUP,IF(h.LIC_STATE = (TYPEOF(h.LIC_STATE))'',0,100));
    maxlength_LIC_STATE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)));
    avelength_LIC_STATE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)),h.LIC_STATE<>(typeof(h.LIC_STATE))'');
    populated_C_LIC_NBR_pcnt := AVE(GROUP,IF(h.C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',0,100));
    maxlength_C_LIC_NBR := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)));
    avelength_C_LIC_NBR := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)),h.C_LIC_NBR<>(typeof(h.C_LIC_NBR))'');
    populated_DEA_NUMBER_pcnt := AVE(GROUP,IF(h.DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',0,100));
    maxlength_DEA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)));
    avelength_DEA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)),h.DEA_NUMBER<>(typeof(h.DEA_NUMBER))'');
    populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)));
    avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
    populated_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',0,100));
    maxlength_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)));
    avelength_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)),h.NPI_NUMBER<>(typeof(h.NPI_NUMBER))'');
    populated_CLIA_NUMBER_pcnt := AVE(GROUP,IF(h.CLIA_NUMBER = (TYPEOF(h.CLIA_NUMBER))'',0,100));
    maxlength_CLIA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CLIA_NUMBER)));
    avelength_CLIA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CLIA_NUMBER)),h.CLIA_NUMBER<>(typeof(h.CLIA_NUMBER))'');
    populated_MEDICARE_FACILITY_NUMBER_pcnt := AVE(GROUP,IF(h.MEDICARE_FACILITY_NUMBER = (TYPEOF(h.MEDICARE_FACILITY_NUMBER))'',0,100));
    maxlength_MEDICARE_FACILITY_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.MEDICARE_FACILITY_NUMBER)));
    avelength_MEDICARE_FACILITY_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.MEDICARE_FACILITY_NUMBER)),h.MEDICARE_FACILITY_NUMBER<>(typeof(h.MEDICARE_FACILITY_NUMBER))'');
    populated_MEDICAID_NUMBER_pcnt := AVE(GROUP,IF(h.MEDICAID_NUMBER = (TYPEOF(h.MEDICAID_NUMBER))'',0,100));
    maxlength_MEDICAID_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.MEDICAID_NUMBER)));
    avelength_MEDICAID_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.MEDICAID_NUMBER)),h.MEDICAID_NUMBER<>(typeof(h.MEDICAID_NUMBER))'');
    populated_NCPDP_NUMBER_pcnt := AVE(GROUP,IF(h.NCPDP_NUMBER = (TYPEOF(h.NCPDP_NUMBER))'',0,100));
    maxlength_NCPDP_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.NCPDP_NUMBER)));
    avelength_NCPDP_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.NCPDP_NUMBER)),h.NCPDP_NUMBER<>(typeof(h.NCPDP_NUMBER))'');
    populated_TAXONOMY_pcnt := AVE(GROUP,IF(h.TAXONOMY = (TYPEOF(h.TAXONOMY))'',0,100));
    maxlength_TAXONOMY := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY)));
    avelength_TAXONOMY := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY)),h.TAXONOMY<>(typeof(h.TAXONOMY))'');
    populated_TAXONOMY_CODE_pcnt := AVE(GROUP,IF(h.TAXONOMY_CODE = (TYPEOF(h.TAXONOMY_CODE))'',0,100));
    maxlength_TAXONOMY_CODE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY_CODE)));
    avelength_TAXONOMY_CODE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY_CODE)),h.TAXONOMY_CODE<>(typeof(h.TAXONOMY_CODE))'');
    populated_BDID_pcnt := AVE(GROUP,IF(h.BDID = (TYPEOF(h.BDID))'',0,100));
    maxlength_BDID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BDID)));
    avelength_BDID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BDID)),h.BDID<>(typeof(h.BDID))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_SOURCE_RID_pcnt := AVE(GROUP,IF(h.SOURCE_RID = (TYPEOF(h.SOURCE_RID))'',0,100));
    maxlength_SOURCE_RID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SOURCE_RID)));
    avelength_SOURCE_RID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SOURCE_RID)),h.SOURCE_RID<>(typeof(h.SOURCE_RID))'');
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT29.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LNPID;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.CNP_NAME),TRIM((SALT29.StrType)le.CNP_NUMBER),TRIM((SALT29.StrType)le.CNP_STORE_NUMBER),TRIM((SALT29.StrType)le.CNP_BTYPE),TRIM((SALT29.StrType)le.CNP_LOWV),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.FEIN),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.CLIA_NUMBER),TRIM((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT29.StrType)le.MEDICAID_NUMBER),TRIM((SALT29.StrType)le.NCPDP_NUMBER),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.TAXONOMY_CODE),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,30,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT29.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 30);
  SELF.FldNo2 := 1 + (C % 30);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.CNP_NAME),TRIM((SALT29.StrType)le.CNP_NUMBER),TRIM((SALT29.StrType)le.CNP_STORE_NUMBER),TRIM((SALT29.StrType)le.CNP_BTYPE),TRIM((SALT29.StrType)le.CNP_LOWV),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.FEIN),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.CLIA_NUMBER),TRIM((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT29.StrType)le.MEDICAID_NUMBER),TRIM((SALT29.StrType)le.NCPDP_NUMBER),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.TAXONOMY_CODE),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.CNP_NAME),TRIM((SALT29.StrType)le.CNP_NUMBER),TRIM((SALT29.StrType)le.CNP_STORE_NUMBER),TRIM((SALT29.StrType)le.CNP_BTYPE),TRIM((SALT29.StrType)le.CNP_LOWV),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.FEIN),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.CLIA_NUMBER),TRIM((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT29.StrType)le.MEDICAID_NUMBER),TRIM((SALT29.StrType)le.NCPDP_NUMBER),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.TAXONOMY_CODE),TRIM((SALT29.StrType)le.BDID),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.SOURCE_RID)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),30*30,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'CNAME'}
      ,{2,'CNP_NAME'}
      ,{3,'CNP_NUMBER'}
      ,{4,'CNP_STORE_NUMBER'}
      ,{5,'CNP_BTYPE'}
      ,{6,'CNP_LOWV'}
      ,{7,'PRIM_RANGE'}
      ,{8,'PRIM_NAME'}
      ,{9,'SEC_RANGE'}
      ,{10,'V_CITY_NAME'}
      ,{11,'ST'}
      ,{12,'ZIP'}
      ,{13,'TAX_ID'}
      ,{14,'FEIN'}
      ,{15,'PHONE'}
      ,{16,'FAX'}
      ,{17,'LIC_STATE'}
      ,{18,'C_LIC_NBR'}
      ,{19,'DEA_NUMBER'}
      ,{20,'VENDOR_ID'}
      ,{21,'NPI_NUMBER'}
      ,{22,'CLIA_NUMBER'}
      ,{23,'MEDICARE_FACILITY_NUMBER'}
      ,{24,'MEDICAID_NUMBER'}
      ,{25,'NCPDP_NUMBER'}
      ,{26,'TAXONOMY'}
      ,{27,'TAXONOMY_CODE'}
      ,{28,'BDID'}
      ,{29,'SRC'}
      ,{30,'SOURCE_RID'}],SALT29.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT29.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT29.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT29.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_CNAME((SALT29.StrType)le.CNAME),
    Fields.InValid_CNP_NAME((SALT29.StrType)le.CNP_NAME),
    Fields.InValid_CNP_NUMBER((SALT29.StrType)le.CNP_NUMBER),
    Fields.InValid_CNP_STORE_NUMBER((SALT29.StrType)le.CNP_STORE_NUMBER),
    Fields.InValid_CNP_BTYPE((SALT29.StrType)le.CNP_BTYPE),
    Fields.InValid_CNP_LOWV((SALT29.StrType)le.CNP_LOWV),
    Fields.InValid_PRIM_RANGE((SALT29.StrType)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((SALT29.StrType)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((SALT29.StrType)le.SEC_RANGE),
    Fields.InValid_V_CITY_NAME((SALT29.StrType)le.V_CITY_NAME),
    Fields.InValid_ST((SALT29.StrType)le.ST),
    Fields.InValid_ZIP((SALT29.StrType)le.ZIP),
    Fields.InValid_TAX_ID((SALT29.StrType)le.TAX_ID),
    Fields.InValid_FEIN((SALT29.StrType)le.FEIN),
    Fields.InValid_PHONE((SALT29.StrType)le.PHONE),
    Fields.InValid_FAX((SALT29.StrType)le.FAX),
    Fields.InValid_LIC_STATE((SALT29.StrType)le.LIC_STATE),
    Fields.InValid_C_LIC_NBR((SALT29.StrType)le.C_LIC_NBR),
    Fields.InValid_DEA_NUMBER((SALT29.StrType)le.DEA_NUMBER),
    Fields.InValid_VENDOR_ID((SALT29.StrType)le.VENDOR_ID),
    Fields.InValid_NPI_NUMBER((SALT29.StrType)le.NPI_NUMBER),
    Fields.InValid_CLIA_NUMBER((SALT29.StrType)le.CLIA_NUMBER),
    Fields.InValid_MEDICARE_FACILITY_NUMBER((SALT29.StrType)le.MEDICARE_FACILITY_NUMBER),
    Fields.InValid_MEDICAID_NUMBER((SALT29.StrType)le.MEDICAID_NUMBER),
    Fields.InValid_NCPDP_NUMBER((SALT29.StrType)le.NCPDP_NUMBER),
    Fields.InValid_TAXONOMY((SALT29.StrType)le.TAXONOMY),
    Fields.InValid_TAXONOMY_CODE((SALT29.StrType)le.TAXONOMY_CODE),
    Fields.InValid_BDID((SALT29.StrType)le.BDID),
    Fields.InValid_SRC((SALT29.StrType)le.SRC),
    Fields.InValid_SOURCE_RID((SALT29.StrType)le.SOURCE_RID),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,34,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_CNAME(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_STORE_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_BTYPE(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_LOWV(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_V_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_FEIN(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_FAX(TotalErrors.ErrorNum),Fields.InValidMessage_LIC_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_C_LIC_NBR(TotalErrors.ErrorNum),Fields.InValidMessage_DEA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CLIA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_MEDICARE_FACILITY_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_MEDICAID_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_NCPDP_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_TAXONOMY(TotalErrors.ErrorNum),Fields.InValidMessage_TAXONOMY_CODE(TotalErrors.ErrorNum),Fields.InValidMessage_BDID(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_SOURCE_RID(TotalErrors.ErrorNum),'','','','');
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
//We have LNPID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT29.MOD_ClusterStats.Counts(h,LNPID);
END;
