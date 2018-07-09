IMPORT SALT37;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_HEADER)
    UNSIGNED1 SSN_Invalid;
    UNSIGNED1 POLICY_NUMBER_Invalid;
    UNSIGNED1 CLAIM_NUMBER_Invalid;
    UNSIGNED1 DL_NBR_Invalid;
    UNSIGNED1 DOB_Invalid;
    UNSIGNED1 ZIP_Invalid;
    UNSIGNED1 PRIM_NAME_Invalid;
    UNSIGNED1 LNAME_Invalid;
    UNSIGNED1 PRIM_RANGE_Invalid;
    UNSIGNED1 CITY_Invalid;
    UNSIGNED1 FNAME_Invalid;
    UNSIGNED1 SEC_RANGE_Invalid;
    UNSIGNED1 MNAME_Invalid;
    UNSIGNED1 ST_Invalid;
    UNSIGNED1 SNAME_Invalid;
    UNSIGNED1 GENDER_Invalid;
    UNSIGNED1 DERIVED_GENDER_Invalid;
    UNSIGNED1 VENDOR_ID_Invalid;
    UNSIGNED1 BOCA_DID_Invalid;
    UNSIGNED1 SRC_Invalid;
    UNSIGNED1 DT_FIRST_SEEN_Invalid;
    UNSIGNED1 DT_LAST_SEEN_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_HEADER)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_HEADER) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.SSN_Invalid := Fields.InValid_SSN((SALT37.StrType)le.SSN);
      clean_SSN := (TYPEOF(le.SSN))Fields.Make_SSN((SALT37.StrType)le.SSN);
      clean_SSN_Invalid := Fields.InValid_SSN((SALT37.StrType)clean_SSN);
      SELF.SSN := IF(withOnfail, clean_SSN, le.SSN); // ONFAIL(CLEAN)
    SELF.POLICY_NUMBER_Invalid := Fields.InValid_POLICY_NUMBER((SALT37.StrType)le.POLICY_NUMBER);
      clean_POLICY_NUMBER := (TYPEOF(le.POLICY_NUMBER))Fields.Make_POLICY_NUMBER((SALT37.StrType)le.POLICY_NUMBER);
      clean_POLICY_NUMBER_Invalid := Fields.InValid_POLICY_NUMBER((SALT37.StrType)clean_POLICY_NUMBER);
      SELF.POLICY_NUMBER := IF(withOnfail, clean_POLICY_NUMBER, le.POLICY_NUMBER); // ONFAIL(CLEAN)
    SELF.CLAIM_NUMBER_Invalid := Fields.InValid_CLAIM_NUMBER((SALT37.StrType)le.CLAIM_NUMBER);
      clean_CLAIM_NUMBER := (TYPEOF(le.CLAIM_NUMBER))Fields.Make_CLAIM_NUMBER((SALT37.StrType)le.CLAIM_NUMBER);
      clean_CLAIM_NUMBER_Invalid := Fields.InValid_CLAIM_NUMBER((SALT37.StrType)clean_CLAIM_NUMBER);
      SELF.CLAIM_NUMBER := IF(withOnfail, clean_CLAIM_NUMBER, le.CLAIM_NUMBER); // ONFAIL(CLEAN)
    SELF.DL_NBR_Invalid := Fields.InValid_DL_NBR((SALT37.StrType)le.DL_NBR);
      clean_DL_NBR := (TYPEOF(le.DL_NBR))Fields.Make_DL_NBR((SALT37.StrType)le.DL_NBR);
      clean_DL_NBR_Invalid := Fields.InValid_DL_NBR((SALT37.StrType)clean_DL_NBR);
      SELF.DL_NBR := IF(withOnfail, clean_DL_NBR, le.DL_NBR); // ONFAIL(CLEAN)
    SELF.DOB_Invalid := Fields.InValid_DOB((SALT37.StrType)le.DOB);
      clean_DOB := (TYPEOF(le.DOB))Fields.Make_DOB((SALT37.StrType)le.DOB);
      clean_DOB_Invalid := Fields.InValid_DOB((SALT37.StrType)clean_DOB);
      SELF.DOB := IF(withOnfail, clean_DOB, le.DOB); // ONFAIL(CLEAN)
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT37.StrType)le.ZIP);
      clean_ZIP := (TYPEOF(le.ZIP))Fields.Make_ZIP((SALT37.StrType)le.ZIP);
      clean_ZIP_Invalid := Fields.InValid_ZIP((SALT37.StrType)clean_ZIP);
      SELF.ZIP := IF(withOnfail, clean_ZIP, le.ZIP); // ONFAIL(CLEAN)
    SELF.PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT37.StrType)le.PRIM_NAME);
      clean_PRIM_NAME := (TYPEOF(le.PRIM_NAME))Fields.Make_PRIM_NAME((SALT37.StrType)le.PRIM_NAME);
      clean_PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT37.StrType)clean_PRIM_NAME);
      SELF.PRIM_NAME := IF(withOnfail, clean_PRIM_NAME, le.PRIM_NAME); // ONFAIL(CLEAN)
    SELF.LNAME_Invalid := Fields.InValid_LNAME((SALT37.StrType)le.LNAME);
      clean_LNAME := (TYPEOF(le.LNAME))Fields.Make_LNAME((SALT37.StrType)le.LNAME);
      clean_LNAME_Invalid := Fields.InValid_LNAME((SALT37.StrType)clean_LNAME);
      SELF.LNAME := IF(withOnfail, clean_LNAME, le.LNAME); // ONFAIL(CLEAN)
    SELF.PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE);
      clean_PRIM_RANGE := (TYPEOF(le.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE);
      clean_PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT37.StrType)clean_PRIM_RANGE);
      SELF.PRIM_RANGE := IF(withOnfail, clean_PRIM_RANGE, le.PRIM_RANGE); // ONFAIL(CLEAN)
    SELF.CITY_Invalid := Fields.InValid_CITY((SALT37.StrType)le.CITY);
      clean_CITY := (TYPEOF(le.CITY))Fields.Make_CITY((SALT37.StrType)le.CITY);
      clean_CITY_Invalid := Fields.InValid_CITY((SALT37.StrType)clean_CITY);
      SELF.CITY := IF(withOnfail, clean_CITY, le.CITY); // ONFAIL(CLEAN)
    SELF.FNAME_Invalid := Fields.InValid_FNAME((SALT37.StrType)le.FNAME);
      clean_FNAME := (TYPEOF(le.FNAME))Fields.Make_FNAME((SALT37.StrType)le.FNAME);
      clean_FNAME_Invalid := Fields.InValid_FNAME((SALT37.StrType)clean_FNAME);
      SELF.FNAME := IF(withOnfail, clean_FNAME, le.FNAME); // ONFAIL(CLEAN)
    SELF.SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT37.StrType)le.SEC_RANGE);
      clean_SEC_RANGE := (TYPEOF(le.SEC_RANGE))Fields.Make_SEC_RANGE((SALT37.StrType)le.SEC_RANGE);
      clean_SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT37.StrType)clean_SEC_RANGE);
      SELF.SEC_RANGE := IF(withOnfail, clean_SEC_RANGE, le.SEC_RANGE); // ONFAIL(CLEAN)
    SELF.MNAME_Invalid := Fields.InValid_MNAME((SALT37.StrType)le.MNAME);
      clean_MNAME := (TYPEOF(le.MNAME))Fields.Make_MNAME((SALT37.StrType)le.MNAME);
      clean_MNAME_Invalid := Fields.InValid_MNAME((SALT37.StrType)clean_MNAME);
      SELF.MNAME := IF(withOnfail, clean_MNAME, le.MNAME); // ONFAIL(CLEAN)
    SELF.ST_Invalid := Fields.InValid_ST((SALT37.StrType)le.ST);
      clean_ST := (TYPEOF(le.ST))Fields.Make_ST((SALT37.StrType)le.ST);
      clean_ST_Invalid := Fields.InValid_ST((SALT37.StrType)clean_ST);
      SELF.ST := IF(withOnfail, clean_ST, le.ST); // ONFAIL(CLEAN)
    SELF.SNAME_Invalid := Fields.InValid_SNAME((SALT37.StrType)le.SNAME);
      clean_SNAME := (TYPEOF(le.SNAME))Fields.Make_SNAME((SALT37.StrType)le.SNAME);
      clean_SNAME_Invalid := Fields.InValid_SNAME((SALT37.StrType)clean_SNAME);
      SELF.SNAME := IF(withOnfail, clean_SNAME, le.SNAME); // ONFAIL(CLEAN)
    SELF.GENDER_Invalid := Fields.InValid_GENDER((SALT37.StrType)le.GENDER);
      clean_GENDER := (TYPEOF(le.GENDER))Fields.Make_GENDER((SALT37.StrType)le.GENDER);
      clean_GENDER_Invalid := Fields.InValid_GENDER((SALT37.StrType)clean_GENDER);
      SELF.GENDER := IF(withOnfail, clean_GENDER, le.GENDER); // ONFAIL(CLEAN)
    SELF.DERIVED_GENDER_Invalid := Fields.InValid_DERIVED_GENDER((SALT37.StrType)le.DERIVED_GENDER);
      clean_DERIVED_GENDER := (TYPEOF(le.DERIVED_GENDER))Fields.Make_DERIVED_GENDER((SALT37.StrType)le.DERIVED_GENDER);
      clean_DERIVED_GENDER_Invalid := Fields.InValid_DERIVED_GENDER((SALT37.StrType)clean_DERIVED_GENDER);
      SELF.DERIVED_GENDER := IF(withOnfail, clean_DERIVED_GENDER, le.DERIVED_GENDER); // ONFAIL(CLEAN)
    SELF.VENDOR_ID_Invalid := Fields.InValid_VENDOR_ID((SALT37.StrType)le.VENDOR_ID);
      clean_VENDOR_ID := (TYPEOF(le.VENDOR_ID))Fields.Make_VENDOR_ID((SALT37.StrType)le.VENDOR_ID);
      clean_VENDOR_ID_Invalid := Fields.InValid_VENDOR_ID((SALT37.StrType)clean_VENDOR_ID);
      SELF.VENDOR_ID := IF(withOnfail, clean_VENDOR_ID, le.VENDOR_ID); // ONFAIL(CLEAN)
    SELF.BOCA_DID_Invalid := Fields.InValid_BOCA_DID((SALT37.StrType)le.BOCA_DID);
      clean_BOCA_DID := (TYPEOF(le.BOCA_DID))Fields.Make_BOCA_DID((SALT37.StrType)le.BOCA_DID);
      clean_BOCA_DID_Invalid := Fields.InValid_BOCA_DID((SALT37.StrType)clean_BOCA_DID);
      SELF.BOCA_DID := IF(withOnfail, clean_BOCA_DID, le.BOCA_DID); // ONFAIL(CLEAN)
    SELF.SRC_Invalid := Fields.InValid_SRC((SALT37.StrType)le.SRC);
      clean_SRC := (TYPEOF(le.SRC))Fields.Make_SRC((SALT37.StrType)le.SRC);
      clean_SRC_Invalid := Fields.InValid_SRC((SALT37.StrType)clean_SRC);
      SELF.SRC := IF(withOnfail, clean_SRC, le.SRC); // ONFAIL(CLEAN)
    SELF.DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN);
      clean_DT_FIRST_SEEN := (TYPEOF(le.DT_FIRST_SEEN))Fields.Make_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN);
      clean_DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT37.StrType)clean_DT_FIRST_SEEN);
      SELF.DT_FIRST_SEEN := IF(withOnfail, clean_DT_FIRST_SEEN, le.DT_FIRST_SEEN); // ONFAIL(CLEAN)
    SELF.DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN);
      clean_DT_LAST_SEEN := (TYPEOF(le.DT_LAST_SEEN))Fields.Make_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN);
      clean_DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT37.StrType)clean_DT_LAST_SEEN);
      SELF.DT_LAST_SEEN := IF(withOnfail, clean_DT_LAST_SEEN, le.DT_LAST_SEEN); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_HEADER);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.SSN_Invalid << 0 ) + ( le.POLICY_NUMBER_Invalid << 2 ) + ( le.CLAIM_NUMBER_Invalid << 4 ) + ( le.DL_NBR_Invalid << 6 ) + ( le.DOB_Invalid << 8 ) + ( le.ZIP_Invalid << 10 ) + ( le.PRIM_NAME_Invalid << 12 ) + ( le.LNAME_Invalid << 14 ) + ( le.PRIM_RANGE_Invalid << 16 ) + ( le.CITY_Invalid << 18 ) + ( le.FNAME_Invalid << 20 ) + ( le.SEC_RANGE_Invalid << 22 ) + ( le.MNAME_Invalid << 24 ) + ( le.ST_Invalid << 26 ) + ( le.SNAME_Invalid << 28 ) + ( le.GENDER_Invalid << 30 ) + ( le.DERIVED_GENDER_Invalid << 32 ) + ( le.VENDOR_ID_Invalid << 34 ) + ( le.BOCA_DID_Invalid << 36 ) + ( le.SRC_Invalid << 38 ) + ( le.DT_FIRST_SEEN_Invalid << 40 ) + ( le.DT_LAST_SEEN_Invalid << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_HEADER);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.SSN_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.POLICY_NUMBER_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.CLAIM_NUMBER_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.DL_NBR_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.DOB_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.LNAME_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.CITY_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.FNAME_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.MNAME_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.SNAME_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.GENDER_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.DERIVED_GENDER_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.VENDOR_ID_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.BOCA_DID_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.SRC_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.DT_FIRST_SEEN_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.DT_LAST_SEEN_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.RID=RIGHT.RID AND (LEFT.SSN_Invalid <> RIGHT.SSN_Invalid OR LEFT.POLICY_NUMBER_Invalid <> RIGHT.POLICY_NUMBER_Invalid OR LEFT.CLAIM_NUMBER_Invalid <> RIGHT.CLAIM_NUMBER_Invalid OR LEFT.DL_NBR_Invalid <> RIGHT.DL_NBR_Invalid OR LEFT.DOB_Invalid <> RIGHT.DOB_Invalid OR LEFT.ZIP_Invalid <> RIGHT.ZIP_Invalid OR LEFT.PRIM_NAME_Invalid <> RIGHT.PRIM_NAME_Invalid OR LEFT.LNAME_Invalid <> RIGHT.LNAME_Invalid OR LEFT.PRIM_RANGE_Invalid <> RIGHT.PRIM_RANGE_Invalid OR LEFT.CITY_Invalid <> RIGHT.CITY_Invalid OR LEFT.FNAME_Invalid <> RIGHT.FNAME_Invalid OR LEFT.SEC_RANGE_Invalid <> RIGHT.SEC_RANGE_Invalid OR LEFT.MNAME_Invalid <> RIGHT.MNAME_Invalid OR LEFT.ST_Invalid <> RIGHT.ST_Invalid OR LEFT.SNAME_Invalid <> RIGHT.SNAME_Invalid OR LEFT.GENDER_Invalid <> RIGHT.GENDER_Invalid OR LEFT.DERIVED_GENDER_Invalid <> RIGHT.DERIVED_GENDER_Invalid OR LEFT.VENDOR_ID_Invalid <> RIGHT.VENDOR_ID_Invalid OR LEFT.BOCA_DID_Invalid <> RIGHT.BOCA_DID_Invalid OR LEFT.SRC_Invalid <> RIGHT.SRC_Invalid OR LEFT.DT_FIRST_SEEN_Invalid <> RIGHT.DT_FIRST_SEEN_Invalid OR LEFT.DT_LAST_SEEN_Invalid <> RIGHT.DT_LAST_SEEN_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.SRC;
    TotalCnt := COUNT(GROUP); // Number of records in total
    SSN_QUOTES_ErrorCount := COUNT(GROUP,h.SSN_Invalid=1);
    SSN_ALLOW_ErrorCount := COUNT(GROUP,h.SSN_Invalid=2);
    SSN_Total_ErrorCount := COUNT(GROUP,h.SSN_Invalid>0);
    POLICY_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.POLICY_NUMBER_Invalid=1);
    POLICY_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.POLICY_NUMBER_Invalid=2);
    POLICY_NUMBER_Total_ErrorCount := COUNT(GROUP,h.POLICY_NUMBER_Invalid>0);
    CLAIM_NUMBER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CLAIM_NUMBER_Invalid=1);
    CLAIM_NUMBER_QUOTES_ErrorCount := COUNT(GROUP,h.CLAIM_NUMBER_Invalid=2);
    CLAIM_NUMBER_Total_ErrorCount := COUNT(GROUP,h.CLAIM_NUMBER_Invalid>0);
    DL_NBR_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid=1);
    DL_NBR_QUOTES_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid=2);
    DL_NBR_Total_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid>0);
    DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DOB_Invalid=1);
    DOB_QUOTES_ErrorCount := COUNT(GROUP,h.DOB_Invalid=2);
    DOB_Total_ErrorCount := COUNT(GROUP,h.DOB_Invalid>0);
    ZIP_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    ZIP_QUOTES_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=2);
    ZIP_Total_ErrorCount := COUNT(GROUP,h.ZIP_Invalid>0);
    PRIM_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1);
    PRIM_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2);
    PRIM_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid>0);
    LNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=1);
    LNAME_QUOTES_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=2);
    LNAME_Total_ErrorCount := COUNT(GROUP,h.LNAME_Invalid>0);
    PRIM_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1);
    PRIM_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2);
    PRIM_RANGE_Total_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid>0);
    CITY_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CITY_Invalid=1);
    CITY_QUOTES_ErrorCount := COUNT(GROUP,h.CITY_Invalid=2);
    CITY_Total_ErrorCount := COUNT(GROUP,h.CITY_Invalid>0);
    FNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=1);
    FNAME_QUOTES_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=2);
    FNAME_Total_ErrorCount := COUNT(GROUP,h.FNAME_Invalid>0);
    SEC_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1);
    SEC_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2);
    SEC_RANGE_Total_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid>0);
    MNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=1);
    MNAME_QUOTES_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=2);
    MNAME_Total_ErrorCount := COUNT(GROUP,h.MNAME_Invalid>0);
    ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_QUOTES_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    SNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=1);
    SNAME_QUOTES_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=2);
    SNAME_Total_ErrorCount := COUNT(GROUP,h.SNAME_Invalid>0);
    GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=1);
    GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=2);
    GENDER_Total_ErrorCount := COUNT(GROUP,h.GENDER_Invalid>0);
    DERIVED_GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=1);
    DERIVED_GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=2);
    DERIVED_GENDER_Total_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid>0);
    VENDOR_ID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=1);
    VENDOR_ID_QUOTES_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid=2);
    VENDOR_ID_Total_ErrorCount := COUNT(GROUP,h.VENDOR_ID_Invalid>0);
    BOCA_DID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.BOCA_DID_Invalid=1);
    BOCA_DID_QUOTES_ErrorCount := COUNT(GROUP,h.BOCA_DID_Invalid=2);
    BOCA_DID_Total_ErrorCount := COUNT(GROUP,h.BOCA_DID_Invalid>0);
    SRC_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SRC_Invalid=1);
    SRC_QUOTES_ErrorCount := COUNT(GROUP,h.SRC_Invalid=2);
    SRC_Total_ErrorCount := COUNT(GROUP,h.SRC_Invalid>0);
    DT_FIRST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=1);
    DT_FIRST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=2);
    DT_FIRST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid>0);
    DT_LAST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=1);
    DT_LAST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=2);
    DT_LAST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,SRC,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.SRC;
    UNSIGNED1 ErrNum := CHOOSE(c,le.SSN_Invalid,le.POLICY_NUMBER_Invalid,le.CLAIM_NUMBER_Invalid,le.DL_NBR_Invalid,le.DOB_Invalid,le.ZIP_Invalid,le.PRIM_NAME_Invalid,le.LNAME_Invalid,le.PRIM_RANGE_Invalid,le.CITY_Invalid,le.FNAME_Invalid,le.SEC_RANGE_Invalid,le.MNAME_Invalid,le.ST_Invalid,le.SNAME_Invalid,le.GENDER_Invalid,le.DERIVED_GENDER_Invalid,le.VENDOR_ID_Invalid,le.BOCA_DID_Invalid,le.SRC_Invalid,le.DT_FIRST_SEEN_Invalid,le.DT_LAST_SEEN_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_SSN(le.SSN_Invalid),Fields.InvalidMessage_POLICY_NUMBER(le.POLICY_NUMBER_Invalid),Fields.InvalidMessage_CLAIM_NUMBER(le.CLAIM_NUMBER_Invalid),Fields.InvalidMessage_DL_NBR(le.DL_NBR_Invalid),Fields.InvalidMessage_DOB(le.DOB_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_LNAME(le.LNAME_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_CITY(le.CITY_Invalid),Fields.InvalidMessage_FNAME(le.FNAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_MNAME(le.MNAME_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_SNAME(le.SNAME_Invalid),Fields.InvalidMessage_GENDER(le.GENDER_Invalid),Fields.InvalidMessage_DERIVED_GENDER(le.DERIVED_GENDER_Invalid),Fields.InvalidMessage_VENDOR_ID(le.VENDOR_ID_Invalid),Fields.InvalidMessage_BOCA_DID(le.BOCA_DID_Invalid),Fields.InvalidMessage_SRC(le.SRC_Invalid),Fields.InvalidMessage_DT_FIRST_SEEN(le.DT_FIRST_SEEN_Invalid),Fields.InvalidMessage_DT_LAST_SEEN(le.DT_LAST_SEEN_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.SSN_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.POLICY_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CLAIM_NUMBER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DL_NBR_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CITY_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DERIVED_GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.VENDOR_ID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.BOCA_DID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SRC_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_FIRST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LAST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'SSN','POLICY_NUMBER','CLAIM_NUMBER','DL_NBR','DOB','ZIP','PRIM_NAME','LNAME','PRIM_RANGE','CITY','FNAME','SEC_RANGE','MNAME','ST','SNAME','GENDER','DERIVED_GENDER','VENDOR_ID','BOCA_DID','SRC','DT_FIRST_SEEN','DT_LAST_SEEN','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.SSN,(SALT37.StrType)le.POLICY_NUMBER,(SALT37.StrType)le.CLAIM_NUMBER,(SALT37.StrType)le.DL_NBR,(SALT37.StrType)le.DOB,(SALT37.StrType)le.ZIP,(SALT37.StrType)le.PRIM_NAME,(SALT37.StrType)le.LNAME,(SALT37.StrType)le.PRIM_RANGE,(SALT37.StrType)le.CITY,(SALT37.StrType)le.FNAME,(SALT37.StrType)le.SEC_RANGE,(SALT37.StrType)le.MNAME,(SALT37.StrType)le.ST,(SALT37.StrType)le.SNAME,(SALT37.StrType)le.GENDER,(SALT37.StrType)le.DERIVED_GENDER,(SALT37.StrType)le.VENDOR_ID,(SALT37.StrType)le.BOCA_DID,(SALT37.StrType)le.SRC,(SALT37.StrType)le.DT_FIRST_SEEN,(SALT37.StrType)le.DT_LAST_SEEN,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.SRC;
      SELF.ruledesc := CHOOSE(c
          ,'SSN:NUMBER:QUOTES','SSN:NUMBER:ALLOW'
          ,'POLICY_NUMBER:DEFAULT:LEFTTRIM','POLICY_NUMBER:DEFAULT:QUOTES'
          ,'CLAIM_NUMBER:DEFAULT:LEFTTRIM','CLAIM_NUMBER:DEFAULT:QUOTES'
          ,'DL_NBR:DEFAULT:LEFTTRIM','DL_NBR:DEFAULT:QUOTES'
          ,'DOB:DEFAULT:LEFTTRIM','DOB:DEFAULT:QUOTES'
          ,'ZIP:DEFAULT:LEFTTRIM','ZIP:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'LNAME:DEFAULT:LEFTTRIM','LNAME:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'CITY:DEFAULT:LEFTTRIM','CITY:DEFAULT:QUOTES'
          ,'FNAME:DEFAULT:LEFTTRIM','FNAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'MNAME:DEFAULT:LEFTTRIM','MNAME:DEFAULT:QUOTES'
          ,'ST:DEFAULT:LEFTTRIM','ST:DEFAULT:QUOTES'
          ,'SNAME:DEFAULT:LEFTTRIM','SNAME:DEFAULT:QUOTES'
          ,'GENDER:DEFAULT:LEFTTRIM','GENDER:DEFAULT:QUOTES'
          ,'DERIVED_GENDER:DEFAULT:LEFTTRIM','DERIVED_GENDER:DEFAULT:QUOTES'
          ,'VENDOR_ID:DEFAULT:LEFTTRIM','VENDOR_ID:DEFAULT:QUOTES'
          ,'BOCA_DID:DEFAULT:LEFTTRIM','BOCA_DID:DEFAULT:QUOTES'
          ,'SRC:DEFAULT:LEFTTRIM','SRC:DEFAULT:QUOTES'
          ,'DT_FIRST_SEEN:DEFAULT:LEFTTRIM','DT_FIRST_SEEN:DEFAULT:QUOTES'
          ,'DT_LAST_SEEN:DEFAULT:LEFTTRIM','DT_LAST_SEEN:DEFAULT:QUOTES','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_SSN(1),Fields.InvalidMessage_SSN(2)
          ,Fields.InvalidMessage_POLICY_NUMBER(1),Fields.InvalidMessage_POLICY_NUMBER(2)
          ,Fields.InvalidMessage_CLAIM_NUMBER(1),Fields.InvalidMessage_CLAIM_NUMBER(2)
          ,Fields.InvalidMessage_DL_NBR(1),Fields.InvalidMessage_DL_NBR(2)
          ,Fields.InvalidMessage_DOB(1),Fields.InvalidMessage_DOB(2)
          ,Fields.InvalidMessage_ZIP(1),Fields.InvalidMessage_ZIP(2)
          ,Fields.InvalidMessage_PRIM_NAME(1),Fields.InvalidMessage_PRIM_NAME(2)
          ,Fields.InvalidMessage_LNAME(1),Fields.InvalidMessage_LNAME(2)
          ,Fields.InvalidMessage_PRIM_RANGE(1),Fields.InvalidMessage_PRIM_RANGE(2)
          ,Fields.InvalidMessage_CITY(1),Fields.InvalidMessage_CITY(2)
          ,Fields.InvalidMessage_FNAME(1),Fields.InvalidMessage_FNAME(2)
          ,Fields.InvalidMessage_SEC_RANGE(1),Fields.InvalidMessage_SEC_RANGE(2)
          ,Fields.InvalidMessage_MNAME(1),Fields.InvalidMessage_MNAME(2)
          ,Fields.InvalidMessage_ST(1),Fields.InvalidMessage_ST(2)
          ,Fields.InvalidMessage_SNAME(1),Fields.InvalidMessage_SNAME(2)
          ,Fields.InvalidMessage_GENDER(1),Fields.InvalidMessage_GENDER(2)
          ,Fields.InvalidMessage_DERIVED_GENDER(1),Fields.InvalidMessage_DERIVED_GENDER(2)
          ,Fields.InvalidMessage_VENDOR_ID(1),Fields.InvalidMessage_VENDOR_ID(2)
          ,Fields.InvalidMessage_BOCA_DID(1),Fields.InvalidMessage_BOCA_DID(2)
          ,Fields.InvalidMessage_SRC(1),Fields.InvalidMessage_SRC(2)
          ,Fields.InvalidMessage_DT_FIRST_SEEN(1),Fields.InvalidMessage_DT_FIRST_SEEN(2)
          ,Fields.InvalidMessage_DT_LAST_SEEN(1),Fields.InvalidMessage_DT_LAST_SEEN(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.SSN_QUOTES_ErrorCount,le.SSN_ALLOW_ErrorCount
          ,le.POLICY_NUMBER_LEFTTRIM_ErrorCount,le.POLICY_NUMBER_QUOTES_ErrorCount
          ,le.CLAIM_NUMBER_LEFTTRIM_ErrorCount,le.CLAIM_NUMBER_QUOTES_ErrorCount
          ,le.DL_NBR_LEFTTRIM_ErrorCount,le.DL_NBR_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.CITY_LEFTTRIM_ErrorCount,le.CITY_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.DERIVED_GENDER_LEFTTRIM_ErrorCount,le.DERIVED_GENDER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.BOCA_DID_LEFTTRIM_ErrorCount,le.BOCA_DID_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.SSN_QUOTES_ErrorCount,le.SSN_ALLOW_ErrorCount
          ,le.POLICY_NUMBER_LEFTTRIM_ErrorCount,le.POLICY_NUMBER_QUOTES_ErrorCount
          ,le.CLAIM_NUMBER_LEFTTRIM_ErrorCount,le.CLAIM_NUMBER_QUOTES_ErrorCount
          ,le.DL_NBR_LEFTTRIM_ErrorCount,le.DL_NBR_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.CITY_LEFTTRIM_ErrorCount,le.CITY_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.DERIVED_GENDER_LEFTTRIM_ErrorCount,le.DERIVED_GENDER_QUOTES_ErrorCount
          ,le.VENDOR_ID_LEFTTRIM_ErrorCount,le.VENDOR_ID_QUOTES_ErrorCount
          ,le.BOCA_DID_LEFTTRIM_ErrorCount,le.BOCA_DID_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,44,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
