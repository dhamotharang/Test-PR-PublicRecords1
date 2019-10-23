IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 34;
  EXPORT NumRulesFromFieldType := 34;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 17;
  EXPORT NumRulesWithPossibleEdits := 34;
  EXPORT Expanded_Layout := RECORD(Layout_HEADER)
    UNSIGNED1 LEXID_Invalid;
    BOOLEAN LEXID_wouldClean;
    UNSIGNED1 MNAME_Invalid;
    BOOLEAN MNAME_wouldClean;
    UNSIGNED1 PRIM_RANGE_Invalid;
    BOOLEAN PRIM_RANGE_wouldClean;
    UNSIGNED1 SUFFIX_Invalid;
    BOOLEAN SUFFIX_wouldClean;
    UNSIGNED1 LNAME_Invalid;
    BOOLEAN LNAME_wouldClean;
    UNSIGNED1 PRIM_NAME_Invalid;
    BOOLEAN PRIM_NAME_wouldClean;
    UNSIGNED1 FNAME_Invalid;
    BOOLEAN FNAME_wouldClean;
    UNSIGNED1 SEC_RANGE_Invalid;
    BOOLEAN SEC_RANGE_wouldClean;
    UNSIGNED1 CITY_NAME_Invalid;
    BOOLEAN CITY_NAME_wouldClean;
    UNSIGNED1 ZIP_Invalid;
    BOOLEAN ZIP_wouldClean;
    UNSIGNED1 GENDER_Invalid;
    BOOLEAN GENDER_wouldClean;
    UNSIGNED1 SRC_Invalid;
    BOOLEAN SRC_wouldClean;
    UNSIGNED1 SSN_Invalid;
    BOOLEAN SSN_wouldClean;
    UNSIGNED1 DOB_Invalid;
    BOOLEAN DOB_wouldClean;
    UNSIGNED1 ST_Invalid;
    BOOLEAN ST_wouldClean;
    UNSIGNED1 DT_FIRST_SEEN_Invalid;
    BOOLEAN DT_FIRST_SEEN_wouldClean;
    UNSIGNED1 DT_LAST_SEEN_Invalid;
    BOOLEAN DT_LAST_SEEN_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_HEADER)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
EXPORT FromNone(DATASET(Layout_HEADER) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.LEXID_Invalid := Fields.InValid_LEXID((SALT311.StrType)le.LEXID);
    clean_LEXID := (TYPEOF(le.LEXID))Fields.Make_LEXID((SALT311.StrType)le.LEXID);
    clean_LEXID_Invalid := Fields.InValid_LEXID((SALT311.StrType)clean_LEXID);
    SELF.LEXID := IF(withOnfail, clean_LEXID, le.LEXID); // ONFAIL(CLEAN)
    SELF.LEXID_wouldClean := TRIM((SALT311.StrType)le.LEXID) <> TRIM((SALT311.StrType)clean_LEXID);
    SELF.MNAME_Invalid := Fields.InValid_MNAME((SALT311.StrType)le.MNAME);
    clean_MNAME := (TYPEOF(le.MNAME))Fields.Make_MNAME((SALT311.StrType)le.MNAME);
    clean_MNAME_Invalid := Fields.InValid_MNAME((SALT311.StrType)clean_MNAME);
    SELF.MNAME := IF(withOnfail, clean_MNAME, le.MNAME); // ONFAIL(CLEAN)
    SELF.MNAME_wouldClean := TRIM((SALT311.StrType)le.MNAME) <> TRIM((SALT311.StrType)clean_MNAME);
    SELF.PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    clean_PRIM_RANGE := (TYPEOF(le.PRIM_RANGE))Fields.Make_PRIM_RANGE((SALT311.StrType)le.PRIM_RANGE);
    clean_PRIM_RANGE_Invalid := Fields.InValid_PRIM_RANGE((SALT311.StrType)clean_PRIM_RANGE);
    SELF.PRIM_RANGE := IF(withOnfail, clean_PRIM_RANGE, le.PRIM_RANGE); // ONFAIL(CLEAN)
    SELF.PRIM_RANGE_wouldClean := TRIM((SALT311.StrType)le.PRIM_RANGE) <> TRIM((SALT311.StrType)clean_PRIM_RANGE);
    SELF.SUFFIX_Invalid := Fields.InValid_SUFFIX((SALT311.StrType)le.SUFFIX);
    clean_SUFFIX := (TYPEOF(le.SUFFIX))Fields.Make_SUFFIX((SALT311.StrType)le.SUFFIX);
    clean_SUFFIX_Invalid := Fields.InValid_SUFFIX((SALT311.StrType)clean_SUFFIX);
    SELF.SUFFIX := IF(withOnfail, clean_SUFFIX, le.SUFFIX); // ONFAIL(CLEAN)
    SELF.SUFFIX_wouldClean := TRIM((SALT311.StrType)le.SUFFIX) <> TRIM((SALT311.StrType)clean_SUFFIX);
    SELF.LNAME_Invalid := Fields.InValid_LNAME((SALT311.StrType)le.LNAME);
    clean_LNAME := (TYPEOF(le.LNAME))Fields.Make_LNAME((SALT311.StrType)le.LNAME);
    clean_LNAME_Invalid := Fields.InValid_LNAME((SALT311.StrType)clean_LNAME);
    SELF.LNAME := IF(withOnfail, clean_LNAME, le.LNAME); // ONFAIL(CLEAN)
    SELF.LNAME_wouldClean := TRIM((SALT311.StrType)le.LNAME) <> TRIM((SALT311.StrType)clean_LNAME);
    SELF.PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    clean_PRIM_NAME := (TYPEOF(le.PRIM_NAME))Fields.Make_PRIM_NAME((SALT311.StrType)le.PRIM_NAME);
    clean_PRIM_NAME_Invalid := Fields.InValid_PRIM_NAME((SALT311.StrType)clean_PRIM_NAME);
    SELF.PRIM_NAME := IF(withOnfail, clean_PRIM_NAME, le.PRIM_NAME); // ONFAIL(CLEAN)
    SELF.PRIM_NAME_wouldClean := TRIM((SALT311.StrType)le.PRIM_NAME) <> TRIM((SALT311.StrType)clean_PRIM_NAME);
    SELF.FNAME_Invalid := Fields.InValid_FNAME((SALT311.StrType)le.FNAME);
    clean_FNAME := (TYPEOF(le.FNAME))Fields.Make_FNAME((SALT311.StrType)le.FNAME);
    clean_FNAME_Invalid := Fields.InValid_FNAME((SALT311.StrType)clean_FNAME);
    SELF.FNAME := IF(withOnfail, clean_FNAME, le.FNAME); // ONFAIL(CLEAN)
    SELF.FNAME_wouldClean := TRIM((SALT311.StrType)le.FNAME) <> TRIM((SALT311.StrType)clean_FNAME);
    SELF.SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    clean_SEC_RANGE := (TYPEOF(le.SEC_RANGE))Fields.Make_SEC_RANGE((SALT311.StrType)le.SEC_RANGE);
    clean_SEC_RANGE_Invalid := Fields.InValid_SEC_RANGE((SALT311.StrType)clean_SEC_RANGE);
    SELF.SEC_RANGE := IF(withOnfail, clean_SEC_RANGE, le.SEC_RANGE); // ONFAIL(CLEAN)
    SELF.SEC_RANGE_wouldClean := TRIM((SALT311.StrType)le.SEC_RANGE) <> TRIM((SALT311.StrType)clean_SEC_RANGE);
    SELF.CITY_NAME_Invalid := Fields.InValid_CITY_NAME((SALT311.StrType)le.CITY_NAME);
    clean_CITY_NAME := (TYPEOF(le.CITY_NAME))Fields.Make_CITY_NAME((SALT311.StrType)le.CITY_NAME);
    clean_CITY_NAME_Invalid := Fields.InValid_CITY_NAME((SALT311.StrType)clean_CITY_NAME);
    SELF.CITY_NAME := IF(withOnfail, clean_CITY_NAME, le.CITY_NAME); // ONFAIL(CLEAN)
    SELF.CITY_NAME_wouldClean := TRIM((SALT311.StrType)le.CITY_NAME) <> TRIM((SALT311.StrType)clean_CITY_NAME);
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT311.StrType)le.ZIP);
    clean_ZIP := (TYPEOF(le.ZIP))Fields.Make_ZIP((SALT311.StrType)le.ZIP);
    clean_ZIP_Invalid := Fields.InValid_ZIP((SALT311.StrType)clean_ZIP);
    SELF.ZIP := IF(withOnfail, clean_ZIP, le.ZIP); // ONFAIL(CLEAN)
    SELF.ZIP_wouldClean := TRIM((SALT311.StrType)le.ZIP) <> TRIM((SALT311.StrType)clean_ZIP);
    SELF.GENDER_Invalid := Fields.InValid_GENDER((SALT311.StrType)le.GENDER);
    clean_GENDER := (TYPEOF(le.GENDER))Fields.Make_GENDER((SALT311.StrType)le.GENDER);
    clean_GENDER_Invalid := Fields.InValid_GENDER((SALT311.StrType)clean_GENDER);
    SELF.GENDER := IF(withOnfail, clean_GENDER, le.GENDER); // ONFAIL(CLEAN)
    SELF.GENDER_wouldClean := TRIM((SALT311.StrType)le.GENDER) <> TRIM((SALT311.StrType)clean_GENDER);
    SELF.SRC_Invalid := Fields.InValid_SRC((SALT311.StrType)le.SRC);
    clean_SRC := (TYPEOF(le.SRC))Fields.Make_SRC((SALT311.StrType)le.SRC);
    clean_SRC_Invalid := Fields.InValid_SRC((SALT311.StrType)clean_SRC);
    SELF.SRC := IF(withOnfail, clean_SRC, le.SRC); // ONFAIL(CLEAN)
    SELF.SRC_wouldClean := TRIM((SALT311.StrType)le.SRC) <> TRIM((SALT311.StrType)clean_SRC);
    SELF.SSN_Invalid := Fields.InValid_SSN((SALT311.StrType)le.SSN);
    clean_SSN := (TYPEOF(le.SSN))Fields.Make_SSN((SALT311.StrType)le.SSN);
    clean_SSN_Invalid := Fields.InValid_SSN((SALT311.StrType)clean_SSN);
    SELF.SSN := IF(withOnfail, clean_SSN, le.SSN); // ONFAIL(CLEAN)
    SELF.SSN_wouldClean := TRIM((SALT311.StrType)le.SSN) <> TRIM((SALT311.StrType)clean_SSN);
    SELF.DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)le.DOB);
    clean_DOB := (TYPEOF(le.DOB))Fields.Make_DOB((SALT311.StrType)le.DOB);
    clean_DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)clean_DOB);
    SELF.DOB := IF(withOnfail, clean_DOB, le.DOB); // ONFAIL(CLEAN)
    SELF.DOB_wouldClean := TRIM((SALT311.StrType)le.DOB) <> TRIM((SALT311.StrType)clean_DOB);
    SELF.ST_Invalid := Fields.InValid_ST((SALT311.StrType)le.ST);
    clean_ST := (TYPEOF(le.ST))Fields.Make_ST((SALT311.StrType)le.ST);
    clean_ST_Invalid := Fields.InValid_ST((SALT311.StrType)clean_ST);
    SELF.ST := IF(withOnfail, clean_ST, le.ST); // ONFAIL(CLEAN)
    SELF.ST_wouldClean := TRIM((SALT311.StrType)le.ST) <> TRIM((SALT311.StrType)clean_ST);
    SELF.DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT311.StrType)le.DT_FIRST_SEEN);
    clean_DT_FIRST_SEEN := (TYPEOF(le.DT_FIRST_SEEN))Fields.Make_DT_FIRST_SEEN((SALT311.StrType)le.DT_FIRST_SEEN);
    clean_DT_FIRST_SEEN_Invalid := Fields.InValid_DT_FIRST_SEEN((SALT311.StrType)clean_DT_FIRST_SEEN);
    SELF.DT_FIRST_SEEN := IF(withOnfail, clean_DT_FIRST_SEEN, le.DT_FIRST_SEEN); // ONFAIL(CLEAN)
    SELF.DT_FIRST_SEEN_wouldClean := TRIM((SALT311.StrType)le.DT_FIRST_SEEN) <> TRIM((SALT311.StrType)clean_DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT311.StrType)le.DT_LAST_SEEN);
    clean_DT_LAST_SEEN := (TYPEOF(le.DT_LAST_SEEN))Fields.Make_DT_LAST_SEEN((SALT311.StrType)le.DT_LAST_SEEN);
    clean_DT_LAST_SEEN_Invalid := Fields.InValid_DT_LAST_SEEN((SALT311.StrType)clean_DT_LAST_SEEN);
    SELF.DT_LAST_SEEN := IF(withOnfail, clean_DT_LAST_SEEN, le.DT_LAST_SEEN); // ONFAIL(CLEAN)
    SELF.DT_LAST_SEEN_wouldClean := TRIM((SALT311.StrType)le.DT_LAST_SEEN) <> TRIM((SALT311.StrType)clean_DT_LAST_SEEN);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_HEADER);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.LEXID_Invalid << 0 ) + ( le.MNAME_Invalid << 2 ) + ( le.PRIM_RANGE_Invalid << 4 ) + ( le.SUFFIX_Invalid << 6 ) + ( le.LNAME_Invalid << 8 ) + ( le.PRIM_NAME_Invalid << 10 ) + ( le.FNAME_Invalid << 12 ) + ( le.SEC_RANGE_Invalid << 14 ) + ( le.CITY_NAME_Invalid << 16 ) + ( le.ZIP_Invalid << 18 ) + ( le.GENDER_Invalid << 20 ) + ( le.SRC_Invalid << 22 ) + ( le.SSN_Invalid << 24 ) + ( le.DOB_Invalid << 26 ) + ( le.ST_Invalid << 28 ) + ( le.DT_FIRST_SEEN_Invalid << 30 ) + ( le.DT_LAST_SEEN_Invalid << 32 );
    SELF.ScrubsCleanBits1 := ( IF(le.LEXID_wouldClean, 1, 0) << 0 ) + ( IF(le.MNAME_wouldClean, 1, 0) << 1 ) + ( IF(le.PRIM_RANGE_wouldClean, 1, 0) << 2 ) + ( IF(le.SUFFIX_wouldClean, 1, 0) << 3 ) + ( IF(le.LNAME_wouldClean, 1, 0) << 4 ) + ( IF(le.PRIM_NAME_wouldClean, 1, 0) << 5 ) + ( IF(le.FNAME_wouldClean, 1, 0) << 6 ) + ( IF(le.SEC_RANGE_wouldClean, 1, 0) << 7 ) + ( IF(le.CITY_NAME_wouldClean, 1, 0) << 8 ) + ( IF(le.ZIP_wouldClean, 1, 0) << 9 ) + ( IF(le.GENDER_wouldClean, 1, 0) << 10 ) + ( IF(le.SRC_wouldClean, 1, 0) << 11 ) + ( IF(le.SSN_wouldClean, 1, 0) << 12 ) + ( IF(le.DOB_wouldClean, 1, 0) << 13 ) + ( IF(le.ST_wouldClean, 1, 0) << 14 ) + ( IF(le.DT_FIRST_SEEN_wouldClean, 1, 0) << 15 ) + ( IF(le.DT_LAST_SEEN_wouldClean, 1, 0) << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_HEADER);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.LEXID_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.MNAME_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.SUFFIX_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.LNAME_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.FNAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.CITY_NAME_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.GENDER_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.SRC_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.SSN_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.DOB_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.DT_FIRST_SEEN_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.DT_LAST_SEEN_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.LEXID_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.MNAME_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.PRIM_RANGE_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.SUFFIX_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.LNAME_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.PRIM_NAME_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.FNAME_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.SEC_RANGE_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.CITY_NAME_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.ZIP_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.GENDER_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.SRC_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.SSN_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.DOB_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.ST_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.DT_FIRST_SEEN_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.DT_LAST_SEEN_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.RID=RIGHT.RID AND (LEFT.LEXID_Invalid <> RIGHT.LEXID_Invalid OR LEFT.MNAME_Invalid <> RIGHT.MNAME_Invalid OR LEFT.PRIM_RANGE_Invalid <> RIGHT.PRIM_RANGE_Invalid OR LEFT.SUFFIX_Invalid <> RIGHT.SUFFIX_Invalid OR LEFT.LNAME_Invalid <> RIGHT.LNAME_Invalid OR LEFT.PRIM_NAME_Invalid <> RIGHT.PRIM_NAME_Invalid OR LEFT.FNAME_Invalid <> RIGHT.FNAME_Invalid OR LEFT.SEC_RANGE_Invalid <> RIGHT.SEC_RANGE_Invalid OR LEFT.CITY_NAME_Invalid <> RIGHT.CITY_NAME_Invalid OR LEFT.ZIP_Invalid <> RIGHT.ZIP_Invalid OR LEFT.GENDER_Invalid <> RIGHT.GENDER_Invalid OR LEFT.SRC_Invalid <> RIGHT.SRC_Invalid OR LEFT.SSN_Invalid <> RIGHT.SSN_Invalid OR LEFT.DOB_Invalid <> RIGHT.DOB_Invalid OR LEFT.ST_Invalid <> RIGHT.ST_Invalid OR LEFT.DT_FIRST_SEEN_Invalid <> RIGHT.DT_FIRST_SEEN_Invalid OR LEFT.DT_LAST_SEEN_Invalid <> RIGHT.DT_LAST_SEEN_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.SRC) SRC := IF(Glob, '', h.SRC);
    TotalCnt := COUNT(GROUP); // Number of records in total
    LEXID_QUOTES_ErrorCount := COUNT(GROUP,h.LEXID_Invalid=1);
    LEXID_QUOTES_WouldModifyCount := COUNT(GROUP,h.LEXID_Invalid=1 AND h.LEXID_wouldClean);
    LEXID_ALLOW_ErrorCount := COUNT(GROUP,h.LEXID_Invalid=2);
    LEXID_ALLOW_WouldModifyCount := COUNT(GROUP,h.LEXID_Invalid=2 AND h.LEXID_wouldClean);
    LEXID_Total_ErrorCount := COUNT(GROUP,h.LEXID_Invalid>0);
    MNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=1);
    MNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.MNAME_Invalid=1 AND h.MNAME_wouldClean);
    MNAME_QUOTES_ErrorCount := COUNT(GROUP,h.MNAME_Invalid=2);
    MNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.MNAME_Invalid=2 AND h.MNAME_wouldClean);
    MNAME_Total_ErrorCount := COUNT(GROUP,h.MNAME_Invalid>0);
    PRIM_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1);
    PRIM_RANGE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=1 AND h.PRIM_RANGE_wouldClean);
    PRIM_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2);
    PRIM_RANGE_QUOTES_WouldModifyCount := COUNT(GROUP,h.PRIM_RANGE_Invalid=2 AND h.PRIM_RANGE_wouldClean);
    PRIM_RANGE_Total_ErrorCount := COUNT(GROUP,h.PRIM_RANGE_Invalid>0);
    SUFFIX_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SUFFIX_Invalid=1);
    SUFFIX_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SUFFIX_Invalid=1 AND h.SUFFIX_wouldClean);
    SUFFIX_QUOTES_ErrorCount := COUNT(GROUP,h.SUFFIX_Invalid=2);
    SUFFIX_QUOTES_WouldModifyCount := COUNT(GROUP,h.SUFFIX_Invalid=2 AND h.SUFFIX_wouldClean);
    SUFFIX_Total_ErrorCount := COUNT(GROUP,h.SUFFIX_Invalid>0);
    LNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=1);
    LNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.LNAME_Invalid=1 AND h.LNAME_wouldClean);
    LNAME_QUOTES_ErrorCount := COUNT(GROUP,h.LNAME_Invalid=2);
    LNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.LNAME_Invalid=2 AND h.LNAME_wouldClean);
    LNAME_Total_ErrorCount := COUNT(GROUP,h.LNAME_Invalid>0);
    PRIM_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1);
    PRIM_NAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.PRIM_NAME_Invalid=1 AND h.PRIM_NAME_wouldClean);
    PRIM_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2);
    PRIM_NAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.PRIM_NAME_Invalid=2 AND h.PRIM_NAME_wouldClean);
    PRIM_NAME_Total_ErrorCount := COUNT(GROUP,h.PRIM_NAME_Invalid>0);
    FNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=1);
    FNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.FNAME_Invalid=1 AND h.FNAME_wouldClean);
    FNAME_QUOTES_ErrorCount := COUNT(GROUP,h.FNAME_Invalid=2);
    FNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.FNAME_Invalid=2 AND h.FNAME_wouldClean);
    FNAME_Total_ErrorCount := COUNT(GROUP,h.FNAME_Invalid>0);
    SEC_RANGE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1);
    SEC_RANGE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SEC_RANGE_Invalid=1 AND h.SEC_RANGE_wouldClean);
    SEC_RANGE_QUOTES_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2);
    SEC_RANGE_QUOTES_WouldModifyCount := COUNT(GROUP,h.SEC_RANGE_Invalid=2 AND h.SEC_RANGE_wouldClean);
    SEC_RANGE_Total_ErrorCount := COUNT(GROUP,h.SEC_RANGE_Invalid>0);
    CITY_NAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CITY_NAME_Invalid=1);
    CITY_NAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.CITY_NAME_Invalid=1 AND h.CITY_NAME_wouldClean);
    CITY_NAME_QUOTES_ErrorCount := COUNT(GROUP,h.CITY_NAME_Invalid=2);
    CITY_NAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.CITY_NAME_Invalid=2 AND h.CITY_NAME_wouldClean);
    CITY_NAME_Total_ErrorCount := COUNT(GROUP,h.CITY_NAME_Invalid>0);
    ZIP_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    ZIP_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ZIP_Invalid=1 AND h.ZIP_wouldClean);
    ZIP_QUOTES_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=2);
    ZIP_QUOTES_WouldModifyCount := COUNT(GROUP,h.ZIP_Invalid=2 AND h.ZIP_wouldClean);
    ZIP_Total_ErrorCount := COUNT(GROUP,h.ZIP_Invalid>0);
    GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=1);
    GENDER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.GENDER_Invalid=1 AND h.GENDER_wouldClean);
    GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.GENDER_Invalid=2);
    GENDER_QUOTES_WouldModifyCount := COUNT(GROUP,h.GENDER_Invalid=2 AND h.GENDER_wouldClean);
    GENDER_Total_ErrorCount := COUNT(GROUP,h.GENDER_Invalid>0);
    SRC_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SRC_Invalid=1);
    SRC_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SRC_Invalid=1 AND h.SRC_wouldClean);
    SRC_QUOTES_ErrorCount := COUNT(GROUP,h.SRC_Invalid=2);
    SRC_QUOTES_WouldModifyCount := COUNT(GROUP,h.SRC_Invalid=2 AND h.SRC_wouldClean);
    SRC_Total_ErrorCount := COUNT(GROUP,h.SRC_Invalid>0);
    SSN_QUOTES_ErrorCount := COUNT(GROUP,h.SSN_Invalid=1);
    SSN_QUOTES_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=1 AND h.SSN_wouldClean);
    SSN_ALLOW_ErrorCount := COUNT(GROUP,h.SSN_Invalid=2);
    SSN_ALLOW_WouldModifyCount := COUNT(GROUP,h.SSN_Invalid=2 AND h.SSN_wouldClean);
    SSN_Total_ErrorCount := COUNT(GROUP,h.SSN_Invalid>0);
    DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DOB_Invalid=1);
    DOB_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=1 AND h.DOB_wouldClean);
    DOB_QUOTES_ErrorCount := COUNT(GROUP,h.DOB_Invalid=2);
    DOB_QUOTES_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=2 AND h.DOB_wouldClean);
    DOB_Total_ErrorCount := COUNT(GROUP,h.DOB_Invalid>0);
    ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=1 AND h.ST_wouldClean);
    ST_QUOTES_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_QUOTES_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=2 AND h.ST_wouldClean);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    DT_FIRST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=1);
    DT_FIRST_SEEN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=1 AND h.DT_FIRST_SEEN_wouldClean);
    DT_FIRST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=2);
    DT_FIRST_SEEN_QUOTES_WouldModifyCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid=2 AND h.DT_FIRST_SEEN_wouldClean);
    DT_FIRST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_FIRST_SEEN_Invalid>0);
    DT_LAST_SEEN_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=1);
    DT_LAST_SEEN_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=1 AND h.DT_LAST_SEEN_wouldClean);
    DT_LAST_SEEN_QUOTES_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=2);
    DT_LAST_SEEN_QUOTES_WouldModifyCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid=2 AND h.DT_LAST_SEEN_wouldClean);
    DT_LAST_SEEN_Total_ErrorCount := COUNT(GROUP,h.DT_LAST_SEEN_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.LEXID_Invalid > 0 OR h.MNAME_Invalid > 0 OR h.PRIM_RANGE_Invalid > 0 OR h.SUFFIX_Invalid > 0 OR h.LNAME_Invalid > 0 OR h.PRIM_NAME_Invalid > 0 OR h.FNAME_Invalid > 0 OR h.SEC_RANGE_Invalid > 0 OR h.CITY_NAME_Invalid > 0 OR h.ZIP_Invalid > 0 OR h.GENDER_Invalid > 0 OR h.SRC_Invalid > 0 OR h.SSN_Invalid > 0 OR h.DOB_Invalid > 0 OR h.ST_Invalid > 0 OR h.DT_FIRST_SEEN_Invalid > 0 OR h.DT_LAST_SEEN_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.LEXID_wouldClean OR h.MNAME_wouldClean OR h.PRIM_RANGE_wouldClean OR h.SUFFIX_wouldClean OR h.LNAME_wouldClean OR h.PRIM_NAME_wouldClean OR h.FNAME_wouldClean OR h.SEC_RANGE_wouldClean OR h.CITY_NAME_wouldClean OR h.ZIP_wouldClean OR h.GENDER_wouldClean OR h.SRC_wouldClean OR h.SSN_wouldClean OR h.DOB_wouldClean OR h.ST_wouldClean OR h.DT_FIRST_SEEN_wouldClean OR h.DT_LAST_SEEN_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,SRC,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.LEXID_Total_ErrorCount > 0, 1, 0) + IF(le.MNAME_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.SUFFIX_Total_ErrorCount > 0, 1, 0) + IF(le.LNAME_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_Total_ErrorCount > 0, 1, 0) + IF(le.FNAME_Total_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.CITY_NAME_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_Total_ErrorCount > 0, 1, 0) + IF(le.GENDER_Total_ErrorCount > 0, 1, 0) + IF(le.SRC_Total_ErrorCount > 0, 1, 0) + IF(le.SSN_Total_ErrorCount > 0, 1, 0) + IF(le.DOB_Total_ErrorCount > 0, 1, 0) + IF(le.ST_Total_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_Total_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.LEXID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.LEXID_ALLOW_ErrorCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.MNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SUFFIX_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SUFFIX_QUOTES_ErrorCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.LNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.FNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.FNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.CITY_NAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.CITY_NAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ZIP_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ZIP_QUOTES_ErrorCount > 0, 1, 0) + IF(le.GENDER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.GENDER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SRC_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SSN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SSN_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DOB_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ST_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_QUOTES_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.LEXID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.LEXID_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SUFFIX_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SUFFIX_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.FNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.FNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.CITY_NAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.CITY_NAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.ZIP_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ZIP_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.GENDER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.GENDER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SRC_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SSN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SSN_ALLOW_WouldModifyCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DOB_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ST_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_QUOTES_WouldModifyCount > 0, 1, 0);
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
    SELF.Src :=  le.SRC;
    UNSIGNED1 ErrNum := CHOOSE(c,le.LEXID_Invalid,le.MNAME_Invalid,le.PRIM_RANGE_Invalid,le.SUFFIX_Invalid,le.LNAME_Invalid,le.PRIM_NAME_Invalid,le.FNAME_Invalid,le.SEC_RANGE_Invalid,le.CITY_NAME_Invalid,le.ZIP_Invalid,le.GENDER_Invalid,le.SRC_Invalid,le.SSN_Invalid,le.DOB_Invalid,le.ST_Invalid,le.DT_FIRST_SEEN_Invalid,le.DT_LAST_SEEN_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_LEXID(le.LEXID_Invalid),Fields.InvalidMessage_MNAME(le.MNAME_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_SUFFIX(le.SUFFIX_Invalid),Fields.InvalidMessage_LNAME(le.LNAME_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_FNAME(le.FNAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_CITY_NAME(le.CITY_NAME_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_GENDER(le.GENDER_Invalid),Fields.InvalidMessage_SRC(le.SRC_Invalid),Fields.InvalidMessage_SSN(le.SSN_Invalid),Fields.InvalidMessage_DOB(le.DOB_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_DT_FIRST_SEEN(le.DT_FIRST_SEEN_Invalid),Fields.InvalidMessage_DT_LAST_SEEN(le.DT_LAST_SEEN_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.LEXID_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.MNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SUFFIX_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CITY_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SRC_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SSN_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_FIRST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LAST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'LEXID','MNAME','PRIM_RANGE','SUFFIX','LNAME','PRIM_NAME','FNAME','SEC_RANGE','CITY_NAME','ZIP','GENDER','SRC','SSN','DOB','ST','DT_FIRST_SEEN','DT_LAST_SEEN','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.LEXID,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.SUFFIX,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.FNAME,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.CITY_NAME,(SALT311.StrType)le.ZIP,(SALT311.StrType)le.GENDER,(SALT311.StrType)le.SRC,(SALT311.StrType)le.SSN,(SALT311.StrType)le.DOB,(SALT311.StrType)le.ST,(SALT311.StrType)le.DT_FIRST_SEEN,(SALT311.StrType)le.DT_LAST_SEEN,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_HEADER) prevDS = DATASET([], Layout_HEADER)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.SRC;
      SELF.ruledesc := CHOOSE(c
          ,'LEXID:NUMBER:QUOTES','LEXID:NUMBER:ALLOW'
          ,'MNAME:DEFAULT:LEFTTRIM','MNAME:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'SUFFIX:DEFAULT:LEFTTRIM','SUFFIX:DEFAULT:QUOTES'
          ,'LNAME:DEFAULT:LEFTTRIM','LNAME:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'FNAME:DEFAULT:LEFTTRIM','FNAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'CITY_NAME:DEFAULT:LEFTTRIM','CITY_NAME:DEFAULT:QUOTES'
          ,'ZIP:DEFAULT:LEFTTRIM','ZIP:DEFAULT:QUOTES'
          ,'GENDER:DEFAULT:LEFTTRIM','GENDER:DEFAULT:QUOTES'
          ,'SRC:DEFAULT:LEFTTRIM','SRC:DEFAULT:QUOTES'
          ,'SSN:NUMBER:QUOTES','SSN:NUMBER:ALLOW'
          ,'DOB:DEFAULT:LEFTTRIM','DOB:DEFAULT:QUOTES'
          ,'ST:DEFAULT:LEFTTRIM','ST:DEFAULT:QUOTES'
          ,'DT_FIRST_SEEN:DEFAULT:LEFTTRIM','DT_FIRST_SEEN:DEFAULT:QUOTES'
          ,'DT_LAST_SEEN:DEFAULT:LEFTTRIM','DT_LAST_SEEN:DEFAULT:QUOTES'
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
          ,Fields.InvalidMessage_LEXID(1),Fields.InvalidMessage_LEXID(2)
          ,Fields.InvalidMessage_MNAME(1),Fields.InvalidMessage_MNAME(2)
          ,Fields.InvalidMessage_PRIM_RANGE(1),Fields.InvalidMessage_PRIM_RANGE(2)
          ,Fields.InvalidMessage_SUFFIX(1),Fields.InvalidMessage_SUFFIX(2)
          ,Fields.InvalidMessage_LNAME(1),Fields.InvalidMessage_LNAME(2)
          ,Fields.InvalidMessage_PRIM_NAME(1),Fields.InvalidMessage_PRIM_NAME(2)
          ,Fields.InvalidMessage_FNAME(1),Fields.InvalidMessage_FNAME(2)
          ,Fields.InvalidMessage_SEC_RANGE(1),Fields.InvalidMessage_SEC_RANGE(2)
          ,Fields.InvalidMessage_CITY_NAME(1),Fields.InvalidMessage_CITY_NAME(2)
          ,Fields.InvalidMessage_ZIP(1),Fields.InvalidMessage_ZIP(2)
          ,Fields.InvalidMessage_GENDER(1),Fields.InvalidMessage_GENDER(2)
          ,Fields.InvalidMessage_SRC(1),Fields.InvalidMessage_SRC(2)
          ,Fields.InvalidMessage_SSN(1),Fields.InvalidMessage_SSN(2)
          ,Fields.InvalidMessage_DOB(1),Fields.InvalidMessage_DOB(2)
          ,Fields.InvalidMessage_ST(1),Fields.InvalidMessage_ST(2)
          ,Fields.InvalidMessage_DT_FIRST_SEEN(1),Fields.InvalidMessage_DT_FIRST_SEEN(2)
          ,Fields.InvalidMessage_DT_LAST_SEEN(1),Fields.InvalidMessage_DT_LAST_SEEN(2)
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
          ,le.LEXID_QUOTES_ErrorCount,le.LEXID_ALLOW_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.SUFFIX_LEFTTRIM_ErrorCount,le.SUFFIX_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.CITY_NAME_LEFTTRIM_ErrorCount,le.CITY_NAME_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SSN_QUOTES_ErrorCount,le.SSN_ALLOW_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
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
          ,le.LEXID_QUOTES_ErrorCount,le.LEXID_ALLOW_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.SUFFIX_LEFTTRIM_ErrorCount,le.SUFFIX_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.CITY_NAME_LEFTTRIM_ErrorCount,le.CITY_NAME_QUOTES_ErrorCount
          ,le.ZIP_LEFTTRIM_ErrorCount,le.ZIP_QUOTES_ErrorCount
          ,le.GENDER_LEFTTRIM_ErrorCount,le.GENDER_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SSN_QUOTES_ErrorCount,le.SSN_ALLOW_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_HEADER));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'LEXID:' + getFieldTypeText(h.LEXID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MNAME:' + getFieldTypeText(h.MNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_RANGE:' + getFieldTypeText(h.PRIM_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SUFFIX:' + getFieldTypeText(h.SUFFIX) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LNAME:' + getFieldTypeText(h.LNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_NAME:' + getFieldTypeText(h.PRIM_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FNAME:' + getFieldTypeText(h.FNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SEC_RANGE:' + getFieldTypeText(h.SEC_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CITY_NAME:' + getFieldTypeText(h.CITY_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP:' + getFieldTypeText(h.ZIP) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'GENDER:' + getFieldTypeText(h.GENDER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SRC:' + getFieldTypeText(h.SRC) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN:' + getFieldTypeText(h.SSN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DOB:' + getFieldTypeText(h.DOB) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ST:' + getFieldTypeText(h.ST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_FIRST_SEEN:' + getFieldTypeText(h.DT_FIRST_SEEN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_LAST_SEEN:' + getFieldTypeText(h.DT_LAST_SEEN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_LEXID_cnt
          ,le.populated_MNAME_cnt
          ,le.populated_PRIM_RANGE_cnt
          ,le.populated_SUFFIX_cnt
          ,le.populated_LNAME_cnt
          ,le.populated_PRIM_NAME_cnt
          ,le.populated_FNAME_cnt
          ,le.populated_SEC_RANGE_cnt
          ,le.populated_CITY_NAME_cnt
          ,le.populated_ZIP_cnt
          ,le.populated_GENDER_cnt
          ,le.populated_SRC_cnt
          ,le.populated_SSN_cnt
          ,le.populated_DOB_cnt
          ,le.populated_ST_cnt
          ,le.populated_DT_FIRST_SEEN_cnt
          ,le.populated_DT_LAST_SEEN_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_LEXID_pcnt
          ,le.populated_MNAME_pcnt
          ,le.populated_PRIM_RANGE_pcnt
          ,le.populated_SUFFIX_pcnt
          ,le.populated_LNAME_pcnt
          ,le.populated_PRIM_NAME_pcnt
          ,le.populated_FNAME_pcnt
          ,le.populated_SEC_RANGE_pcnt
          ,le.populated_CITY_NAME_pcnt
          ,le.populated_ZIP_pcnt
          ,le.populated_GENDER_pcnt
          ,le.populated_SRC_pcnt
          ,le.populated_SSN_pcnt
          ,le.populated_DOB_pcnt
          ,le.populated_ST_pcnt
          ,le.populated_DT_FIRST_SEEN_pcnt
          ,le.populated_DT_LAST_SEEN_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,17,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_HEADER));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),17,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_HEADER) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(HealthcareNoMatchHeader_InternalLinking, Fields, 'RECORDOF(scrubsSummaryOverall)', 'SRC');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, SRC, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
