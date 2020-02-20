IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 60;
  EXPORT NumRulesFromFieldType := 60;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 30;
  EXPORT NumFieldsWithPossibleEdits := 30;
  EXPORT NumRulesWithPossibleEdits := 60;
  EXPORT Expanded_Layout := RECORD(Layout_HealthProvider)
    UNSIGNED1 FNAME_Invalid;
    BOOLEAN FNAME_wouldClean;
    UNSIGNED1 MNAME_Invalid;
    BOOLEAN MNAME_wouldClean;
    UNSIGNED1 LNAME_Invalid;
    BOOLEAN LNAME_wouldClean;
    UNSIGNED1 SNAME_Invalid;
    BOOLEAN SNAME_wouldClean;
    UNSIGNED1 GENDER_Invalid;
    BOOLEAN GENDER_wouldClean;
    UNSIGNED1 PRIM_RANGE_Invalid;
    BOOLEAN PRIM_RANGE_wouldClean;
    UNSIGNED1 PRIM_NAME_Invalid;
    BOOLEAN PRIM_NAME_wouldClean;
    UNSIGNED1 SEC_RANGE_Invalid;
    BOOLEAN SEC_RANGE_wouldClean;
    UNSIGNED1 V_CITY_NAME_Invalid;
    BOOLEAN V_CITY_NAME_wouldClean;
    UNSIGNED1 ST_Invalid;
    BOOLEAN ST_wouldClean;
    UNSIGNED1 ZIP_Invalid;
    BOOLEAN ZIP_wouldClean;
    UNSIGNED1 SSN_Invalid;
    BOOLEAN SSN_wouldClean;
    UNSIGNED1 CNSMR_SSN_Invalid;
    BOOLEAN CNSMR_SSN_wouldClean;
    UNSIGNED1 DOB_Invalid;
    BOOLEAN DOB_wouldClean;
    UNSIGNED1 CNSMR_DOB_Invalid;
    BOOLEAN CNSMR_DOB_wouldClean;
    UNSIGNED1 PHONE_Invalid;
    BOOLEAN PHONE_wouldClean;
    UNSIGNED1 LIC_STATE_Invalid;
    BOOLEAN LIC_STATE_wouldClean;
    UNSIGNED1 C_LIC_NBR_Invalid;
    BOOLEAN C_LIC_NBR_wouldClean;
    UNSIGNED1 TAX_ID_Invalid;
    BOOLEAN TAX_ID_wouldClean;
    UNSIGNED1 BILLING_TAX_ID_Invalid;
    BOOLEAN BILLING_TAX_ID_wouldClean;
    UNSIGNED1 DEA_NUMBER_Invalid;
    BOOLEAN DEA_NUMBER_wouldClean;
    UNSIGNED1 VENDOR_ID_Invalid;
    BOOLEAN VENDOR_ID_wouldClean;
    UNSIGNED1 NPI_NUMBER_Invalid;
    BOOLEAN NPI_NUMBER_wouldClean;
    UNSIGNED1 BILLING_NPI_NUMBER_Invalid;
    BOOLEAN BILLING_NPI_NUMBER_wouldClean;
    UNSIGNED1 UPIN_Invalid;
    BOOLEAN UPIN_wouldClean;
    UNSIGNED1 DID_Invalid;
    BOOLEAN DID_wouldClean;
    UNSIGNED1 BDID_Invalid;
    BOOLEAN BDID_wouldClean;
    UNSIGNED1 SRC_Invalid;
    BOOLEAN SRC_wouldClean;
    UNSIGNED1 SOURCE_RID_Invalid;
    BOOLEAN SOURCE_RID_wouldClean;
    UNSIGNED1 RID_Invalid;
    BOOLEAN RID_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_HealthProvider)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_HealthProvider) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.FNAME_Invalid := Fields.InValid_FNAME((SALT311.StrType)le.FNAME);
    clean_FNAME := (TYPEOF(le.FNAME))Fields.Make_FNAME((SALT311.StrType)le.FNAME);
    clean_FNAME_Invalid := Fields.InValid_FNAME((SALT311.StrType)clean_FNAME);
    SELF.FNAME := IF(withOnfail, clean_FNAME, le.FNAME); // ONFAIL(CLEAN)
    SELF.FNAME_wouldClean := TRIM((SALT311.StrType)le.FNAME) <> TRIM((SALT311.StrType)clean_FNAME);
    SELF.MNAME_Invalid := Fields.InValid_MNAME((SALT311.StrType)le.MNAME);
    clean_MNAME := (TYPEOF(le.MNAME))Fields.Make_MNAME((SALT311.StrType)le.MNAME);
    clean_MNAME_Invalid := Fields.InValid_MNAME((SALT311.StrType)clean_MNAME);
    SELF.MNAME := IF(withOnfail, clean_MNAME, le.MNAME); // ONFAIL(CLEAN)
    SELF.MNAME_wouldClean := TRIM((SALT311.StrType)le.MNAME) <> TRIM((SALT311.StrType)clean_MNAME);
    SELF.LNAME_Invalid := Fields.InValid_LNAME((SALT311.StrType)le.LNAME);
    clean_LNAME := (TYPEOF(le.LNAME))Fields.Make_LNAME((SALT311.StrType)le.LNAME);
    clean_LNAME_Invalid := Fields.InValid_LNAME((SALT311.StrType)clean_LNAME);
    SELF.LNAME := IF(withOnfail, clean_LNAME, le.LNAME); // ONFAIL(CLEAN)
    SELF.LNAME_wouldClean := TRIM((SALT311.StrType)le.LNAME) <> TRIM((SALT311.StrType)clean_LNAME);
    SELF.SNAME_Invalid := Fields.InValid_SNAME((SALT311.StrType)le.SNAME);
    clean_SNAME := (TYPEOF(le.SNAME))Fields.Make_SNAME((SALT311.StrType)le.SNAME);
    clean_SNAME_Invalid := Fields.InValid_SNAME((SALT311.StrType)clean_SNAME);
    SELF.SNAME := IF(withOnfail, clean_SNAME, le.SNAME); // ONFAIL(CLEAN)
    SELF.SNAME_wouldClean := TRIM((SALT311.StrType)le.SNAME) <> TRIM((SALT311.StrType)clean_SNAME);
    SELF.GENDER_Invalid := Fields.InValid_GENDER((SALT311.StrType)le.GENDER);
    clean_GENDER := (TYPEOF(le.GENDER))Fields.Make_GENDER((SALT311.StrType)le.GENDER);
    clean_GENDER_Invalid := Fields.InValid_GENDER((SALT311.StrType)clean_GENDER);
    SELF.GENDER := IF(withOnfail, clean_GENDER, le.GENDER); // ONFAIL(CLEAN)
    SELF.GENDER_wouldClean := TRIM((SALT311.StrType)le.GENDER) <> TRIM((SALT311.StrType)clean_GENDER);
    SELF.PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    clean_PRIM_RANGE := (TYPEOF(le.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    clean_PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT311.StrType)clean_PRIM_RANGE);
    SELF.PRIM_RANGE := IF(withOnfail, clean_PRIM_RANGE, le.PRIM_RANGE); // ONFAIL(CLEAN)
    SELF.PRIM_RANGE_wouldClean := TRIM((SALT311.StrType)le.PRIM_RANGE) <> TRIM((SALT311.StrType)clean_PRIM_RANGE);
    SELF.PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    clean_PRIM_NAME := (TYPEOF(le.PRIM_NAME))Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    clean_PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT311.StrType)clean_PRIM_NAME);
    SELF.PRIM_NAME := IF(withOnfail, clean_PRIM_NAME, le.PRIM_NAME); // ONFAIL(CLEAN)
    SELF.PRIM_NAME_wouldClean := TRIM((SALT311.StrType)le.PRIM_NAME) <> TRIM((SALT311.StrType)clean_PRIM_NAME);
    SELF.SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    clean_SEC_RANGE := (TYPEOF(le.SEC_RANGE))Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    clean_SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT311.StrType)clean_SEC_RANGE);
    SELF.SEC_RANGE := IF(withOnfail, clean_SEC_RANGE, le.SEC_RANGE); // ONFAIL(CLEAN)
    SELF.SEC_RANGE_wouldClean := TRIM((SALT311.StrType)le.SEC_RANGE) <> TRIM((SALT311.StrType)clean_SEC_RANGE);
    SELF.V_CITY_NAME_Invalid := Fields.InValid_V_CITY_NAME((SALT311.StrType)le.V_CITY_NAME);
    clean_V_CITY_NAME := (TYPEOF(le.V_CITY_NAME))Fields.Make_V_CITY_NAME((SALT311.StrType)le.V_CITY_NAME);
    clean_V_CITY_NAME_Invalid := Fields.InValid_V_CITY_NAME((SALT311.StrType)clean_V_CITY_NAME);
    SELF.V_CITY_NAME := IF(withOnfail, clean_V_CITY_NAME, le.V_CITY_NAME); // ONFAIL(CLEAN)
    SELF.V_CITY_NAME_wouldClean := TRIM((SALT311.StrType)le.V_CITY_NAME) <> TRIM((SALT311.StrType)clean_V_CITY_NAME);
    SELF.ST_Invalid := Fields.InValid_ST((SALT311.StrType)le.ST);
    clean_ST := (TYPEOF(le.ST))Fields.Make_ST((SALT311.StrType)le.ST);
    clean_ST_Invalid := Fields.InValid_ST((SALT311.StrType)clean_ST);
    SELF.ST := IF(withOnfail, clean_ST, le.ST); // ONFAIL(CLEAN)
    SELF.ST_wouldClean := TRIM((SALT311.StrType)le.ST) <> TRIM((SALT311.StrType)clean_ST);
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT311.StrType)le.ZIP);
    clean_ZIP := (TYPEOF(le.ZIP))Fields.Make_ZIP((SALT311.StrType)le.ZIP);
    clean_ZIP_Invalid := Fields.InValid_ZIP((SALT311.StrType)clean_ZIP);
    SELF.ZIP := IF(withOnfail, clean_ZIP, le.ZIP); // ONFAIL(CLEAN)
    SELF.ZIP_wouldClean := TRIM((SALT311.StrType)le.ZIP) <> TRIM((SALT311.StrType)clean_ZIP);
    SELF.SSN_Invalid := Fields.InValid_SSN((SALT311.StrType)le.SSN);
    clean_SSN := (TYPEOF(le.SSN))Fields.Make_SSN((SALT311.StrType)le.SSN);
    clean_SSN_Invalid := Fields.InValid_SSN((SALT311.StrType)clean_SSN);
    SELF.SSN := IF(withOnfail, clean_SSN, le.SSN); // ONFAIL(CLEAN)
    SELF.SSN_wouldClean := TRIM((SALT311.StrType)le.SSN) <> TRIM((SALT311.StrType)clean_SSN);
    SELF.CNSMR_SSN_Invalid := Fields.InValid_CNSMR_SSN((SALT311.StrType)le.CNSMR_SSN);
    clean_CNSMR_SSN := (TYPEOF(le.CNSMR_SSN))Fields.Make_CNSMR_SSN((SALT311.StrType)le.CNSMR_SSN);
    clean_CNSMR_SSN_Invalid := Fields.InValid_CNSMR_SSN((SALT311.StrType)clean_CNSMR_SSN);
    SELF.CNSMR_SSN := IF(withOnfail, clean_CNSMR_SSN, le.CNSMR_SSN); // ONFAIL(CLEAN)
    SELF.CNSMR_SSN_wouldClean := TRIM((SALT311.StrType)le.CNSMR_SSN) <> TRIM((SALT311.StrType)clean_CNSMR_SSN);
    SELF.DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)le.DOB);
    clean_DOB := (TYPEOF(le.DOB))Fields.Make_DOB((SALT311.StrType)le.DOB);
    clean_DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)clean_DOB);
    SELF.DOB := IF(withOnfail, clean_DOB, le.DOB); // ONFAIL(CLEAN)
    SELF.DOB_wouldClean := TRIM((SALT311.StrType)le.DOB) <> TRIM((SALT311.StrType)clean_DOB);
    SELF.CNSMR_DOB_Invalid := Fields.InValid_CNSMR_DOB((SALT311.StrType)le.CNSMR_DOB);
    clean_CNSMR_DOB := (TYPEOF(le.CNSMR_DOB))Fields.Make_CNSMR_DOB((SALT311.StrType)le.CNSMR_DOB);
    clean_CNSMR_DOB_Invalid := Fields.InValid_CNSMR_DOB((SALT311.StrType)clean_CNSMR_DOB);
    SELF.CNSMR_DOB := IF(withOnfail, clean_CNSMR_DOB, le.CNSMR_DOB); // ONFAIL(CLEAN)
    SELF.CNSMR_DOB_wouldClean := TRIM((SALT311.StrType)le.CNSMR_DOB) <> TRIM((SALT311.StrType)clean_CNSMR_DOB);
    SELF.PHONE_Invalid := Fields.InValid_PHONE((SALT311.StrType)le.PHONE);
    clean_PHONE := (TYPEOF(le.PHONE))Fields.Make_PHONE((SALT311.StrType)le.PHONE);
    clean_PHONE_Invalid := Fields.InValid_PHONE((SALT311.StrType)clean_PHONE);
    SELF.PHONE := IF(withOnfail, clean_PHONE, le.PHONE); // ONFAIL(CLEAN)
    SELF.PHONE_wouldClean := TRIM((SALT311.StrType)le.PHONE) <> TRIM((SALT311.StrType)clean_PHONE);
    SELF.LIC_STATE_Invalid := Fields.InValid_LIC_STATE((SALT311.StrType)le.LIC_STATE);
    clean_LIC_STATE := (TYPEOF(le.LIC_STATE))Fields.Make_LIC_STATE((SALT311.StrType)le.LIC_STATE);
    clean_LIC_STATE_Invalid := Fields.InValid_LIC_STATE((SALT311.StrType)clean_LIC_STATE);
    SELF.LIC_STATE := IF(withOnfail, clean_LIC_STATE, le.LIC_STATE); // ONFAIL(CLEAN)
    SELF.LIC_STATE_wouldClean := TRIM((SALT311.StrType)le.LIC_STATE) <> TRIM((SALT311.StrType)clean_LIC_STATE);
    SELF.C_LIC_NBR_Invalid := Fields.InValid_C_LIC_NBR((SALT311.StrType)le.C_LIC_NBR);
    clean_C_LIC_NBR := (TYPEOF(le.C_LIC_NBR))Fields.Make_C_LIC_NBR((SALT311.StrType)le.C_LIC_NBR);
    clean_C_LIC_NBR_Invalid := Fields.InValid_C_LIC_NBR((SALT311.StrType)clean_C_LIC_NBR);
    SELF.C_LIC_NBR := IF(withOnfail, clean_C_LIC_NBR, le.C_LIC_NBR); // ONFAIL(CLEAN)
    SELF.C_LIC_NBR_wouldClean := TRIM((SALT311.StrType)le.C_LIC_NBR) <> TRIM((SALT311.StrType)clean_C_LIC_NBR);
    SELF.TAX_ID_Invalid := Fields.InValid_TAX_ID((SALT311.StrType)le.TAX_ID);
    clean_TAX_ID := (TYPEOF(le.TAX_ID))Fields.Make_TAX_ID((SALT311.StrType)le.TAX_ID);
    clean_TAX_ID_Invalid := Fields.InValid_TAX_ID((SALT311.StrType)clean_TAX_ID);
    SELF.TAX_ID := IF(withOnfail, clean_TAX_ID, le.TAX_ID); // ONFAIL(CLEAN)
    SELF.TAX_ID_wouldClean := TRIM((SALT311.StrType)le.TAX_ID) <> TRIM((SALT311.StrType)clean_TAX_ID);
    SELF.BILLING_TAX_ID_Invalid := Fields.InValid_BILLING_TAX_ID((SALT311.StrType)le.BILLING_TAX_ID);
    clean_BILLING_TAX_ID := (TYPEOF(le.BILLING_TAX_ID))Fields.Make_BILLING_TAX_ID((SALT311.StrType)le.BILLING_TAX_ID);
    clean_BILLING_TAX_ID_Invalid := Fields.InValid_BILLING_TAX_ID((SALT311.StrType)clean_BILLING_TAX_ID);
    SELF.BILLING_TAX_ID := IF(withOnfail, clean_BILLING_TAX_ID, le.BILLING_TAX_ID); // ONFAIL(CLEAN)
    SELF.BILLING_TAX_ID_wouldClean := TRIM((SALT311.StrType)le.BILLING_TAX_ID) <> TRIM((SALT311.StrType)clean_BILLING_TAX_ID);
    SELF.DEA_NUMBER_Invalid := Fields.InValid_DEA_NUMBER((SALT311.StrType)le.DEA_NUMBER);
    clean_DEA_NUMBER := (TYPEOF(le.DEA_NUMBER))Fields.Make_DEA_NUMBER((SALT311.StrType)le.DEA_NUMBER);
    clean_DEA_NUMBER_Invalid := Fields.InValid_DEA_NUMBER((SALT311.StrType)clean_DEA_NUMBER);
    SELF.DEA_NUMBER := IF(withOnfail, clean_DEA_NUMBER, le.DEA_NUMBER); // ONFAIL(CLEAN)
    SELF.DEA_NUMBER_wouldClean := TRIM((SALT311.StrType)le.DEA_NUMBER) <> TRIM((SALT311.StrType)clean_DEA_NUMBER);
    SELF.VENDOR_ID_Invalid := Fields.InValid_VENDOR_ID((SALT311.StrType)le.VENDOR_ID);
    clean_VENDOR_ID := (TYPEOF(le.VENDOR_ID))Fields.Make_VENDOR_ID((SALT311.StrType)le.VENDOR_ID);
    clean_VENDOR_ID_Invalid := Fields.InValid_VENDOR_ID((SALT311.StrType)clean_VENDOR_ID);
    SELF.VENDOR_ID := IF(withOnfail, clean_VENDOR_ID, le.VENDOR_ID); // ONFAIL(CLEAN)
    SELF.VENDOR_ID_wouldClean := TRIM((SALT311.StrType)le.VENDOR_ID) <> TRIM((SALT311.StrType)clean_VENDOR_ID);
    SELF.NPI_NUMBER_Invalid := Fields.InValid_NPI_NUMBER((SALT311.StrType)le.NPI_NUMBER);
    clean_NPI_NUMBER := (TYPEOF(le.NPI_NUMBER))Fields.Make_NPI_NUMBER((SALT311.StrType)le.NPI_NUMBER);
    clean_NPI_NUMBER_Invalid := Fields.InValid_NPI_NUMBER((SALT311.StrType)clean_NPI_NUMBER);
    SELF.NPI_NUMBER := IF(withOnfail, clean_NPI_NUMBER, le.NPI_NUMBER); // ONFAIL(CLEAN)
    SELF.NPI_NUMBER_wouldClean := TRIM((SALT311.StrType)le.NPI_NUMBER) <> TRIM((SALT311.StrType)clean_NPI_NUMBER);
    SELF.BILLING_NPI_NUMBER_Invalid := Fields.InValid_BILLING_NPI_NUMBER((SALT311.StrType)le.BILLING_NPI_NUMBER);
    clean_BILLING_NPI_NUMBER := (TYPEOF(le.BILLING_NPI_NUMBER))Fields.Make_BILLING_NPI_NUMBER((SALT311.StrType)le.BILLING_NPI_NUMBER);
    clean_BILLING_NPI_NUMBER_Invalid := Fields.InValid_BILLING_NPI_NUMBER((SALT311.StrType)clean_BILLING_NPI_NUMBER);
    SELF.BILLING_NPI_NUMBER := IF(withOnfail, clean_BILLING_NPI_NUMBER, le.BILLING_NPI_NUMBER); // ONFAIL(CLEAN)
    SELF.BILLING_NPI_NUMBER_wouldClean := TRIM((SALT311.StrType)le.BILLING_NPI_NUMBER) <> TRIM((SALT311.StrType)clean_BILLING_NPI_NUMBER);
    SELF.UPIN_Invalid := Fields.InValid_UPIN((SALT311.StrType)le.UPIN);
    clean_UPIN := (TYPEOF(le.UPIN))Fields.Make_UPIN((SALT311.StrType)le.UPIN);
    clean_UPIN_Invalid := Fields.InValid_UPIN((SALT311.StrType)clean_UPIN);
    SELF.UPIN := IF(withOnfail, clean_UPIN, le.UPIN); // ONFAIL(CLEAN)
    SELF.UPIN_wouldClean := TRIM((SALT311.StrType)le.UPIN) <> TRIM((SALT311.StrType)clean_UPIN);
    SELF.DID_Invalid := Fields.InValid_DID((SALT311.StrType)le.DID);
    clean_DID := (TYPEOF(le.DID))Fields.Make_DID((SALT311.StrType)le.DID);
    clean_DID_Invalid := Fields.InValid_DID((SALT311.StrType)clean_DID);
    SELF.DID := IF(withOnfail, clean_DID, le.DID); // ONFAIL(CLEAN)
    SELF.DID_wouldClean := TRIM((SALT311.StrType)le.DID) <> TRIM((SALT311.StrType)clean_DID);
    SELF.BDID_Invalid := Fields.InValid_BDID((SALT311.StrType)le.BDID);
    clean_BDID := (TYPEOF(le.BDID))Fields.Make_BDID((SALT311.StrType)le.BDID);
    clean_BDID_Invalid := Fields.InValid_BDID((SALT311.StrType)clean_BDID);
    SELF.BDID := IF(withOnfail, clean_BDID, le.BDID); // ONFAIL(CLEAN)
    SELF.BDID_wouldClean := TRIM((SALT311.StrType)le.BDID) <> TRIM((SALT311.StrType)clean_BDID);
    SELF.SRC_Invalid := Fields.InValid_SRC((SALT311.StrType)le.SRC);
    clean_SRC := (TYPEOF(le.SRC))Fields.Make_SRC((SALT311.StrType)le.SRC);
    clean_SRC_Invalid := Fields.InValid_SRC((SALT311.StrType)clean_SRC);
    SELF.SRC := IF(withOnfail, clean_SRC, le.SRC); // ONFAIL(CLEAN)
    SELF.SRC_wouldClean := TRIM((SALT311.StrType)le.SRC) <> TRIM((SALT311.StrType)clean_SRC);
    SELF.SOURCE_RID_Invalid := Fields.InValid_SOURCE_RID((SALT311.StrType)le.SOURCE_RID);
    clean_SOURCE_RID := (TYPEOF(le.SOURCE_RID))Fields.Make_SOURCE_RID((SALT311.StrType)le.SOURCE_RID);
    clean_SOURCE_RID_Invalid := Fields.InValid_SOURCE_RID((SALT311.StrType)clean_SOURCE_RID);
    SELF.SOURCE_RID := IF(withOnfail, clean_SOURCE_RID, le.SOURCE_RID); // ONFAIL(CLEAN)
    SELF.SOURCE_RID_wouldClean := TRIM((SALT311.StrType)le.SOURCE_RID) <> TRIM((SALT311.StrType)clean_SOURCE_RID);
    SELF.RID_Invalid := Fields.InValid_RID((SALT311.StrType)le.RID);
    clean_RID := (TYPEOF(le.RID))Fields.Make_RID((SALT311.StrType)le.RID);
    clean_RID_Invalid := Fields.InValid_RID((SALT311.StrType)clean_RID);
    SELF.RID := IF(withOnfail, clean_RID, le.RID); // ONFAIL(CLEAN)
    SELF.RID_wouldClean := TRIM((SALT311.StrType)le.RID) <> TRIM((SALT311.StrType)clean_RID);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_HealthProvider);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.FNAME_Invalid << 0 ) + ( le.MNAME_Invalid << 2 ) + ( le.LNAME_Invalid << 4 ) + ( le.SNAME_Invalid << 6 ) + ( le.GENDER_Invalid << 8 ) + ( le.PRIM_RANGE_Invalid << 10 ) + ( le.PRIM_NAME_Invalid << 12 ) + ( le.SEC_RANGE_Invalid << 14 ) + ( le.V_CITY_NAME_Invalid << 16 ) + ( le.ST_Invalid << 18 ) + ( le.ZIP_Invalid << 20 ) + ( le.SSN_Invalid << 22 ) + ( le.CNSMR_SSN_Invalid << 24 ) + ( le.DOB_Invalid << 26 ) + ( le.CNSMR_DOB_Invalid << 28 ) + ( le.PHONE_Invalid << 30 ) + ( le.LIC_STATE_Invalid << 32 ) + ( le.C_LIC_NBR_Invalid << 34 ) + ( le.TAX_ID_Invalid << 36 ) + ( le.BILLING_TAX_ID_Invalid << 38 ) + ( le.DEA_NUMBER_Invalid << 40 ) + ( le.VENDOR_ID_Invalid << 42 ) + ( le.NPI_NUMBER_Invalid << 44 ) + ( le.BILLING_NPI_NUMBER_Invalid << 46 ) + ( le.UPIN_Invalid << 48 ) + ( le.DID_Invalid << 50 ) + ( le.BDID_Invalid << 52 ) + ( le.SRC_Invalid << 54 ) + ( le.SOURCE_RID_Invalid << 56 ) + ( le.RID_Invalid << 58 );
    SELF.ScrubsCleanBits1 := ( IF(le.FNAME_wouldClean, 1, 0) << 0 ) + ( IF(le.MNAME_wouldClean, 1, 0) << 1 ) + ( IF(le.LNAME_wouldClean, 1, 0) << 2 ) + ( IF(le.SNAME_wouldClean, 1, 0) << 3 ) + ( IF(le.GENDER_wouldClean, 1, 0) << 4 ) + ( IF(le.PRIM_RANGE_wouldClean, 1, 0) << 5 ) + ( IF(le.PRIM_NAME_wouldClean, 1, 0) << 6 ) + ( IF(le.SEC_RANGE_wouldClean, 1, 0) << 7 ) + ( IF(le.V_CITY_NAME_wouldClean, 1, 0) << 8 ) + ( IF(le.ST_wouldClean, 1, 0) << 9 ) + ( IF(le.ZIP_wouldClean, 1, 0) << 10 ) + ( IF(le.SSN_wouldClean, 1, 0) << 11 ) + ( IF(le.CNSMR_SSN_wouldClean, 1, 0) << 12 ) + ( IF(le.DOB_wouldClean, 1, 0) << 13 ) + ( IF(le.CNSMR_DOB_wouldClean, 1, 0) << 14 ) + ( IF(le.PHONE_wouldClean, 1, 0) << 15 ) + ( IF(le.LIC_STATE_wouldClean, 1, 0) << 16 ) + ( IF(le.C_LIC_NBR_wouldClean, 1, 0) << 17 ) + ( IF(le.TAX_ID_wouldClean, 1, 0) << 18 ) + ( IF(le.BILLING_TAX_ID_wouldClean, 1, 0) << 19 ) + ( IF(le.DEA_NUMBER_wouldClean, 1, 0) << 20 ) + ( IF(le.VENDOR_ID_wouldClean, 1, 0) << 21 ) + ( IF(le.NPI_NUMBER_wouldClean, 1, 0) << 22 ) + ( IF(le.BILLING_NPI_NUMBER_wouldClean, 1, 0) << 23 ) + ( IF(le.UPIN_wouldClean, 1, 0) << 24 ) + ( IF(le.DID_wouldClean, 1, 0) << 25 ) + ( IF(le.BDID_wouldClean, 1, 0) << 26 ) + ( IF(le.SRC_wouldClean, 1, 0) << 27 ) + ( IF(le.SOURCE_RID_wouldClean, 1, 0) << 28 ) + ( IF(le.RID_wouldClean, 1, 0) << 29 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_HealthProvider);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.FNAME_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.MNAME_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.LNAME_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.SNAME_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.GENDER_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.V_CITY_NAME_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.SSN_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.CNSMR_SSN_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.DOB_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.CNSMR_DOB_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.PHONE_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.LIC_STATE_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.C_LIC_NBR_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.TAX_ID_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.BILLING_TAX_ID_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.DEA_NUMBER_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.VENDOR_ID_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.NPI_NUMBER_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.BILLING_NPI_NUMBER_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.UPIN_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.DID_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.BDID_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.SRC_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.SOURCE_RID_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.RID_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.FNAME_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.MNAME_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.LNAME_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.SNAME_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.GENDER_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.PRIM_RANGE_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.PRIM_NAME_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.SEC_RANGE_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.V_CITY_NAME_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.ST_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.ZIP_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.SSN_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.CNSMR_SSN_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.DOB_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.CNSMR_DOB_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.PHONE_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.LIC_STATE_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.C_LIC_NBR_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.TAX_ID_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.BILLING_TAX_ID_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.DEA_NUMBER_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF.VENDOR_ID_wouldClean := le.ScrubsCleanBits1 >> 21;
    SELF.NPI_NUMBER_wouldClean := le.ScrubsCleanBits1 >> 22;
    SELF.BILLING_NPI_NUMBER_wouldClean := le.ScrubsCleanBits1 >> 23;
    SELF.UPIN_wouldClean := le.ScrubsCleanBits1 >> 24;
    SELF.DID_wouldClean := le.ScrubsCleanBits1 >> 25;
    SELF.BDID_wouldClean := le.ScrubsCleanBits1 >> 26;
    SELF.SRC_wouldClean := le.ScrubsCleanBits1 >> 27;
    SELF.SOURCE_RID_wouldClean := le.ScrubsCleanBits1 >> 28;
    SELF.RID_wouldClean := le.ScrubsCleanBits1 >> 29;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    FNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=1);
    FNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.FNAME_Invalid=1 AND h.FNAME_wouldClean);
    FNAME_QUOTES_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=2);
    FNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.FNAME_Invalid=2 AND h.FNAME_wouldClean);
    FNAME_Total_ErrorCount := COUNT(GROUP,h.FNAME_Invalid>0);
    MNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=1);
    MNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.MNAME_Invalid=1 AND h.MNAME_wouldClean);
    MNAME_QUOTES_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=2);
    MNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.MNAME_Invalid=2 AND h.MNAME_wouldClean);
    MNAME_Total_ErrorCount := COUNT(GROUP,h.MNAME_Invalid>0);
    LNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=1);
    LNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.LNAME_Invalid=1 AND h.LNAME_wouldClean);
    LNAME_QUOTES_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=2);
    LNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.LNAME_Invalid=2 AND h.LNAME_wouldClean);
    LNAME_Total_ErrorCount := COUNT(GROUP,h.LNAME_Invalid>0);
    SNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=1);
    SNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SNAME_Invalid=1 AND h.SNAME_wouldClean);
    SNAME_QUOTES_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=2);
    SNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.SNAME_Invalid=2 AND h.SNAME_wouldClean);
    SNAME_Total_ErrorCount := COUNT(GROUP,h.SNAME_Invalid>0);
    GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=1);
    GENDER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.GENDER_Invalid=1 AND h.GENDER_wouldClean);
    GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=2);
    GENDER_QUOTES_WouldModifyCount := COUNT(GROUP,h.GENDER_Invalid=2 AND h.GENDER_wouldClean);
    GENDER_Total_ErrorCount := COUNT(GROUP,h.GENDER_Invalid>0);
    PRIM_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1);
    PRIM_RANGE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1 AND h.PRIM_RANGE_wouldClean);
    PRIM_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2);
    PRIM_RANGE_QUOTES_WouldModifyCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2 AND h.PRIM_RANGE_wouldClean);
    PRIM_RANGE_Total_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid>0);
    PRIM_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1);
    PRIM_NAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1 AND h.PRIM_NAME_wouldClean);
    PRIM_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2);
    PRIM_NAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2 AND h.PRIM_NAME_wouldClean);
    PRIM_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid>0);
    SEC_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1);
    SEC_RANGE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1 AND h.SEC_RANGE_wouldClean);
    SEC_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2);
    SEC_RANGE_QUOTES_WouldModifyCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2 AND h.SEC_RANGE_wouldClean);
    SEC_RANGE_Total_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid>0);
    V_CITY_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=1);
    V_CITY_NAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=1 AND h.V_CITY_NAME_wouldClean);
    V_CITY_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=2);
    V_CITY_NAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.V_CITY_NAME_Invalid=2 AND h.V_CITY_NAME_wouldClean);
    V_CITY_NAME_Total_ErrorCount := COUNT(GROUP,h.V_CITY_NAME_Invalid>0);
    ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=1 AND h.ST_wouldClean);
    ST_QUOTES_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_QUOTES_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=2 AND h.ST_wouldClean);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    ZIP_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    ZIP_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ZIP_Invalid=1 AND h.ZIP_wouldClean);
    ZIP_QUOTES_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=2);
    ZIP_QUOTES_WouldModifyCount := COUNT(GROUP,h.ZIP_Invalid=2 AND h.ZIP_wouldClean);
    ZIP_Total_ErrorCount := COUNT(GROUP,h.ZIP_Invalid>0);
    SSN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SSN_Invalid=1);
    SSN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=1 AND h.SSN_wouldClean);
    SSN_QUOTES_ErrorCount := COUNT(GROUP,h.SSN_Invalid=2);
    SSN_QUOTES_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=2 AND h.SSN_wouldClean);
    SSN_Total_ErrorCount := COUNT(GROUP,h.SSN_Invalid>0);
    CNSMR_SSN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNSMR_SSN_Invalid=1);
    CNSMR_SSN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.CNSMR_SSN_Invalid=1 AND h.CNSMR_SSN_wouldClean);
    CNSMR_SSN_QUOTES_ErrorCount := COUNT(GROUP,h.CNSMR_SSN_Invalid=2);
    CNSMR_SSN_QUOTES_WouldModifyCount := COUNT(GROUP,h.CNSMR_SSN_Invalid=2 AND h.CNSMR_SSN_wouldClean);
    CNSMR_SSN_Total_ErrorCount := COUNT(GROUP,h.CNSMR_SSN_Invalid>0);
    DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DOB_Invalid=1);
    DOB_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=1 AND h.DOB_wouldClean);
    DOB_QUOTES_ErrorCount := COUNT(GROUP,h.DOB_Invalid=2);
    DOB_QUOTES_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=2 AND h.DOB_wouldClean);
    DOB_Total_ErrorCount := COUNT(GROUP,h.DOB_Invalid>0);
    CNSMR_DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CNSMR_DOB_Invalid=1);
    CNSMR_DOB_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.CNSMR_DOB_Invalid=1 AND h.CNSMR_DOB_wouldClean);
    CNSMR_DOB_QUOTES_ErrorCount := COUNT(GROUP,h.CNSMR_DOB_Invalid=2);
    CNSMR_DOB_QUOTES_WouldModifyCount := COUNT(GROUP,h.CNSMR_DOB_Invalid=2 AND h.CNSMR_DOB_wouldClean);
    CNSMR_DOB_Total_ErrorCount := COUNT(GROUP,h.CNSMR_DOB_Invalid>0);
    PHONE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=1);
    PHONE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.PHONE_Invalid=1 AND h.PHONE_wouldClean);
    PHONE_QUOTES_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=2);
    PHONE_QUOTES_WouldModifyCount := COUNT(GROUP,h.PHONE_Invalid=2 AND h.PHONE_wouldClean);
    PHONE_Total_ErrorCount := COUNT(GROUP,h.PHONE_Invalid>0);
    LIC_STATE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LIC_STATE_Invalid=1);
    LIC_STATE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.LIC_STATE_Invalid=1 AND h.LIC_STATE_wouldClean);
    LIC_STATE_QUOTES_ErrorCount := COUNT(GROUP,h.LIC_STATE_Invalid=2);
    LIC_STATE_QUOTES_WouldModifyCount := COUNT(GROUP,h.LIC_STATE_Invalid=2 AND h.LIC_STATE_wouldClean);
    LIC_STATE_Total_ErrorCount := COUNT(GROUP,h.LIC_STATE_Invalid>0);
    C_LIC_NBR_LEFTTRIM_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=1);
    C_LIC_NBR_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=1 AND h.C_LIC_NBR_wouldClean);
    C_LIC_NBR_QUOTES_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=2);
    C_LIC_NBR_QUOTES_WouldModifyCount := COUNT(GROUP,h.C_LIC_NBR_Invalid=2 AND h.C_LIC_NBR_wouldClean);
    C_LIC_NBR_Total_ErrorCount := COUNT(GROUP,h.C_LIC_NBR_Invalid>0);
    TAX_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid=1);
    TAX_ID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.TAX_ID_Invalid=1 AND h.TAX_ID_wouldClean);
    TAX_ID_QUOTES_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid=2);
    TAX_ID_QUOTES_WouldModifyCount := COUNT(GROUP,h.TAX_ID_Invalid=2 AND h.TAX_ID_wouldClean);
    TAX_ID_Total_ErrorCount := COUNT(GROUP,h.TAX_ID_Invalid>0);
    BILLING_TAX_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.BILLING_TAX_ID_Invalid=1);
    BILLING_TAX_ID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.BILLING_TAX_ID_Invalid=1 AND h.BILLING_TAX_ID_wouldClean);
    BILLING_TAX_ID_QUOTES_ErrorCount := COUNT(GROUP,h.BILLING_TAX_ID_Invalid=2);
    BILLING_TAX_ID_QUOTES_WouldModifyCount := COUNT(GROUP,h.BILLING_TAX_ID_Invalid=2 AND h.BILLING_TAX_ID_wouldClean);
    BILLING_TAX_ID_Total_ErrorCount := COUNT(GROUP,h.BILLING_TAX_ID_Invalid>0);
    DEA_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=1);
    DEA_NUMBER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=1 AND h.DEA_NUMBER_wouldClean);
    DEA_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=2);
    DEA_NUMBER_QUOTES_WouldModifyCount := COUNT(GROUP,h.DEA_NUMBER_Invalid=2 AND h.DEA_NUMBER_wouldClean);
    DEA_NUMBER_Total_ErrorCount := COUNT(GROUP,h.DEA_NUMBER_Invalid>0);
    VENDOR_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=1);
    VENDOR_ID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.VENDOR_ID_Invalid=1 AND h.VENDOR_ID_wouldClean);
    VENDOR_ID_QUOTES_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=2);
    VENDOR_ID_QUOTES_WouldModifyCount := COUNT(GROUP,h.VENDOR_ID_Invalid=2 AND h.VENDOR_ID_wouldClean);
    VENDOR_ID_Total_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid>0);
    NPI_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.NPI_NUMBER_Invalid=1);
    NPI_NUMBER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.NPI_NUMBER_Invalid=1 AND h.NPI_NUMBER_wouldClean);
    NPI_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.NPI_NUMBER_Invalid=2);
    NPI_NUMBER_QUOTES_WouldModifyCount := COUNT(GROUP,h.NPI_NUMBER_Invalid=2 AND h.NPI_NUMBER_wouldClean);
    NPI_NUMBER_Total_ErrorCount := COUNT(GROUP,h.NPI_NUMBER_Invalid>0);
    BILLING_NPI_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.BILLING_NPI_NUMBER_Invalid=1);
    BILLING_NPI_NUMBER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.BILLING_NPI_NUMBER_Invalid=1 AND h.BILLING_NPI_NUMBER_wouldClean);
    BILLING_NPI_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.BILLING_NPI_NUMBER_Invalid=2);
    BILLING_NPI_NUMBER_QUOTES_WouldModifyCount := COUNT(GROUP,h.BILLING_NPI_NUMBER_Invalid=2 AND h.BILLING_NPI_NUMBER_wouldClean);
    BILLING_NPI_NUMBER_Total_ErrorCount := COUNT(GROUP,h.BILLING_NPI_NUMBER_Invalid>0);
    UPIN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.UPIN_Invalid=1);
    UPIN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.UPIN_Invalid=1 AND h.UPIN_wouldClean);
    UPIN_QUOTES_ErrorCount := COUNT(GROUP,h.UPIN_Invalid=2);
    UPIN_QUOTES_WouldModifyCount := COUNT(GROUP,h.UPIN_Invalid=2 AND h.UPIN_wouldClean);
    UPIN_Total_ErrorCount := COUNT(GROUP,h.UPIN_Invalid>0);
    DID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DID_Invalid=1);
    DID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DID_Invalid=1 AND h.DID_wouldClean);
    DID_QUOTES_ErrorCount := COUNT(GROUP,h.DID_Invalid=2);
    DID_QUOTES_WouldModifyCount := COUNT(GROUP,h.DID_Invalid=2 AND h.DID_wouldClean);
    DID_Total_ErrorCount := COUNT(GROUP,h.DID_Invalid>0);
    BDID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.BDID_Invalid=1);
    BDID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.BDID_Invalid=1 AND h.BDID_wouldClean);
    BDID_QUOTES_ErrorCount := COUNT(GROUP,h.BDID_Invalid=2);
    BDID_QUOTES_WouldModifyCount := COUNT(GROUP,h.BDID_Invalid=2 AND h.BDID_wouldClean);
    BDID_Total_ErrorCount := COUNT(GROUP,h.BDID_Invalid>0);
    SRC_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SRC_Invalid=1);
    SRC_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SRC_Invalid=1 AND h.SRC_wouldClean);
    SRC_QUOTES_ErrorCount := COUNT(GROUP,h.SRC_Invalid=2);
    SRC_QUOTES_WouldModifyCount := COUNT(GROUP,h.SRC_Invalid=2 AND h.SRC_wouldClean);
    SRC_Total_ErrorCount := COUNT(GROUP,h.SRC_Invalid>0);
    SOURCE_RID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SOURCE_RID_Invalid=1);
    SOURCE_RID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SOURCE_RID_Invalid=1 AND h.SOURCE_RID_wouldClean);
    SOURCE_RID_QUOTES_ErrorCount := COUNT(GROUP,h.SOURCE_RID_Invalid=2);
    SOURCE_RID_QUOTES_WouldModifyCount := COUNT(GROUP,h.SOURCE_RID_Invalid=2 AND h.SOURCE_RID_wouldClean);
    SOURCE_RID_Total_ErrorCount := COUNT(GROUP,h.SOURCE_RID_Invalid>0);
    RID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.RID_Invalid=1);
    RID_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.RID_Invalid=1 AND h.RID_wouldClean);
    RID_QUOTES_ErrorCount := COUNT(GROUP,h.RID_Invalid=2);
    RID_QUOTES_WouldModifyCount := COUNT(GROUP,h.RID_Invalid=2 AND h.RID_wouldClean);
    RID_Total_ErrorCount := COUNT(GROUP,h.RID_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.FNAME_Invalid > 0 OR h.MNAME_Invalid > 0 OR h.LNAME_Invalid > 0 OR h.SNAME_Invalid > 0 OR h.GENDER_Invalid > 0 OR h.PRIM_RANGE_Invalid > 0 OR h.PRIM_NAME_Invalid > 0 OR h.SEC_RANGE_Invalid > 0 OR h.V_CITY_NAME_Invalid > 0 OR h.ST_Invalid > 0 OR h.ZIP_Invalid > 0 OR h.SSN_Invalid > 0 OR h.CNSMR_SSN_Invalid > 0 OR h.DOB_Invalid > 0 OR h.CNSMR_DOB_Invalid > 0 OR h.PHONE_Invalid > 0 OR h.LIC_STATE_Invalid > 0 OR h.C_LIC_NBR_Invalid > 0 OR h.TAX_ID_Invalid > 0 OR h.BILLING_TAX_ID_Invalid > 0 OR h.DEA_NUMBER_Invalid > 0 OR h.VENDOR_ID_Invalid > 0 OR h.NPI_NUMBER_Invalid > 0 OR h.BILLING_NPI_NUMBER_Invalid > 0 OR h.UPIN_Invalid > 0 OR h.DID_Invalid > 0 OR h.BDID_Invalid > 0 OR h.SRC_Invalid > 0 OR h.SOURCE_RID_Invalid > 0 OR h.RID_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.FNAME_wouldClean OR h.MNAME_wouldClean OR h.LNAME_wouldClean OR h.SNAME_wouldClean OR h.GENDER_wouldClean OR h.PRIM_RANGE_wouldClean OR h.PRIM_NAME_wouldClean OR h.SEC_RANGE_wouldClean OR h.V_CITY_NAME_wouldClean OR h.ST_wouldClean OR h.ZIP_wouldClean OR h.SSN_wouldClean OR h.CNSMR_SSN_wouldClean OR h.DOB_wouldClean OR h.CNSMR_DOB_wouldClean OR h.PHONE_wouldClean OR h.LIC_STATE_wouldClean OR h.C_LIC_NBR_wouldClean OR h.TAX_ID_wouldClean OR h.BILLING_TAX_ID_wouldClean OR h.DEA_NUMBER_wouldClean OR h.VENDOR_ID_wouldClean OR h.NPI_NUMBER_wouldClean OR h.BILLING_NPI_NUMBER_wouldClean OR h.UPIN_wouldClean OR h.DID_wouldClean OR h.BDID_wouldClean OR h.SRC_wouldClean OR h.SOURCE_RID_wouldClean OR h.RID_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.FNAME_Total_ErrorCount > 0, 1, 0) + IF(le.MNAME_Total_ErrorCount > 0, 1, 0) + IF(le.LNAME_Total_ErrorCount > 0, 1, 0) + IF(le.SNAME_Total_ErrorCount > 0, 1, 0) + IF(le.GENDER_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_Total_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.V_CITY_NAME_Total_ErrorCount > 0, 1, 0) + IF(le.ST_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_Total_ErrorCount > 0, 1, 0) + IF(le.SSN_Total_ErrorCount > 0, 1, 0) + IF(le.CNSMR_SSN_Total_ErrorCount > 0, 1, 0) + IF(le.DOB_Total_ErrorCount > 0, 1, 0) + IF(le.CNSMR_DOB_Total_ErrorCount > 0, 1, 0) + IF(le.PHONE_Total_ErrorCount > 0, 1, 0) + IF(le.LIC_STATE_Total_ErrorCount > 0, 1, 0) + IF(le.C_LIC_NBR_Total_ErrorCount > 0, 1, 0) + IF(le.TAX_ID_Total_ErrorCount > 0, 1, 0) + IF(le.BILLING_TAX_ID_Total_ErrorCount > 0, 1, 0) + IF(le.DEA_NUMBER_Total_ErrorCount > 0, 1, 0) + IF(le.VENDOR_ID_Total_ErrorCount > 0, 1, 0) + IF(le.NPI_NUMBER_Total_ErrorCount > 0, 1, 0) + IF(le.BILLING_NPI_NUMBER_Total_ErrorCount > 0, 1, 0) + IF(le.UPIN_Total_ErrorCount > 0, 1, 0) + IF(le.DID_Total_ErrorCount > 0, 1, 0) + IF(le.BDID_Total_ErrorCount > 0, 1, 0) + IF(le.SRC_Total_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_Total_ErrorCount > 0, 1, 0) + IF(le.RID_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.FNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.FNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.MNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.LNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.GENDER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.GENDER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.V_CITY_NAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.V_CITY_NAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ST_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ZIP_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ZIP_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SSN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SSN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.CNSMR_SSN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.CNSMR_SSN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DOB_QUOTES_ErrorCount > 0, 1, 0) + IF(le.CNSMR_DOB_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.CNSMR_DOB_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PHONE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PHONE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.LIC_STATE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.LIC_STATE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.C_LIC_NBR_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.C_LIC_NBR_QUOTES_ErrorCount > 0, 1, 0) + IF(le.TAX_ID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.TAX_ID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.BILLING_TAX_ID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.BILLING_TAX_ID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DEA_NUMBER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DEA_NUMBER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.VENDOR_ID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.VENDOR_ID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.NPI_NUMBER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.NPI_NUMBER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.BILLING_NPI_NUMBER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.BILLING_NPI_NUMBER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.UPIN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.UPIN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.BDID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.BDID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SRC_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.RID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.RID_QUOTES_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.FNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.FNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.GENDER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.GENDER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.V_CITY_NAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.V_CITY_NAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ST_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.ZIP_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ZIP_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SSN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SSN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.CNSMR_SSN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.CNSMR_SSN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DOB_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.CNSMR_DOB_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.CNSMR_DOB_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PHONE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PHONE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.LIC_STATE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.LIC_STATE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.C_LIC_NBR_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.C_LIC_NBR_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.TAX_ID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.TAX_ID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.BILLING_TAX_ID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.BILLING_TAX_ID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DEA_NUMBER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DEA_NUMBER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.VENDOR_ID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.VENDOR_ID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.NPI_NUMBER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.NPI_NUMBER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.BILLING_NPI_NUMBER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.BILLING_NPI_NUMBER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.UPIN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.UPIN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.BDID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.BDID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SRC_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SOURCE_RID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SOURCE_RID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.RID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.RID_QUOTES_WouldModifyCount > 0, 1, 0);
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.FNAME_Invalid,le.MNAME_Invalid,le.LNAME_Invalid,le.SNAME_Invalid,le.GENDER_Invalid,le.PRIM_RANGE_Invalid,le.PRIM_NAME_Invalid,le.SEC_RANGE_Invalid,le.V_CITY_NAME_Invalid,le.ST_Invalid,le.ZIP_Invalid,le.SSN_Invalid,le.CNSMR_SSN_Invalid,le.DOB_Invalid,le.CNSMR_DOB_Invalid,le.PHONE_Invalid,le.LIC_STATE_Invalid,le.C_LIC_NBR_Invalid,le.TAX_ID_Invalid,le.BILLING_TAX_ID_Invalid,le.DEA_NUMBER_Invalid,le.VENDOR_ID_Invalid,le.NPI_NUMBER_Invalid,le.BILLING_NPI_NUMBER_Invalid,le.UPIN_Invalid,le.DID_Invalid,le.BDID_Invalid,le.SRC_Invalid,le.SOURCE_RID_Invalid,le.RID_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_FNAME(le.FNAME_Invalid),Fields.InvalidMessage_MNAME(le.MNAME_Invalid),Fields.InvalidMessage_LNAME(le.LNAME_Invalid),Fields.InvalidMessage_SNAME(le.SNAME_Invalid),Fields.InvalidMessage_GENDER(le.GENDER_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_V_CITY_NAME(le.V_CITY_NAME_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_SSN(le.SSN_Invalid),Fields.InvalidMessage_CNSMR_SSN(le.CNSMR_SSN_Invalid),Fields.InvalidMessage_DOB(le.DOB_Invalid),Fields.InvalidMessage_CNSMR_DOB(le.CNSMR_DOB_Invalid),Fields.InvalidMessage_PHONE(le.PHONE_Invalid),Fields.InvalidMessage_LIC_STATE(le.LIC_STATE_Invalid),Fields.InvalidMessage_C_LIC_NBR(le.C_LIC_NBR_Invalid),Fields.InvalidMessage_TAX_ID(le.TAX_ID_Invalid),Fields.InvalidMessage_BILLING_TAX_ID(le.BILLING_TAX_ID_Invalid),Fields.InvalidMessage_DEA_NUMBER(le.DEA_NUMBER_Invalid),Fields.InvalidMessage_VENDOR_ID(le.VENDOR_ID_Invalid),Fields.InvalidMessage_NPI_NUMBER(le.NPI_NUMBER_Invalid),Fields.InvalidMessage_BILLING_NPI_NUMBER(le.BILLING_NPI_NUMBER_Invalid),Fields.InvalidMessage_UPIN(le.UPIN_Invalid),Fields.InvalidMessage_DID(le.DID_Invalid),Fields.InvalidMessage_BDID(le.BDID_Invalid),Fields.InvalidMessage_SRC(le.SRC_Invalid),Fields.InvalidMessage_SOURCE_RID(le.SOURCE_RID_Invalid),Fields.InvalidMessage_RID(le.RID_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.FNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.V_CITY_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SSN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNSMR_SSN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CNSMR_DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PHONE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LIC_STATE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.C_LIC_NBR_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.TAX_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.BILLING_TAX_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DEA_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.VENDOR_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.NPI_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.BILLING_NPI_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.UPIN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.BDID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SRC_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SOURCE_RID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.RID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'FNAME','MNAME','LNAME','SNAME','GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','V_CITY_NAME','ST','ZIP','SSN','CNSMR_SSN','DOB','CNSMR_DOB','PHONE','LIC_STATE','C_LIC_NBR','TAX_ID','BILLING_TAX_ID','DEA_NUMBER','VENDOR_ID','NPI_NUMBER','BILLING_NPI_NUMBER','UPIN','DID','BDID','SRC','SOURCE_RID','RID','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.SNAME,(SALT311.StrType)le.GENDER,(SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.V_CITY_NAME,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP,(SALT311.StrType)le.SSN,(SALT311.StrType)le.CNSMR_SSN,(SALT311.StrType)le.DOB,(SALT311.StrType)le.CNSMR_DOB,(SALT311.StrType)le.PHONE,(SALT311.StrType)le.LIC_STATE,(SALT311.StrType)le.C_LIC_NBR,(SALT311.StrType)le.TAX_ID,(SALT311.StrType)le.BILLING_TAX_ID,(SALT311.StrType)le.DEA_NUMBER,(SALT311.StrType)le.VENDOR_ID,(SALT311.StrType)le.NPI_NUMBER,(SALT311.StrType)le.BILLING_NPI_NUMBER,(SALT311.StrType)le.UPIN,(SALT311.StrType)le.DID,(SALT311.StrType)le.BDID,(SALT311.StrType)le.SRC,(SALT311.StrType)le.SOURCE_RID,(SALT311.StrType)le.RID,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,30,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_HealthProvider) prevDS = DATASET([], Layout_HealthProvider), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'FNAME:DEFAULT:LEFTTRIM','FNAME:DEFAULT:QUOTES'
          ,'MNAME:DEFAULT:LEFTTRIM','MNAME:DEFAULT:QUOTES'
          ,'LNAME:DEFAULT:LEFTTRIM','LNAME:DEFAULT:QUOTES'
          ,'SNAME:DEFAULT:LEFTTRIM','SNAME:DEFAULT:QUOTES'
          ,'GENDER:DEFAULT:LEFTTRIM','GENDER:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'V_CITY_NAME:DEFAULT:LEFTTRIM','V_CITY_NAME:DEFAULT:QUOTES'
          ,'ST:DEFAULT:LEFTTRIM','ST:DEFAULT:QUOTES'
          ,'ZIP:DEFAULT:LEFTTRIM','ZIP:DEFAULT:QUOTES'
          ,'SSN:DEFAULT:LEFTTRIM','SSN:DEFAULT:QUOTES'
          ,'CNSMR_SSN:DEFAULT:LEFTTRIM','CNSMR_SSN:DEFAULT:QUOTES'
          ,'DOB:DEFAULT:LEFTTRIM','DOB:DEFAULT:QUOTES'
          ,'CNSMR_DOB:DEFAULT:LEFTTRIM','CNSMR_DOB:DEFAULT:QUOTES'
          ,'PHONE:DEFAULT:LEFTTRIM','PHONE:DEFAULT:QUOTES'
          ,'LIC_STATE:DEFAULT:LEFTTRIM','LIC_STATE:DEFAULT:QUOTES'
          ,'C_LIC_NBR:DEFAULT:LEFTTRIM','C_LIC_NBR:DEFAULT:QUOTES'
          ,'TAX_ID:DEFAULT:LEFTTRIM','TAX_ID:DEFAULT:QUOTES'
          ,'BILLING_TAX_ID:DEFAULT:LEFTTRIM','BILLING_TAX_ID:DEFAULT:QUOTES'
          ,'DEA_NUMBER:DEFAULT:LEFTTRIM','DEA_NUMBER:DEFAULT:QUOTES'
          ,'VENDOR_ID:DEFAULT:LEFTTRIM','VENDOR_ID:DEFAULT:QUOTES'
          ,'NPI_NUMBER:DEFAULT:LEFTTRIM','NPI_NUMBER:DEFAULT:QUOTES'
          ,'BILLING_NPI_NUMBER:DEFAULT:LEFTTRIM','BILLING_NPI_NUMBER:DEFAULT:QUOTES'
          ,'UPIN:DEFAULT:LEFTTRIM','UPIN:DEFAULT:QUOTES'
          ,'DID:DEFAULT:LEFTTRIM','DID:DEFAULT:QUOTES'
          ,'BDID:DEFAULT:LEFTTRIM','BDID:DEFAULT:QUOTES'
          ,'SRC:DEFAULT:LEFTTRIM','SRC:DEFAULT:QUOTES'
          ,'SOURCE_RID:DEFAULT:LEFTTRIM','SOURCE_RID:DEFAULT:QUOTES'
          ,'RID:DEFAULT:LEFTTRIM','RID:DEFAULT:QUOTES'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_FNAME(1),Fields.InvalidMessage_FNAME(2)
          ,Fields.InvalidMessage_MNAME(1),Fields.InvalidMessage_MNAME(2)
          ,Fields.InvalidMessage_LNAME(1),Fields.InvalidMessage_LNAME(2)
          ,Fields.InvalidMessage_SNAME(1),Fields.InvalidMessage_SNAME(2)
          ,Fields.InvalidMessage_GENDER(1),Fields.InvalidMessage_GENDER(2)
          ,Fields.InvalidMessage_PRIM_RANGE(1),Fields.InvalidMessage_PRIM_RANGE(2)
          ,Fields.InvalidMessage_PRIM_NAME(1),Fields.InvalidMessage_PRIM_NAME(2)
          ,Fields.InvalidMessage_SEC_RANGE(1),Fields.InvalidMessage_SEC_RANGE(2)
          ,Fields.InvalidMessage_V_CITY_NAME(1),Fields.InvalidMessage_V_CITY_NAME(2)
          ,Fields.InvalidMessage_ST(1),Fields.InvalidMessage_ST(2)
          ,Fields.InvalidMessage_ZIP(1),Fields.InvalidMessage_ZIP(2)
          ,Fields.InvalidMessage_SSN(1),Fields.InvalidMessage_SSN(2)
          ,Fields.InvalidMessage_CNSMR_SSN(1),Fields.InvalidMessage_CNSMR_SSN(2)
          ,Fields.InvalidMessage_DOB(1),Fields.InvalidMessage_DOB(2)
          ,Fields.InvalidMessage_CNSMR_DOB(1),Fields.InvalidMessage_CNSMR_DOB(2)
          ,Fields.InvalidMessage_PHONE(1),Fields.InvalidMessage_PHONE(2)
          ,Fields.InvalidMessage_LIC_STATE(1),Fields.InvalidMessage_LIC_STATE(2)
          ,Fields.InvalidMessage_C_LIC_NBR(1),Fields.InvalidMessage_C_LIC_NBR(2)
          ,Fields.InvalidMessage_TAX_ID(1),Fields.InvalidMessage_TAX_ID(2)
          ,Fields.InvalidMessage_BILLING_TAX_ID(1),Fields.InvalidMessage_BILLING_TAX_ID(2)
          ,Fields.InvalidMessage_DEA_NUMBER(1),Fields.InvalidMessage_DEA_NUMBER(2)
          ,Fields.InvalidMessage_VENDOR_ID(1),Fields.InvalidMessage_VENDOR_ID(2)
          ,Fields.InvalidMessage_NPI_NUMBER(1),Fields.InvalidMessage_NPI_NUMBER(2)
          ,Fields.InvalidMessage_BILLING_NPI_NUMBER(1),Fields.InvalidMessage_BILLING_NPI_NUMBER(2)
          ,Fields.InvalidMessage_UPIN(1),Fields.InvalidMessage_UPIN(2)
          ,Fields.InvalidMessage_DID(1),Fields.InvalidMessage_DID(2)
          ,Fields.InvalidMessage_BDID(1),Fields.InvalidMessage_BDID(2)
          ,Fields.InvalidMessage_SRC(1),Fields.InvalidMessage_SRC(2)
          ,Fields.InvalidMessage_SOURCE_RID(1),Fields.InvalidMessage_SOURCE_RID(2)
          ,Fields.InvalidMessage_RID(1),Fields.InvalidMessage_RID(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.V_CITY_NAME_LEFTTRIM_ErrorCount,le.V_CITY_NAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.SSN_LEFTTRIM_ErrorCount,le.SSN_QUOTES_ErrorCount
          ,le.CNSMR_SSN_LEFTTRIM_ErrorCount,le.CNSMR_SSN_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.CNSMR_DOB_LEFTTRIM_ErrorCount,le.CNSMR_DOB_QUOTES_ErrorCount
          ,le.PHONE_LEFTTRIM_ErrorCount,le.PHONE_QUOTES_ErrorCount
          ,le.LIC_STATE_LEFTTRIM_ErrorCount,le.LIC_STATE_QUOTES_ErrorCount
          ,le.C_LIC_NBR_LEFTTRIM_ErrorCount,le.C_LIC_NBR_QUOTES_ErrorCount
          ,le.TAX_ID_LEFTTRIM_ErrorCount,le.TAX_ID_QUOTES_ErrorCount
          ,le.BILLING_TAX_ID_LEFTTRIM_ErrorCount,le.BILLING_TAX_ID_QUOTES_ErrorCount
          ,le.DEA_NUMBER_LEFTTRIM_ErrorCount,le.DEA_NUMBER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.NPI_NUMBER_LEFTTRIM_ErrorCount,le.NPI_NUMBER_QUOTES_ErrorCount
          ,le.BILLING_NPI_NUMBER_LEFTTRIM_ErrorCount,le.BILLING_NPI_NUMBER_QUOTES_ErrorCount
          ,le.UPIN_LEFTTRIM_ErrorCount,le.UPIN_QUOTES_ErrorCount
          ,le.DID_LEFTTRIM_ErrorCount,le.DID_QUOTES_ErrorCount
          ,le.BDID_LEFTTRIM_ErrorCount,le.BDID_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SOURCE_RID_LEFTTRIM_ErrorCount,le.SOURCE_RID_QUOTES_ErrorCount
          ,le.RID_LEFTTRIM_ErrorCount,le.RID_QUOTES_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount
          ,le.AnyRule_WithEditsCount
          ,le.Rules_WithEdits,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.V_CITY_NAME_LEFTTRIM_ErrorCount,le.V_CITY_NAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.SSN_LEFTTRIM_ErrorCount,le.SSN_QUOTES_ErrorCount
          ,le.CNSMR_SSN_LEFTTRIM_ErrorCount,le.CNSMR_SSN_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.CNSMR_DOB_LEFTTRIM_ErrorCount,le.CNSMR_DOB_QUOTES_ErrorCount
          ,le.PHONE_LEFTTRIM_ErrorCount,le.PHONE_QUOTES_ErrorCount
          ,le.LIC_STATE_LEFTTRIM_ErrorCount,le.LIC_STATE_QUOTES_ErrorCount
          ,le.C_LIC_NBR_LEFTTRIM_ErrorCount,le.C_LIC_NBR_QUOTES_ErrorCount
          ,le.TAX_ID_LEFTTRIM_ErrorCount,le.TAX_ID_QUOTES_ErrorCount
          ,le.BILLING_TAX_ID_LEFTTRIM_ErrorCount,le.BILLING_TAX_ID_QUOTES_ErrorCount
          ,le.DEA_NUMBER_LEFTTRIM_ErrorCount,le.DEA_NUMBER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.NPI_NUMBER_LEFTTRIM_ErrorCount,le.NPI_NUMBER_QUOTES_ErrorCount
          ,le.BILLING_NPI_NUMBER_LEFTTRIM_ErrorCount,le.BILLING_NPI_NUMBER_QUOTES_ErrorCount
          ,le.UPIN_LEFTTRIM_ErrorCount,le.UPIN_QUOTES_ErrorCount
          ,le.DID_LEFTTRIM_ErrorCount,le.DID_QUOTES_ErrorCount
          ,le.BDID_LEFTTRIM_ErrorCount,le.BDID_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SOURCE_RID_LEFTTRIM_ErrorCount,le.SOURCE_RID_QUOTES_ErrorCount
          ,le.RID_LEFTTRIM_ErrorCount,le.RID_QUOTES_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithEditsCount/SELF.recordstotal * 100)
          ,IF(NumRulesWithPossibleEdits = 0, 0, le.Rules_WithEdits/NumRulesWithPossibleEdits * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 9,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_HealthProvider));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'FNAME:' + getFieldTypeText(h.FNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MNAME:' + getFieldTypeText(h.MNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LNAME:' + getFieldTypeText(h.LNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SNAME:' + getFieldTypeText(h.SNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'GENDER:' + getFieldTypeText(h.GENDER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_RANGE:' + getFieldTypeText(h.PRIM_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_NAME:' + getFieldTypeText(h.PRIM_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SEC_RANGE:' + getFieldTypeText(h.SEC_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'V_CITY_NAME:' + getFieldTypeText(h.V_CITY_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ST:' + getFieldTypeText(h.ST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP:' + getFieldTypeText(h.ZIP) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN:' + getFieldTypeText(h.SSN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CNSMR_SSN:' + getFieldTypeText(h.CNSMR_SSN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DOB:' + getFieldTypeText(h.DOB) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CNSMR_DOB:' + getFieldTypeText(h.CNSMR_DOB) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PHONE:' + getFieldTypeText(h.PHONE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LIC_STATE:' + getFieldTypeText(h.LIC_STATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'C_LIC_NBR:' + getFieldTypeText(h.C_LIC_NBR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'TAX_ID:' + getFieldTypeText(h.TAX_ID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BILLING_TAX_ID:' + getFieldTypeText(h.BILLING_TAX_ID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DEA_NUMBER:' + getFieldTypeText(h.DEA_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'VENDOR_ID:' + getFieldTypeText(h.VENDOR_ID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'NPI_NUMBER:' + getFieldTypeText(h.NPI_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BILLING_NPI_NUMBER:' + getFieldTypeText(h.BILLING_NPI_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'UPIN:' + getFieldTypeText(h.UPIN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DID:' + getFieldTypeText(h.DID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'BDID:' + getFieldTypeText(h.BDID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SRC:' + getFieldTypeText(h.SRC) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SOURCE_RID:' + getFieldTypeText(h.SOURCE_RID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RID:' + getFieldTypeText(h.RID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_FNAME_cnt
          ,le.populated_MNAME_cnt
          ,le.populated_LNAME_cnt
          ,le.populated_SNAME_cnt
          ,le.populated_GENDER_cnt
          ,le.populated_PRIM_RANGE_cnt
          ,le.populated_PRIM_NAME_cnt
          ,le.populated_SEC_RANGE_cnt
          ,le.populated_V_CITY_NAME_cnt
          ,le.populated_ST_cnt
          ,le.populated_ZIP_cnt
          ,le.populated_SSN_cnt
          ,le.populated_CNSMR_SSN_cnt
          ,le.populated_DOB_cnt
          ,le.populated_CNSMR_DOB_cnt
          ,le.populated_PHONE_cnt
          ,le.populated_LIC_STATE_cnt
          ,le.populated_C_LIC_NBR_cnt
          ,le.populated_TAX_ID_cnt
          ,le.populated_BILLING_TAX_ID_cnt
          ,le.populated_DEA_NUMBER_cnt
          ,le.populated_VENDOR_ID_cnt
          ,le.populated_NPI_NUMBER_cnt
          ,le.populated_BILLING_NPI_NUMBER_cnt
          ,le.populated_UPIN_cnt
          ,le.populated_DID_cnt
          ,le.populated_BDID_cnt
          ,le.populated_SRC_cnt
          ,le.populated_SOURCE_RID_cnt
          ,le.populated_RID_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_FNAME_pcnt
          ,le.populated_MNAME_pcnt
          ,le.populated_LNAME_pcnt
          ,le.populated_SNAME_pcnt
          ,le.populated_GENDER_pcnt
          ,le.populated_PRIM_RANGE_pcnt
          ,le.populated_PRIM_NAME_pcnt
          ,le.populated_SEC_RANGE_pcnt
          ,le.populated_V_CITY_NAME_pcnt
          ,le.populated_ST_pcnt
          ,le.populated_ZIP_pcnt
          ,le.populated_SSN_pcnt
          ,le.populated_CNSMR_SSN_pcnt
          ,le.populated_DOB_pcnt
          ,le.populated_CNSMR_DOB_pcnt
          ,le.populated_PHONE_pcnt
          ,le.populated_LIC_STATE_pcnt
          ,le.populated_C_LIC_NBR_pcnt
          ,le.populated_TAX_ID_pcnt
          ,le.populated_BILLING_TAX_ID_pcnt
          ,le.populated_DEA_NUMBER_pcnt
          ,le.populated_VENDOR_ID_pcnt
          ,le.populated_NPI_NUMBER_pcnt
          ,le.populated_BILLING_NPI_NUMBER_pcnt
          ,le.populated_UPIN_pcnt
          ,le.populated_DID_pcnt
          ,le.populated_BDID_pcnt
          ,le.populated_SRC_pcnt
          ,le.populated_SOURCE_RID_pcnt
          ,le.populated_RID_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,30,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_HealthProvider));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),30,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_HealthProvider) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Health_Provider_Services_CCPA, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
