IMPORT SALT37,std;
EXPORT match_methods(DATASET(layout_HEADER) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_ADDRESS(TYPEOF(h.ADDRESS) L,TYPEOF(h.ADDRESS) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_SSN(TYPEOF(h.SSN) L, TYPEOF(h.SSN) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    fn_Right4(L) =  fn_Right4(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_Right4 values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_POLICY_NUMBER(TYPEOF(h.POLICY_NUMBER) L, TYPEOF(h.POLICY_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    fn_TrimLeadingZero(L) =  fn_TrimLeadingZero(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_TrimLeadingZero values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CLAIM_NUMBER(TYPEOF(h.CLAIM_NUMBER) L, TYPEOF(h.CLAIM_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DL_NBR(TYPEOF(h.DL_NBR) L, TYPEOF(h.DL_NBR) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    fn_TrimLeadingZero(L) =  fn_TrimLeadingZero(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_TrimLeadingZero values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_FULLNAME(TYPEOF(h.FULLNAME) L,TYPEOF(h.FULLNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_MAINNAME(TYPEOF(h.MAINNAME) L,TYPEOF(h.MAINNAME) R,SALT37.StrType L_FNAME = '',TYPEOF(h.FNAME_weight100) L_FNAME_spec = 0,BOOLEAN L_FNAME_allow_blank = FALSE,INTEGER L_FNAME_force = 0,BOOLEAN L_FNAME_use_init = FALSE, UNSIGNED2 L_FNAME_initial_char_weight100 = 0,INTEGER L_FNAME_edit = 0,UNSIGNED2 L_FNAME_edit_threshold = 0,UNSIGNED2 L_FNAME_length = 0,TYPEOF(h.FNAME_MAINNAME_weight100) L_FNAME_MAINNAME_fuzzy_weight100 = 0,SALT37.StrType L_MNAME = '',TYPEOF(h.MNAME_weight100) L_MNAME_spec = 0,BOOLEAN L_MNAME_allow_blank = FALSE,INTEGER L_MNAME_force = 0,BOOLEAN L_MNAME_use_init = FALSE, UNSIGNED2 L_MNAME_initial_char_weight100 = 0,INTEGER L_MNAME_edit = 0,UNSIGNED2 L_MNAME_edit_threshold = 0,UNSIGNED2 L_MNAME_length = 0,TYPEOF(h.MNAME_MAINNAME_weight100) L_MNAME_MAINNAME_fuzzy_weight100 = 0,SALT37.StrType L_LNAME = '',TYPEOF(h.LNAME_weight100) L_LNAME_spec = 0,BOOLEAN L_LNAME_allow_blank = FALSE,INTEGER L_LNAME_force = 0,BOOLEAN L_LNAME_use_init = FALSE, UNSIGNED2 L_LNAME_initial_char_weight100 = 0,INTEGER L_LNAME_edit = 0,UNSIGNED2 L_LNAME_edit_threshold = 0,UNSIGNED2 L_LNAME_length = 0,TYPEOF(h.LNAME_MAINNAME_weight100) L_LNAME_MAINNAME_fuzzy_weight100 = 0,SALT37.StrType R_FNAME = '',TYPEOF(h.FNAME_weight100) R_FNAME_spec = 0,UNSIGNED2 R_FNAME_length = 0,TYPEOF(h.FNAME_MAINNAME_weight100) R_FNAME_MAINNAME_fuzzy_weight100 = 0,SALT37.StrType R_MNAME = '',TYPEOF(h.MNAME_weight100) R_MNAME_spec = 0,UNSIGNED2 R_MNAME_length = 0,TYPEOF(h.MNAME_MAINNAME_weight100) R_MNAME_MAINNAME_fuzzy_weight100 = 0,SALT37.StrType R_LNAME = '',TYPEOF(h.LNAME_weight100) R_LNAME_spec = 0,UNSIGNED2 R_LNAME_length = 0,TYPEOF(h.LNAME_MAINNAME_weight100) R_LNAME_MAINNAME_fuzzy_weight100 = 0,BOOLEAN el, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
    ~el AND SALT37.fn_concept_wordbag_EditN.Match3((SALT37.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init,L_FNAME_edit,L_FNAME_edit_threshold,L_FNAME_length,L_FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init,L_MNAME_edit,L_MNAME_edit_threshold,L_MNAME_length,L_MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init,L_LNAME_edit,L_LNAME_edit_threshold,L_LNAME_length,L_LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)R_FNAME,R_FNAME_spec,R_FNAME_length,R_FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)R_MNAME,R_MNAME_spec,R_MNAME_length,R_MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)R_LNAME,R_LNAME_spec,R_LNAME_length,R_LNAME_MAINNAME_fuzzy_weight100,InsuranceHeader_RemoteLinking.Config.WithinEditN) <> 0 => SALT37.MatchCode.WordBagMatch,
    el AND SALT37.fn_concept_wordbag_EditN_EL.Match3((SALT37.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init, L_FNAME_initial_char_weight100,L_FNAME_edit,L_FNAME_edit_threshold,L_FNAME_length,L_FNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init, L_MNAME_initial_char_weight100,L_MNAME_edit,L_MNAME_edit_threshold,L_MNAME_length,L_MNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init, L_LNAME_initial_char_weight100,L_LNAME_edit,L_LNAME_edit_threshold,L_LNAME_length,L_LNAME_MAINNAME_fuzzy_weight100,(SALT37.StrType)R_FNAME,R_FNAME_length,(SALT37.StrType)R_MNAME,R_MNAME_length,(SALT37.StrType)R_LNAME,R_LNAME_length,InsuranceHeader_RemoteLinking.Config.WithinEditN) <> 0 => SALT37.MatchCode.WordBagMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_ADDR1(TYPEOF(h.ADDR1) L,TYPEOF(h.ADDR1) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_DOB_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT37.MatchCode.ExactMatch,
	SALT37.Fn_YearMatch(L_year,R_year,12) => SALT37.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	SALT37.MatchCode.NoMatch);
EXPORT match_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT37.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT37.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT37.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT37.MatchCode.NoMatch);
EXPORT match_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT37.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT37.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT37.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT37.MatchCode.NoMatch);
EXPORT match_DOB(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT37.MatchCode.ExactMatch,
	SALT37.Fn_YearMatch(L_year,R_year,12) AND L_month = R_month AND L_day = R_day => SALT37.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	L_month = R_day AND L_day = R_month => SALT37.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT37.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT37.MatchCode.NoMatch);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LOCALE(TYPEOF(h.LOCALE) L,TYPEOF(h.LOCALE) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LNAME(TYPEOF(h.LNAME) L, TYPEOF(h.LNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=2 => SALT37.MatchCode.HyphenMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 6) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CITY(TYPEOF(h.CITY) L, TYPEOF(h.CITY) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_FNAME(TYPEOF(h.FNAME) L, TYPEOF(h.FNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 6) => SALT37.MatchCode.EditDistanceMatch,
    fn_PreferredName(L) =  fn_PreferredName(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=2 => SALT37.MatchCode.HyphenMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_MNAME(TYPEOF(h.MNAME) L, TYPEOF(h.MNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 6) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_SNAME(TYPEOF(h.SNAME) L, TYPEOF(h.SNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_GENDER(TYPEOF(h.GENDER) L, TYPEOF(h.GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DERIVED_GENDER(TYPEOF(h.DERIVED_GENDER) L, TYPEOF(h.DERIVED_GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
END;
