IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_HealthFacility) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.SRC);    NumberOfRecords := COUNT(GROUP);
    populated_PHONE_pcnt := AVE(GROUP,IF(h.PHONE = (TYPEOF(h.PHONE))'',0,100));
    maxlength_PHONE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.PHONE)));
    avelength_PHONE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.PHONE)),h.PHONE<>(typeof(h.PHONE))'');
    populated_FAX_pcnt := AVE(GROUP,IF(h.FAX = (TYPEOF(h.FAX))'',0,100));
    maxlength_FAX := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.FAX)));
    avelength_FAX := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.FAX)),h.FAX<>(typeof(h.FAX))'');
    populated_UPIN_pcnt := AVE(GROUP,IF(h.UPIN = (TYPEOF(h.UPIN))'',0,100));
    maxlength_UPIN := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.UPIN)));
    avelength_UPIN := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.UPIN)),h.UPIN<>(typeof(h.UPIN))'');
    populated_NPI_NUMBER_pcnt := AVE(GROUP,IF(h.NPI_NUMBER = (TYPEOF(h.NPI_NUMBER))'',0,100));
    maxlength_NPI_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.NPI_NUMBER)));
    avelength_NPI_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.NPI_NUMBER)),h.NPI_NUMBER<>(typeof(h.NPI_NUMBER))'');
    populated_DEA_NUMBER_pcnt := AVE(GROUP,IF(h.DEA_NUMBER = (TYPEOF(h.DEA_NUMBER))'',0,100));
    maxlength_DEA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.DEA_NUMBER)));
    avelength_DEA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.DEA_NUMBER)),h.DEA_NUMBER<>(typeof(h.DEA_NUMBER))'');
    populated_CLIA_NUMBER_pcnt := AVE(GROUP,IF(h.CLIA_NUMBER = (TYPEOF(h.CLIA_NUMBER))'',0,100));
    maxlength_CLIA_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CLIA_NUMBER)));
    avelength_CLIA_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CLIA_NUMBER)),h.CLIA_NUMBER<>(typeof(h.CLIA_NUMBER))'');
    populated_MEDICARE_FACILITY_NUMBER_pcnt := AVE(GROUP,IF(h.MEDICARE_FACILITY_NUMBER = (TYPEOF(h.MEDICARE_FACILITY_NUMBER))'',0,100));
    maxlength_MEDICARE_FACILITY_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.MEDICARE_FACILITY_NUMBER)));
    avelength_MEDICARE_FACILITY_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.MEDICARE_FACILITY_NUMBER)),h.MEDICARE_FACILITY_NUMBER<>(typeof(h.MEDICARE_FACILITY_NUMBER))'');
    populated_NCPDP_NUMBER_pcnt := AVE(GROUP,IF(h.NCPDP_NUMBER = (TYPEOF(h.NCPDP_NUMBER))'',0,100));
    maxlength_NCPDP_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.NCPDP_NUMBER)));
    avelength_NCPDP_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.NCPDP_NUMBER)),h.NCPDP_NUMBER<>(typeof(h.NCPDP_NUMBER))'');
    populated_TAX_ID_pcnt := AVE(GROUP,IF(h.TAX_ID = (TYPEOF(h.TAX_ID))'',0,100));
    maxlength_TAX_ID := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAX_ID)));
    avelength_TAX_ID := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAX_ID)),h.TAX_ID<>(typeof(h.TAX_ID))'');
    populated_FEIN_pcnt := AVE(GROUP,IF(h.FEIN = (TYPEOF(h.FEIN))'',0,100));
    maxlength_FEIN := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.FEIN)));
    avelength_FEIN := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.FEIN)),h.FEIN<>(typeof(h.FEIN))'');
    populated_C_LIC_NBR_pcnt := AVE(GROUP,IF(h.C_LIC_NBR = (TYPEOF(h.C_LIC_NBR))'',0,100));
    maxlength_C_LIC_NBR := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.C_LIC_NBR)));
    avelength_C_LIC_NBR := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.C_LIC_NBR)),h.C_LIC_NBR<>(typeof(h.C_LIC_NBR))'');
    populated_SRC_pcnt := AVE(GROUP,IF(h.SRC = (TYPEOF(h.SRC))'',0,100));
    maxlength_SRC := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.SRC)));
    avelength_SRC := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.SRC)),h.SRC<>(typeof(h.SRC))'');
    populated_CNAME_pcnt := AVE(GROUP,IF(h.CNAME = (TYPEOF(h.CNAME))'',0,100));
    maxlength_CNAME := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNAME)));
    avelength_CNAME := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNAME)),h.CNAME<>(typeof(h.CNAME))'');
    populated_CNP_NAME_pcnt := AVE(GROUP,IF(h.CNP_NAME = (TYPEOF(h.CNP_NAME))'',0,100));
    maxlength_CNP_NAME := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_NAME)));
    avelength_CNP_NAME := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_NAME)),h.CNP_NAME<>(typeof(h.CNP_NAME))'');
    populated_CNP_NUMBER_pcnt := AVE(GROUP,IF(h.CNP_NUMBER = (TYPEOF(h.CNP_NUMBER))'',0,100));
    maxlength_CNP_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_NUMBER)));
    avelength_CNP_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_NUMBER)),h.CNP_NUMBER<>(typeof(h.CNP_NUMBER))'');
    populated_CNP_STORE_NUMBER_pcnt := AVE(GROUP,IF(h.CNP_STORE_NUMBER = (TYPEOF(h.CNP_STORE_NUMBER))'',0,100));
    maxlength_CNP_STORE_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_STORE_NUMBER)));
    avelength_CNP_STORE_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_STORE_NUMBER)),h.CNP_STORE_NUMBER<>(typeof(h.CNP_STORE_NUMBER))'');
    populated_CNP_BTYPE_pcnt := AVE(GROUP,IF(h.CNP_BTYPE = (TYPEOF(h.CNP_BTYPE))'',0,100));
    maxlength_CNP_BTYPE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_BTYPE)));
    avelength_CNP_BTYPE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_BTYPE)),h.CNP_BTYPE<>(typeof(h.CNP_BTYPE))'');
    populated_CNP_LOWV_pcnt := AVE(GROUP,IF(h.CNP_LOWV = (TYPEOF(h.CNP_LOWV))'',0,100));
    maxlength_CNP_LOWV := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_LOWV)));
    avelength_CNP_LOWV := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_LOWV)),h.CNP_LOWV<>(typeof(h.CNP_LOWV))'');
    populated_CNP_TRANSLATED_pcnt := AVE(GROUP,IF(h.CNP_TRANSLATED = (TYPEOF(h.CNP_TRANSLATED))'',0,100));
    maxlength_CNP_TRANSLATED := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_TRANSLATED)));
    avelength_CNP_TRANSLATED := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_TRANSLATED)),h.CNP_TRANSLATED<>(typeof(h.CNP_TRANSLATED))'');
    populated_CNP_CLASSID_pcnt := AVE(GROUP,IF(h.CNP_CLASSID = (TYPEOF(h.CNP_CLASSID))'',0,100));
    maxlength_CNP_CLASSID := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_CLASSID)));
    avelength_CNP_CLASSID := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.CNP_CLASSID)),h.CNP_CLASSID<>(typeof(h.CNP_CLASSID))'');
    populated_ADDRESS_ID_pcnt := AVE(GROUP,IF(h.ADDRESS_ID = (TYPEOF(h.ADDRESS_ID))'',0,100));
    maxlength_ADDRESS_ID := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ADDRESS_ID)));
    avelength_ADDRESS_ID := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ADDRESS_ID)),h.ADDRESS_ID<>(typeof(h.ADDRESS_ID))'');
    populated_ADDRESS_CLASSIFICATION_pcnt := AVE(GROUP,IF(h.ADDRESS_CLASSIFICATION = (TYPEOF(h.ADDRESS_CLASSIFICATION))'',0,100));
    maxlength_ADDRESS_CLASSIFICATION := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ADDRESS_CLASSIFICATION)));
    avelength_ADDRESS_CLASSIFICATION := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ADDRESS_CLASSIFICATION)),h.ADDRESS_CLASSIFICATION<>(typeof(h.ADDRESS_CLASSIFICATION))'');
    populated_PRIM_RANGE_pcnt := AVE(GROUP,IF(h.PRIM_RANGE = (TYPEOF(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.PRIM_RANGE)),h.PRIM_RANGE<>(typeof(h.PRIM_RANGE))'');
    populated_PRIM_NAME_pcnt := AVE(GROUP,IF(h.PRIM_NAME = (TYPEOF(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.PRIM_NAME)));
    avelength_PRIM_NAME := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.PRIM_NAME)),h.PRIM_NAME<>(typeof(h.PRIM_NAME))'');
    populated_SEC_RANGE_pcnt := AVE(GROUP,IF(h.SEC_RANGE = (TYPEOF(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.SEC_RANGE)));
    avelength_SEC_RANGE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.SEC_RANGE)),h.SEC_RANGE<>(typeof(h.SEC_RANGE))'');
    populated_ST_pcnt := AVE(GROUP,IF(h.ST = (TYPEOF(h.ST))'',0,100));
    maxlength_ST := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ST)));
    avelength_ST := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ST)),h.ST<>(typeof(h.ST))'');
    populated_V_CITY_NAME_pcnt := AVE(GROUP,IF(h.V_CITY_NAME = (TYPEOF(h.V_CITY_NAME))'',0,100));
    maxlength_V_CITY_NAME := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.V_CITY_NAME)));
    avelength_V_CITY_NAME := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.V_CITY_NAME)),h.V_CITY_NAME<>(typeof(h.V_CITY_NAME))'');
    populated_ZIP_pcnt := AVE(GROUP,IF(h.ZIP = (TYPEOF(h.ZIP))'',0,100));
    maxlength_ZIP := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ZIP)));
    avelength_ZIP := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ZIP)),h.ZIP<>(typeof(h.ZIP))'');
    populated_TAXONOMY_pcnt := AVE(GROUP,IF(h.TAXONOMY = (TYPEOF(h.TAXONOMY))'',0,100));
    maxlength_TAXONOMY := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAXONOMY)));
    avelength_TAXONOMY := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAXONOMY)),h.TAXONOMY<>(typeof(h.TAXONOMY))'');
    populated_TAXONOMY_CODE_pcnt := AVE(GROUP,IF(h.TAXONOMY_CODE = (TYPEOF(h.TAXONOMY_CODE))'',0,100));
    maxlength_TAXONOMY_CODE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAXONOMY_CODE)));
    avelength_TAXONOMY_CODE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.TAXONOMY_CODE)),h.TAXONOMY_CODE<>(typeof(h.TAXONOMY_CODE))'');
    populated_MEDICAID_NUMBER_pcnt := AVE(GROUP,IF(h.MEDICAID_NUMBER = (TYPEOF(h.MEDICAID_NUMBER))'',0,100));
    maxlength_MEDICAID_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.MEDICAID_NUMBER)));
    avelength_MEDICAID_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.MEDICAID_NUMBER)),h.MEDICAID_NUMBER<>(typeof(h.MEDICAID_NUMBER))'');
    populated_VENDOR_ID_pcnt := AVE(GROUP,IF(h.VENDOR_ID = (TYPEOF(h.VENDOR_ID))'',0,100));
    maxlength_VENDOR_ID := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.VENDOR_ID)));
    avelength_VENDOR_ID := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.VENDOR_ID)),h.VENDOR_ID<>(typeof(h.VENDOR_ID))'');
    populated_DT_FIRST_SEEN_pcnt := AVE(GROUP,IF(h.DT_FIRST_SEEN = (TYPEOF(h.DT_FIRST_SEEN))'',0,100));
    maxlength_DT_FIRST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_FIRST_SEEN)));
    avelength_DT_FIRST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_FIRST_SEEN)),h.DT_FIRST_SEEN<>(typeof(h.DT_FIRST_SEEN))'');
    populated_DT_LAST_SEEN_pcnt := AVE(GROUP,IF(h.DT_LAST_SEEN = (TYPEOF(h.DT_LAST_SEEN))'',0,100));
    maxlength_DT_LAST_SEEN := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_LAST_SEEN)));
    avelength_DT_LAST_SEEN := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_LAST_SEEN)),h.DT_LAST_SEEN<>(typeof(h.DT_LAST_SEEN))'');
    populated_DT_LIC_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_LIC_EXPIRATION = (TYPEOF(h.DT_LIC_EXPIRATION))'',0,100));
    maxlength_DT_LIC_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_LIC_EXPIRATION)));
    avelength_DT_LIC_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_LIC_EXPIRATION)),h.DT_LIC_EXPIRATION<>(typeof(h.DT_LIC_EXPIRATION))'');
    populated_DT_DEA_EXPIRATION_pcnt := AVE(GROUP,IF(h.DT_DEA_EXPIRATION = (TYPEOF(h.DT_DEA_EXPIRATION))'',0,100));
    maxlength_DT_DEA_EXPIRATION := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_DEA_EXPIRATION)));
    avelength_DT_DEA_EXPIRATION := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.DT_DEA_EXPIRATION)),h.DT_DEA_EXPIRATION<>(typeof(h.DT_DEA_EXPIRATION))'');
    populated_LIC_STATE_pcnt := AVE(GROUP,IF(h.LIC_STATE = (TYPEOF(h.LIC_STATE))'',0,100));
    maxlength_LIC_STATE := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.LIC_STATE)));
    avelength_LIC_STATE := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.LIC_STATE)),h.LIC_STATE<>(typeof(h.LIC_STATE))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,SRC,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_PHONE_pcnt *  20.00 / 100 + T.Populated_FAX_pcnt *  20.00 / 100 + T.Populated_UPIN_pcnt *   0.00 / 100 + T.Populated_NPI_NUMBER_pcnt *  22.00 / 100 + T.Populated_DEA_NUMBER_pcnt *  21.00 / 100 + T.Populated_CLIA_NUMBER_pcnt *  22.00 / 100 + T.Populated_MEDICARE_FACILITY_NUMBER_pcnt *  21.00 / 100 + T.Populated_NCPDP_NUMBER_pcnt *  22.00 / 100 + T.Populated_TAX_ID_pcnt *  21.00 / 100 + T.Populated_FEIN_pcnt *  17.00 / 100 + T.Populated_C_LIC_NBR_pcnt *  19.00 / 100 + T.Populated_SRC_pcnt *   0.00 / 100 + T.Populated_CNAME_pcnt *   0.00 / 100 + T.Populated_CNP_NAME_pcnt *  13.00 / 100 + T.Populated_CNP_NUMBER_pcnt *  13.00 / 100 + T.Populated_CNP_STORE_NUMBER_pcnt *  20.00 / 100 + T.Populated_CNP_BTYPE_pcnt *   4.00 / 100 + T.Populated_CNP_LOWV_pcnt *   0.00 / 100 + T.Populated_CNP_TRANSLATED_pcnt *   0.00 / 100 + T.Populated_CNP_CLASSID_pcnt *   0.00 / 100 + T.Populated_ADDRESS_ID_pcnt *   0.00 / 100 + T.Populated_ADDRESS_CLASSIFICATION_pcnt *   0.00 / 100 + T.Populated_PRIM_RANGE_pcnt *  12.00 / 100 + T.Populated_PRIM_NAME_pcnt *  13.00 / 100 + T.Populated_SEC_RANGE_pcnt *   7.00 / 100 + T.Populated_ST_pcnt *   5.00 / 100 + T.Populated_V_CITY_NAME_pcnt *  11.00 / 100 + T.Populated_ZIP_pcnt *  13.00 / 100 + T.Populated_TAXONOMY_pcnt *   7.00 / 100 + T.Populated_TAXONOMY_CODE_pcnt *   4.00 / 100 + T.Populated_MEDICAID_NUMBER_pcnt *  22.00 / 100 + T.Populated_VENDOR_ID_pcnt *  21.00 / 100 + T.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_LAST_SEEN_pcnt *   0.00 / 100 + T.Populated_DT_LIC_EXPIRATION_pcnt *   0.00 / 100 + T.Populated_DT_DEA_EXPIRATION_pcnt *   0.00 / 100 + T.Populated_LIC_STATE_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING SRC1;
    STRING SRC2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.SRC1 := le.Source;
    SELF.SRC2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_PHONE_pcnt*ri.Populated_PHONE_pcnt *  20.00 / 10000 + le.Populated_FAX_pcnt*ri.Populated_FAX_pcnt *  20.00 / 10000 + le.Populated_UPIN_pcnt*ri.Populated_UPIN_pcnt *   0.00 / 10000 + le.Populated_NPI_NUMBER_pcnt*ri.Populated_NPI_NUMBER_pcnt *  22.00 / 10000 + le.Populated_DEA_NUMBER_pcnt*ri.Populated_DEA_NUMBER_pcnt *  21.00 / 10000 + le.Populated_CLIA_NUMBER_pcnt*ri.Populated_CLIA_NUMBER_pcnt *  22.00 / 10000 + le.Populated_MEDICARE_FACILITY_NUMBER_pcnt*ri.Populated_MEDICARE_FACILITY_NUMBER_pcnt *  21.00 / 10000 + le.Populated_NCPDP_NUMBER_pcnt*ri.Populated_NCPDP_NUMBER_pcnt *  22.00 / 10000 + le.Populated_TAX_ID_pcnt*ri.Populated_TAX_ID_pcnt *  21.00 / 10000 + le.Populated_FEIN_pcnt*ri.Populated_FEIN_pcnt *  17.00 / 10000 + le.Populated_C_LIC_NBR_pcnt*ri.Populated_C_LIC_NBR_pcnt *  19.00 / 10000 + le.Populated_SRC_pcnt*ri.Populated_SRC_pcnt *   0.00 / 10000 + le.Populated_CNAME_pcnt*ri.Populated_CNAME_pcnt *   0.00 / 10000 + le.Populated_CNP_NAME_pcnt*ri.Populated_CNP_NAME_pcnt *  13.00 / 10000 + le.Populated_CNP_NUMBER_pcnt*ri.Populated_CNP_NUMBER_pcnt *  13.00 / 10000 + le.Populated_CNP_STORE_NUMBER_pcnt*ri.Populated_CNP_STORE_NUMBER_pcnt *  20.00 / 10000 + le.Populated_CNP_BTYPE_pcnt*ri.Populated_CNP_BTYPE_pcnt *   4.00 / 10000 + le.Populated_CNP_LOWV_pcnt*ri.Populated_CNP_LOWV_pcnt *   0.00 / 10000 + le.Populated_CNP_TRANSLATED_pcnt*ri.Populated_CNP_TRANSLATED_pcnt *   0.00 / 10000 + le.Populated_CNP_CLASSID_pcnt*ri.Populated_CNP_CLASSID_pcnt *   0.00 / 10000 + le.Populated_ADDRESS_ID_pcnt*ri.Populated_ADDRESS_ID_pcnt *   0.00 / 10000 + le.Populated_ADDRESS_CLASSIFICATION_pcnt*ri.Populated_ADDRESS_CLASSIFICATION_pcnt *   0.00 / 10000 + le.Populated_PRIM_RANGE_pcnt*ri.Populated_PRIM_RANGE_pcnt *  12.00 / 10000 + le.Populated_PRIM_NAME_pcnt*ri.Populated_PRIM_NAME_pcnt *  13.00 / 10000 + le.Populated_SEC_RANGE_pcnt*ri.Populated_SEC_RANGE_pcnt *   7.00 / 10000 + le.Populated_ST_pcnt*ri.Populated_ST_pcnt *   5.00 / 10000 + le.Populated_V_CITY_NAME_pcnt*ri.Populated_V_CITY_NAME_pcnt *  11.00 / 10000 + le.Populated_ZIP_pcnt*ri.Populated_ZIP_pcnt *  13.00 / 10000 + le.Populated_TAXONOMY_pcnt*ri.Populated_TAXONOMY_pcnt *   7.00 / 10000 + le.Populated_TAXONOMY_CODE_pcnt*ri.Populated_TAXONOMY_CODE_pcnt *   4.00 / 10000 + le.Populated_MEDICAID_NUMBER_pcnt*ri.Populated_MEDICAID_NUMBER_pcnt *  22.00 / 10000 + le.Populated_VENDOR_ID_pcnt*ri.Populated_VENDOR_ID_pcnt *  21.00 / 10000 + le.Populated_DT_FIRST_SEEN_pcnt*ri.Populated_DT_FIRST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_LAST_SEEN_pcnt*ri.Populated_DT_LAST_SEEN_pcnt *   0.00 / 10000 + le.Populated_DT_LIC_EXPIRATION_pcnt*ri.Populated_DT_LIC_EXPIRATION_pcnt *   0.00 / 10000 + le.Populated_DT_DEA_EXPIRATION_pcnt*ri.Populated_DT_DEA_EXPIRATION_pcnt *   0.00 / 10000 + le.Populated_LIC_STATE_pcnt*ri.Populated_LIC_STATE_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'PHONE','FAX','UPIN','NPI_NUMBER','DEA_NUMBER','CLIA_NUMBER','MEDICARE_FACILITY_NUMBER','NCPDP_NUMBER','TAX_ID','FEIN','C_LIC_NBR','SRC','CNAME','CNP_NAME','CNP_NUMBER','CNP_STORE_NUMBER','CNP_BTYPE','CNP_LOWV','CNP_TRANSLATED','CNP_CLASSID','ADDRESS_ID','ADDRESS_CLASSIFICATION','PRIM_RANGE','PRIM_NAME','SEC_RANGE','ST','V_CITY_NAME','ZIP','TAXONOMY','TAXONOMY_CODE','MEDICAID_NUMBER','VENDOR_ID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_LIC_EXPIRATION','DT_DEA_EXPIRATION','LIC_STATE');
  SELF.populated_pcnt := CHOOSE(C,le.populated_PHONE_pcnt,le.populated_FAX_pcnt,le.populated_UPIN_pcnt,le.populated_NPI_NUMBER_pcnt,le.populated_DEA_NUMBER_pcnt,le.populated_CLIA_NUMBER_pcnt,le.populated_MEDICARE_FACILITY_NUMBER_pcnt,le.populated_NCPDP_NUMBER_pcnt,le.populated_TAX_ID_pcnt,le.populated_FEIN_pcnt,le.populated_C_LIC_NBR_pcnt,le.populated_SRC_pcnt,le.populated_CNAME_pcnt,le.populated_CNP_NAME_pcnt,le.populated_CNP_NUMBER_pcnt,le.populated_CNP_STORE_NUMBER_pcnt,le.populated_CNP_BTYPE_pcnt,le.populated_CNP_LOWV_pcnt,le.populated_CNP_TRANSLATED_pcnt,le.populated_CNP_CLASSID_pcnt,le.populated_ADDRESS_ID_pcnt,le.populated_ADDRESS_CLASSIFICATION_pcnt,le.populated_PRIM_RANGE_pcnt,le.populated_PRIM_NAME_pcnt,le.populated_SEC_RANGE_pcnt,le.populated_ST_pcnt,le.populated_V_CITY_NAME_pcnt,le.populated_ZIP_pcnt,le.populated_TAXONOMY_pcnt,le.populated_TAXONOMY_CODE_pcnt,le.populated_MEDICAID_NUMBER_pcnt,le.populated_VENDOR_ID_pcnt,le.populated_DT_FIRST_SEEN_pcnt,le.populated_DT_LAST_SEEN_pcnt,le.populated_DT_LIC_EXPIRATION_pcnt,le.populated_DT_DEA_EXPIRATION_pcnt,le.populated_LIC_STATE_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_PHONE,le.maxlength_FAX,le.maxlength_UPIN,le.maxlength_NPI_NUMBER,le.maxlength_DEA_NUMBER,le.maxlength_CLIA_NUMBER,le.maxlength_MEDICARE_FACILITY_NUMBER,le.maxlength_NCPDP_NUMBER,le.maxlength_TAX_ID,le.maxlength_FEIN,le.maxlength_C_LIC_NBR,le.maxlength_SRC,le.maxlength_CNAME,le.maxlength_CNP_NAME,le.maxlength_CNP_NUMBER,le.maxlength_CNP_STORE_NUMBER,le.maxlength_CNP_BTYPE,le.maxlength_CNP_LOWV,le.maxlength_CNP_TRANSLATED,le.maxlength_CNP_CLASSID,le.maxlength_ADDRESS_ID,le.maxlength_ADDRESS_CLASSIFICATION,le.maxlength_PRIM_RANGE,le.maxlength_PRIM_NAME,le.maxlength_SEC_RANGE,le.maxlength_ST,le.maxlength_V_CITY_NAME,le.maxlength_ZIP,le.maxlength_TAXONOMY,le.maxlength_TAXONOMY_CODE,le.maxlength_MEDICAID_NUMBER,le.maxlength_VENDOR_ID,le.maxlength_DT_FIRST_SEEN,le.maxlength_DT_LAST_SEEN,le.maxlength_DT_LIC_EXPIRATION,le.maxlength_DT_DEA_EXPIRATION,le.maxlength_LIC_STATE);
  SELF.avelength := CHOOSE(C,le.avelength_PHONE,le.avelength_FAX,le.avelength_UPIN,le.avelength_NPI_NUMBER,le.avelength_DEA_NUMBER,le.avelength_CLIA_NUMBER,le.avelength_MEDICARE_FACILITY_NUMBER,le.avelength_NCPDP_NUMBER,le.avelength_TAX_ID,le.avelength_FEIN,le.avelength_C_LIC_NBR,le.avelength_SRC,le.avelength_CNAME,le.avelength_CNP_NAME,le.avelength_CNP_NUMBER,le.avelength_CNP_STORE_NUMBER,le.avelength_CNP_BTYPE,le.avelength_CNP_LOWV,le.avelength_CNP_TRANSLATED,le.avelength_CNP_CLASSID,le.avelength_ADDRESS_ID,le.avelength_ADDRESS_CLASSIFICATION,le.avelength_PRIM_RANGE,le.avelength_PRIM_NAME,le.avelength_SEC_RANGE,le.avelength_ST,le.avelength_V_CITY_NAME,le.avelength_ZIP,le.avelength_TAXONOMY,le.avelength_TAXONOMY_CODE,le.avelength_MEDICAID_NUMBER,le.avelength_VENDOR_ID,le.avelength_DT_FIRST_SEEN,le.avelength_DT_LAST_SEEN,le.avelength_DT_LIC_EXPIRATION,le.avelength_DT_DEA_EXPIRATION,le.avelength_LIC_STATE);
END;
EXPORT invSummary := NORMALIZE(summary0, 37, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.LNPID;
  SELF.Src := le.SRC;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.PHONE),TRIM((SALT30.StrType)le.FAX),TRIM((SALT30.StrType)le.UPIN),TRIM((SALT30.StrType)le.NPI_NUMBER),TRIM((SALT30.StrType)le.DEA_NUMBER),TRIM((SALT30.StrType)le.CLIA_NUMBER),TRIM((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT30.StrType)le.NCPDP_NUMBER),TRIM((SALT30.StrType)le.TAX_ID),TRIM((SALT30.StrType)le.FEIN),TRIM((SALT30.StrType)le.C_LIC_NBR),TRIM((SALT30.StrType)le.SRC),TRIM((SALT30.StrType)le.CNAME),TRIM((SALT30.StrType)le.CNP_NAME),TRIM((SALT30.StrType)le.CNP_NUMBER),TRIM((SALT30.StrType)le.CNP_STORE_NUMBER),TRIM((SALT30.StrType)le.CNP_BTYPE),TRIM((SALT30.StrType)le.CNP_LOWV),TRIM((SALT30.StrType)le.CNP_TRANSLATED),TRIM((SALT30.StrType)le.CNP_CLASSID),TRIM((SALT30.StrType)le.ADDRESS_ID),TRIM((SALT30.StrType)le.ADDRESS_CLASSIFICATION),TRIM((SALT30.StrType)le.PRIM_RANGE),TRIM((SALT30.StrType)le.PRIM_NAME),TRIM((SALT30.StrType)le.SEC_RANGE),TRIM((SALT30.StrType)le.ST),TRIM((SALT30.StrType)le.V_CITY_NAME),TRIM((SALT30.StrType)le.ZIP),TRIM((SALT30.StrType)le.TAXONOMY),TRIM((SALT30.StrType)le.TAXONOMY_CODE),TRIM((SALT30.StrType)le.MEDICAID_NUMBER),TRIM((SALT30.StrType)le.VENDOR_ID),TRIM((SALT30.StrType)le.DT_FIRST_SEEN),TRIM((SALT30.StrType)le.DT_LAST_SEEN),TRIM((SALT30.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT30.StrType)le.DT_DEA_EXPIRATION),TRIM((SALT30.StrType)le.LIC_STATE)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,37,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 37);
  SELF.FldNo2 := 1 + (C % 37);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.PHONE),TRIM((SALT30.StrType)le.FAX),TRIM((SALT30.StrType)le.UPIN),TRIM((SALT30.StrType)le.NPI_NUMBER),TRIM((SALT30.StrType)le.DEA_NUMBER),TRIM((SALT30.StrType)le.CLIA_NUMBER),TRIM((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT30.StrType)le.NCPDP_NUMBER),TRIM((SALT30.StrType)le.TAX_ID),TRIM((SALT30.StrType)le.FEIN),TRIM((SALT30.StrType)le.C_LIC_NBR),TRIM((SALT30.StrType)le.SRC),TRIM((SALT30.StrType)le.CNAME),TRIM((SALT30.StrType)le.CNP_NAME),TRIM((SALT30.StrType)le.CNP_NUMBER),TRIM((SALT30.StrType)le.CNP_STORE_NUMBER),TRIM((SALT30.StrType)le.CNP_BTYPE),TRIM((SALT30.StrType)le.CNP_LOWV),TRIM((SALT30.StrType)le.CNP_TRANSLATED),TRIM((SALT30.StrType)le.CNP_CLASSID),TRIM((SALT30.StrType)le.ADDRESS_ID),TRIM((SALT30.StrType)le.ADDRESS_CLASSIFICATION),TRIM((SALT30.StrType)le.PRIM_RANGE),TRIM((SALT30.StrType)le.PRIM_NAME),TRIM((SALT30.StrType)le.SEC_RANGE),TRIM((SALT30.StrType)le.ST),TRIM((SALT30.StrType)le.V_CITY_NAME),TRIM((SALT30.StrType)le.ZIP),TRIM((SALT30.StrType)le.TAXONOMY),TRIM((SALT30.StrType)le.TAXONOMY_CODE),TRIM((SALT30.StrType)le.MEDICAID_NUMBER),TRIM((SALT30.StrType)le.VENDOR_ID),TRIM((SALT30.StrType)le.DT_FIRST_SEEN),TRIM((SALT30.StrType)le.DT_LAST_SEEN),TRIM((SALT30.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT30.StrType)le.DT_DEA_EXPIRATION),TRIM((SALT30.StrType)le.LIC_STATE)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.PHONE),TRIM((SALT30.StrType)le.FAX),TRIM((SALT30.StrType)le.UPIN),TRIM((SALT30.StrType)le.NPI_NUMBER),TRIM((SALT30.StrType)le.DEA_NUMBER),TRIM((SALT30.StrType)le.CLIA_NUMBER),TRIM((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER),TRIM((SALT30.StrType)le.NCPDP_NUMBER),TRIM((SALT30.StrType)le.TAX_ID),TRIM((SALT30.StrType)le.FEIN),TRIM((SALT30.StrType)le.C_LIC_NBR),TRIM((SALT30.StrType)le.SRC),TRIM((SALT30.StrType)le.CNAME),TRIM((SALT30.StrType)le.CNP_NAME),TRIM((SALT30.StrType)le.CNP_NUMBER),TRIM((SALT30.StrType)le.CNP_STORE_NUMBER),TRIM((SALT30.StrType)le.CNP_BTYPE),TRIM((SALT30.StrType)le.CNP_LOWV),TRIM((SALT30.StrType)le.CNP_TRANSLATED),TRIM((SALT30.StrType)le.CNP_CLASSID),TRIM((SALT30.StrType)le.ADDRESS_ID),TRIM((SALT30.StrType)le.ADDRESS_CLASSIFICATION),TRIM((SALT30.StrType)le.PRIM_RANGE),TRIM((SALT30.StrType)le.PRIM_NAME),TRIM((SALT30.StrType)le.SEC_RANGE),TRIM((SALT30.StrType)le.ST),TRIM((SALT30.StrType)le.V_CITY_NAME),TRIM((SALT30.StrType)le.ZIP),TRIM((SALT30.StrType)le.TAXONOMY),TRIM((SALT30.StrType)le.TAXONOMY_CODE),TRIM((SALT30.StrType)le.MEDICAID_NUMBER),TRIM((SALT30.StrType)le.VENDOR_ID),TRIM((SALT30.StrType)le.DT_FIRST_SEEN),TRIM((SALT30.StrType)le.DT_LAST_SEEN),TRIM((SALT30.StrType)le.DT_LIC_EXPIRATION),TRIM((SALT30.StrType)le.DT_DEA_EXPIRATION),TRIM((SALT30.StrType)le.LIC_STATE)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),37*37,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'PHONE'}
      ,{2,'FAX'}
      ,{3,'UPIN'}
      ,{4,'NPI_NUMBER'}
      ,{5,'DEA_NUMBER'}
      ,{6,'CLIA_NUMBER'}
      ,{7,'MEDICARE_FACILITY_NUMBER'}
      ,{8,'NCPDP_NUMBER'}
      ,{9,'TAX_ID'}
      ,{10,'FEIN'}
      ,{11,'C_LIC_NBR'}
      ,{12,'SRC'}
      ,{13,'CNAME'}
      ,{14,'CNP_NAME'}
      ,{15,'CNP_NUMBER'}
      ,{16,'CNP_STORE_NUMBER'}
      ,{17,'CNP_BTYPE'}
      ,{18,'CNP_LOWV'}
      ,{19,'CNP_TRANSLATED'}
      ,{20,'CNP_CLASSID'}
      ,{21,'ADDRESS_ID'}
      ,{22,'ADDRESS_CLASSIFICATION'}
      ,{23,'PRIM_RANGE'}
      ,{24,'PRIM_NAME'}
      ,{25,'SEC_RANGE'}
      ,{26,'ST'}
      ,{27,'V_CITY_NAME'}
      ,{28,'ZIP'}
      ,{29,'TAXONOMY'}
      ,{30,'TAXONOMY_CODE'}
      ,{31,'MEDICAID_NUMBER'}
      ,{32,'VENDOR_ID'}
      ,{33,'DT_FIRST_SEEN'}
      ,{34,'DT_LAST_SEEN'}
      ,{35,'DT_LIC_EXPIRATION'}
      ,{36,'DT_DEA_EXPIRATION'}
      ,{37,'LIC_STATE'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.SRC) SRC; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_PHONE((SALT30.StrType)le.PHONE),
    Fields.InValid_FAX((SALT30.StrType)le.FAX),
    Fields.InValid_UPIN((SALT30.StrType)le.UPIN),
    Fields.InValid_NPI_NUMBER((SALT30.StrType)le.NPI_NUMBER),
    Fields.InValid_DEA_NUMBER((SALT30.StrType)le.DEA_NUMBER),
    Fields.InValid_CLIA_NUMBER((SALT30.StrType)le.CLIA_NUMBER),
    Fields.InValid_MEDICARE_FACILITY_NUMBER((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER),
    Fields.InValid_NCPDP_NUMBER((SALT30.StrType)le.NCPDP_NUMBER),
    Fields.InValid_TAX_ID((SALT30.StrType)le.TAX_ID),
    Fields.InValid_FEIN((SALT30.StrType)le.FEIN),
    Fields.InValid_C_LIC_NBR((SALT30.StrType)le.C_LIC_NBR),
    Fields.InValid_SRC((SALT30.StrType)le.SRC),
    Fields.InValid_CNAME((SALT30.StrType)le.CNAME),
    Fields.InValid_CNP_NAME((SALT30.StrType)le.CNP_NAME),
    Fields.InValid_CNP_NUMBER((SALT30.StrType)le.CNP_NUMBER),
    Fields.InValid_CNP_STORE_NUMBER((SALT30.StrType)le.CNP_STORE_NUMBER),
    Fields.InValid_CNP_BTYPE((SALT30.StrType)le.CNP_BTYPE),
    Fields.InValid_CNP_LOWV((SALT30.StrType)le.CNP_LOWV),
    Fields.InValid_CNP_TRANSLATED((SALT30.StrType)le.CNP_TRANSLATED),
    Fields.InValid_CNP_CLASSID((SALT30.StrType)le.CNP_CLASSID),
    Fields.InValid_ADDRESS_ID((SALT30.StrType)le.ADDRESS_ID),
    Fields.InValid_ADDRESS_CLASSIFICATION((SALT30.StrType)le.ADDRESS_CLASSIFICATION),
    Fields.InValid_PRIM_RANGE((SALT30.StrType)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((SALT30.StrType)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((SALT30.StrType)le.SEC_RANGE),
    Fields.InValid_ST((SALT30.StrType)le.ST),
    Fields.InValid_V_CITY_NAME((SALT30.StrType)le.V_CITY_NAME),
    Fields.InValid_ZIP((SALT30.StrType)le.ZIP),
    Fields.InValid_TAXONOMY((SALT30.StrType)le.TAXONOMY),
    Fields.InValid_TAXONOMY_CODE((SALT30.StrType)le.TAXONOMY_CODE),
    Fields.InValid_MEDICAID_NUMBER((SALT30.StrType)le.MEDICAID_NUMBER),
    Fields.InValid_VENDOR_ID((SALT30.StrType)le.VENDOR_ID),
    Fields.InValid_DT_FIRST_SEEN((SALT30.StrType)le.DT_FIRST_SEEN),
    Fields.InValid_DT_LAST_SEEN((SALT30.StrType)le.DT_LAST_SEEN),
    Fields.InValid_DT_LIC_EXPIRATION((SALT30.StrType)le.DT_LIC_EXPIRATION),
    Fields.InValid_DT_DEA_EXPIRATION((SALT30.StrType)le.DT_DEA_EXPIRATION),
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    0, // Uncleanable field
    Fields.InValid_LIC_STATE((SALT30.StrType)le.LIC_STATE),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.SRC := le.SRC;
END;
Errors := NORMALIZE(h,41,NoteErrors(LEFT,COUNTER));
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','WORDBAG','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','ALPHA','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_FAX(TotalErrors.ErrorNum),Fields.InValidMessage_UPIN(TotalErrors.ErrorNum),Fields.InValidMessage_NPI_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_DEA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CLIA_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_MEDICARE_FACILITY_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_NCPDP_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_TAX_ID(TotalErrors.ErrorNum),Fields.InValidMessage_FEIN(TotalErrors.ErrorNum),Fields.InValidMessage_C_LIC_NBR(TotalErrors.ErrorNum),Fields.InValidMessage_SRC(TotalErrors.ErrorNum),Fields.InValidMessage_CNAME(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_STORE_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_BTYPE(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_LOWV(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_TRANSLATED(TotalErrors.ErrorNum),Fields.InValidMessage_CNP_CLASSID(TotalErrors.ErrorNum),Fields.InValidMessage_ADDRESS_ID(TotalErrors.ErrorNum),Fields.InValidMessage_ADDRESS_CLASSIFICATION(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_ST(TotalErrors.ErrorNum),Fields.InValidMessage_V_CITY_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_TAXONOMY(TotalErrors.ErrorNum),Fields.InValidMessage_TAXONOMY_CODE(TotalErrors.ErrorNum),Fields.InValidMessage_MEDICAID_NUMBER(TotalErrors.ErrorNum),Fields.InValidMessage_VENDOR_ID(TotalErrors.ErrorNum),Fields.InValidMessage_DT_FIRST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LAST_SEEN(TotalErrors.ErrorNum),Fields.InValidMessage_DT_LIC_EXPIRATION(TotalErrors.ErrorNum),Fields.InValidMessage_DT_DEA_EXPIRATION(TotalErrors.ErrorNum),'','','','',Fields.InValidMessage_LIC_STATE(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.SRC=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
//We have LNPID specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT30.MOD_ClusterStats.Counts(h,LNPID);
EXPORT ClusterSrc := SALT30.MOD_ClusterStats.Sources(h,LNPID,SRC);
END;
