IMPORT ut,SALT33;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Classify_PS)
    UNSIGNED1 NAME_SUFFIX_Invalid;
    UNSIGNED1 FNAME_Invalid;
    UNSIGNED1 MNAME_Invalid;
    UNSIGNED1 LNAME_Invalid;
    UNSIGNED1 PRIM_RANGE_Invalid;
    UNSIGNED1 PRIM_NAME_Invalid;
    UNSIGNED1 SEC_RANGE_Invalid;
    UNSIGNED1 P_CITY_NAME_Invalid;
    UNSIGNED1 ST_Invalid;
    UNSIGNED1 ZIP_Invalid;
    UNSIGNED1 DOB_Invalid;
    UNSIGNED1 PHONE_Invalid;
    UNSIGNED1 DL_ST_Invalid;
    UNSIGNED1 DL_Invalid;
    UNSIGNED1 LEXID_Invalid;
    UNSIGNED1 POSSIBLE_SSN_Invalid;
    UNSIGNED1 CRIME_Invalid;
    UNSIGNED1 NAME_TYPE_Invalid;
    UNSIGNED1 CLEAN_GENDER_Invalid;
    UNSIGNED1 CLASS_CODE_Invalid;
    UNSIGNED1 DT_FIRST_SEEN_Invalid;
    UNSIGNED1 DT_LAST_SEEN_Invalid;
    UNSIGNED1 DATA_PROVIDER_ORI_Invalid;
    UNSIGNED1 VIN_Invalid;
    UNSIGNED1 PLATE_Invalid;
    UNSIGNED1 LATITUDE_Invalid;
    UNSIGNED1 LONGITUDE_Invalid;
    UNSIGNED1 SEARCH_ADDR1_Invalid;
    UNSIGNED1 SEARCH_ADDR2_Invalid;
    UNSIGNED1 CLEAN_COMPANY_NAME_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Classify_PS)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Classify_PS) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.NAME_SUFFIX_Invalid := Fields.InValid_NAME_SUFFIX((SALT33.StrType)le.NAME_SUFFIX);
      clean_NAME_SUFFIX := (TYPEOF(le.NAME_SUFFIX))Fields.Make_NAME_SUFFIX((SALT33.StrType)le.NAME_SUFFIX);
      clean_NAME_SUFFIX_Invalid := Fields.InValid_NAME_SUFFIX((SALT33.StrType)clean_NAME_SUFFIX);
      SELF.NAME_SUFFIX := IF(withOnfail, clean_NAME_SUFFIX, le.NAME_SUFFIX); // ONFAIL(CLEAN)
    SELF.FNAME_Invalid := Fields.InValid_FNAME((SALT33.StrType)le.FNAME);
      clean_FNAME := (TYPEOF(le.FNAME))Fields.Make_FNAME((SALT33.StrType)le.FNAME);
      clean_FNAME_Invalid := Fields.InValid_FNAME((SALT33.StrType)clean_FNAME);
      SELF.FNAME := IF(withOnfail, clean_FNAME, le.FNAME); // ONFAIL(CLEAN)
    SELF.MNAME_Invalid := Fields.InValid_MNAME((SALT33.StrType)le.MNAME);
      clean_MNAME := (TYPEOF(le.MNAME))Fields.Make_MNAME((SALT33.StrType)le.MNAME);
      clean_MNAME_Invalid := Fields.InValid_MNAME((SALT33.StrType)clean_MNAME);
      SELF.MNAME := IF(withOnfail, clean_MNAME, le.MNAME); // ONFAIL(CLEAN)
    SELF.LNAME_Invalid := Fields.InValid_LNAME((SALT33.StrType)le.LNAME);
      clean_LNAME := (TYPEOF(le.LNAME))Fields.Make_LNAME((SALT33.StrType)le.LNAME);
      clean_LNAME_Invalid := Fields.InValid_LNAME((SALT33.StrType)clean_LNAME);
      SELF.LNAME := IF(withOnfail, clean_LNAME, le.LNAME); // ONFAIL(CLEAN)
    SELF.PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT33.StrType)le.PRIM_RANGE);
      clean_PRIM_RANGE := (TYPEOF(le.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT33.StrType)le.PRIM_RANGE);
      clean_PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT33.StrType)clean_PRIM_RANGE);
      SELF.PRIM_RANGE := IF(withOnfail, clean_PRIM_RANGE, le.PRIM_RANGE); // ONFAIL(CLEAN)
    SELF.PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT33.StrType)le.PRIM_NAME);
      clean_PRIM_NAME := (TYPEOF(le.PRIM_NAME))Fields.Make_PRIM_NAME((SALT33.StrType)le.PRIM_NAME);
      clean_PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT33.StrType)clean_PRIM_NAME);
      SELF.PRIM_NAME := IF(withOnfail, clean_PRIM_NAME, le.PRIM_NAME); // ONFAIL(CLEAN)
    SELF.SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT33.StrType)le.SEC_RANGE);
      clean_SEC_RANGE := (TYPEOF(le.SEC_RANGE))Fields.Make_SEC_RANGE((SALT33.StrType)le.SEC_RANGE);
      clean_SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT33.StrType)clean_SEC_RANGE);
      SELF.SEC_RANGE := IF(withOnfail, clean_SEC_RANGE, le.SEC_RANGE); // ONFAIL(CLEAN)
    SELF.P_CITY_NAME_Invalid := Fields.InValid_P_CITY_NAME((SALT33.StrType)le.P_CITY_NAME);
      clean_P_CITY_NAME := (TYPEOF(le.P_CITY_NAME))Fields.Make_P_CITY_NAME((SALT33.StrType)le.P_CITY_NAME);
      clean_P_CITY_NAME_Invalid := Fields.InValid_P_CITY_NAME((SALT33.StrType)clean_P_CITY_NAME);
      SELF.P_CITY_NAME := IF(withOnfail, clean_P_CITY_NAME, le.P_CITY_NAME); // ONFAIL(CLEAN)
    SELF.ST_Invalid := Fields.InValid_ST((SALT33.StrType)le.ST);
      clean_ST := (TYPEOF(le.ST))Fields.Make_ST((SALT33.StrType)le.ST);
      clean_ST_Invalid := Fields.InValid_ST((SALT33.StrType)clean_ST);
      SELF.ST := IF(withOnfail, clean_ST, le.ST); // ONFAIL(CLEAN)
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT33.StrType)le.ZIP);
    SELF.DOB_Invalid := Fields.InValid_DOB((SALT33.StrType)le.DOB);
      clean_DOB := (TYPEOF(le.DOB))Fields.Make_DOB((SALT33.StrType)le.DOB);
      clean_DOB_Invalid := Fields.InValid_DOB((SALT33.StrType)clean_DOB);
      SELF.DOB := IF(withOnfail, clean_DOB, le.DOB); // ONFAIL(CLEAN)
    SELF.PHONE_Invalid := Fields.InValid_PHONE((SALT33.StrType)le.PHONE);
    SELF.DL_ST_Invalid := Fields.InValid_DL_ST((SALT33.StrType)le.DL_ST);
      clean_DL_ST := (TYPEOF(le.DL_ST))Fields.Make_DL_ST((SALT33.StrType)le.DL_ST);
      clean_DL_ST_Invalid := Fields.InValid_DL_ST((SALT33.StrType)clean_DL_ST);
      SELF.DL_ST := IF(withOnfail, clean_DL_ST, le.DL_ST); // ONFAIL(CLEAN)
    SELF.DL_Invalid := Fields.InValid_DL((SALT33.StrType)le.DL);
      clean_DL := (TYPEOF(le.DL))Fields.Make_DL((SALT33.StrType)le.DL);
      clean_DL_Invalid := Fields.InValid_DL((SALT33.StrType)clean_DL);
      SELF.DL := IF(withOnfail, clean_DL, le.DL); // ONFAIL(CLEAN)
    SELF.LEXID_Invalid := Fields.InValid_LEXID((SALT33.StrType)le.LEXID);
      clean_LEXID := (TYPEOF(le.LEXID))Fields.Make_LEXID((SALT33.StrType)le.LEXID);
      clean_LEXID_Invalid := Fields.InValid_LEXID((SALT33.StrType)clean_LEXID);
      SELF.LEXID := IF(withOnfail, clean_LEXID, le.LEXID); // ONFAIL(CLEAN)
    SELF.POSSIBLE_SSN_Invalid := Fields.InValid_POSSIBLE_SSN((SALT33.StrType)le.POSSIBLE_SSN);
      clean_POSSIBLE_SSN := (TYPEOF(le.POSSIBLE_SSN))Fields.Make_POSSIBLE_SSN((SALT33.StrType)le.POSSIBLE_SSN);
      clean_POSSIBLE_SSN_Invalid := Fields.InValid_POSSIBLE_SSN((SALT33.StrType)clean_POSSIBLE_SSN);
      SELF.POSSIBLE_SSN := IF(withOnfail, clean_POSSIBLE_SSN, le.POSSIBLE_SSN); // ONFAIL(CLEAN)
    SELF.CRIME_Invalid := Fields.InValid_CRIME((SALT33.StrType)le.CRIME);
      clean_CRIME := (TYPEOF(le.CRIME))Fields.Make_CRIME((SALT33.StrType)le.CRIME);
      clean_CRIME_Invalid := Fields.InValid_CRIME((SALT33.StrType)clean_CRIME);
      SELF.CRIME := IF(withOnfail, clean_CRIME, le.CRIME); // ONFAIL(CLEAN)
    SELF.NAME_TYPE_Invalid := Fields.InValid_NAME_TYPE((SALT33.StrType)le.NAME_TYPE);
      clean_NAME_TYPE := (TYPEOF(le.NAME_TYPE))Fields.Make_NAME_TYPE((SALT33.StrType)le.NAME_TYPE);
      clean_NAME_TYPE_Invalid := Fields.InValid_NAME_TYPE((SALT33.StrType)clean_NAME_TYPE);
      SELF.NAME_TYPE := IF(withOnfail, clean_NAME_TYPE, le.NAME_TYPE); // ONFAIL(CLEAN)
    SELF.CLEAN_GENDER_Invalid := Fields.InValid_CLEAN_GENDER((SALT33.StrType)le.CLEAN_GENDER);
      clean_CLEAN_GENDER := (TYPEOF(le.CLEAN_GENDER))Fields.Make_CLEAN_GENDER((SALT33.StrType)le.CLEAN_GENDER);
      clean_CLEAN_GENDER_Invalid := Fields.InValid_CLEAN_GENDER((SALT33.StrType)clean_CLEAN_GENDER);
      SELF.CLEAN_GENDER := IF(withOnfail, clean_CLEAN_GENDER, le.CLEAN_GENDER); // ONFAIL(CLEAN)
    SELF.CLASS_CODE_Invalid := Fields.InValid_CLASS_CODE((SALT33.StrType)le.CLASS_CODE);
      clean_CLASS_CODE := (TYPEOF(le.CLASS_CODE))Fields.Make_CLASS_CODE((SALT33.StrType)le.CLASS_CODE);
      clean_CLASS_CODE_Invalid := Fields.InValid_CLASS_CODE((SALT33.StrType)clean_CLASS_CODE);
      SELF.CLASS_CODE := IF(withOnfail, clean_CLASS_CODE, le.CLASS_CODE); // ONFAIL(CLEAN)
    SELF.DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT33.StrType)le.DT_FIRST_SEEN);
      clean_DT_FIRST_SEEN := (TYPEOF(le.DT_FIRST_SEEN))Fields.Make_DT_FIRST_SEEN((SALT33.StrType)le.DT_FIRST_SEEN);
      clean_DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT33.StrType)clean_DT_FIRST_SEEN);
      SELF.DT_FIRST_SEEN := IF(withOnfail, clean_DT_FIRST_SEEN, le.DT_FIRST_SEEN); // ONFAIL(CLEAN)
    SELF.DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT33.StrType)le.DT_LAST_SEEN);
      clean_DT_LAST_SEEN := (TYPEOF(le.DT_LAST_SEEN))Fields.Make_DT_LAST_SEEN((SALT33.StrType)le.DT_LAST_SEEN);
      clean_DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT33.StrType)clean_DT_LAST_SEEN);
      SELF.DT_LAST_SEEN := IF(withOnfail, clean_DT_LAST_SEEN, le.DT_LAST_SEEN); // ONFAIL(CLEAN)
    SELF.DATA_PROVIDER_ORI_Invalid := Fields.InValid_DATA_PROVIDER_ORI((SALT33.StrType)le.DATA_PROVIDER_ORI);
      clean_DATA_PROVIDER_ORI := (TYPEOF(le.DATA_PROVIDER_ORI))Fields.Make_DATA_PROVIDER_ORI((SALT33.StrType)le.DATA_PROVIDER_ORI);
      clean_DATA_PROVIDER_ORI_Invalid := Fields.InValid_DATA_PROVIDER_ORI((SALT33.StrType)clean_DATA_PROVIDER_ORI);
      SELF.DATA_PROVIDER_ORI := IF(withOnfail, clean_DATA_PROVIDER_ORI, le.DATA_PROVIDER_ORI); // ONFAIL(CLEAN)
    SELF.VIN_Invalid := Fields.InValid_VIN((SALT33.StrType)le.VIN);
      clean_VIN := (TYPEOF(le.VIN))Fields.Make_VIN((SALT33.StrType)le.VIN);
      clean_VIN_Invalid := Fields.InValid_VIN((SALT33.StrType)clean_VIN);
      SELF.VIN := IF(withOnfail, clean_VIN, le.VIN); // ONFAIL(CLEAN)
    SELF.PLATE_Invalid := Fields.InValid_PLATE((SALT33.StrType)le.PLATE);
      clean_PLATE := (TYPEOF(le.PLATE))Fields.Make_PLATE((SALT33.StrType)le.PLATE);
      clean_PLATE_Invalid := Fields.InValid_PLATE((SALT33.StrType)clean_PLATE);
      SELF.PLATE := IF(withOnfail, clean_PLATE, le.PLATE); // ONFAIL(CLEAN)
    SELF.LATITUDE_Invalid := Fields.InValid_LATITUDE((SALT33.StrType)le.LATITUDE);
      clean_LATITUDE := (TYPEOF(le.LATITUDE))Fields.Make_LATITUDE((SALT33.StrType)le.LATITUDE);
      clean_LATITUDE_Invalid := Fields.InValid_LATITUDE((SALT33.StrType)clean_LATITUDE);
      SELF.LATITUDE := IF(withOnfail, clean_LATITUDE, le.LATITUDE); // ONFAIL(CLEAN)
    SELF.LONGITUDE_Invalid := Fields.InValid_LONGITUDE((SALT33.StrType)le.LONGITUDE);
      clean_LONGITUDE := (TYPEOF(le.LONGITUDE))Fields.Make_LONGITUDE((SALT33.StrType)le.LONGITUDE);
      clean_LONGITUDE_Invalid := Fields.InValid_LONGITUDE((SALT33.StrType)clean_LONGITUDE);
      SELF.LONGITUDE := IF(withOnfail, clean_LONGITUDE, le.LONGITUDE); // ONFAIL(CLEAN)
    SELF.SEARCH_ADDR1_Invalid := Fields.InValid_SEARCH_ADDR1((SALT33.StrType)le.SEARCH_ADDR1);
      clean_SEARCH_ADDR1 := (TYPEOF(le.SEARCH_ADDR1))Fields.Make_SEARCH_ADDR1((SALT33.StrType)le.SEARCH_ADDR1);
      clean_SEARCH_ADDR1_Invalid := Fields.InValid_SEARCH_ADDR1((SALT33.StrType)clean_SEARCH_ADDR1);
      SELF.SEARCH_ADDR1 := IF(withOnfail, clean_SEARCH_ADDR1, le.SEARCH_ADDR1); // ONFAIL(CLEAN)
    SELF.SEARCH_ADDR2_Invalid := Fields.InValid_SEARCH_ADDR2((SALT33.StrType)le.SEARCH_ADDR2);
      clean_SEARCH_ADDR2 := (TYPEOF(le.SEARCH_ADDR2))Fields.Make_SEARCH_ADDR2((SALT33.StrType)le.SEARCH_ADDR2);
      clean_SEARCH_ADDR2_Invalid := Fields.InValid_SEARCH_ADDR2((SALT33.StrType)clean_SEARCH_ADDR2);
      SELF.SEARCH_ADDR2 := IF(withOnfail, clean_SEARCH_ADDR2, le.SEARCH_ADDR2); // ONFAIL(CLEAN)
    SELF.CLEAN_COMPANY_NAME_Invalid := Fields.InValid_CLEAN_COMPANY_NAME((SALT33.StrType)le.CLEAN_COMPANY_NAME);
      clean_CLEAN_COMPANY_NAME := (TYPEOF(le.CLEAN_COMPANY_NAME))Fields.Make_CLEAN_COMPANY_NAME((SALT33.StrType)le.CLEAN_COMPANY_NAME);
      clean_CLEAN_COMPANY_NAME_Invalid := Fields.InValid_CLEAN_COMPANY_NAME((SALT33.StrType)clean_CLEAN_COMPANY_NAME);
      SELF.CLEAN_COMPANY_NAME := IF(withOnfail, clean_CLEAN_COMPANY_NAME, le.CLEAN_COMPANY_NAME); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Classify_PS);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.NAME_SUFFIX_Invalid << 0 ) + ( le.FNAME_Invalid << 2 ) + ( le.MNAME_Invalid << 4 ) + ( le.LNAME_Invalid << 6 ) + ( le.PRIM_RANGE_Invalid << 8 ) + ( le.PRIM_NAME_Invalid << 10 ) + ( le.SEC_RANGE_Invalid << 12 ) + ( le.P_CITY_NAME_Invalid << 14 ) + ( le.ST_Invalid << 16 ) + ( le.ZIP_Invalid << 18 ) + ( le.DOB_Invalid << 19 ) + ( le.PHONE_Invalid << 21 ) + ( le.DL_ST_Invalid << 22 ) + ( le.DL_Invalid << 24 ) + ( le.LEXID_Invalid << 26 ) + ( le.POSSIBLE_SSN_Invalid << 28 ) + ( le.CRIME_Invalid << 30 ) + ( le.NAME_TYPE_Invalid << 32 ) + ( le.CLEAN_GENDER_Invalid << 34 ) + ( le.CLASS_CODE_Invalid << 36 ) + ( le.DT_FIRST_SEEN_Invalid << 38 ) + ( le.DT_LAST_SEEN_Invalid << 40 ) + ( le.DATA_PROVIDER_ORI_Invalid << 42 ) + ( le.VIN_Invalid << 44 ) + ( le.PLATE_Invalid << 46 ) + ( le.LATITUDE_Invalid << 48 ) + ( le.LONGITUDE_Invalid << 50 ) + ( le.SEARCH_ADDR1_Invalid << 52 ) + ( le.SEARCH_ADDR2_Invalid << 54 ) + ( le.CLEAN_COMPANY_NAME_Invalid << 56 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Classify_PS);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.NAME_SUFFIX_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.FNAME_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.MNAME_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.LNAME_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.P_CITY_NAME_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.DOB_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.PHONE_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.DL_ST_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.DL_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.LEXID_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.POSSIBLE_SSN_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.CRIME_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.NAME_TYPE_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.CLEAN_GENDER_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.CLASS_CODE_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.DT_FIRST_SEEN_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.DT_LAST_SEEN_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.DATA_PROVIDER_ORI_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.VIN_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.PLATE_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.LATITUDE_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.LONGITUDE_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.SEARCH_ADDR1_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.SEARCH_ADDR2_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.CLEAN_COMPANY_NAME_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    NAME_SUFFIX_LEFTTRIM_ErrorCount := COUNT(GROUP,h.NAME_SUFFIX_Invalid=1);
    NAME_SUFFIX_QUOTES_ErrorCount := COUNT(GROUP,h.NAME_SUFFIX_Invalid=2);
    NAME_SUFFIX_Total_ErrorCount := COUNT(GROUP,h.NAME_SUFFIX_Invalid>0);
    FNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=1);
    FNAME_QUOTES_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=2);
    FNAME_Total_ErrorCount := COUNT(GROUP,h.FNAME_Invalid>0);
    MNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=1);
    MNAME_QUOTES_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=2);
    MNAME_Total_ErrorCount := COUNT(GROUP,h.MNAME_Invalid>0);
    LNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=1);
    LNAME_QUOTES_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=2);
    LNAME_Total_ErrorCount := COUNT(GROUP,h.LNAME_Invalid>0);
    PRIM_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1);
    PRIM_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2);
    PRIM_RANGE_Total_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid>0);
    PRIM_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1);
    PRIM_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2);
    PRIM_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid>0);
    SEC_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1);
    SEC_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2);
    SEC_RANGE_Total_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid>0);
    P_CITY_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.P_CITY_NAME_Invalid=1);
    P_CITY_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.P_CITY_NAME_Invalid=2);
    P_CITY_NAME_Total_ErrorCount := COUNT(GROUP,h.P_CITY_NAME_Invalid>0);
    ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_QUOTES_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    ZIP_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DOB_Invalid=1);
    DOB_QUOTES_ErrorCount := COUNT(GROUP,h.DOB_Invalid=2);
    DOB_Total_ErrorCount := COUNT(GROUP,h.DOB_Invalid>0);
    PHONE_ALLOW_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=1);
    DL_ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DL_ST_Invalid=1);
    DL_ST_QUOTES_ErrorCount := COUNT(GROUP,h.DL_ST_Invalid=2);
    DL_ST_Total_ErrorCount := COUNT(GROUP,h.DL_ST_Invalid>0);
    DL_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DL_Invalid=1);
    DL_QUOTES_ErrorCount := COUNT(GROUP,h.DL_Invalid=2);
    DL_Total_ErrorCount := COUNT(GROUP,h.DL_Invalid>0);
    LEXID_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LEXID_Invalid=1);
    LEXID_QUOTES_ErrorCount := COUNT(GROUP,h.LEXID_Invalid=2);
    LEXID_Total_ErrorCount := COUNT(GROUP,h.LEXID_Invalid>0);
    POSSIBLE_SSN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.POSSIBLE_SSN_Invalid=1);
    POSSIBLE_SSN_QUOTES_ErrorCount := COUNT(GROUP,h.POSSIBLE_SSN_Invalid=2);
    POSSIBLE_SSN_Total_ErrorCount := COUNT(GROUP,h.POSSIBLE_SSN_Invalid>0);
    CRIME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CRIME_Invalid=1);
    CRIME_QUOTES_ErrorCount := COUNT(GROUP,h.CRIME_Invalid=2);
    CRIME_Total_ErrorCount := COUNT(GROUP,h.CRIME_Invalid>0);
    NAME_TYPE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.NAME_TYPE_Invalid=1);
    NAME_TYPE_QUOTES_ErrorCount := COUNT(GROUP,h.NAME_TYPE_Invalid=2);
    NAME_TYPE_Total_ErrorCount := COUNT(GROUP,h.NAME_TYPE_Invalid>0);
    CLEAN_GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CLEAN_GENDER_Invalid=1);
    CLEAN_GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.CLEAN_GENDER_Invalid=2);
    CLEAN_GENDER_Total_ErrorCount := COUNT(GROUP,h.CLEAN_GENDER_Invalid>0);
    CLASS_CODE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CLASS_CODE_Invalid=1);
    CLASS_CODE_QUOTES_ErrorCount := COUNT(GROUP,h.CLASS_CODE_Invalid=2);
    CLASS_CODE_Total_ErrorCount := COUNT(GROUP,h.CLASS_CODE_Invalid>0);
    DT_FIRST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=1);
    DT_FIRST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=2);
    DT_FIRST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid>0);
    DT_LAST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=1);
    DT_LAST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=2);
    DT_LAST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid>0);
    DATA_PROVIDER_ORI_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DATA_PROVIDER_ORI_Invalid=1);
    DATA_PROVIDER_ORI_QUOTES_ErrorCount := COUNT(GROUP,h.DATA_PROVIDER_ORI_Invalid=2);
    DATA_PROVIDER_ORI_Total_ErrorCount := COUNT(GROUP,h.DATA_PROVIDER_ORI_Invalid>0);
    VIN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.VIN_Invalid=1);
    VIN_QUOTES_ErrorCount := COUNT(GROUP,h.VIN_Invalid=2);
    VIN_Total_ErrorCount := COUNT(GROUP,h.VIN_Invalid>0);
    PLATE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PLATE_Invalid=1);
    PLATE_QUOTES_ErrorCount := COUNT(GROUP,h.PLATE_Invalid=2);
    PLATE_Total_ErrorCount := COUNT(GROUP,h.PLATE_Invalid>0);
    LATITUDE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LATITUDE_Invalid=1);
    LATITUDE_QUOTES_ErrorCount := COUNT(GROUP,h.LATITUDE_Invalid=2);
    LATITUDE_Total_ErrorCount := COUNT(GROUP,h.LATITUDE_Invalid>0);
    LONGITUDE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LONGITUDE_Invalid=1);
    LONGITUDE_QUOTES_ErrorCount := COUNT(GROUP,h.LONGITUDE_Invalid=2);
    LONGITUDE_Total_ErrorCount := COUNT(GROUP,h.LONGITUDE_Invalid>0);
    SEARCH_ADDR1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR1_Invalid=1);
    SEARCH_ADDR1_QUOTES_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR1_Invalid=2);
    SEARCH_ADDR1_Total_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR1_Invalid>0);
    SEARCH_ADDR2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR2_Invalid=1);
    SEARCH_ADDR2_QUOTES_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR2_Invalid=2);
    SEARCH_ADDR2_Total_ErrorCount := COUNT(GROUP,h.SEARCH_ADDR2_Invalid>0);
    CLEAN_COMPANY_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CLEAN_COMPANY_NAME_Invalid=1);
    CLEAN_COMPANY_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.CLEAN_COMPANY_NAME_Invalid=2);
    CLEAN_COMPANY_NAME_Total_ErrorCount := COUNT(GROUP,h.CLEAN_COMPANY_NAME_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.NAME_SUFFIX_Invalid,le.FNAME_Invalid,le.MNAME_Invalid,le.LNAME_Invalid,le.PRIM_RANGE_Invalid,le.PRIM_NAME_Invalid,le.SEC_RANGE_Invalid,le.P_CITY_NAME_Invalid,le.ST_Invalid,le.ZIP_Invalid,le.DOB_Invalid,le.PHONE_Invalid,le.DL_ST_Invalid,le.DL_Invalid,le.LEXID_Invalid,le.POSSIBLE_SSN_Invalid,le.CRIME_Invalid,le.NAME_TYPE_Invalid,le.CLEAN_GENDER_Invalid,le.CLASS_CODE_Invalid,le.DT_FIRST_SEEN_Invalid,le.DT_LAST_SEEN_Invalid,le.DATA_PROVIDER_ORI_Invalid,le.VIN_Invalid,le.PLATE_Invalid,le.LATITUDE_Invalid,le.LONGITUDE_Invalid,le.SEARCH_ADDR1_Invalid,le.SEARCH_ADDR2_Invalid,le.CLEAN_COMPANY_NAME_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_NAME_SUFFIX(le.NAME_SUFFIX_Invalid),Fields.InvalidMessage_FNAME(le.FNAME_Invalid),Fields.InvalidMessage_MNAME(le.MNAME_Invalid),Fields.InvalidMessage_LNAME(le.LNAME_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_P_CITY_NAME(le.P_CITY_NAME_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_DOB(le.DOB_Invalid),Fields.InvalidMessage_PHONE(le.PHONE_Invalid),Fields.InvalidMessage_DL_ST(le.DL_ST_Invalid),Fields.InvalidMessage_DL(le.DL_Invalid),Fields.InvalidMessage_LEXID(le.LEXID_Invalid),Fields.InvalidMessage_POSSIBLE_SSN(le.POSSIBLE_SSN_Invalid),Fields.InvalidMessage_CRIME(le.CRIME_Invalid),Fields.InvalidMessage_NAME_TYPE(le.NAME_TYPE_Invalid),Fields.InvalidMessage_CLEAN_GENDER(le.CLEAN_GENDER_Invalid),Fields.InvalidMessage_CLASS_CODE(le.CLASS_CODE_Invalid),Fields.InvalidMessage_DT_FIRST_SEEN(le.DT_FIRST_SEEN_Invalid),Fields.InvalidMessage_DT_LAST_SEEN(le.DT_LAST_SEEN_Invalid),Fields.InvalidMessage_DATA_PROVIDER_ORI(le.DATA_PROVIDER_ORI_Invalid),Fields.InvalidMessage_VIN(le.VIN_Invalid),Fields.InvalidMessage_PLATE(le.PLATE_Invalid),Fields.InvalidMessage_LATITUDE(le.LATITUDE_Invalid),Fields.InvalidMessage_LONGITUDE(le.LONGITUDE_Invalid),Fields.InvalidMessage_SEARCH_ADDR1(le.SEARCH_ADDR1_Invalid),Fields.InvalidMessage_SEARCH_ADDR2(le.SEARCH_ADDR2_Invalid),Fields.InvalidMessage_CLEAN_COMPANY_NAME(le.CLEAN_COMPANY_NAME_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.NAME_SUFFIX_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.P_CITY_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PHONE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.DL_ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DL_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LEXID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.POSSIBLE_SSN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CRIME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.NAME_TYPE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CLEAN_GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CLASS_CODE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_FIRST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LAST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DATA_PROVIDER_ORI_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.VIN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PLATE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LATITUDE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LONGITUDE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEARCH_ADDR1_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEARCH_ADDR2_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CLEAN_COMPANY_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'NAME_SUFFIX','FNAME','MNAME','LNAME','PRIM_RANGE','PRIM_NAME','SEC_RANGE','P_CITY_NAME','ST','ZIP','DOB','PHONE','DL_ST','DL','LEXID','POSSIBLE_SSN','CRIME','NAME_TYPE','CLEAN_GENDER','CLASS_CODE','DT_FIRST_SEEN','DT_LAST_SEEN','DATA_PROVIDER_ORI','VIN','PLATE','LATITUDE','LONGITUDE','SEARCH_ADDR1','SEARCH_ADDR2','CLEAN_COMPANY_NAME','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.NAME_SUFFIX,(SALT33.StrType)le.FNAME,(SALT33.StrType)le.MNAME,(SALT33.StrType)le.LNAME,(SALT33.StrType)le.PRIM_RANGE,(SALT33.StrType)le.PRIM_NAME,(SALT33.StrType)le.SEC_RANGE,(SALT33.StrType)le.P_CITY_NAME,(SALT33.StrType)le.ST,(SALT33.StrType)le.ZIP,(SALT33.StrType)le.DOB,(SALT33.StrType)le.PHONE,(SALT33.StrType)le.DL_ST,(SALT33.StrType)le.DL,(SALT33.StrType)le.LEXID,(SALT33.StrType)le.POSSIBLE_SSN,(SALT33.StrType)le.CRIME,(SALT33.StrType)le.NAME_TYPE,(SALT33.StrType)le.CLEAN_GENDER,(SALT33.StrType)le.CLASS_CODE,(SALT33.StrType)le.DT_FIRST_SEEN,(SALT33.StrType)le.DT_LAST_SEEN,(SALT33.StrType)le.DATA_PROVIDER_ORI,(SALT33.StrType)le.VIN,(SALT33.StrType)le.PLATE,(SALT33.StrType)le.LATITUDE,(SALT33.StrType)le.LONGITUDE,(SALT33.StrType)le.SEARCH_ADDR1,(SALT33.StrType)le.SEARCH_ADDR2,(SALT33.StrType)le.CLEAN_COMPANY_NAME,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,30,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'NAME_SUFFIX:DEFAULT:LEFTTRIM','NAME_SUFFIX:DEFAULT:QUOTES'
          ,'FNAME:DEFAULT:LEFTTRIM','FNAME:DEFAULT:QUOTES'
          ,'MNAME:DEFAULT:LEFTTRIM','MNAME:DEFAULT:QUOTES'
          ,'LNAME:DEFAULT:LEFTTRIM','LNAME:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'P_CITY_NAME:DEFAULT:LEFTTRIM','P_CITY_NAME:DEFAULT:QUOTES'
          ,'ST:DEFAULT:LEFTTRIM','ST:DEFAULT:QUOTES'
          ,'ZIP:NUMBER:ALLOW'
          ,'DOB:DEFAULT:LEFTTRIM','DOB:DEFAULT:QUOTES'
          ,'PHONE:NUMBER:ALLOW'
          ,'DL_ST:DEFAULT:LEFTTRIM','DL_ST:DEFAULT:QUOTES'
          ,'DL:DEFAULT:LEFTTRIM','DL:DEFAULT:QUOTES'
          ,'LEXID:DEFAULT:LEFTTRIM','LEXID:DEFAULT:QUOTES'
          ,'POSSIBLE_SSN:DEFAULT:LEFTTRIM','POSSIBLE_SSN:DEFAULT:QUOTES'
          ,'CRIME:DEFAULT:LEFTTRIM','CRIME:DEFAULT:QUOTES'
          ,'NAME_TYPE:DEFAULT:LEFTTRIM','NAME_TYPE:DEFAULT:QUOTES'
          ,'CLEAN_GENDER:DEFAULT:LEFTTRIM','CLEAN_GENDER:DEFAULT:QUOTES'
          ,'CLASS_CODE:DEFAULT:LEFTTRIM','CLASS_CODE:DEFAULT:QUOTES'
          ,'DT_FIRST_SEEN:DEFAULT:LEFTTRIM','DT_FIRST_SEEN:DEFAULT:QUOTES'
          ,'DT_LAST_SEEN:DEFAULT:LEFTTRIM','DT_LAST_SEEN:DEFAULT:QUOTES'
          ,'DATA_PROVIDER_ORI:DEFAULT:LEFTTRIM','DATA_PROVIDER_ORI:DEFAULT:QUOTES'
          ,'VIN:DEFAULT:LEFTTRIM','VIN:DEFAULT:QUOTES'
          ,'PLATE:DEFAULT:LEFTTRIM','PLATE:DEFAULT:QUOTES'
          ,'LATITUDE:DEFAULT:LEFTTRIM','LATITUDE:DEFAULT:QUOTES'
          ,'LONGITUDE:DEFAULT:LEFTTRIM','LONGITUDE:DEFAULT:QUOTES'
          ,'SEARCH_ADDR1:DEFAULT:LEFTTRIM','SEARCH_ADDR1:DEFAULT:QUOTES'
          ,'SEARCH_ADDR2:DEFAULT:LEFTTRIM','SEARCH_ADDR2:DEFAULT:QUOTES'
          ,'CLEAN_COMPANY_NAME:DEFAULT:LEFTTRIM','CLEAN_COMPANY_NAME:DEFAULT:QUOTES','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_NAME_SUFFIX(1),Fields.InvalidMessage_NAME_SUFFIX(2)
          ,Fields.InvalidMessage_FNAME(1),Fields.InvalidMessage_FNAME(2)
          ,Fields.InvalidMessage_MNAME(1),Fields.InvalidMessage_MNAME(2)
          ,Fields.InvalidMessage_LNAME(1),Fields.InvalidMessage_LNAME(2)
          ,Fields.InvalidMessage_PRIM_RANGE(1),Fields.InvalidMessage_PRIM_RANGE(2)
          ,Fields.InvalidMessage_PRIM_NAME(1),Fields.InvalidMessage_PRIM_NAME(2)
          ,Fields.InvalidMessage_SEC_RANGE(1),Fields.InvalidMessage_SEC_RANGE(2)
          ,Fields.InvalidMessage_P_CITY_NAME(1),Fields.InvalidMessage_P_CITY_NAME(2)
          ,Fields.InvalidMessage_ST(1),Fields.InvalidMessage_ST(2)
          ,Fields.InvalidMessage_ZIP(1)
          ,Fields.InvalidMessage_DOB(1),Fields.InvalidMessage_DOB(2)
          ,Fields.InvalidMessage_PHONE(1)
          ,Fields.InvalidMessage_DL_ST(1),Fields.InvalidMessage_DL_ST(2)
          ,Fields.InvalidMessage_DL(1),Fields.InvalidMessage_DL(2)
          ,Fields.InvalidMessage_LEXID(1),Fields.InvalidMessage_LEXID(2)
          ,Fields.InvalidMessage_POSSIBLE_SSN(1),Fields.InvalidMessage_POSSIBLE_SSN(2)
          ,Fields.InvalidMessage_CRIME(1),Fields.InvalidMessage_CRIME(2)
          ,Fields.InvalidMessage_NAME_TYPE(1),Fields.InvalidMessage_NAME_TYPE(2)
          ,Fields.InvalidMessage_CLEAN_GENDER(1),Fields.InvalidMessage_CLEAN_GENDER(2)
          ,Fields.InvalidMessage_CLASS_CODE(1),Fields.InvalidMessage_CLASS_CODE(2)
          ,Fields.InvalidMessage_DT_FIRST_SEEN(1),Fields.InvalidMessage_DT_FIRST_SEEN(2)
          ,Fields.InvalidMessage_DT_LAST_SEEN(1),Fields.InvalidMessage_DT_LAST_SEEN(2)
          ,Fields.InvalidMessage_DATA_PROVIDER_ORI(1),Fields.InvalidMessage_DATA_PROVIDER_ORI(2)
          ,Fields.InvalidMessage_VIN(1),Fields.InvalidMessage_VIN(2)
          ,Fields.InvalidMessage_PLATE(1),Fields.InvalidMessage_PLATE(2)
          ,Fields.InvalidMessage_LATITUDE(1),Fields.InvalidMessage_LATITUDE(2)
          ,Fields.InvalidMessage_LONGITUDE(1),Fields.InvalidMessage_LONGITUDE(2)
          ,Fields.InvalidMessage_SEARCH_ADDR1(1),Fields.InvalidMessage_SEARCH_ADDR1(2)
          ,Fields.InvalidMessage_SEARCH_ADDR2(1),Fields.InvalidMessage_SEARCH_ADDR2(2)
          ,Fields.InvalidMessage_CLEAN_COMPANY_NAME(1),Fields.InvalidMessage_CLEAN_COMPANY_NAME(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.NAME_SUFFIX_LEFTTRIM_ErrorCount,le.NAME_SUFFIX_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.P_CITY_NAME_LEFTTRIM_ErrorCount,le.P_CITY_NAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_ALLOW_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.PHONE_ALLOW_ErrorCount
          ,le.DL_ST_LEFTTRIM_ErrorCount,le.DL_ST_QUOTES_ErrorCount
          ,le.DL_LEFTTRIM_ErrorCount,le.DL_QUOTES_ErrorCount
          ,le.LEXID_LEFTTRIM_ErrorCount,le.LEXID_QUOTES_ErrorCount
          ,le.POSSIBLE_SSN_LEFTTRIM_ErrorCount,le.POSSIBLE_SSN_QUOTES_ErrorCount
          ,le.CRIME_LEFTTRIM_ErrorCount,le.CRIME_QUOTES_ErrorCount
          ,le.NAME_TYPE_LEFTTRIM_ErrorCount,le.NAME_TYPE_QUOTES_ErrorCount
          ,le.CLEAN_GENDER_LEFTTRIM_ErrorCount,le.CLEAN_GENDER_QUOTES_ErrorCount
          ,le.CLASS_CODE_LEFTTRIM_ErrorCount,le.CLASS_CODE_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DATA_PROVIDER_ORI_LEFTTRIM_ErrorCount,le.DATA_PROVIDER_ORI_QUOTES_ErrorCount
          ,le.VIN_LEFTTRIM_ErrorCount,le.VIN_QUOTES_ErrorCount
          ,le.PLATE_LEFTTRIM_ErrorCount,le.PLATE_QUOTES_ErrorCount
          ,le.LATITUDE_LEFTTRIM_ErrorCount,le.LATITUDE_QUOTES_ErrorCount
          ,le.LONGITUDE_LEFTTRIM_ErrorCount,le.LONGITUDE_QUOTES_ErrorCount
          ,le.SEARCH_ADDR1_LEFTTRIM_ErrorCount,le.SEARCH_ADDR1_QUOTES_ErrorCount
          ,le.SEARCH_ADDR2_LEFTTRIM_ErrorCount,le.SEARCH_ADDR2_QUOTES_ErrorCount
          ,le.CLEAN_COMPANY_NAME_LEFTTRIM_ErrorCount,le.CLEAN_COMPANY_NAME_QUOTES_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.NAME_SUFFIX_LEFTTRIM_ErrorCount,le.NAME_SUFFIX_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.P_CITY_NAME_LEFTTRIM_ErrorCount,le.P_CITY_NAME_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_ALLOW_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.PHONE_ALLOW_ErrorCount
          ,le.DL_ST_LEFTTRIM_ErrorCount,le.DL_ST_QUOTES_ErrorCount
          ,le.DL_LEFTTRIM_ErrorCount,le.DL_QUOTES_ErrorCount
          ,le.LEXID_LEFTTRIM_ErrorCount,le.LEXID_QUOTES_ErrorCount
          ,le.POSSIBLE_SSN_LEFTTRIM_ErrorCount,le.POSSIBLE_SSN_QUOTES_ErrorCount
          ,le.CRIME_LEFTTRIM_ErrorCount,le.CRIME_QUOTES_ErrorCount
          ,le.NAME_TYPE_LEFTTRIM_ErrorCount,le.NAME_TYPE_QUOTES_ErrorCount
          ,le.CLEAN_GENDER_LEFTTRIM_ErrorCount,le.CLEAN_GENDER_QUOTES_ErrorCount
          ,le.CLASS_CODE_LEFTTRIM_ErrorCount,le.CLASS_CODE_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DATA_PROVIDER_ORI_LEFTTRIM_ErrorCount,le.DATA_PROVIDER_ORI_QUOTES_ErrorCount
          ,le.VIN_LEFTTRIM_ErrorCount,le.VIN_QUOTES_ErrorCount
          ,le.PLATE_LEFTTRIM_ErrorCount,le.PLATE_QUOTES_ErrorCount
          ,le.LATITUDE_LEFTTRIM_ErrorCount,le.LATITUDE_QUOTES_ErrorCount
          ,le.LONGITUDE_LEFTTRIM_ErrorCount,le.LONGITUDE_QUOTES_ErrorCount
          ,le.SEARCH_ADDR1_LEFTTRIM_ErrorCount,le.SEARCH_ADDR1_QUOTES_ErrorCount
          ,le.SEARCH_ADDR2_LEFTTRIM_ErrorCount,le.SEARCH_ADDR2_QUOTES_ErrorCount
          ,le.CLEAN_COMPANY_NAME_LEFTTRIM_ErrorCount,le.CLEAN_COMPANY_NAME_QUOTES_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,58,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
