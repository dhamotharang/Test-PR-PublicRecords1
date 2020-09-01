IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 44;
  EXPORT NumRulesFromFieldType := 44;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 21;
  EXPORT NumRulesWithPossibleEdits := 42;
  EXPORT Expanded_Layout := RECORD(Layout_InsuranceHeader)
    UNSIGNED1 SNAME_Invalid;
    BOOLEAN SNAME_wouldClean;
    UNSIGNED1 FNAME_Invalid;
    BOOLEAN FNAME_wouldClean;
    UNSIGNED1 MNAME_Invalid;
    BOOLEAN MNAME_wouldClean;
    UNSIGNED1 LNAME_Invalid;
    BOOLEAN LNAME_wouldClean;
    UNSIGNED1 DERIVED_GENDER_Invalid;
    BOOLEAN DERIVED_GENDER_wouldClean;
    UNSIGNED1 PRIM_RANGE_Invalid;
    BOOLEAN PRIM_RANGE_wouldClean;
    UNSIGNED1 PRIM_NAME_Invalid;
    BOOLEAN PRIM_NAME_wouldClean;
    UNSIGNED1 SEC_RANGE_Invalid;
    BOOLEAN SEC_RANGE_wouldClean;
    UNSIGNED1 CITY_Invalid;
    BOOLEAN CITY_wouldClean;
    UNSIGNED1 ST_Invalid;
    BOOLEAN ST_wouldClean;
    UNSIGNED1 ZIP_Invalid;
    UNSIGNED1 SSN5_Invalid;
    BOOLEAN SSN5_wouldClean;
    UNSIGNED1 SSN4_Invalid;
    BOOLEAN SSN4_wouldClean;
    UNSIGNED1 DOB_Invalid;
    BOOLEAN DOB_wouldClean;
    UNSIGNED1 PHONE_Invalid;
    UNSIGNED1 DL_STATE_Invalid;
    BOOLEAN DL_STATE_wouldClean;
    UNSIGNED1 DL_NBR_Invalid;
    BOOLEAN DL_NBR_wouldClean;
    UNSIGNED1 SRC_Invalid;
    BOOLEAN SRC_wouldClean;
    UNSIGNED1 SOURCE_RID_Invalid;
    BOOLEAN SOURCE_RID_wouldClean;
    UNSIGNED1 DT_FIRST_SEEN_Invalid;
    BOOLEAN DT_FIRST_SEEN_wouldClean;
    UNSIGNED1 DT_LAST_SEEN_Invalid;
    BOOLEAN DT_LAST_SEEN_wouldClean;
    UNSIGNED1 DT_EFFECTIVE_FIRST_Invalid;
    BOOLEAN DT_EFFECTIVE_FIRST_wouldClean;
    UNSIGNED1 DT_EFFECTIVE_LAST_Invalid;
    BOOLEAN DT_EFFECTIVE_LAST_wouldClean;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_InsuranceHeader)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsCleanBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_InsuranceHeader)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'SNAME:DEFAULT:LEFTTRIM','SNAME:DEFAULT:QUOTES'
          ,'FNAME:DEFAULT:LEFTTRIM','FNAME:DEFAULT:QUOTES'
          ,'MNAME:DEFAULT:LEFTTRIM','MNAME:DEFAULT:QUOTES'
          ,'LNAME:DEFAULT:LEFTTRIM','LNAME:DEFAULT:QUOTES'
          ,'DERIVED_GENDER:DEFAULT:LEFTTRIM','DERIVED_GENDER:DEFAULT:QUOTES'
          ,'PRIM_RANGE:DEFAULT:LEFTTRIM','PRIM_RANGE:DEFAULT:QUOTES'
          ,'PRIM_NAME:DEFAULT:LEFTTRIM','PRIM_NAME:DEFAULT:QUOTES'
          ,'SEC_RANGE:DEFAULT:LEFTTRIM','SEC_RANGE:DEFAULT:QUOTES'
          ,'CITY:DEFAULT:LEFTTRIM','CITY:DEFAULT:QUOTES'
          ,'ST:DEFAULT:LEFTTRIM','ST:DEFAULT:QUOTES'
          ,'ZIP:NUMBER:ALLOW'
          ,'SSN5:DEFAULT:LEFTTRIM','SSN5:DEFAULT:QUOTES'
          ,'SSN4:DEFAULT:LEFTTRIM','SSN4:DEFAULT:QUOTES'
          ,'DOB:DEFAULT:LEFTTRIM','DOB:DEFAULT:QUOTES'
          ,'PHONE:NUMBER:ALLOW'
          ,'DL_STATE:DEFAULT:LEFTTRIM','DL_STATE:DEFAULT:QUOTES'
          ,'DL_NBR:DEFAULT:LEFTTRIM','DL_NBR:DEFAULT:QUOTES'
          ,'SRC:DEFAULT:LEFTTRIM','SRC:DEFAULT:QUOTES'
          ,'SOURCE_RID:DEFAULT:LEFTTRIM','SOURCE_RID:DEFAULT:QUOTES'
          ,'DT_FIRST_SEEN:DEFAULT:LEFTTRIM','DT_FIRST_SEEN:DEFAULT:QUOTES'
          ,'DT_LAST_SEEN:DEFAULT:LEFTTRIM','DT_LAST_SEEN:DEFAULT:QUOTES'
          ,'DT_EFFECTIVE_FIRST:DEFAULT:LEFTTRIM','DT_EFFECTIVE_FIRST:DEFAULT:QUOTES'
          ,'DT_EFFECTIVE_LAST:DEFAULT:LEFTTRIM','DT_EFFECTIVE_LAST:DEFAULT:QUOTES'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY'
          ,'record:Number_Edited_Records:SUMMARY'
          ,'rule:Number_Edited_Rules:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_SNAME(1),Fields.InvalidMessage_SNAME(2)
          ,Fields.InvalidMessage_FNAME(1),Fields.InvalidMessage_FNAME(2)
          ,Fields.InvalidMessage_MNAME(1),Fields.InvalidMessage_MNAME(2)
          ,Fields.InvalidMessage_LNAME(1),Fields.InvalidMessage_LNAME(2)
          ,Fields.InvalidMessage_DERIVED_GENDER(1),Fields.InvalidMessage_DERIVED_GENDER(2)
          ,Fields.InvalidMessage_PRIM_RANGE(1),Fields.InvalidMessage_PRIM_RANGE(2)
          ,Fields.InvalidMessage_PRIM_NAME(1),Fields.InvalidMessage_PRIM_NAME(2)
          ,Fields.InvalidMessage_SEC_RANGE(1),Fields.InvalidMessage_SEC_RANGE(2)
          ,Fields.InvalidMessage_CITY(1),Fields.InvalidMessage_CITY(2)
          ,Fields.InvalidMessage_ST(1),Fields.InvalidMessage_ST(2)
          ,Fields.InvalidMessage_ZIP(1)
          ,Fields.InvalidMessage_SSN5(1),Fields.InvalidMessage_SSN5(2)
          ,Fields.InvalidMessage_SSN4(1),Fields.InvalidMessage_SSN4(2)
          ,Fields.InvalidMessage_DOB(1),Fields.InvalidMessage_DOB(2)
          ,Fields.InvalidMessage_PHONE(1)
          ,Fields.InvalidMessage_DL_STATE(1),Fields.InvalidMessage_DL_STATE(2)
          ,Fields.InvalidMessage_DL_NBR(1),Fields.InvalidMessage_DL_NBR(2)
          ,Fields.InvalidMessage_SRC(1),Fields.InvalidMessage_SRC(2)
          ,Fields.InvalidMessage_SOURCE_RID(1),Fields.InvalidMessage_SOURCE_RID(2)
          ,Fields.InvalidMessage_DT_FIRST_SEEN(1),Fields.InvalidMessage_DT_FIRST_SEEN(2)
          ,Fields.InvalidMessage_DT_LAST_SEEN(1),Fields.InvalidMessage_DT_LAST_SEEN(2)
          ,Fields.InvalidMessage_DT_EFFECTIVE_FIRST(1),Fields.InvalidMessage_DT_EFFECTIVE_FIRST(2)
          ,Fields.InvalidMessage_DT_EFFECTIVE_LAST(1),Fields.InvalidMessage_DT_EFFECTIVE_LAST(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors'
          ,'Edited records'
          ,'Rules leading to edits','UNKNOWN');
EXPORT FromNone(DATASET(Layout_InsuranceHeader) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.SNAME_Invalid := Fields.InValid_SNAME((SALT311.StrType)le.SNAME);
    clean_SNAME := (TYPEOF(le.SNAME))Fields.Make_SNAME((SALT311.StrType)le.SNAME);
    clean_SNAME_Invalid := Fields.InValid_SNAME((SALT311.StrType)clean_SNAME);
    SELF.SNAME := IF(withOnfail, clean_SNAME, le.SNAME); // ONFAIL(CLEAN)
    SELF.SNAME_wouldClean := TRIM((SALT311.StrType)le.SNAME) <> TRIM((SALT311.StrType)clean_SNAME);
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
    SELF.DERIVED_GENDER_Invalid := Fields.InValid_DERIVED_GENDER((SALT311.StrType)le.DERIVED_GENDER);
    clean_DERIVED_GENDER := (TYPEOF(le.DERIVED_GENDER))Fields.Make_DERIVED_GENDER((SALT311.StrType)le.DERIVED_GENDER);
    clean_DERIVED_GENDER_Invalid := Fields.InValid_DERIVED_GENDER((SALT311.StrType)clean_DERIVED_GENDER);
    SELF.DERIVED_GENDER := IF(withOnfail, clean_DERIVED_GENDER, le.DERIVED_GENDER); // ONFAIL(CLEAN)
    SELF.DERIVED_GENDER_wouldClean := TRIM((SALT311.StrType)le.DERIVED_GENDER) <> TRIM((SALT311.StrType)clean_DERIVED_GENDER);
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
    SELF.CITY_Invalid := Fields.InValid_CITY((SALT311.StrType)le.CITY);
    clean_CITY := (TYPEOF(le.CITY))Fields.Make_CITY((SALT311.StrType)le.CITY);
    clean_CITY_Invalid := Fields.InValid_CITY((SALT311.StrType)clean_CITY);
    SELF.CITY := IF(withOnfail, clean_CITY, le.CITY); // ONFAIL(CLEAN)
    SELF.CITY_wouldClean := TRIM((SALT311.StrType)le.CITY) <> TRIM((SALT311.StrType)clean_CITY);
    SELF.ST_Invalid := Fields.InValid_ST((SALT311.StrType)le.ST);
    clean_ST := (TYPEOF(le.ST))Fields.Make_ST((SALT311.StrType)le.ST);
    clean_ST_Invalid := Fields.InValid_ST((SALT311.StrType)clean_ST);
    SELF.ST := IF(withOnfail, clean_ST, le.ST); // ONFAIL(CLEAN)
    SELF.ST_wouldClean := TRIM((SALT311.StrType)le.ST) <> TRIM((SALT311.StrType)clean_ST);
    SELF.ZIP_Invalid := Fields.InValid_ZIP((SALT311.StrType)le.ZIP);
    SELF.SSN5_Invalid := Fields.InValid_SSN5((SALT311.StrType)le.SSN5);
    clean_SSN5 := (TYPEOF(le.SSN5))Fields.Make_SSN5((SALT311.StrType)le.SSN5);
    clean_SSN5_Invalid := Fields.InValid_SSN5((SALT311.StrType)clean_SSN5);
    SELF.SSN5 := IF(withOnfail, clean_SSN5, le.SSN5); // ONFAIL(CLEAN)
    SELF.SSN5_wouldClean := TRIM((SALT311.StrType)le.SSN5) <> TRIM((SALT311.StrType)clean_SSN5);
    SELF.SSN4_Invalid := Fields.InValid_SSN4((SALT311.StrType)le.SSN4);
    clean_SSN4 := (TYPEOF(le.SSN4))Fields.Make_SSN4((SALT311.StrType)le.SSN4);
    clean_SSN4_Invalid := Fields.InValid_SSN4((SALT311.StrType)clean_SSN4);
    SELF.SSN4 := IF(withOnfail, clean_SSN4, le.SSN4); // ONFAIL(CLEAN)
    SELF.SSN4_wouldClean := TRIM((SALT311.StrType)le.SSN4) <> TRIM((SALT311.StrType)clean_SSN4);
    SELF.DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)le.DOB);
    clean_DOB := (TYPEOF(le.DOB))Fields.Make_DOB((SALT311.StrType)le.DOB);
    clean_DOB_Invalid := Fields.InValid_DOB((SALT311.StrType)clean_DOB);
    SELF.DOB := IF(withOnfail, clean_DOB, le.DOB); // ONFAIL(CLEAN)
    SELF.DOB_wouldClean := TRIM((SALT311.StrType)le.DOB) <> TRIM((SALT311.StrType)clean_DOB);
    SELF.PHONE_Invalid := Fields.InValid_PHONE((SALT311.StrType)le.PHONE);
    SELF.DL_STATE_Invalid := Fields.InValid_DL_STATE((SALT311.StrType)le.DL_STATE);
    clean_DL_STATE := (TYPEOF(le.DL_STATE))Fields.Make_DL_STATE((SALT311.StrType)le.DL_STATE);
    clean_DL_STATE_Invalid := Fields.InValid_DL_STATE((SALT311.StrType)clean_DL_STATE);
    SELF.DL_STATE := IF(withOnfail, clean_DL_STATE, le.DL_STATE); // ONFAIL(CLEAN)
    SELF.DL_STATE_wouldClean := TRIM((SALT311.StrType)le.DL_STATE) <> TRIM((SALT311.StrType)clean_DL_STATE);
    SELF.DL_NBR_Invalid := Fields.InValid_DL_NBR((SALT311.StrType)le.DL_NBR);
    clean_DL_NBR := (TYPEOF(le.DL_NBR))Fields.Make_DL_NBR((SALT311.StrType)le.DL_NBR);
    clean_DL_NBR_Invalid := Fields.InValid_DL_NBR((SALT311.StrType)clean_DL_NBR);
    SELF.DL_NBR := IF(withOnfail, clean_DL_NBR, le.DL_NBR); // ONFAIL(CLEAN)
    SELF.DL_NBR_wouldClean := TRIM((SALT311.StrType)le.DL_NBR) <> TRIM((SALT311.StrType)clean_DL_NBR);
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
    SELF.DT_EFFECTIVE_FIRST_Invalid := Fields.InValid_DT_EFFECTIVE_FIRST((SALT311.StrType)le.DT_EFFECTIVE_FIRST);
    clean_DT_EFFECTIVE_FIRST := (TYPEOF(le.DT_EFFECTIVE_FIRST))Fields.Make_DT_EFFECTIVE_FIRST((SALT311.StrType)le.DT_EFFECTIVE_FIRST);
    clean_DT_EFFECTIVE_FIRST_Invalid := Fields.InValid_DT_EFFECTIVE_FIRST((SALT311.StrType)clean_DT_EFFECTIVE_FIRST);
    SELF.DT_EFFECTIVE_FIRST := IF(withOnfail, clean_DT_EFFECTIVE_FIRST, le.DT_EFFECTIVE_FIRST); // ONFAIL(CLEAN)
    SELF.DT_EFFECTIVE_FIRST_wouldClean := TRIM((SALT311.StrType)le.DT_EFFECTIVE_FIRST) <> TRIM((SALT311.StrType)clean_DT_EFFECTIVE_FIRST);
    SELF.DT_EFFECTIVE_LAST_Invalid := Fields.InValid_DT_EFFECTIVE_LAST((SALT311.StrType)le.DT_EFFECTIVE_LAST);
    clean_DT_EFFECTIVE_LAST := (TYPEOF(le.DT_EFFECTIVE_LAST))Fields.Make_DT_EFFECTIVE_LAST((SALT311.StrType)le.DT_EFFECTIVE_LAST);
    clean_DT_EFFECTIVE_LAST_Invalid := Fields.InValid_DT_EFFECTIVE_LAST((SALT311.StrType)clean_DT_EFFECTIVE_LAST);
    SELF.DT_EFFECTIVE_LAST := IF(withOnfail, clean_DT_EFFECTIVE_LAST, le.DT_EFFECTIVE_LAST); // ONFAIL(CLEAN)
    SELF.DT_EFFECTIVE_LAST_wouldClean := TRIM((SALT311.StrType)le.DT_EFFECTIVE_LAST) <> TRIM((SALT311.StrType)clean_DT_EFFECTIVE_LAST);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_InsuranceHeader);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.SNAME_Invalid << 0 ) + ( le.FNAME_Invalid << 2 ) + ( le.MNAME_Invalid << 4 ) + ( le.LNAME_Invalid << 6 ) + ( le.DERIVED_GENDER_Invalid << 8 ) + ( le.PRIM_RANGE_Invalid << 10 ) + ( le.PRIM_NAME_Invalid << 12 ) + ( le.SEC_RANGE_Invalid << 14 ) + ( le.CITY_Invalid << 16 ) + ( le.ST_Invalid << 18 ) + ( le.ZIP_Invalid << 20 ) + ( le.SSN5_Invalid << 21 ) + ( le.SSN4_Invalid << 23 ) + ( le.DOB_Invalid << 25 ) + ( le.PHONE_Invalid << 27 ) + ( le.DL_STATE_Invalid << 28 ) + ( le.DL_NBR_Invalid << 30 ) + ( le.SRC_Invalid << 32 ) + ( le.SOURCE_RID_Invalid << 34 ) + ( le.DT_FIRST_SEEN_Invalid << 36 ) + ( le.DT_LAST_SEEN_Invalid << 38 ) + ( le.DT_EFFECTIVE_FIRST_Invalid << 40 ) + ( le.DT_EFFECTIVE_LAST_Invalid << 42 );
    SELF.ScrubsCleanBits1 := ( IF(le.SNAME_wouldClean, 1, 0) << 0 ) + ( IF(le.FNAME_wouldClean, 1, 0) << 1 ) + ( IF(le.MNAME_wouldClean, 1, 0) << 2 ) + ( IF(le.LNAME_wouldClean, 1, 0) << 3 ) + ( IF(le.DERIVED_GENDER_wouldClean, 1, 0) << 4 ) + ( IF(le.PRIM_RANGE_wouldClean, 1, 0) << 5 ) + ( IF(le.PRIM_NAME_wouldClean, 1, 0) << 6 ) + ( IF(le.SEC_RANGE_wouldClean, 1, 0) << 7 ) + ( IF(le.CITY_wouldClean, 1, 0) << 8 ) + ( IF(le.ST_wouldClean, 1, 0) << 9 ) + ( IF(le.SSN5_wouldClean, 1, 0) << 10 ) + ( IF(le.SSN4_wouldClean, 1, 0) << 11 ) + ( IF(le.DOB_wouldClean, 1, 0) << 12 ) + ( IF(le.DL_STATE_wouldClean, 1, 0) << 13 ) + ( IF(le.DL_NBR_wouldClean, 1, 0) << 14 ) + ( IF(le.SRC_wouldClean, 1, 0) << 15 ) + ( IF(le.SOURCE_RID_wouldClean, 1, 0) << 16 ) + ( IF(le.DT_FIRST_SEEN_wouldClean, 1, 0) << 17 ) + ( IF(le.DT_LAST_SEEN_wouldClean, 1, 0) << 18 ) + ( IF(le.DT_EFFECTIVE_FIRST_wouldClean, 1, 0) << 19 ) + ( IF(le.DT_EFFECTIVE_LAST_wouldClean, 1, 0) << 20 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_InsuranceHeader);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.SNAME_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.FNAME_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.MNAME_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.LNAME_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.DERIVED_GENDER_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.PRIM_RANGE_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.PRIM_NAME_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.SEC_RANGE_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.CITY_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.ST_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.ZIP_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.SSN5_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.SSN4_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.DOB_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.PHONE_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.DL_STATE_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.DL_NBR_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.SRC_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.SOURCE_RID_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.DT_FIRST_SEEN_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.DT_LAST_SEEN_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.DT_EFFECTIVE_FIRST_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.DT_EFFECTIVE_LAST_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.SNAME_wouldClean := le.ScrubsCleanBits1 >> 0;
    SELF.FNAME_wouldClean := le.ScrubsCleanBits1 >> 1;
    SELF.MNAME_wouldClean := le.ScrubsCleanBits1 >> 2;
    SELF.LNAME_wouldClean := le.ScrubsCleanBits1 >> 3;
    SELF.DERIVED_GENDER_wouldClean := le.ScrubsCleanBits1 >> 4;
    SELF.PRIM_RANGE_wouldClean := le.ScrubsCleanBits1 >> 5;
    SELF.PRIM_NAME_wouldClean := le.ScrubsCleanBits1 >> 6;
    SELF.SEC_RANGE_wouldClean := le.ScrubsCleanBits1 >> 7;
    SELF.CITY_wouldClean := le.ScrubsCleanBits1 >> 8;
    SELF.ST_wouldClean := le.ScrubsCleanBits1 >> 9;
    SELF.SSN5_wouldClean := le.ScrubsCleanBits1 >> 10;
    SELF.SSN4_wouldClean := le.ScrubsCleanBits1 >> 11;
    SELF.DOB_wouldClean := le.ScrubsCleanBits1 >> 12;
    SELF.DL_STATE_wouldClean := le.ScrubsCleanBits1 >> 13;
    SELF.DL_NBR_wouldClean := le.ScrubsCleanBits1 >> 14;
    SELF.SRC_wouldClean := le.ScrubsCleanBits1 >> 15;
    SELF.SOURCE_RID_wouldClean := le.ScrubsCleanBits1 >> 16;
    SELF.DT_FIRST_SEEN_wouldClean := le.ScrubsCleanBits1 >> 17;
    SELF.DT_LAST_SEEN_wouldClean := le.ScrubsCleanBits1 >> 18;
    SELF.DT_EFFECTIVE_FIRST_wouldClean := le.ScrubsCleanBits1 >> 19;
    SELF.DT_EFFECTIVE_LAST_wouldClean := le.ScrubsCleanBits1 >> 20;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.RID=RIGHT.RID AND (LEFT.SNAME_Invalid <> RIGHT.SNAME_Invalid OR LEFT.FNAME_Invalid <> RIGHT.FNAME_Invalid OR LEFT.MNAME_Invalid <> RIGHT.MNAME_Invalid OR LEFT.LNAME_Invalid <> RIGHT.LNAME_Invalid OR LEFT.DERIVED_GENDER_Invalid <> RIGHT.DERIVED_GENDER_Invalid OR LEFT.PRIM_RANGE_Invalid <> RIGHT.PRIM_RANGE_Invalid OR LEFT.PRIM_NAME_Invalid <> RIGHT.PRIM_NAME_Invalid OR LEFT.SEC_RANGE_Invalid <> RIGHT.SEC_RANGE_Invalid OR LEFT.CITY_Invalid <> RIGHT.CITY_Invalid OR LEFT.ST_Invalid <> RIGHT.ST_Invalid OR LEFT.ZIP_Invalid <> RIGHT.ZIP_Invalid OR LEFT.SSN5_Invalid <> RIGHT.SSN5_Invalid OR LEFT.SSN4_Invalid <> RIGHT.SSN4_Invalid OR LEFT.DOB_Invalid <> RIGHT.DOB_Invalid OR LEFT.PHONE_Invalid <> RIGHT.PHONE_Invalid OR LEFT.DL_STATE_Invalid <> RIGHT.DL_STATE_Invalid OR LEFT.DL_NBR_Invalid <> RIGHT.DL_NBR_Invalid OR LEFT.SRC_Invalid <> RIGHT.SRC_Invalid OR LEFT.SOURCE_RID_Invalid <> RIGHT.SOURCE_RID_Invalid OR LEFT.DT_FIRST_SEEN_Invalid <> RIGHT.DT_FIRST_SEEN_Invalid OR LEFT.DT_LAST_SEEN_Invalid <> RIGHT.DT_LAST_SEEN_Invalid OR LEFT.DT_EFFECTIVE_FIRST_Invalid <> RIGHT.DT_EFFECTIVE_FIRST_Invalid OR LEFT.DT_EFFECTIVE_LAST_Invalid <> RIGHT.DT_EFFECTIVE_LAST_Invalid), TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.SRC) SRC := IF(Glob, '', h.SRC);
    TotalCnt := COUNT(GROUP); // Number of records in total
    SNAME_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=1);
    SNAME_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SNAME_Invalid=1 AND h.SNAME_wouldClean);
    SNAME_QUOTES_ErrorCount := COUNT(GROUP,h.SNAME_Invalid=2);
    SNAME_QUOTES_WouldModifyCount := COUNT(GROUP,h.SNAME_Invalid=2 AND h.SNAME_wouldClean);
    SNAME_Total_ErrorCount := COUNT(GROUP,h.SNAME_Invalid>0);
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
    DERIVED_GENDER_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=1);
    DERIVED_GENDER_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=1 AND h.DERIVED_GENDER_wouldClean);
    DERIVED_GENDER_QUOTES_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=2);
    DERIVED_GENDER_QUOTES_WouldModifyCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid=2 AND h.DERIVED_GENDER_wouldClean);
    DERIVED_GENDER_Total_ErrorCount := COUNT(GROUP,h.DERIVED_GENDER_Invalid>0);
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
    CITY_LEFTTRIM_ErrorCount := COUNT(GROUP,h.CITY_Invalid=1);
    CITY_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.CITY_Invalid=1 AND h.CITY_wouldClean);
    CITY_QUOTES_ErrorCount := COUNT(GROUP,h.CITY_Invalid=2);
    CITY_QUOTES_WouldModifyCount := COUNT(GROUP,h.CITY_Invalid=2 AND h.CITY_wouldClean);
    CITY_Total_ErrorCount := COUNT(GROUP,h.CITY_Invalid>0);
    ST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ST_Invalid=1);
    ST_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=1 AND h.ST_wouldClean);
    ST_QUOTES_ErrorCount := COUNT(GROUP,h.ST_Invalid=2);
    ST_QUOTES_WouldModifyCount := COUNT(GROUP,h.ST_Invalid=2 AND h.ST_wouldClean);
    ST_Total_ErrorCount := COUNT(GROUP,h.ST_Invalid>0);
    ZIP_ALLOW_ErrorCount := COUNT(GROUP,h.ZIP_Invalid=1);
    SSN5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SSN5_Invalid=1);
    SSN5_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SSN5_Invalid=1 AND h.SSN5_wouldClean);
    SSN5_QUOTES_ErrorCount := COUNT(GROUP,h.SSN5_Invalid=2);
    SSN5_QUOTES_WouldModifyCount := COUNT(GROUP,h.SSN5_Invalid=2 AND h.SSN5_wouldClean);
    SSN5_Total_ErrorCount := COUNT(GROUP,h.SSN5_Invalid>0);
    SSN4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.SSN4_Invalid=1);
    SSN4_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.SSN4_Invalid=1 AND h.SSN4_wouldClean);
    SSN4_QUOTES_ErrorCount := COUNT(GROUP,h.SSN4_Invalid=2);
    SSN4_QUOTES_WouldModifyCount := COUNT(GROUP,h.SSN4_Invalid=2 AND h.SSN4_wouldClean);
    SSN4_Total_ErrorCount := COUNT(GROUP,h.SSN4_Invalid>0);
    DOB_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DOB_Invalid=1);
    DOB_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=1 AND h.DOB_wouldClean);
    DOB_QUOTES_ErrorCount := COUNT(GROUP,h.DOB_Invalid=2);
    DOB_QUOTES_WouldModifyCount := COUNT(GROUP,h.DOB_Invalid=2 AND h.DOB_wouldClean);
    DOB_Total_ErrorCount := COUNT(GROUP,h.DOB_Invalid>0);
    PHONE_ALLOW_ErrorCount := COUNT(GROUP,h.PHONE_Invalid=1);
    DL_STATE_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DL_STATE_Invalid=1);
    DL_STATE_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DL_STATE_Invalid=1 AND h.DL_STATE_wouldClean);
    DL_STATE_QUOTES_ErrorCount := COUNT(GROUP,h.DL_STATE_Invalid=2);
    DL_STATE_QUOTES_WouldModifyCount := COUNT(GROUP,h.DL_STATE_Invalid=2 AND h.DL_STATE_wouldClean);
    DL_STATE_Total_ErrorCount := COUNT(GROUP,h.DL_STATE_Invalid>0);
    DL_NBR_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid=1);
    DL_NBR_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DL_NBR_Invalid=1 AND h.DL_NBR_wouldClean);
    DL_NBR_QUOTES_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid=2);
    DL_NBR_QUOTES_WouldModifyCount := COUNT(GROUP,h.DL_NBR_Invalid=2 AND h.DL_NBR_wouldClean);
    DL_NBR_Total_ErrorCount := COUNT(GROUP,h.DL_NBR_Invalid>0);
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
    DT_EFFECTIVE_FIRST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_FIRST_Invalid=1);
    DT_EFFECTIVE_FIRST_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DT_EFFECTIVE_FIRST_Invalid=1 AND h.DT_EFFECTIVE_FIRST_wouldClean);
    DT_EFFECTIVE_FIRST_QUOTES_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_FIRST_Invalid=2);
    DT_EFFECTIVE_FIRST_QUOTES_WouldModifyCount := COUNT(GROUP,h.DT_EFFECTIVE_FIRST_Invalid=2 AND h.DT_EFFECTIVE_FIRST_wouldClean);
    DT_EFFECTIVE_FIRST_Total_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_FIRST_Invalid>0);
    DT_EFFECTIVE_LAST_LEFTTRIM_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_LAST_Invalid=1);
    DT_EFFECTIVE_LAST_LEFTTRIM_WouldModifyCount := COUNT(GROUP,h.DT_EFFECTIVE_LAST_Invalid=1 AND h.DT_EFFECTIVE_LAST_wouldClean);
    DT_EFFECTIVE_LAST_QUOTES_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_LAST_Invalid=2);
    DT_EFFECTIVE_LAST_QUOTES_WouldModifyCount := COUNT(GROUP,h.DT_EFFECTIVE_LAST_Invalid=2 AND h.DT_EFFECTIVE_LAST_wouldClean);
    DT_EFFECTIVE_LAST_Total_ErrorCount := COUNT(GROUP,h.DT_EFFECTIVE_LAST_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.SNAME_Invalid > 0 OR h.FNAME_Invalid > 0 OR h.MNAME_Invalid > 0 OR h.LNAME_Invalid > 0 OR h.DERIVED_GENDER_Invalid > 0 OR h.PRIM_RANGE_Invalid > 0 OR h.PRIM_NAME_Invalid > 0 OR h.SEC_RANGE_Invalid > 0 OR h.CITY_Invalid > 0 OR h.ST_Invalid > 0 OR h.ZIP_Invalid > 0 OR h.SSN5_Invalid > 0 OR h.SSN4_Invalid > 0 OR h.DOB_Invalid > 0 OR h.PHONE_Invalid > 0 OR h.DL_STATE_Invalid > 0 OR h.DL_NBR_Invalid > 0 OR h.SRC_Invalid > 0 OR h.SOURCE_RID_Invalid > 0 OR h.DT_FIRST_SEEN_Invalid > 0 OR h.DT_LAST_SEEN_Invalid > 0 OR h.DT_EFFECTIVE_FIRST_Invalid > 0 OR h.DT_EFFECTIVE_LAST_Invalid > 0);
    AnyRule_WithEditsCount := COUNT(GROUP, h.SNAME_wouldClean OR h.FNAME_wouldClean OR h.MNAME_wouldClean OR h.LNAME_wouldClean OR h.DERIVED_GENDER_wouldClean OR h.PRIM_RANGE_wouldClean OR h.PRIM_NAME_wouldClean OR h.SEC_RANGE_wouldClean OR h.CITY_wouldClean OR h.ST_wouldClean OR h.SSN5_wouldClean OR h.SSN4_wouldClean OR h.DOB_wouldClean OR h.DL_STATE_wouldClean OR h.DL_NBR_wouldClean OR h.SRC_wouldClean OR h.SOURCE_RID_wouldClean OR h.DT_FIRST_SEEN_wouldClean OR h.DT_LAST_SEEN_wouldClean OR h.DT_EFFECTIVE_FIRST_wouldClean OR h.DT_EFFECTIVE_LAST_wouldClean);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
    Rules_WithEdits := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,SRC,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.SNAME_Total_ErrorCount > 0, 1, 0) + IF(le.FNAME_Total_ErrorCount > 0, 1, 0) + IF(le.MNAME_Total_ErrorCount > 0, 1, 0) + IF(le.LNAME_Total_ErrorCount > 0, 1, 0) + IF(le.DERIVED_GENDER_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_Total_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_Total_ErrorCount > 0, 1, 0) + IF(le.CITY_Total_ErrorCount > 0, 1, 0) + IF(le.ST_Total_ErrorCount > 0, 1, 0) + IF(le.ZIP_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN5_Total_ErrorCount > 0, 1, 0) + IF(le.SSN4_Total_ErrorCount > 0, 1, 0) + IF(le.DOB_Total_ErrorCount > 0, 1, 0) + IF(le.PHONE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DL_STATE_Total_ErrorCount > 0, 1, 0) + IF(le.DL_NBR_Total_ErrorCount > 0, 1, 0) + IF(le.SRC_Total_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_Total_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_Total_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_Total_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_FIRST_Total_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_LAST_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.SNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.FNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.FNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.MNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.LNAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DERIVED_GENDER_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DERIVED_GENDER_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.CITY_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.CITY_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ST_QUOTES_ErrorCount > 0, 1, 0) + IF(le.ZIP_ALLOW_ErrorCount > 0, 1, 0) + IF(le.SSN5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SSN5_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SSN4_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SSN4_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DOB_QUOTES_ErrorCount > 0, 1, 0) + IF(le.PHONE_ALLOW_ErrorCount > 0, 1, 0) + IF(le.DL_STATE_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DL_STATE_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DL_NBR_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DL_NBR_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SRC_QUOTES_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.SOURCE_RID_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_FIRST_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_FIRST_QUOTES_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_LAST_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_LAST_QUOTES_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF.Rules_WithEdits := IF(le.SNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.FNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.FNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.MNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.LNAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DERIVED_GENDER_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DERIVED_GENDER_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.PRIM_NAME_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SEC_RANGE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.CITY_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.CITY_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.ST_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.ST_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SSN5_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SSN5_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SSN4_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SSN4_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DOB_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DOB_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DL_STATE_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DL_STATE_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DL_NBR_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DL_NBR_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SRC_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SRC_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.SOURCE_RID_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.SOURCE_RID_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_FIRST_SEEN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_LAST_SEEN_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_FIRST_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_FIRST_QUOTES_WouldModifyCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_LAST_LEFTTRIM_WouldModifyCount > 0, 1, 0) + IF(le.DT_EFFECTIVE_LAST_QUOTES_WouldModifyCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.SNAME_Invalid,le.FNAME_Invalid,le.MNAME_Invalid,le.LNAME_Invalid,le.DERIVED_GENDER_Invalid,le.PRIM_RANGE_Invalid,le.PRIM_NAME_Invalid,le.SEC_RANGE_Invalid,le.CITY_Invalid,le.ST_Invalid,le.ZIP_Invalid,le.SSN5_Invalid,le.SSN4_Invalid,le.DOB_Invalid,le.PHONE_Invalid,le.DL_STATE_Invalid,le.DL_NBR_Invalid,le.SRC_Invalid,le.SOURCE_RID_Invalid,le.DT_FIRST_SEEN_Invalid,le.DT_LAST_SEEN_Invalid,le.DT_EFFECTIVE_FIRST_Invalid,le.DT_EFFECTIVE_LAST_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_SNAME(le.SNAME_Invalid),Fields.InvalidMessage_FNAME(le.FNAME_Invalid),Fields.InvalidMessage_MNAME(le.MNAME_Invalid),Fields.InvalidMessage_LNAME(le.LNAME_Invalid),Fields.InvalidMessage_DERIVED_GENDER(le.DERIVED_GENDER_Invalid),Fields.InvalidMessage_PRIM_RANGE(le.PRIM_RANGE_Invalid),Fields.InvalidMessage_PRIM_NAME(le.PRIM_NAME_Invalid),Fields.InvalidMessage_SEC_RANGE(le.SEC_RANGE_Invalid),Fields.InvalidMessage_CITY(le.CITY_Invalid),Fields.InvalidMessage_ST(le.ST_Invalid),Fields.InvalidMessage_ZIP(le.ZIP_Invalid),Fields.InvalidMessage_SSN5(le.SSN5_Invalid),Fields.InvalidMessage_SSN4(le.SSN4_Invalid),Fields.InvalidMessage_DOB(le.DOB_Invalid),Fields.InvalidMessage_PHONE(le.PHONE_Invalid),Fields.InvalidMessage_DL_STATE(le.DL_STATE_Invalid),Fields.InvalidMessage_DL_NBR(le.DL_NBR_Invalid),Fields.InvalidMessage_SRC(le.SRC_Invalid),Fields.InvalidMessage_SOURCE_RID(le.SOURCE_RID_Invalid),Fields.InvalidMessage_DT_FIRST_SEEN(le.DT_FIRST_SEEN_Invalid),Fields.InvalidMessage_DT_LAST_SEEN(le.DT_LAST_SEEN_Invalid),Fields.InvalidMessage_DT_EFFECTIVE_FIRST(le.DT_EFFECTIVE_FIRST_Invalid),Fields.InvalidMessage_DT_EFFECTIVE_LAST(le.DT_EFFECTIVE_LAST_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.SNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.FNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.MNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.LNAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DERIVED_GENDER_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PRIM_NAME_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SEC_RANGE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.CITY_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.ZIP_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.SSN5_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SSN4_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DOB_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.PHONE_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.DL_STATE_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DL_NBR_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SRC_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.SOURCE_RID_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_FIRST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_LAST_SEEN_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_EFFECTIVE_FIRST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN')
          ,CHOOSE(le.DT_EFFECTIVE_LAST_Invalid,'LEFTTRIM','QUOTES','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'SNAME','FNAME','MNAME','LNAME','DERIVED_GENDER','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','ST','ZIP','SSN5','SSN4','DOB','PHONE','DL_STATE','DL_NBR','SRC','SOURCE_RID','DT_FIRST_SEEN','DT_LAST_SEEN','DT_EFFECTIVE_FIRST','DT_EFFECTIVE_LAST','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','NUMBER','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','DEFAULT','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.SNAME,(SALT311.StrType)le.FNAME,(SALT311.StrType)le.MNAME,(SALT311.StrType)le.LNAME,(SALT311.StrType)le.DERIVED_GENDER,(SALT311.StrType)le.PRIM_RANGE,(SALT311.StrType)le.PRIM_NAME,(SALT311.StrType)le.SEC_RANGE,(SALT311.StrType)le.CITY,(SALT311.StrType)le.ST,(SALT311.StrType)le.ZIP,(SALT311.StrType)le.SSN5,(SALT311.StrType)le.SSN4,(SALT311.StrType)le.DOB,(SALT311.StrType)le.PHONE,(SALT311.StrType)le.DL_STATE,(SALT311.StrType)le.DL_NBR,(SALT311.StrType)le.SRC,(SALT311.StrType)le.SOURCE_RID,(SALT311.StrType)le.DT_FIRST_SEEN,(SALT311.StrType)le.DT_LAST_SEEN,(SALT311.StrType)le.DT_EFFECTIVE_FIRST,(SALT311.StrType)le.DT_EFFECTIVE_LAST,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_InsuranceHeader) prevDS = DATASET([], Layout_InsuranceHeader)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.SRC;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.DERIVED_GENDER_LEFTTRIM_ErrorCount,le.DERIVED_GENDER_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.CITY_LEFTTRIM_ErrorCount,le.CITY_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_ALLOW_ErrorCount
          ,le.SSN5_LEFTTRIM_ErrorCount,le.SSN5_QUOTES_ErrorCount
          ,le.SSN4_LEFTTRIM_ErrorCount,le.SSN4_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.PHONE_ALLOW_ErrorCount
          ,le.DL_STATE_LEFTTRIM_ErrorCount,le.DL_STATE_QUOTES_ErrorCount
          ,le.DL_NBR_LEFTTRIM_ErrorCount,le.DL_NBR_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SOURCE_RID_LEFTTRIM_ErrorCount,le.SOURCE_RID_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DT_EFFECTIVE_FIRST_LEFTTRIM_ErrorCount,le.DT_EFFECTIVE_FIRST_QUOTES_ErrorCount
          ,le.DT_EFFECTIVE_LAST_LEFTTRIM_ErrorCount,le.DT_EFFECTIVE_LAST_QUOTES_ErrorCount
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
          ,le.SNAME_LEFTTRIM_ErrorCount,le.SNAME_QUOTES_ErrorCount
          ,le.FNAME_LEFTTRIM_ErrorCount,le.FNAME_QUOTES_ErrorCount
          ,le.MNAME_LEFTTRIM_ErrorCount,le.MNAME_QUOTES_ErrorCount
          ,le.LNAME_LEFTTRIM_ErrorCount,le.LNAME_QUOTES_ErrorCount
          ,le.DERIVED_GENDER_LEFTTRIM_ErrorCount,le.DERIVED_GENDER_QUOTES_ErrorCount
          ,le.PRIM_RANGE_LEFTTRIM_ErrorCount,le.PRIM_RANGE_QUOTES_ErrorCount
          ,le.PRIM_NAME_LEFTTRIM_ErrorCount,le.PRIM_NAME_QUOTES_ErrorCount
          ,le.SEC_RANGE_LEFTTRIM_ErrorCount,le.SEC_RANGE_QUOTES_ErrorCount
          ,le.CITY_LEFTTRIM_ErrorCount,le.CITY_QUOTES_ErrorCount
          ,le.ST_LEFTTRIM_ErrorCount,le.ST_QUOTES_ErrorCount
          ,le.ZIP_ALLOW_ErrorCount
          ,le.SSN5_LEFTTRIM_ErrorCount,le.SSN5_QUOTES_ErrorCount
          ,le.SSN4_LEFTTRIM_ErrorCount,le.SSN4_QUOTES_ErrorCount
          ,le.DOB_LEFTTRIM_ErrorCount,le.DOB_QUOTES_ErrorCount
          ,le.PHONE_ALLOW_ErrorCount
          ,le.DL_STATE_LEFTTRIM_ErrorCount,le.DL_STATE_QUOTES_ErrorCount
          ,le.DL_NBR_LEFTTRIM_ErrorCount,le.DL_NBR_QUOTES_ErrorCount
          ,le.SRC_LEFTTRIM_ErrorCount,le.SRC_QUOTES_ErrorCount
          ,le.SOURCE_RID_LEFTTRIM_ErrorCount,le.SOURCE_RID_QUOTES_ErrorCount
          ,le.DT_FIRST_SEEN_LEFTTRIM_ErrorCount,le.DT_FIRST_SEEN_QUOTES_ErrorCount
          ,le.DT_LAST_SEEN_LEFTTRIM_ErrorCount,le.DT_LAST_SEEN_QUOTES_ErrorCount
          ,le.DT_EFFECTIVE_FIRST_LEFTTRIM_ErrorCount,le.DT_EFFECTIVE_FIRST_QUOTES_ErrorCount
          ,le.DT_EFFECTIVE_LAST_LEFTTRIM_ErrorCount,le.DT_EFFECTIVE_LAST_QUOTES_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_InsuranceHeader));
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
          ,'SNAME:' + getFieldTypeText(h.SNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FNAME:' + getFieldTypeText(h.FNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'MNAME:' + getFieldTypeText(h.MNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'LNAME:' + getFieldTypeText(h.LNAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DERIVED_GENDER:' + getFieldTypeText(h.DERIVED_GENDER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_RANGE:' + getFieldTypeText(h.PRIM_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PRIM_NAME:' + getFieldTypeText(h.PRIM_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SEC_RANGE:' + getFieldTypeText(h.SEC_RANGE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'CITY:' + getFieldTypeText(h.CITY) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ST:' + getFieldTypeText(h.ST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ZIP:' + getFieldTypeText(h.ZIP) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN5:' + getFieldTypeText(h.SSN5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SSN4:' + getFieldTypeText(h.SSN4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DOB:' + getFieldTypeText(h.DOB) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'PHONE:' + getFieldTypeText(h.PHONE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DL_STATE:' + getFieldTypeText(h.DL_STATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DL_NBR:' + getFieldTypeText(h.DL_NBR) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SRC:' + getFieldTypeText(h.SRC) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'SOURCE_RID:' + getFieldTypeText(h.SOURCE_RID) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_FIRST_SEEN:' + getFieldTypeText(h.DT_FIRST_SEEN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_LAST_SEEN:' + getFieldTypeText(h.DT_LAST_SEEN) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_EFFECTIVE_FIRST:' + getFieldTypeText(h.DT_EFFECTIVE_FIRST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'DT_EFFECTIVE_LAST:' + getFieldTypeText(h.DT_EFFECTIVE_LAST) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_SNAME_cnt
          ,le.populated_FNAME_cnt
          ,le.populated_MNAME_cnt
          ,le.populated_LNAME_cnt
          ,le.populated_DERIVED_GENDER_cnt
          ,le.populated_PRIM_RANGE_cnt
          ,le.populated_PRIM_NAME_cnt
          ,le.populated_SEC_RANGE_cnt
          ,le.populated_CITY_cnt
          ,le.populated_ST_cnt
          ,le.populated_ZIP_cnt
          ,le.populated_SSN5_cnt
          ,le.populated_SSN4_cnt
          ,le.populated_DOB_cnt
          ,le.populated_PHONE_cnt
          ,le.populated_DL_STATE_cnt
          ,le.populated_DL_NBR_cnt
          ,le.populated_SRC_cnt
          ,le.populated_SOURCE_RID_cnt
          ,le.populated_DT_FIRST_SEEN_cnt
          ,le.populated_DT_LAST_SEEN_cnt
          ,le.populated_DT_EFFECTIVE_FIRST_cnt
          ,le.populated_DT_EFFECTIVE_LAST_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_SNAME_pcnt
          ,le.populated_FNAME_pcnt
          ,le.populated_MNAME_pcnt
          ,le.populated_LNAME_pcnt
          ,le.populated_DERIVED_GENDER_pcnt
          ,le.populated_PRIM_RANGE_pcnt
          ,le.populated_PRIM_NAME_pcnt
          ,le.populated_SEC_RANGE_pcnt
          ,le.populated_CITY_pcnt
          ,le.populated_ST_pcnt
          ,le.populated_ZIP_pcnt
          ,le.populated_SSN5_pcnt
          ,le.populated_SSN4_pcnt
          ,le.populated_DOB_pcnt
          ,le.populated_PHONE_pcnt
          ,le.populated_DL_STATE_pcnt
          ,le.populated_DL_NBR_pcnt
          ,le.populated_SRC_pcnt
          ,le.populated_SOURCE_RID_pcnt
          ,le.populated_DT_FIRST_SEEN_pcnt
          ,le.populated_DT_LAST_SEEN_pcnt
          ,le.populated_DT_EFFECTIVE_FIRST_pcnt
          ,le.populated_DT_EFFECTIVE_LAST_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,23,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_InsuranceHeader));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),23,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_InsuranceHeader) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(InsuranceHeader_xLink, Fields, 'RECORDOF(scrubsSummaryOverall)', 'SRC');
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
