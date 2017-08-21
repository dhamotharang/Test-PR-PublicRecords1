IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_HealthFacility)
    UNSIGNED1 PHONE_Invalid;
    UNSIGNED1 FAX_Invalid;
    UNSIGNED1 UPIN_Invalid;
    UNSIGNED1 NPI_NUMBER_Invalid;
    UNSIGNED1 DEA_NUMBER_Invalid;
    UNSIGNED1 CLIA_NUMBER_Invalid;
    UNSIGNED1 MEDICARE_FACILITY_NUMBER_Invalid;
    UNSIGNED1 NCPDP_NUMBER_Invalid;
    UNSIGNED1 TAX_ID_Invalid;
    UNSIGNED1 FEIN_Invalid;
    UNSIGNED1 C_LIC_NBR_Invalid;
    UNSIGNED1 SRC_Invalid;
    UNSIGNED1 CNAME_Invalid;
    UNSIGNED1 CNP_NAME_Invalid;
    UNSIGNED1 CNP_NUMBER_Invalid;
    UNSIGNED1 CNP_STORE_NUMBER_Invalid;
    UNSIGNED1 CNP_BTYPE_Invalid;
    UNSIGNED1 CNP_LOWV_Invalid;
    UNSIGNED1 CNP_TRANSLATED_Invalid;
    UNSIGNED1 CNP_CLASSID_Invalid;
    UNSIGNED1 ADDRESS_ID_Invalid;
    UNSIGNED1 ADDRESS_CLASSIFICATION_Invalid;
    UNSIGNED1 PRIM_RANGE_Invalid;
    UNSIGNED1 PRIM_NAME_Invalid;
    UNSIGNED1 SEC_RANGE_Invalid;
    UNSIGNED1 ST_Invalid;
    UNSIGNED1 V_CITY_NAME_Invalid;
    UNSIGNED1 ZIP_Invalid;
    UNSIGNED1 TAXONOMY_Invalid;
    UNSIGNED1 TAXONOMY_CODE_Invalid;
    UNSIGNED1 MEDICAID_NUMBER_Invalid;
    UNSIGNED1 VENDOR_ID_Invalid;
    UNSIGNED1 DT_FIRST_SEEN_Invalid;
    UNSIGNED1 DT_LAST_SEEN_Invalid;
    UNSIGNED1 DT_LIC_EXPIRATION_Invalid;
    UNSIGNED1 DT_DEA_EXPIRATION_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_HealthFacility)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_HealthFacility) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.PHONE_Invalid := Fields.InValid_PHONE((SALT30.StrType)le.PHONE);
    SELF.FAX_Invalid := Fields.InValid_FAX((SALT30.StrType)le.FAX);
    SELF.UPIN_Invalid := Fields.InValid_UPIN((SALT30.StrType)le.UPIN);
    SELF.NPI_NUMBER_Invalid := Fields.InValid_NPI_NUMBER((SALT30.StrType)le.NPI_NUMBER);
    SELF.DEA_NUMBER_Invalid := Fields.InValid_DEA_NUMBER((SALT30.StrType)le.DEA_NUMBER);
    SELF.CLIA_NUMBER_Invalid := Fields.InValid_CLIA_NUMBER((SALT30.StrType)le.CLIA_NUMBER);
    SELF.MEDICARE_FACILITY_NUMBER_Invalid := Fields.InValid_MEDICARE_FACILITY_NUMBER((SALT30.StrType)le.MEDICARE_FACILITY_NUMBER);
    SELF.NCPDP_NUMBER_Invalid := Fields.InValid_NCPDP_NUMBER((SALT30.StrType)le.NCPDP_NUMBER);
    SELF.TAX_ID_Invalid := Fields.InValid_TAX_ID((SALT30.StrType)le.TAX_ID);
    SELF.FEIN_Invalid := Fields.InValid_FEIN((SALT30.StrType)le.FEIN);
    SELF.C_LIC_NBR_Invalid := Fields.InValid_C_LIC_NBR((SALT30.StrType)le.C_LIC_NBR);
    SELF.SRC_Invalid := Fields.InValid_SRC((SALT30.StrType)le.SRC);
    SELF.CNAME_Invalid := Fields.InValid_CNAME((SALT30.StrType)le.CNAME);
    SELF.CNP_NAME_Invalid := Fields.InValid_CNP_NAME((SALT30.StrType)le.CNP_NAME);
    SELF.CNP_NUMBER_Invalid := Fields.InValid_CNP_NUMBER((SALT30.StrType)le.CNP_NUMBER);
    SELF.CNP_STORE_NUMBER_Invalid := Fields.InValid_CNP_STORE_NUMBER((SALT30.StrType)le.CNP_STORE_NUMBER);
    SELF.CNP_BTYPE_Invalid := Fields.InValid_CNP_BTYPE((SALT30.StrType)le.CNP_BTYPE);
    SELF.CNP_LOWV_Invalid := Fields.InValid_CNP_LOWV((SALT30.StrType)le.CNP_LOWV);
    SELF.CNP_TRANSLATED_Invalid := Fields.InValid_CNP_TRANSLATED((SALT30.StrType)le.CNP_TRANSLATED);
    SELF.CNP_CLASSID_Invalid := Fields.InValid_CNP_CLASSID((SALT30.StrType)le.CNP_CLASSID);
    SELF.ADDRESS_ID_Invalid := Fields.InValid_ADDRESS_ID((SALT30.StrType)le.ADDRESS_ID);
    SELF.ADDRESS_CLASSIFICATION_Invalid := Fields.InValid_ADDRESS_CLASSIFICATION((SALT30.StrType)le.ADDRESS_CLASSIFICATION);
    SELF.PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT30.StrType)le.PRIM_RANGE);
    SELF.PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT30.StrType)le.PRIM_NAME);
    SELF.SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT30.StrType)le.SEC_RANGE);
    SELF.ST_Invalid := Fields.InValid_ST((SALT30.StrType)le.ST);
    SELF.V_CITY_NAME_Invalid := Fields.InValid_V_CITY_NAME((SALT30.StrType)le.V_CITY_NAME);
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT30.StrType)le.ZIP);
    SELF.TAXONOMY_Invalid := Fields.InValid_TAXONOMY((SALT30.StrType)le.TAXONOMY);
    SELF.TAXONOMY_CODE_Invalid := Fields.InValid_TAXONOMY_CODE((SALT30.StrType)le.TAXONOMY_CODE);
    SELF.MEDICAID_NUMBER_Invalid := Fields.InValid_MEDICAID_NUMBER((SALT30.StrType)le.MEDICAID_NUMBER);
    SELF.VENDOR_ID_Invalid := Fields.InValid_VENDOR_ID((SALT30.StrType)le.VENDOR_ID);
    SELF.DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT30.StrType)le.DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT30.StrType)le.DT_LAST_SEEN);
    SELF.DT_LIC_EXPIRATION_Invalid := Fields.InValid_DT_LIC_EXPIRATION((SALT30.StrType)le.DT_LIC_EXPIRATION);
    SELF.DT_DEA_EXPIRATION_Invalid := Fields.InValid_DT_DEA_EXPIRATION((SALT30.StrType)le.DT_DEA_EXPIRATION);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.PHONE_Invalid << 0 ) + ( le.FAX_Invalid << 2 ) + ( le.UPIN_Invalid << 4 ) + ( le.NPI_NUMBER_Invalid << 6 ) + ( le.DEA_NUMBER_Invalid << 7 ) + ( le.CLIA_NUMBER_Invalid << 9 ) + ( le.MEDICARE_FACILITY_NUMBER_Invalid << 11 ) + ( le.NCPDP_NUMBER_Invalid << 13 ) + ( le.TAX_ID_Invalid << 15 ) + ( le.FEIN_Invalid << 17 ) + ( le.C_LIC_NBR_Invalid << 19 ) + ( le.SRC_Invalid << 21 ) + ( le.CNAME_Invalid << 23 ) + ( le.CNP_NAME_Invalid << 25 ) + ( le.CNP_NUMBER_Invalid << 27 ) + ( le.CNP_STORE_NUMBER_Invalid << 29 ) + ( le.CNP_BTYPE_Invalid << 31 ) + ( le.CNP_LOWV_Invalid << 33 ) + ( le.CNP_TRANSLATED_Invalid << 35 ) + ( le.CNP_CLASSID_Invalid << 37 ) + ( le.ADDRESS_ID_Invalid << 39 ) + ( le.ADDRESS_CLASSIFICATION_Invalid << 40 ) + ( le.PRIM_RANGE_Invalid << 42 ) + ( le.PRIM_NAME_Invalid << 44 ) + ( le.SEC_RANGE_Invalid << 46 ) + ( le.ST_Invalid << 48 ) + ( le.V_CITY_NAME_Invalid << 50 ) + ( le.ZIP_Invalid << 52 ) + ( le.TAXONOMY_Invalid << 54 ) + ( le.TAXONOMY_CODE_Invalid << 56 ) + ( le.MEDICAID_NUMBER_Invalid << 58 ) + ( le.VENDOR_ID_Invalid << 60 ) + ( le.DT_FIRST_SEEN_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.DT_LAST_SEEN_Invalid << 0 ) + ( le.DT_LIC_EXPIRATION_Invalid << 2 ) + ( le.DT_DEA_EXPIRATION_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_HealthFacility);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.PHONE_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.FAX_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.UPIN_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.NPI_NUMBER_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.DEA_NUMBER_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.CLIA_NUMBER_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.MEDICARE_FACILITY_NUMBER_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.NCPDP_NUMBER_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.TAX_ID_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.FEIN_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.C_LIC_NBR_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.SRC_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.CNAME_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.CNP_NAME_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.CNP_NUMBER_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.CNP_STORE_NUMBER_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.CNP_BTYPE_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.CNP_LOWV_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.CNP_TRANSLATED_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.CNP_CLASSID_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.ADDRESS_ID_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.ADDRESS_CLASSIFICATION_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.V_CITY_NAME_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.TAXONOMY_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.TAXONOMY_CODE_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.MEDICAID_NUMBER_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.VENDOR_ID_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.DT_FIRST_SEEN_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.DT_LAST_SEEN_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.DT_LIC_EXPIRATION_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.DT_DEA_EXPIRATION_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.RID=RIGHT.RID AND (LEFT.PHONE_Invalid <> RIGHT.PHONE_Invalid OR LEFT.FAX_Invalid <> RIGHT.FAX_Invalid OR LEFT.UPIN_Invalid <> RIGHT.UPIN_Invalid OR LEFT.NPI_NUMBER_Invalid <> RIGHT.NPI_NUMBER_Invalid OR LEFT.DEA_NUMBER_Invalid <> RIGHT.DEA_NUMBER_Invalid OR LEFT.CLIA_NUMBER_Invalid <> RIGHT.CLIA_NUMBER_Invalid OR LEFT.MEDICARE_FACILITY_NUMBER_Invalid <> RIGHT.MEDICARE_FACILITY_NUMBER_Invalid OR LEFT.NCPDP_NUMBER_Invalid <> RIGHT.NCPDP_NUMBER_Invalid OR LEFT.TAX_ID_Invalid <> RIGHT.TAX_ID_Invalid OR LEFT.FEIN_Invalid <> RIGHT.FEIN_Invalid OR LEFT.C_LIC_NBR_Invalid <> RIGHT.C_LIC_NBR_Invalid OR LEFT.SRC_Invalid <> RIGHT.SRC_Invalid OR LEFT.CNAME_Invalid <> RIGHT.CNAME_Invalid OR LEFT.CNP_NAME_Invalid <> RIGHT.CNP_NAME_Invalid OR LEFT.CNP_NUMBER_Invalid <> RIGHT.CNP_NUMBER_Invalid OR LEFT.CNP_STORE_NUMBER_Invalid <> RIGHT.CNP_STORE_NUMBER_Invalid OR LEFT.CNP_BTYPE_Invalid <> RIGHT.CNP_BTYPE_Invalid OR LEFT.CNP_LOWV_Invalid <> RIGHT.CNP_LOWV_Invalid OR LEFT.CNP_TRANSLATED_Invalid <> RIGHT.CNP_TRANSLATED_Invalid OR LEFT.CNP_CLASSID_Invalid <> RIGHT.CNP_CLASSID_Invalid OR LEFT.ADDRESS_ID_Invalid <> RIGHT.ADDRESS_ID_Invalid OR LEFT.ADDRESS_CLASSIFICATION_Invalid <> RIGHT.ADDRESS_CLASSIFICATION_Invalid OR LEFT.PRIM_RANGE_Invalid <> RIGHT.PRIM_RANGE_Invalid OR LEFT.PRIM_NAME_Invalid <> RIGHT.PRIM_NAME_Invalid OR LEFT.SEC_RANGE_Invalid <> RIGHT.SEC_RANGE_Invalid OR LEFT.ST_Invalid <> RIGHT.ST_Invalid OR LEFT.V_CITY_NAME_Invalid <> RIGHT.V_CITY_NAME_Invalid OR LEFT.ZIP_Invalid <> RIGHT.ZIP_Invalid OR LEFT.TAXONOMY_Invalid <> RIGHT.TAXONOMY_Invalid OR LEFT.TAXONOMY_CODE_Invalid <> RIGHT.TAXONOMY_CODE_Invalid OR LEFT.MEDICAID_NUMBER_Invalid <> RIGHT.MEDICAID_NUMBER_Invalid OR LEFT.VENDOR_ID_Invalid <> RIGHT.VENDOR_ID_Invalid OR LEFT.DT_FIRST_SEEN_Invalid <> RIGHT.DT_FIRST_SEEN_Invalid OR LEFT.DT_LAST_SEEN_Invalid <> RIGHT.DT_LAST_SEEN_Invalid OR LEFT.DT_LIC_EXPIRATION_Invalid <> RIGHT.DT_LIC_EXPIRATION_Invalid OR LEFT.DT_DEA_EXPIRATION_Invalid <> RIGHT.DT_DEA_EXPIRATION_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.SRC;
    TotalCnt := COUNT(GROUP); // Number of records in total
    PHONE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=1);
    PHONE_QUOTES_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=2);
    PHONE_Total_ErrorCount := COUNT(GROUP,h.PHONE_Invalid>0);
    FAX_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FAX_Invalid=1);
    FAX_QUOTES_ErrorCount := COUNT(GROUP,h.FAX_Invalid=2);
    FAX_Total_ErrorCount := COUNT(GROUP,h.FAX_Invalid>0);
    UPIN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.UPIN_Invalid=1);
    UPIN_QUOTES_ErrorCount := COUNT(GROUP,h.UPIN_Invalid=2);
    UPIN_Total_ErrorCount := COUNT(GROUP,h.UPIN_Invalid>0);
    NPI_NUMBER_ALLOW_ErrorCount := COUNT(GROUP,h.NPI_NUMBER_Invalid=1);
    DEA_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=1);
    DEA_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=2);
    DEA_NUMBER_Total_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid>0);
    CLIA_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CLIA_NUMBER_Invalid=1);
    CLIA_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.CLIA_NUMBER_Invalid=2);
    CLIA_NUMBER_Total_ErrorCount := COUNT(GROUP,h.CLIA_NUMBER_Invalid>0);
    MEDICARE_FACILITY_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MEDICARE_FACILITY_NUMBER_Invalid=1);
    MEDICARE_FACILITY_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.MEDICARE_FACILITY_NUMBER_Invalid=2);
    MEDICARE_FACILITY_NUMBER_Total_ErrorCount := COUNT(GROUP,h.MEDICARE_FACILITY_NUMBER_Invalid>0);
    NCPDP_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.NCPDP_NUMBER_Invalid=1);
    NCPDP_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.NCPDP_NUMBER_Invalid=2);
    NCPDP_NUMBER_Total_ErrorCount := COUNT(GROUP,h.NCPDP_NUMBER_Invalid>0);
    TAX_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid=1);
    TAX_ID_QUOTES_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid=2);
    TAX_ID_Total_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid>0);
    FEIN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FEIN_Invalid=1);
    FEIN_QUOTES_ErrorCount := COUNT(GROUP,h.FEIN_Invalid=2);
    FEIN_Total_ErrorCount := COUNT(GROUP,h.FEIN_Invalid>0);
    C_LIC_NBR_LEFTTRIM_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=1);
    C_LIC_NBR_QUOTES_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=2);
    C_LIC_NBR_Total_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid>0);
    SRC_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SRC_Invalid=1);
    SRC_QUOTES_ErrorCount := COUNT(GROUP,h.SRC_Invalid=2);
    SRC_Total_ErrorCount := COUNT(GROUP,h.SRC_Invalid>0);
    CNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNAME_Invalid=1);
    CNAME_QUOTES_ErrorCount := COUNT(GROUP,h.CNAME_Invalid=2);
    CNAME_Total_ErrorCount := COUNT(GROUP,h.CNAME_Invalid>0);
    CNP_NAME_CAPS_ErrorCount := COUNT(GROUP,h.CNP_NAME_Invalid=1);
    CNP_NAME_ALLOW_ErrorCount := COUNT(GROUP,h.CNP_NAME_Invalid=2);
    CNP_NAME_Total_ErrorCount := COUNT(GROUP,h.CNP_NAME_Invalid>0);
    CNP_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_NUMBER_Invalid=1);
    CNP_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_NUMBER_Invalid=2);
    CNP_NUMBER_Total_ErrorCount := COUNT(GROUP,h.CNP_NUMBER_Invalid>0);
    CNP_STORE_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_STORE_NUMBER_Invalid=1);
    CNP_STORE_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_STORE_NUMBER_Invalid=2);
    CNP_STORE_NUMBER_Total_ErrorCount := COUNT(GROUP,h.CNP_STORE_NUMBER_Invalid>0);
    CNP_BTYPE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_BTYPE_Invalid=1);
    CNP_BTYPE_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_BTYPE_Invalid=2);
    CNP_BTYPE_Total_ErrorCount := COUNT(GROUP,h.CNP_BTYPE_Invalid>0);
    CNP_LOWV_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_LOWV_Invalid=1);
    CNP_LOWV_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_LOWV_Invalid=2);
    CNP_LOWV_Total_ErrorCount := COUNT(GROUP,h.CNP_LOWV_Invalid>0);
    CNP_TRANSLATED_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_TRANSLATED_Invalid=1);
    CNP_TRANSLATED_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_TRANSLATED_Invalid=2);
    CNP_TRANSLATED_Total_ErrorCount := COUNT(GROUP,h.CNP_TRANSLATED_Invalid>0);
    CNP_CLASSID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNP_CLASSID_Invalid=1);
    CNP_CLASSID_QUOTES_ErrorCount := COUNT(GROUP,h.CNP_CLASSID_Invalid=2);
    CNP_CLASSID_Total_ErrorCount := COUNT(GROUP,h.CNP_CLASSID_Invalid>0);
    ADDRESS_ID_ALLOW_ErrorCount := COUNT(GROUP,h.ADDRESS_ID_Invalid=1);
    ADDRESS_CLASSIFICATION_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ADDRESS_CLASSIFICATION_Invalid=1);
    ADDRESS_CLASSIFICATION_QUOTES_ErrorCount := COUNT(GROUP,h.ADDRESS_CLASSIFICATION_Invalid=2);
    ADDRESS_CLASSIFICATION_Total_ErrorCount := COUNT(GROUP,h.ADDRESS_CLASSIFICATION_Invalid>0);
    PRIM_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1);
    PRIM_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2);
    PRIM_RANGE_Total_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid>0);
    PRIM_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1);
    PRIM_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2);
    PRIM_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid>0);
    SEC_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1);
    SEC_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2);
    SEC_RANGE_Total_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid>0);
    ST_CAPS_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_ALLOW_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    V_CITY_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=1);
    V_CITY_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=2);
    V_CITY_NAME_Total_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid>0);
    ZIP_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    ZIP_QUOTES_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=2);
    ZIP_Total_ErrorCount := COUNT(GROUP,h.ZIP_Invalid>0);
    TAXONOMY_LEFTTRIM_ErrorCount := COUNT(GROUP,h.TAXONOMY_Invalid=1);
    TAXONOMY_QUOTES_ErrorCount := COUNT(GROUP,h.TAXONOMY_Invalid=2);
    TAXONOMY_Total_ErrorCount := COUNT(GROUP,h.TAXONOMY_Invalid>0);
    TAXONOMY_CODE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.TAXONOMY_CODE_Invalid=1);
    TAXONOMY_CODE_QUOTES_ErrorCount := COUNT(GROUP,h.TAXONOMY_CODE_Invalid=2);
    TAXONOMY_CODE_Total_ErrorCount := COUNT(GROUP,h.TAXONOMY_CODE_Invalid>0);
    MEDICAID_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MEDICAID_NUMBER_Invalid=1);
    MEDICAID_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.MEDICAID_NUMBER_Invalid=2);
    MEDICAID_NUMBER_Total_ErrorCount := COUNT(GROUP,h.MEDICAID_NUMBER_Invalid>0);
    VENDOR_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=1);
    VENDOR_ID_QUOTES_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=2);
    VENDOR_ID_Total_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid>0);
    DT_FIRST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=1);
    DT_FIRST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=2);
    DT_FIRST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid>0);
    DT_LAST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=1);
    DT_LAST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=2);
    DT_LAST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid>0);
    DT_LIC_EXPIRATION_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_LIC_EXPIRATION_Invalid=1);
    DT_LIC_EXPIRATION_QUOTES_ErrorCount := COUNT(GROUP,h.DT_LIC_EXPIRATION_Invalid=2);
    DT_LIC_EXPIRATION_Total_ErrorCount := COUNT(GROUP,h.DT_LIC_EXPIRATION_Invalid>0);
    DT_DEA_EXPIRATION_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_DEA_EXPIRATION_Invalid=1);
    DT_DEA_EXPIRATION_QUOTES_ErrorCount := COUNT(GROUP,h.DT_DEA_EXPIRATION_Invalid=2);
    DT_DEA_EXPIRATION_Total_ErrorCount := COUNT(GROUP,h.DT_DEA_EXPIRATION_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,SRC,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.SRC;
    UNSIGNED1 ErrNum := CHOOSE(c,le.PHONE_Invalid,le.FAX_Invalid,le.UPIN_Invalid,le.NPI_NUMBER_Invalid,le.DEA_NUMBER_Invalid,le.CLIA_NUMBER_Invalid,le.MEDICARE_FACILITY_NUMBER_Invalid,le.NCPDP_NUMBER_Invalid,le.TAX_ID_Invalid,le.FEIN_Invalid,le.C_LIC_NBR_Invalid,le.SRC_Invalid,le.CNAME_Invalid,le.CNP_NAME_Invalid,le.CNP_NUMBER_Invalid,le.CNP_STORE_NUMBER_Invalid,le.CNP_BTYPE_Invalid,le.CNP_LOWV_Invalid,le.CNP_TRANSLATED_Invalid,le.CNP_CLASSID_Invalid,le.ADDRESS_ID_Invalid,le.ADDRESS_CLASSIFICATION_Invalid,le.PRIM_RANGE_Invalid,le.PRIM_NAME_Invalid,le.SEC_RANGE_Invalid,le.ST_Invalid,le.V_CITY_NAME_Invalid,le.ZIP_Invalid,le.TAXONOMY_Invalid,le.TAXONOMY_CODE_Invalid,le.MEDICAID_NUMBER_Invalid,le.VENDOR_ID_Invalid,le.DT_FIRST_SEEN_Invalid,le.DT_LAST_SEEN_Invalid,le.DT_LIC_EXPIRATION_Invalid,le.DT_DEA_EXPIRATION_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_PHONE(le.PHONE_Invalid),Fields.InvalidMessage_FAX(le.FAX_Invalid),Fields.InvalidMessage_UPIN(le.UPIN_Invalid),Fields.InvalidMessage_NPI_NUMBER(le.NPI_NUMBER_Invalid),Fields.InvalidMessage_DEA_NUMBER(le.DEA_NUMBER_Invalid),Fields.InvalidMessage_CLIA_NUMBER(le.CLIA_NUMBER_Invalid),Fields.InvalidMessage_MEDICARE_FACILITY_NUMBER(le.MEDICARE_FACILITY_NUMBER_Invalid),Fields.InvalidMessage_NCPDP_NUMBER(le.NCPDP_NUMBER_Invalid),Fields.InvalidMessage_TAX_ID(le.TAX_ID_Invalid),Fields.InvalidMessage_FEIN(le.FEIN_Invalid),Fields.InvalidMessage_C_LIC_NBR(le.C_LIC_NBR_Invalid),Fields.InvalidMessage_SRC(le.SRC_Invalid),Fields.InvalidMessage_CNAME(le.CNAME_Invalid),Fields.InvalidMessage_CNP_NAME(le.CNP_NAME_Invalid),Fields.InvalidMessage_CNP_NUMBER(le.CNP_NUMBER_Invalid),Fields.InvalidMessage_CNP_STORE_NUMBER(le.CNP_STORE_NUMBER_Invalid),Fields.InvalidMessage_CNP_BTYPE(le.CNP_BTYPE_Invalid),Fields.InvalidMessage_CNP_LOWV(le.CNP_LOWV_Invalid),Fields.InvalidMessage_CNP_TRANSLATED(le.CNP_TRANSLATED_Invalid),Fields.InvalidMessage_CNP_CLASSID(le.CNP_CLASSID_Invalid),Fields.InvalidMessage_ADDRESS_ID(le.ADDRESS_ID_Invalid),Fields.InvalidMessage_ADDRESS_CLASSIFICATION(le.ADDRESS_CLASSIFICATION_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_V_CITY_NAME(le.V_CITY_NAME_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_TAXONOMY(le.TAXONOMY_Invalid),Fields.InvalidMessage_TAXONOMY_CODE(le.TAXONOMY_CODE_Invalid),Fields.InvalidMessage_MEDICAID_NUMBER(le.MEDICAID_NUMBER_Invalid),Fields.InvalidMessage_VENDOR_ID(le.VENDOR_ID_Invalid),Fields.InvalidMessage_DT_FIRST_SEEN(le.DT_FIRST_SEEN_Invalid),Fields.InvalidMessage_DT_LAST_SEEN(le.DT_LAST_SEEN_Invalid),Fields.InvalidMessage_DT_LIC_EXPIRATION(le.DT_LIC_EXPIRATION_Invalid),Fields.InvalidMessage_DT_DEA_EXPIRATION(le.DT_DEA_EXPIRATION_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.PHONE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FAX_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.UPIN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.NPI_NUMBER_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.DEA_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CLIA_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MEDICARE_FACILITY_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.NCPDP_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.TAX_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FEIN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.C_LIC_NBR_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SRC_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_NAME_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.CNP_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_STORE_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_BTYPE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_LOWV_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_TRANSLATED_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNP_CLASSID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ADDRESS_ID_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ADDRESS_CLASSIFICATION_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.V_CITY_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.TAXONOMY_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.TAXONOMY_CODE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MEDICAID_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.VENDOR_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_FIRST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LAST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LIC_EXPIRATION_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_DEA_EXPIRATION_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'PHONE','FAX','UPIN','NPI_NUMBER','DEA_NUMBER','CLIA_NUMBER','MEDICARE_FACILITY_NUMBER','NCPDP_NUMBER','TAX_ID','FEIN','C_LIC_NBR','SRC','CNAME','CNP_NAME','CNP_NUMBER','CNP_STORE_NUMBER','CNP_BTYPE','CNP_LOWV','CNP_TRANSLATED','CNP_CLASSID','ADDRESS_ID','ADDRESS_CLASSIFICATION','PRIM_RANGE','PRIM_NAME','SEC_RANGE','ST','V_CITY_NAME','ZIP','TAXONOMY','TAXONOMY_CODE','MEDICAID_NUMBER','VENDOR_ID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_LIC_EXPIRATION','DT_DEA_EXPIRATION','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','WORDBAG','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','ALPHA','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.PHONE,(SALT30.StrType)le.FAX,(SALT30.StrType)le.UPIN,(SALT30.StrType)le.NPI_NUMBER,(SALT30.StrType)le.DEA_NUMBER,(SALT30.StrType)le.CLIA_NUMBER,(SALT30.StrType)le.MEDICARE_FACILITY_NUMBER,(SALT30.StrType)le.NCPDP_NUMBER,(SALT30.StrType)le.TAX_ID,(SALT30.StrType)le.FEIN,(SALT30.StrType)le.C_LIC_NBR,(SALT30.StrType)le.SRC,(SALT30.StrType)le.CNAME,(SALT30.StrType)le.CNP_NAME,(SALT30.StrType)le.CNP_NUMBER,(SALT30.StrType)le.CNP_STORE_NUMBER,(SALT30.StrType)le.CNP_BTYPE,(SALT30.StrType)le.CNP_LOWV,(SALT30.StrType)le.CNP_TRANSLATED,(SALT30.StrType)le.CNP_CLASSID,(SALT30.StrType)le.ADDRESS_ID,(SALT30.StrType)le.ADDRESS_CLASSIFICATION,(SALT30.StrType)le.PRIM_RANGE,(SALT30.StrType)le.PRIM_NAME,(SALT30.StrType)le.SEC_RANGE,(SALT30.StrType)le.ST,(SALT30.StrType)le.V_CITY_NAME,(SALT30.StrType)le.ZIP,(SALT30.StrType)le.TAXONOMY,(SALT30.StrType)le.TAXONOMY_CODE,(SALT30.StrType)le.MEDICAID_NUMBER,(SALT30.StrType)le.VENDOR_ID,(SALT30.StrType)le.DT_FIRST_SEEN,(SALT30.StrType)le.DT_LAST_SEEN,(SALT30.StrType)le.DT_LIC_EXPIRATION,(SALT30.StrType)le.DT_DEA_EXPIRATION,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,36,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.SRC;
      SELF.ruledesc := CHOOSE(c
          ,'PHONE:DEFAULT:LEFTTRIM','PHONE:DEFAULT:QUOTES'
          ,'FAX:DEFAULT:LEFTTRIM','FAX:DEFAULT:QUOTES'
          ,'UPIN:DEFAULT:LEFTTRIM','UPIN:DEFAULT:QUOTES'
          ,'NPI_NUMBER:NUMBER:ALLOW'
          ,'DEA_NUMBER:DEFAULT:LEFTTRIM','DEA_NUMBER:DEFAULT:QUOTES'
          ,'CLIA_NUMBER:DEFAULT:LEFTTRIM','CLIA_NUMBER:DEFAULT:QUOTES'
          ,'MEDICARE_FACILITY_NUMBER:DEFAULT:LEFTTRIM','MEDICARE_FACILITY_NUMBER:DEFAULT:QUOTES'
          ,'NCPDP_NUMBER:DEFAULT:LEFTTRIM','NCPDP_NUMBER:DEFAULT:QUOTES'
          ,'TAX_ID:DEFAULT:LEFTTRIM','TAX_ID:DEFAULT:QUOTES'
          ,'FEIN:DEFAULT:LEFTTRIM','FEIN:DEFAULT:QUOTES'
          ,'C_LIC_NBR:DEFAULT:LEFTTRIM','C_LIC_NBR:DEFAULT:QUOTES'
          ,'SRC:DEFAULT:LEFTTRIM','SRC:DEFAULT:QUOTES'
          ,'CNAME:DEFAULT:LEFTTRIM','CNAME:DEFAULT:QUOTES'
          ,'CNP_NAME:WORDBAG:CAPS','CNP_NAME:WORDBAG:ALLOW'
          ,'CNP_NUMBER:DEFAULT:LEFTTRIM','CNP_NUMBER:DEFAULT:QUOTES'
          ,'CNP_STORE_NUMBER:DEFAULT:LEFTTRIM','CNP_STORE_NUMBER:DEFAULT:QUOTES'
          ,'CNP_BTYPE:DEFAULT:LEFTTRIM','CNP_BTYPE:DEFAULT:QUOTES'
          ,'CNP_LOWV:DEFAULT:LEFTTRIM','CNP_LOWV:DEFAULT:QUOTES'
          ,'CNP_TRANSLATED:DEFAULT:LEFTTRIM','CNP_TRANSLATED:DEFAULT:QUOTES'
          ,'CNP_CLASSID:DEFAULT:LEFTTRIM','CNP_CLASSID:DEFAULT:QUOTES'
          ,'ADDRESS_ID:NUMBER:ALLOW'
          ,'ADDRESS_CLASSIFICATION:DEFAULT:LEFTTRIM','ADDRESS_CLASSIFICATION:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'ST:ALPHA:CAPS','ST:ALPHA:ALLOW'
          ,'V_CITY_NAME:DEFAULT:LEFTTRIM','V_CITY_NAME:DEFAULT:QUOTES'
          ,'ZIP:DEFAULT:LEFTTRIM','ZIP:DEFAULT:QUOTES'
          ,'TAXONOMY:DEFAULT:LEFTTRIM','TAXONOMY:DEFAULT:QUOTES'
          ,'TAXONOMY_CODE:DEFAULT:LEFTTRIM','TAXONOMY_CODE:DEFAULT:QUOTES'
          ,'MEDICAID_NUMBER:DEFAULT:LEFTTRIM','MEDICAID_NUMBER:DEFAULT:QUOTES'
          ,'VENDOR_ID:DEFAULT:LEFTTRIM','VENDOR_ID:DEFAULT:QUOTES'
          ,'DT_FIRST_SEEN:DEFAULT:LEFTTRIM','DT_FIRST_SEEN:DEFAULT:QUOTES'
          ,'DT_LAST_SEEN:DEFAULT:LEFTTRIM','DT_LAST_SEEN:DEFAULT:QUOTES'
          ,'DT_LIC_EXPIRATION:DEFAULT:LEFTTRIM','DT_LIC_EXPIRATION:DEFAULT:QUOTES'
          ,'DT_DEA_EXPIRATION:DEFAULT:LEFTTRIM','DT_DEA_EXPIRATION:DEFAULT:QUOTES','UNKNOWN');
      SELF.ErrorMessage := '';
      SELF.rulecnt := CHOOSE(c
          ,le.PHONE_LEFTTRIM_ErrorCount,le.PHONE_QUOTES_ErrorCount
          ,le.FAX_LEFTTRIM_ErrorCount,le.FAX_QUOTES_ErrorCount
          ,le.UPIN_LEFTTRIM_ErrorCount,le.UPIN_QUOTES_ErrorCount
          ,le.NPI_NUMBER_ALLOW_ErrorCount
          ,le.DEA_NUMBER_LEFTTRIM_ErrorCount,le.DEA_NUMBER_QUOTES_ErrorCount
          ,le.CLIA_NUMBER_LEFTTRIM_ErrorCount,le.CLIA_NUMBER_QUOTES_ErrorCount
          ,le.MEDICARE_FACILITY_NUMBER_LEFTTRIM_ErrorCount,le.MEDICARE_FACILITY_NUMBER_QUOTES_ErrorCount
          ,le.NCPDP_NUMBER_LEFTTRIM_ErrorCount,le.NCPDP_NUMBER_QUOTES_ErrorCount
          ,le.TAX_ID_LEFTTRIM_ErrorCount,le.TAX_ID_QUOTES_ErrorCount
          ,le.FEIN_LEFTTRIM_ErrorCount,le.FEIN_QUOTES_ErrorCount
          ,le.C_LIC_NBR_LEFTTRIM_ErrorCount,le.C_LIC_NBR_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.CNAME_LEFTTRIM_ErrorCount,le.CNAME_QUOTES_ErrorCount
          ,le.CNP_NAME_CAPS_ErrorCount,le.CNP_NAME_ALLOW_ErrorCount
          ,le.CNP_NUMBER_LEFTTRIM_ErrorCount,le.CNP_NUMBER_QUOTES_ErrorCount
          ,le.CNP_STORE_NUMBER_LEFTTRIM_ErrorCount,le.CNP_STORE_NUMBER_QUOTES_ErrorCount
          ,le.CNP_BTYPE_LEFTTRIM_ErrorCount,le.CNP_BTYPE_QUOTES_ErrorCount
          ,le.CNP_LOWV_LEFTTRIM_ErrorCount,le.CNP_LOWV_QUOTES_ErrorCount
          ,le.CNP_TRANSLATED_LEFTTRIM_ErrorCount,le.CNP_TRANSLATED_QUOTES_ErrorCount
          ,le.CNP_CLASSID_LEFTTRIM_ErrorCount,le.CNP_CLASSID_QUOTES_ErrorCount
          ,le.ADDRESS_ID_ALLOW_ErrorCount
          ,le.ADDRESS_CLASSIFICATION_LEFTTRIM_ErrorCount,le.ADDRESS_CLASSIFICATION_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.ST_CAPS_ErrorCount,le.ST_ALLOW_ErrorCount
          ,le.V_CITY_NAME_LEFTTRIM_ErrorCount,le.V_CITY_NAME_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.TAXONOMY_LEFTTRIM_ErrorCount,le.TAXONOMY_QUOTES_ErrorCount
          ,le.TAXONOMY_CODE_LEFTTRIM_ErrorCount,le.TAXONOMY_CODE_QUOTES_ErrorCount
          ,le.MEDICAID_NUMBER_LEFTTRIM_ErrorCount,le.MEDICAID_NUMBER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DT_LIC_EXPIRATION_LEFTTRIM_ErrorCount,le.DT_LIC_EXPIRATION_QUOTES_ErrorCount
          ,le.DT_DEA_EXPIRATION_LEFTTRIM_ErrorCount,le.DT_DEA_EXPIRATION_QUOTES_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.PHONE_LEFTTRIM_ErrorCount,le.PHONE_QUOTES_ErrorCount
          ,le.FAX_LEFTTRIM_ErrorCount,le.FAX_QUOTES_ErrorCount
          ,le.UPIN_LEFTTRIM_ErrorCount,le.UPIN_QUOTES_ErrorCount
          ,le.NPI_NUMBER_ALLOW_ErrorCount
          ,le.DEA_NUMBER_LEFTTRIM_ErrorCount,le.DEA_NUMBER_QUOTES_ErrorCount
          ,le.CLIA_NUMBER_LEFTTRIM_ErrorCount,le.CLIA_NUMBER_QUOTES_ErrorCount
          ,le.MEDICARE_FACILITY_NUMBER_LEFTTRIM_ErrorCount,le.MEDICARE_FACILITY_NUMBER_QUOTES_ErrorCount
          ,le.NCPDP_NUMBER_LEFTTRIM_ErrorCount,le.NCPDP_NUMBER_QUOTES_ErrorCount
          ,le.TAX_ID_LEFTTRIM_ErrorCount,le.TAX_ID_QUOTES_ErrorCount
          ,le.FEIN_LEFTTRIM_ErrorCount,le.FEIN_QUOTES_ErrorCount
          ,le.C_LIC_NBR_LEFTTRIM_ErrorCount,le.C_LIC_NBR_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.CNAME_LEFTTRIM_ErrorCount,le.CNAME_QUOTES_ErrorCount
          ,le.CNP_NAME_CAPS_ErrorCount,le.CNP_NAME_ALLOW_ErrorCount
          ,le.CNP_NUMBER_LEFTTRIM_ErrorCount,le.CNP_NUMBER_QUOTES_ErrorCount
          ,le.CNP_STORE_NUMBER_LEFTTRIM_ErrorCount,le.CNP_STORE_NUMBER_QUOTES_ErrorCount
          ,le.CNP_BTYPE_LEFTTRIM_ErrorCount,le.CNP_BTYPE_QUOTES_ErrorCount
          ,le.CNP_LOWV_LEFTTRIM_ErrorCount,le.CNP_LOWV_QUOTES_ErrorCount
          ,le.CNP_TRANSLATED_LEFTTRIM_ErrorCount,le.CNP_TRANSLATED_QUOTES_ErrorCount
          ,le.CNP_CLASSID_LEFTTRIM_ErrorCount,le.CNP_CLASSID_QUOTES_ErrorCount
          ,le.ADDRESS_ID_ALLOW_ErrorCount
          ,le.ADDRESS_CLASSIFICATION_LEFTTRIM_ErrorCount,le.ADDRESS_CLASSIFICATION_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.ST_CAPS_ErrorCount,le.ST_ALLOW_ErrorCount
          ,le.V_CITY_NAME_LEFTTRIM_ErrorCount,le.V_CITY_NAME_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.TAXONOMY_LEFTTRIM_ErrorCount,le.TAXONOMY_QUOTES_ErrorCount
          ,le.TAXONOMY_CODE_LEFTTRIM_ErrorCount,le.TAXONOMY_CODE_QUOTES_ErrorCount
          ,le.MEDICAID_NUMBER_LEFTTRIM_ErrorCount,le.MEDICAID_NUMBER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DT_LIC_EXPIRATION_LEFTTRIM_ErrorCount,le.DT_LIC_EXPIRATION_QUOTES_ErrorCount
          ,le.DT_DEA_EXPIRATION_LEFTTRIM_ErrorCount,le.DT_DEA_EXPIRATION_QUOTES_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,70,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF.ErrorMessage := ri.ErrorMessage;
   SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
