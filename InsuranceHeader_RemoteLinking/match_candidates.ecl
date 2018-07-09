// Begin code to produce match candidates
IMPORT SALT37;
EXPORT match_candidates(DATASET(layout_HEADER) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := InsuranceHeader_RemoteLinking.Specificities(ih).input_file_np;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{RID,VENDOR_ID,BOCA_DID,SRC,SSN,SSN_len,DOB_year,DOB_month,DOB_day,DL_NBR,SNAME,FNAME,FNAME_len,MNAME,MNAME_len,LNAME,LNAME_len,GENDER,DERIVED_GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY,ST,ZIP,POLICY_NUMBER,CLAIM_NUMBER,DT_FIRST_SEEN,DT_LAST_SEEN,MAINNAME,ADDR1,LOCALE,ADDRESS,FULLNAME,DL_STATE,AMBEST,DID}),HASH(DID));
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( thin_table, { thin_table, UNSIGNED2 Buddies := 0 }),HASH(DID)),
    DID,SSN,DOB_year,DOB_month,DOB_day,DL_NBR,SNAME,FNAME,MNAME,LNAME,GENDER,DERIVED_GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY,ST,ZIP,POLICY_NUMBER,CLAIM_NUMBER,DT_FIRST_SEEN,DT_LAST_SEEN, LOCAL),
    DID,SSN,DOB_year,DOB_month,DOB_day,DL_NBR,SNAME,FNAME,MNAME,LNAME,GENDER,DERIVED_GENDER,PRIM_NAME,PRIM_RANGE,SEC_RANGE,CITY,ST,ZIP,POLICY_NUMBER,CLAIM_NUMBER,DT_FIRST_SEEN,DT_LAST_SEEN, LOCAL);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT37.UIDType DID1;
  SALT37.UIDType DID2;
  SALT37.UIDType RID1 := 0;
  SALT37.UIDType RID2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 SSN_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SSN_isnull := (h0.SSN  IN SET(s.nulls_SSN,SSN) OR h0.SSN = (TYPEOF(h0.SSN))''); // Simplify later processing 
  UNSIGNED SSN_cnt := 0; // Number of instances with this particular field value
  UNSIGNED SSN_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING4 SSN_Right4 := (STRING4)'';
  UNSIGNED SSN_Right4_cnt := 0; // Number of names instances matching this one using Right4
  BOOLEAN DOB_year_isnull := h0.DOB_year IN SET(s.nulls_DOB_year,DOB_year); // Simplifies later processing
  BOOLEAN DOB_month_isnull := h0.DOB_month IN SET(s.nulls_DOB_month,DOB_month); // Do for each of three parts of date
  BOOLEAN DOB_day_isnull := h0.DOB_day IN SET(s.nulls_DOB_day,DOB_day);
  UNSIGNED2 DOB_year_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_month_weight100 := 0; // Contains 100x the specificity
  UNSIGNED2 DOB_day_weight100 := 0; // Contains 100x the specificity
  INTEGER2 DL_NBR_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DL_NBR_isnull := (h0.DL_NBR  IN SET(s.nulls_DL_NBR,DL_NBR) OR h0.DL_NBR = (TYPEOF(h0.DL_NBR))''); // Simplify later processing 
  UNSIGNED DL_NBR_cnt := 0; // Number of instances with this particular field value
  STRING20 DL_NBR_TrimLeadingZero := (STRING20)'';
  UNSIGNED DL_NBR_TrimLeadingZero_cnt := 0; // Number of names instances matching this one using TrimLeadingZero
  INTEGER2 SNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SNAME_isnull := (h0.SNAME  IN SET(s.nulls_SNAME,SNAME) OR h0.SNAME = (TYPEOF(h0.SNAME))''); // Simplify later processing 
  INTEGER2 FNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 FNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FNAME_isnull := (h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))''); // Simplify later processing 
  UNSIGNED FNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED FNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED FNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 FNAME_PreferredName := (STRING20)'';
  UNSIGNED FNAME_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  UNSIGNED FNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 MNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 MNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MNAME_isnull := (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))''); // Simplify later processing 
  UNSIGNED MNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED MNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED MNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 LNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_MAINNAME_fuzzy_weight100 := 0; // Contains 100x the specificity
  INTEGER2 LNAME_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LNAME_isnull := (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))''); // Simplify later processing 
  UNSIGNED LNAME_cnt := 0; // Number of instances with this particular field value
  UNSIGNED LNAME_e2_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_e1_cnt := 0; // Number of names instances matching this one by edit distance
  UNSIGNED LNAME_MAINNAME_cnt := 0; // Number of name instances matching this one in CONCEPT as BOW
  INTEGER2 GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN GENDER_isnull := (h0.GENDER  IN SET(s.nulls_GENDER,GENDER) OR h0.GENDER = (TYPEOF(h0.GENDER))''); // Simplify later processing 
  INTEGER2 DERIVED_GENDER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DERIVED_GENDER_isnull := (h0.DERIVED_GENDER  IN SET(s.nulls_DERIVED_GENDER,DERIVED_GENDER) OR h0.DERIVED_GENDER = (TYPEOF(h0.DERIVED_GENDER))''); // Simplify later processing 
  INTEGER2 PRIM_NAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_NAME_isnull := (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))''); // Simplify later processing 
  INTEGER2 PRIM_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PRIM_RANGE_isnull := (h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))''); // Simplify later processing 
  INTEGER2 SEC_RANGE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SEC_RANGE_isnull := (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))''); // Simplify later processing 
  INTEGER2 CITY_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CITY_isnull := (h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))''); // Simplify later processing 
  INTEGER2 ST_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ST_isnull := (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))''); // Simplify later processing 
  INTEGER2 ZIP_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ZIP_isnull := (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''); // Simplify later processing 
  INTEGER2 POLICY_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN POLICY_NUMBER_isnull := (h0.POLICY_NUMBER  IN SET(s.nulls_POLICY_NUMBER,POLICY_NUMBER) OR h0.POLICY_NUMBER = (TYPEOF(h0.POLICY_NUMBER))''); // Simplify later processing 
  UNSIGNED POLICY_NUMBER_cnt := 0; // Number of instances with this particular field value
  STRING20 POLICY_NUMBER_TrimLeadingZero := (STRING20)'';
  UNSIGNED POLICY_NUMBER_TrimLeadingZero_cnt := 0; // Number of names instances matching this one using TrimLeadingZero
  INTEGER2 CLAIM_NUMBER_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CLAIM_NUMBER_isnull := (h0.CLAIM_NUMBER  IN SET(s.nulls_CLAIM_NUMBER,CLAIM_NUMBER) OR h0.CLAIM_NUMBER = (TYPEOF(h0.CLAIM_NUMBER))''); // Simplify later processing 
  INTEGER2 MAINNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MAINNAME_isnull := ((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')); // Simplify later processing 
  INTEGER2 ADDR1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDR1_isnull := ((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')); // Simplify later processing 
  INTEGER2 LOCALE_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LOCALE_isnull := ((h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))'')); // Simplify later processing 
  INTEGER2 ADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ADDRESS_isnull := (((h0.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) OR h0.PRIM_RANGE = (TYPEOF(h0.PRIM_RANGE))'') AND (h0.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) OR h0.SEC_RANGE = (TYPEOF(h0.SEC_RANGE))'') AND (h0.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) OR h0.PRIM_NAME = (TYPEOF(h0.PRIM_NAME))'')) AND ((h0.CITY  IN SET(s.nulls_CITY,CITY) OR h0.CITY = (TYPEOF(h0.CITY))'') AND (h0.ST  IN SET(s.nulls_ST,ST) OR h0.ST = (TYPEOF(h0.ST))'') AND (h0.ZIP  IN SET(s.nulls_ZIP,ZIP) OR h0.ZIP = (TYPEOF(h0.ZIP))''))); // Simplify later processing 
  INTEGER2 FULLNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FULLNAME_isnull := (((h0.FNAME  IN SET(s.nulls_FNAME,FNAME) OR h0.FNAME = (TYPEOF(h0.FNAME))'') AND (h0.MNAME  IN SET(s.nulls_MNAME,MNAME) OR h0.MNAME = (TYPEOF(h0.MNAME))'') AND (h0.LNAME  IN SET(s.nulls_LNAME,LNAME) OR h0.LNAME = (TYPEOF(h0.LNAME))'')) AND (h0.SNAME  IN SET(s.nulls_SNAME,SNAME) OR h0.SNAME = (TYPEOF(h0.SNAME))'')); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_DERIVED_GENDER(layout_candidates le,Specificities(ih).DERIVED_GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DERIVED_GENDER_weight100 := MAP (le.DERIVED_GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.DERIVED_GENDER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j21 := JOIN(h1,Specificities(ih).DERIVED_GENDER_values_index,LEFT.DERIVED_GENDER=RIGHT.DERIVED_GENDER,add_DERIVED_GENDER(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_GENDER(layout_candidates le,Specificities(ih).GENDER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.GENDER_weight100 := MAP (le.GENDER_isnull => 0, patch_default and ri.field_specificity=0 => s.GENDER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j21,Specificities(ih).GENDER_values_index,LEFT.GENDER=RIGHT.GENDER,add_GENDER(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_SNAME(layout_candidates le,Specificities(ih).SNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SNAME_weight100 := MAP (le.SNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.SNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(j20,Specificities(ih).SNAME_values_index,LEFT.SNAME=RIGHT.SNAME,add_SNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_ST(layout_candidates le,Specificities(ih).ST_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ST_weight100 := MAP (le.ST_isnull => 0, patch_default and ri.field_specificity=0 => s.ST_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,Specificities(ih).ST_values_index,LEFT.ST=RIGHT.ST,add_ST(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_MNAME(layout_candidates le,Specificities(ih).MNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MNAME_cnt := ri.cnt;
  SELF.MNAME_e2_cnt := ri.e2_cnt;
  SELF.MNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 MNAME_weight100 := MAP (le.MNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.MNAME_weight100 := MNAME_weight100;
  SELF.MNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.MNAME_MAINNAME_weight100 := IF(MNAME_weight100>0, SALT37.Min1(MNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(MNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.MNAME_initial_char_weight100 := MAP (le.MNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j17 := JOIN(j18,Specificities(ih).MNAME_values_index,LEFT.MNAME=RIGHT.MNAME,add_MNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_SEC_RANGE(layout_candidates le,Specificities(ih).SEC_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SEC_RANGE_weight100 := MAP (le.SEC_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.SEC_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16 := JOIN(j17,Specificities(ih).SEC_RANGE_values_index,LEFT.SEC_RANGE=RIGHT.SEC_RANGE,add_SEC_RANGE(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_FNAME(layout_candidates le,Specificities(ih).FNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FNAME_cnt := ri.cnt;
  SELF.FNAME_e2_cnt := ri.e2_cnt;
  SELF.FNAME_e1_cnt := ri.e1_cnt;
  SELF.FNAME_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field FNAME
  SELF.FNAME_PreferredName := ri.FNAME_PreferredName; // Copy PreferredName value for field FNAME
  INTEGER2 FNAME_weight100 := MAP (le.FNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.FNAME_weight100 := FNAME_weight100;
  SELF.FNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.FNAME_MAINNAME_weight100 := IF(FNAME_weight100>0, SALT37.Min1(FNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(FNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.FNAME_initial_char_weight100 := MAP (le.FNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j15 := JOIN(j16,Specificities(ih).FNAME_values_index,LEFT.FNAME=RIGHT.FNAME,add_FNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_CITY(layout_candidates le,Specificities(ih).CITY_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CITY_weight100 := MAP (le.CITY_isnull => 0, patch_default and ri.field_specificity=0 => s.CITY_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j14 := JOIN(j15,Specificities(ih).CITY_values_index,LEFT.CITY=RIGHT.CITY,add_CITY(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_PRIM_RANGE(layout_candidates le,Specificities(ih).PRIM_RANGE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_RANGE_weight100 := MAP (le.PRIM_RANGE_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_RANGE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j13 := JOIN(j14,Specificities(ih).PRIM_RANGE_values_index,LEFT.PRIM_RANGE=RIGHT.PRIM_RANGE,add_PRIM_RANGE(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_LNAME(layout_candidates le,Specificities(ih).LNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LNAME_cnt := ri.cnt;
  SELF.LNAME_e2_cnt := ri.e2_cnt;
  SELF.LNAME_e1_cnt := ri.e1_cnt;
  INTEGER2 LNAME_weight100 := MAP (le.LNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.LNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.LNAME_weight100 := LNAME_weight100;
  SELF.LNAME_MAINNAME_cnt := ri.MAINNAME_cnt;
  SELF.LNAME_MAINNAME_weight100 := IF(LNAME_weight100>0, SALT37.Min1(LNAME_weight100 + 100*log(ri.cnt/ri.MAINNAME_cnt)/log(2)), 0); // Precompute CONCEPT-WORDBAG specificity 
  SELF.LNAME_MAINNAME_fuzzy_weight100 := SALT37.Min1(LNAME_weight100 + 100*log(ri.MAINNAME_cnt/ri.MAINNAME_fuzzy_cnt)/log(2)); // Precompute CONCEPT-WORDBAG specificity 
  SELF.LNAME_initial_char_weight100 := MAP (le.LNAME_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j12 := JOIN(j13,Specificities(ih).LNAME_values_index,LEFT.LNAME=RIGHT.LNAME,add_LNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_PRIM_NAME(layout_candidates le,Specificities(ih).PRIM_NAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PRIM_NAME_weight100 := MAP (le.PRIM_NAME_isnull => 0, patch_default and ri.field_specificity=0 => s.PRIM_NAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j11 := JOIN(j12,Specificities(ih).PRIM_NAME_values_index,LEFT.PRIM_NAME=RIGHT.PRIM_NAME,add_PRIM_NAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_LOCALE(layout_candidates le,Specificities(ih).LOCALE_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LOCALE_weight100 := MAP (le.LOCALE_isnull => 0, patch_default and ri.field_specificity=0 => s.LOCALE_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j10 := JOIN(j11,Specificities(ih).LOCALE_values_index,LEFT.LOCALE=RIGHT.LOCALE,add_LOCALE(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_ZIP(layout_candidates le,Specificities(ih).ZIP_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ZIP_weight100 := MAP (le.ZIP_isnull => 0, patch_default and ri.field_specificity=0 => s.ZIP_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9 := JOIN(j10,Specificities(ih).ZIP_values_index,LEFT.ZIP=RIGHT.ZIP,add_ZIP(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_DOB_year(layout_candidates le,Specificities(ih).DOB_year_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_year_weight100 := MAP (le.DOB_year_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_year_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9000 := JOIN(j9,Specificities(ih).DOB_year_values_index,LEFT.DOB_year=RIGHT.DOB_year,add_DOB_year(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_DOB_month(layout_candidates le,Specificities(ih).DOB_month_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_month_weight100 := MAP (le.DOB_month_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_month_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9001 := JOIN(j9000,Specificities(ih).DOB_month_values_index,LEFT.DOB_month=RIGHT.DOB_month,add_DOB_month(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_DOB_day(layout_candidates le,Specificities(ih).DOB_day_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DOB_day_weight100 := MAP (le.DOB_day_isnull => 0, patch_default and ri.field_specificity=0 => s.DOB_day_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9002 := JOIN(j9001,Specificities(ih).DOB_day_values_index,LEFT.DOB_day=RIGHT.DOB_day,add_DOB_day(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_ADDR1(layout_candidates le,Specificities(ih).ADDR1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDR1_weight100 := MAP (le.ADDR1_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDR1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j7 := JOIN(j9002,Specificities(ih).ADDR1_values_index,LEFT.ADDR1=RIGHT.ADDR1,add_ADDR1(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_MAINNAME(layout_candidates le,Specificities(ih).MAINNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MAINNAME_weight100 := MAP (le.MAINNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.MAINNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6 := JOIN(j7,Specificities(ih).MAINNAME_values_index,LEFT.MAINNAME=RIGHT.MAINNAME,add_MAINNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_FULLNAME(layout_candidates le,Specificities(ih).FULLNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FULLNAME_weight100 := MAP (le.FULLNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.FULLNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j5 := JOIN(j6,Specificities(ih).FULLNAME_values_index,LEFT.FULLNAME=RIGHT.FULLNAME,add_FULLNAME(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_DL_NBR(layout_candidates le,Specificities(ih).DL_NBR_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DL_NBR_cnt := ri.cnt;
  SELF.DL_NBR_TrimLeadingZero_cnt := ri.TrimLeadingZero_cnt; // Copy in count of matching TrimLeadingZero values for field DL_NBR
  SELF.DL_NBR_TrimLeadingZero := ri.DL_NBR_TrimLeadingZero; // Copy TrimLeadingZero value for field DL_NBR
  SELF.DL_NBR_weight100 := MAP (le.DL_NBR_isnull => 0, patch_default and ri.field_specificity=0 => s.DL_NBR_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j4 := JOIN(j5,Specificities(ih).DL_NBR_values_index,LEFT.DL_NBR=RIGHT.DL_NBR,add_DL_NBR(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_CLAIM_NUMBER(layout_candidates le,Specificities(ih).CLAIM_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CLAIM_NUMBER_weight100 := MAP (le.CLAIM_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.CLAIM_NUMBER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j3 := JOIN(j4,Specificities(ih).CLAIM_NUMBER_values_index,LEFT.CLAIM_NUMBER=RIGHT.CLAIM_NUMBER,add_CLAIM_NUMBER(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_POLICY_NUMBER(layout_candidates le,Specificities(ih).POLICY_NUMBER_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.POLICY_NUMBER_cnt := ri.cnt;
  SELF.POLICY_NUMBER_TrimLeadingZero_cnt := ri.TrimLeadingZero_cnt; // Copy in count of matching TrimLeadingZero values for field POLICY_NUMBER
  SELF.POLICY_NUMBER_TrimLeadingZero := ri.POLICY_NUMBER_TrimLeadingZero; // Copy TrimLeadingZero value for field POLICY_NUMBER
  SELF.POLICY_NUMBER_weight100 := MAP (le.POLICY_NUMBER_isnull => 0, patch_default and ri.field_specificity=0 => s.POLICY_NUMBER_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j2 := JOIN(j3,Specificities(ih).POLICY_NUMBER_values_index,LEFT.POLICY_NUMBER=RIGHT.POLICY_NUMBER,add_POLICY_NUMBER(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_SSN(layout_candidates le,Specificities(ih).SSN_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SSN_cnt := ri.cnt;
  SELF.SSN_e1_cnt := ri.e1_cnt;
  SELF.SSN_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field SSN
  SELF.SSN_Right4 := ri.SSN_Right4; // Copy Right4 value for field SSN
  SELF.SSN_weight100 := MAP (le.SSN_isnull => 0, patch_default and ri.field_specificity=0 => s.SSN_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j1 := JOIN(j2,Specificities(ih).SSN_values_index,LEFT.SSN=RIGHT.SSN,add_SSN(LEFT,RIGHT,TRUE),LEFT OUTER);
layout_candidates add_ADDRESS(layout_candidates le,Specificities(ih).ADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ADDRESS_weight100 := MAP (le.ADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.ADDRESS_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j0 := JOIN(j1,Specificities(ih).ADDRESS_values_index,LEFT.ADDRESS=RIGHT.ADDRESS,add_ADDRESS(LEFT,RIGHT,TRUE),LEFT OUTER);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(DID)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.ADDRESS_weight100 + Annotated.SSN_weight100 + Annotated.POLICY_NUMBER_weight100 + Annotated.CLAIM_NUMBER_weight100 + Annotated.DL_NBR_weight100 + Annotated.FULLNAME_weight100 + Annotated.DOB_year_weight100 + Annotated.DOB_month_weight100 + Annotated.DOB_day_weight100 + Annotated.GENDER_weight100 + Annotated.DERIVED_GENDER_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { RID });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
