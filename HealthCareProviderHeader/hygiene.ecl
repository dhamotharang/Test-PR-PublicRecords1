import ut,SALT29;
export hygiene(dataset(layout_HealthProvider) h) := MODULE
//A simple summary record
export Summary(SALT29.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_UPIN_pcnt := AVE(GROUP,IF(h.UPIN = (TYPEOF(h.UPIN))'',0,100));
    maxlength_UPIN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.UPIN)));
    avelength_UPIN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.UPIN)),h.UPIN<>(typeof(h.UPIN))'');
    populated_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',0,100));
    maxlength_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)));
    avelength_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.NPI_NUMBER)),h.NPI_NUMBER<>(typeof(h.NPI_NUMBER))'');
    populated_DEA_NUMBER_pcnt := AVE(GROUP,IF(h.DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',0,100));
    maxlength_DEA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)));
    avelength_DEA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DEA_NUMBER)),h.DEA_NUMBER<>(typeof(h.DEA_NUMBER))'');
    populated_DID_pcnt := AVE(GROUP,IF(h.DID = (TYPEOF(h.DID))'',0,100));
    maxlength_DID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DID)));
    avelength_DID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DID)),h.DID<>(typeof(h.DID))'');
    populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)));
    avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
    populated_CNSMR_SSN_pcnt := AVE(GROUP,IF(h.CNSMR_SSN = (TYPEOF(h.CNSMR_SSN))'',0,100));
    maxlength_CNSMR_SSN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_SSN)));
    avelength_CNSMR_SSN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_SSN)),h.CNSMR_SSN<>(typeof(h.CNSMR_SSN))'');
    populated_FAX_pcnt := AVE(GROUP,IF(h.FAX = (TYPEOF(h.FAX))'',0,100));
    maxlength_FAX := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.FAX)));
    avelength_FAX := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.FAX)),h.FAX<>(typeof(h.FAX))'');
    populated_C_LIC_NBR_pcnt := AVE(GROUP,IF(h.C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',0,100));
    maxlength_C_LIC_NBR := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)));
    avelength_C_LIC_NBR := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.C_LIC_NBR)),h.C_LIC_NBR<>(typeof(h.C_LIC_NBR))'');
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_DOB_pcnt := AVE(GROUP,IF(h.DOB = (TYPEOF(h.DOB))'',0,100));
    maxlength_DOB := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DOB)));
    avelength_DOB := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DOB)),h.DOB<>(typeof(h.DOB))'');
    populated_CNSMR_DOB_pcnt := AVE(GROUP,IF(h.CNSMR_DOB = (TYPEOF(h.CNSMR_DOB))'',0,100));
    maxlength_CNSMR_DOB := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_DOB)));
    avelength_CNSMR_DOB := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNSMR_DOB)),h.CNSMR_DOB<>(typeof(h.CNSMR_DOB))'');
    populated_BILLING_TAX_ID_pcnt := AVE(GROUP,IF(h.BILLING_TAX_ID = (TYPEOF(h.BILLING_TAX_ID))'',0,100));
    maxlength_BILLING_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_TAX_ID)));
    avelength_BILLING_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_TAX_ID)),h.BILLING_TAX_ID<>(typeof(h.BILLING_TAX_ID))'');
    populated_BILLING_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.BILLING_NPI_NUMBER = (TYPEOF(h.BILLING_NPI_NUMBER))'',0,100));
    maxlength_BILLING_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_NPI_NUMBER)));
    avelength_BILLING_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.BILLING_NPI_NUMBER)),h.BILLING_NPI_NUMBER<>(typeof(h.BILLING_NPI_NUMBER))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_LNAME_pcnt := AVE(GROUP,IF(h.LNAME = (TYPEOF(h.LNAME))'',0,100));
    maxlength_LNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LNAME)));
    avelength_LNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LNAME)),h.LNAME<>(typeof(h.LNAME))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_V_CITY_NAME_pcnt := AVE(GROUP,IF(h.V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',0,100));
    maxlength_V_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.V_CITY_NAME)));
    avelength_V_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.V_CITY_NAME)),h.V_CITY_NAME<>(typeof(h.V_CITY_NAME))'');
    populated_SNAME_pcnt := AVE(GROUP,IF(h.SNAME = (TYPEOF(h.SNAME))'',0,100));
    maxlength_SNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SNAME)));
    avelength_SNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SNAME)),h.SNAME<>(typeof(h.SNAME))'');
    populated_FNAME_pcnt := AVE(GROUP,IF(h.FNAME = (TYPEOF(h.FNAME))'',0,100));
    maxlength_FNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.FNAME)));
    avelength_FNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.FNAME)),h.FNAME<>(typeof(h.FNAME))'');
    populated_MNAME_pcnt := AVE(GROUP,IF(h.MNAME = (TYPEOF(h.MNAME))'',0,100));
    maxlength_MNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.MNAME)));
    avelength_MNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.MNAME)),h.MNAME<>(typeof(h.MNAME))'');
    populated_TAXONOMY_pcnt := AVE(GROUP,IF(h.TAXONOMY = (TYPEOF(h.TAXONOMY))'',0,100));
    maxlength_TAXONOMY := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY)));
    avelength_TAXONOMY := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAXONOMY)),h.TAXONOMY<>(typeof(h.TAXONOMY))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_LIC_TYPE_pcnt := AVE(GROUP,IF(h.LIC_TYPE = (TYPEOF(h.LIC_TYPE))'',0,100));
    maxlength_LIC_TYPE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_TYPE)));
    avelength_LIC_TYPE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_TYPE)),h.LIC_TYPE<>(typeof(h.LIC_TYPE))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_GENDER_pcnt := AVE(GROUP,IF(h.GENDER = (TYPEOF(h.GENDER))'',0,100));
    maxlength_GENDER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.GENDER)));
    avelength_GENDER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.GENDER)),h.GENDER<>(typeof(h.GENDER))'');
    populated_DERIVED_GENDER_pcnt := AVE(GROUP,IF(h.DERIVED_GENDER = (TYPEOF(h.DERIVED_GENDER))'',0,100));
    maxlength_DERIVED_GENDER := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DERIVED_GENDER)));
    avelength_DERIVED_GENDER := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DERIVED_GENDER)),h.DERIVED_GENDER<>(typeof(h.DERIVED_GENDER))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_LIC_STATE_pcnt := AVE(GROUP,IF(h.LIC_STATE = (TYPEOF(h.LIC_STATE))'',0,100));
    maxlength_LIC_STATE := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)));
    avelength_LIC_STATE := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.LIC_STATE)),h.LIC_STATE<>(typeof(h.LIC_STATE))'');
    populated_ADDRESS_ID_pcnt := AVE(GROUP,IF(h.ADDRESS_ID = (TYPEOF(h.ADDRESS_ID))'',0,100));
    maxlength_ADDRESS_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.ADDRESS_ID)));
    avelength_ADDRESS_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.ADDRESS_ID)),h.ADDRESS_ID<>(typeof(h.ADDRESS_ID))'');
    populated_CNAME_pcnt := AVE(GROUP,IF(h.CNAME = (TYPEOF(h.CNAME))'',0,100));
    maxlength_CNAME := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNAME)));
    avelength_CNAME := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.CNAME)),h.CNAME<>(typeof(h.CNAME))'');
    populated_TAX_ID_pcnt := AVE(GROUP,IF(h.TAX_ID = (TYPEOF(h.TAX_ID))'',0,100));
    maxlength_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)));
    avelength_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.TAX_ID)),h.TAX_ID<>(typeof(h.TAX_ID))'');
    populated_GEO_LAT_pcnt := AVE(GROUP,IF(h.GEO_LAT = (TYPEOF(h.GEO_LAT))'',0,100));
    maxlength_GEO_LAT := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.GEO_LAT)));
    avelength_GEO_LAT := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.GEO_LAT)),h.GEO_LAT<>(typeof(h.GEO_LAT))'');
    populated_GEO_LONG_pcnt := AVE(GROUP,IF(h.GEO_LONG = (TYPEOF(h.GEO_LONG))'',0,100));
    maxlength_GEO_LONG := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.GEO_LONG)));
    avelength_GEO_LONG := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.GEO_LONG)),h.GEO_LONG<>(typeof(h.GEO_LONG))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
    populated_DT_LIC_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_LIC_EXPIRATION = (TYPEOF(h.DT_LIC_EXPIRATION))'',0,100));
    maxlength_DT_LIC_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_LIC_EXPIRATION)));
    avelength_DT_LIC_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_LIC_EXPIRATION)),h.DT_LIC_EXPIRATION<>(typeof(h.DT_LIC_EXPIRATION))'');
    populated_DT_DEA_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_DEA_EXPIRATION = (TYPEOF(h.DT_DEA_EXPIRATION))'',0,100));
    maxlength_DT_DEA_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_DEA_EXPIRATION)));
    avelength_DT_DEA_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT29.StrType)h.DT_DEA_EXPIRATION)),h.DT_DEA_EXPIRATION<>(typeof(h.DT_DEA_EXPIRATION))'');
  END;
  RETURN table(h,SummaryLayout);
END;
SrcCntRec := record
  h.SRC;  // Source Group Identifier
  unsigned SourceGroupCount := count(group);
end;
export SourceCounts := table(h,SrcCntRec,SRC,few);
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT29.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LNPID;
  SELF.Src := le.SRC;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.GEO_LAT)+' '+TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.LIC_TYPE),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.DERIVED_GENDER),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.ADDRESS_ID),TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.GEO_LAT),TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.DT_FIRST_SEEN),TRIM((SALT29.StrType)le.DT_LAST_SEEN),TRIM((SALT29.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT29.StrType)le.DT_DEA_EXPIRATION)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,40,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT29.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 40);
  SELF.FldNo2 := 1 + (C % 40);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.GEO_LAT)+' '+TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.LIC_TYPE),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.DERIVED_GENDER),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.ADDRESS_ID),TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.GEO_LAT),TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.DT_FIRST_SEEN),TRIM((SALT29.StrType)le.DT_LAST_SEEN),TRIM((SALT29.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT29.StrType)le.DT_DEA_EXPIRATION)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT29.StrType)le.SSN),TRIM((SALT29.StrType)le.UPIN),TRIM((SALT29.StrType)le.NPI_NUMBER),TRIM((SALT29.StrType)le.DEA_NUMBER),TRIM((SALT29.StrType)le.DID),TRIM((SALT29.StrType)le.VENDOR_ID),TRIM((SALT29.StrType)le.CNSMR_SSN),TRIM((SALT29.StrType)le.FAX),TRIM((SALT29.StrType)le.C_LIC_NBR),TRIM((SALT29.StrType)le.PHONE),TRIM((SALT29.StrType)le.DOB),TRIM((SALT29.StrType)le.CNSMR_DOB),TRIM((SALT29.StrType)le.BILLING_TAX_ID),TRIM((SALT29.StrType)le.BILLING_NPI_NUMBER),TRIM((SALT29.StrType)le.PRIM_NAME),TRIM((SALT29.StrType)le.ZIP),TRIM((SALT29.StrType)le.LNAME),TRIM((SALT29.StrType)le.PRIM_RANGE),TRIM((SALT29.StrType)le.V_CITY_NAME),TRIM((SALT29.StrType)le.GEO_LAT)+' '+TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.SNAME),TRIM((SALT29.StrType)le.FNAME),TRIM((SALT29.StrType)le.MNAME),TRIM((SALT29.StrType)le.TAXONOMY),TRIM((SALT29.StrType)le.SEC_RANGE),TRIM((SALT29.StrType)le.LIC_TYPE),TRIM((SALT29.StrType)le.ST),TRIM((SALT29.StrType)le.GENDER),TRIM((SALT29.StrType)le.DERIVED_GENDER),TRIM((SALT29.StrType)le.SRC),TRIM((SALT29.StrType)le.LIC_STATE),TRIM((SALT29.StrType)le.ADDRESS_ID),TRIM((SALT29.StrType)le.CNAME),TRIM((SALT29.StrType)le.TAX_ID),TRIM((SALT29.StrType)le.GEO_LAT),TRIM((SALT29.StrType)le.GEO_LONG),TRIM((SALT29.StrType)le.DT_FIRST_SEEN),TRIM((SALT29.StrType)le.DT_LAST_SEEN),TRIM((SALT29.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT29.StrType)le.DT_DEA_EXPIRATION)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),40*40,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'SSN'}
      ,{2,'UPIN'}
      ,{3,'NPI_NUMBER'}
      ,{4,'DEA_NUMBER'}
      ,{5,'DID'}
      ,{6,'VENDOR_ID'}
      ,{7,'CNSMR_SSN'}
      ,{8,'FAX'}
      ,{9,'C_LIC_NBR'}
      ,{10,'PHONE'}
      ,{11,'DOB'}
      ,{12,'CNSMR_DOB'}
      ,{13,'BILLING_TAX_ID'}
      ,{14,'BILLING_NPI_NUMBER'}
      ,{15,'PRIM_NAME'}
      ,{16,'ZIP'}
      ,{17,'LNAME'}
      ,{18,'PRIM_RANGE'}
      ,{19,'V_CITY_NAME'}
      ,{20,'LAT_LONG'}
      ,{21,'SNAME'}
      ,{22,'FNAME'}
      ,{23,'MNAME'}
      ,{24,'TAXONOMY'}
      ,{25,'SEC_RANGE'}
      ,{26,'LIC_TYPE'}
      ,{27,'ST'}
      ,{28,'GENDER'}
      ,{29,'DERIVED_GENDER'}
      ,{30,'SRC'}
      ,{31,'LIC_STATE'}
      ,{32,'ADDRESS_ID'}
      ,{33,'CNAME'}
      ,{34,'TAX_ID'}
      ,{35,'GEO_LAT'}
      ,{36,'GEO_LONG'}
      ,{37,'DT_FIRST_SEEN'}
      ,{38,'DT_LAST_SEEN'}
      ,{39,'DT_LIC_EXPIRATION'}
      ,{40,'DT_DEA_EXPIRATION'}],SALT29.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT29.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT29.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT29.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SRC) SRC; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_SSN((SALT29.StrType)le.SSN),
    Fields.InValid_UPIN((SALT29.StrType)le.UPIN),
    Fields.InValid_NPI_NUMBER((SALT29.StrType)le.NPI_NUMBER),
    Fields.InValid_DEA_NUMBER((SALT29.StrType)le.DEA_NUMBER),
    Fields.InValid_DID((SALT29.StrType)le.DID),
    Fields.InValid_VENDOR_ID((SALT29.StrType)le.VENDOR_ID),
    Fields.InValid_CNSMR_SSN((SALT29.StrType)le.CNSMR_SSN),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_FAX((SALT29.StrType)le.FAX),
    Fields.InValid_C_LIC_NBR((SALT29.StrType)le.C_LIC_NBR),
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_PHONE((SALT29.StrType)le.PHONE),
    Fields.InValid_DOB((SALT29.StrType)le.DOB),
    Fields.InValid_CNSMR_DOB((SALT29.StrType)le.CNSMR_DOB),
    Fields.InValid_BILLING_TAX_ID((SALT29.StrType)le.BILLING_TAX_ID),
    Fields.InValid_BILLING_NPI_NUMBER((SALT29.StrType)le.BILLING_NPI_NUMBER),
    Fields.InValid_PRIM_NAME((SALT29.StrType)le.PRIM_NAME),
    Fields.InValid_ZIP((SALT29.StrType)le.ZIP),
    0, // Uncleanable field
    Fields.InValid_LNAME((SALT29.StrType)le.LNAME),
    Fields.InValid_PRIM_RANGE((SALT29.StrType)le.PRIM_RANGE),
    Fields.InValid_V_CITY_NAME((SALT29.StrType)le.V_CITY_NAME),
    0, // Uncleanable field
    Fields.InValid_SNAME((SALT29.StrType)le.SNAME),
    Fields.InValid_FNAME((SALT29.StrType)le.FNAME),
    Fields.InValid_MNAME((SALT29.StrType)le.MNAME),
    Fields.InValid_TAXONOMY((SALT29.StrType)le.TAXONOMY),
    Fields.InValid_SEC_RANGE((SALT29.StrType)le.SEC_RANGE),
    Fields.InValid_LIC_TYPE((SALT29.StrType)le.LIC_TYPE),
    Fields.InValid_ST((SALT29.StrType)le.ST),
    Fields.InValid_GENDER((SALT29.StrType)le.GENDER),
    Fields.InValid_DERIVED_GENDER((SALT29.StrType)le.DERIVED_GENDER),
    Fields.InValid_SRC((SALT29.StrType)le.SRC),
    Fields.InValid_LIC_STATE((SALT29.StrType)le.LIC_STATE),
    Fields.InValid_ADDRESS_ID((SALT29.StrType)le.ADDRESS_ID),
    Fields.InValid_CNAME((SALT29.StrType)le.CNAME),
    Fields.InValid_TAX_ID((SALT29.StrType)le.TAX_ID),
    Fields.InValid_GEO_LAT((SALT29.StrType)le.GEO_LAT),
    Fields.InValid_GEO_LONG((SALT29.StrType)le.GEO_LONG),
    Fields.InValid_DT_FIRST_SEEN((SALT29.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT29.StrType)le.DT_LAST_SEEN),
    Fields.InValid_DT_LIC_EXPIRATION((SALT29.StrType)le.DT_LIC_EXPIRATION),
    Fields.InValid_DT_DEA_EXPIRATION((SALT29.StrType)le.DT_DEA_EXPIRATION),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SRC := le.SRC;
END;
Errors := NORMALIZE(h,45,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.SRC;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,SRC,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.SRC;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_SSN(TotalErrors.ErrorNum),Fields.InValidMessage_UPIN(TotalErrors.ErrorNum),Fields.InValidMessage_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DEA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DID(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_CNSMR_SSN(TotalErrors.ErrorNum),'','',Fields.InValidMessage_FAX(TotalErrors.ErrorNum),Fields.InValidMessage_C_LIC_NBR(TotalErrors.ErrorNum),'','',Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_CNSMR_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_BILLING_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_BILLING_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),'',Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_V_CITY_NAME(TotalErrors.ErrorNum),'',Fields.InValidMessage_SNAME(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_TAXONOMY(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_LIC_TYPE(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_DERIVED_GENDER(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_LIC_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_ADDRESS_ID(TotalErrors.ErrorNum),Fields.InValidMessage_CNAME(TotalErrors.ErrorNum),Fields.InValidMessage_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_GEO_LAT(TotalErrors.ErrorNum),Fields.InValidMessage_GEO_LONG(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LIC_EXPIRATION(TotalErrors.ErrorNum),Fields.InValidMessage_DT_DEA_EXPIRATION(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,SourceCounts,LEFT.SRC=RIGHT.SRC,LOOKUP); // Add source group counts for STRATA compliance
//Compute field consistencies between sources
  SALT29.mac_srcfrequency_outliers(h,SSN,SRC,SSN_outliers)
  SALT29.mac_srcfrequency_outliers(h,UPIN,SRC,UPIN_outliers)
  SALT29.mac_srcfrequency_outliers(h,NPI_NUMBER,SRC,NPI_NUMBER_outliers)
  SALT29.mac_srcfrequency_outliers(h,DEA_NUMBER,SRC,DEA_NUMBER_outliers)
  SALT29.mac_srcfrequency_outliers(h,DID,SRC,DID_outliers)
  SALT29.mac_srcfrequency_outliers(h,VENDOR_ID,SRC,VENDOR_ID_outliers)
  SALT29.mac_srcfrequency_outliers(h,CNSMR_SSN,SRC,CNSMR_SSN_outliers)
  SALT29.mac_srcfrequency_outliers(h,FAX,SRC,FAX_outliers)
  SALT29.mac_srcfrequency_outliers(h,C_LIC_NBR,SRC,C_LIC_NBR_outliers)
  SALT29.mac_srcfrequency_outliers(h,PHONE,SRC,PHONE_outliers)
  SALT29.mac_srcfrequency_outliers(h,DOB,SRC,DOB_outliers)
  SALT29.mac_srcfrequency_outliers(h,CNSMR_DOB,SRC,CNSMR_DOB_outliers)
  SALT29.mac_srcfrequency_outliers(h,BILLING_TAX_ID,SRC,BILLING_TAX_ID_outliers)
  SALT29.mac_srcfrequency_outliers(h,BILLING_NPI_NUMBER,SRC,BILLING_NPI_NUMBER_outliers)
  SALT29.mac_srcfrequency_outliers(h,PRIM_NAME,SRC,PRIM_NAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,ZIP,SRC,ZIP_outliers)
  SALT29.mac_srcfrequency_outliers(h,LNAME,SRC,LNAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,PRIM_RANGE,SRC,PRIM_RANGE_outliers)
  SALT29.mac_srcfrequency_outliers(h,V_CITY_NAME,SRC,V_CITY_NAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,SNAME,SRC,SNAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,FNAME,SRC,FNAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,MNAME,SRC,MNAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,TAXONOMY,SRC,TAXONOMY_outliers)
  SALT29.mac_srcfrequency_outliers(h,SEC_RANGE,SRC,SEC_RANGE_outliers)
  SALT29.mac_srcfrequency_outliers(h,LIC_TYPE,SRC,LIC_TYPE_outliers)
  SALT29.mac_srcfrequency_outliers(h,ST,SRC,ST_outliers)
  SALT29.mac_srcfrequency_outliers(h,GENDER,SRC,GENDER_outliers)
  SALT29.mac_srcfrequency_outliers(h,DERIVED_GENDER,SRC,DERIVED_GENDER_outliers)
  SALT29.mac_srcfrequency_outliers(h,SRC,SRC,SRC_outliers)
  SALT29.mac_srcfrequency_outliers(h,LIC_STATE,SRC,LIC_STATE_outliers)
  SALT29.mac_srcfrequency_outliers(h,ADDRESS_ID,SRC,ADDRESS_ID_outliers)
  SALT29.mac_srcfrequency_outliers(h,CNAME,SRC,CNAME_outliers)
  SALT29.mac_srcfrequency_outliers(h,TAX_ID,SRC,TAX_ID_outliers)
  SALT29.mac_srcfrequency_outliers(h,GEO_LAT,SRC,GEO_LAT_outliers)
  SALT29.mac_srcfrequency_outliers(h,GEO_LONG,SRC,GEO_LONG_outliers)
  SALT29.mac_srcfrequency_outliers(h,DT_FIRST_SEEN,SRC,DT_FIRST_SEEN_outliers)
  SALT29.mac_srcfrequency_outliers(h,DT_LAST_SEEN,SRC,DT_LAST_SEEN_outliers)
  SALT29.mac_srcfrequency_outliers(h,DT_LIC_EXPIRATION,SRC,DT_LIC_EXPIRATION_outliers)
  SALT29.mac_srcfrequency_outliers(h,DT_DEA_EXPIRATION,SRC,DT_DEA_EXPIRATION_outliers)
EXPORT AllOutliers := SSN_outliers + UPIN_outliers + NPI_NUMBER_outliers + DEA_NUMBER_outliers + DID_outliers + VENDOR_ID_outliers + CNSMR_SSN_outliers + FAX_outliers + C_LIC_NBR_outliers + PHONE_outliers + DOB_outliers + CNSMR_DOB_outliers + BILLING_TAX_ID_outliers + BILLING_NPI_NUMBER_outliers + PRIM_NAME_outliers + ZIP_outliers + LNAME_outliers + PRIM_RANGE_outliers + V_CITY_NAME_outliers + SNAME_outliers + FNAME_outliers + MNAME_outliers + TAXONOMY_outliers + SEC_RANGE_outliers + LIC_TYPE_outliers + ST_outliers + GENDER_outliers + DERIVED_GENDER_outliers + SRC_outliers + LIC_STATE_outliers + ADDRESS_ID_outliers + CNAME_outliers + TAX_ID_outliers + GEO_LAT_outliers + GEO_LONG_outliers + DT_FIRST_SEEN_outliers + DT_LAST_SEEN_outliers + DT_LIC_EXPIRATION_outliers + DT_DEA_EXPIRATION_outliers;
//We have LNPID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT29.MOD_ClusterStats.Counts(h,LNPID);
EXPORT ClusterSrc := SALT29.MOD_ClusterStats.Sources(h,LNPID,SRC);
END;
