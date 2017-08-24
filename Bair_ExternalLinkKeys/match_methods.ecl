IMPORT SALT33,std;
EXPORT match_methods(DATASET(layout_Classify_PS) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_NAME_SUFFIX(TYPEOF(h.NAME_SUFFIX) L, TYPEOF(h.NAME_SUFFIX) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_FNAME(TYPEOF(h.FNAME) L, TYPEOF(h.FNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    fn_PreferredName(L) =  fn_PreferredName(R) => SALT33.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
    SALT33.WithinEditNew(L,LL,R,RL,1, 0) => SALT33.MatchCode.EditDistanceMatch,
    metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT33.MatchCode.PhoneticMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT33.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT33.MatchCode.InitialMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_MNAME(TYPEOF(h.MNAME) L, TYPEOF(h.MNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.WithinEditNew(L,LL,R,RL,2, 0) => SALT33.MatchCode.EditDistanceMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT33.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT33.MatchCode.InitialMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_LNAME(TYPEOF(h.LNAME) L, TYPEOF(h.LNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.HyphenMatch(L,R,1)<=2 => SALT33.MatchCode.HyphenMatch,
    SALT33.WithinEditNew(L,LL,R,RL,1, 0) => SALT33.MatchCode.EditDistanceMatch,
    metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT33.MatchCode.PhoneticMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.WithinEditNew(L,LL,R,RL,1, 0) => SALT33.MatchCode.EditDistanceMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.WithinEditNew(L,LL,R,RL,1, 0) => SALT33.MatchCode.EditDistanceMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.HyphenMatch(L,R,1)<=2 => SALT33.MatchCode.HyphenMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_P_CITY_NAME(TYPEOF(h.P_CITY_NAME) L, TYPEOF(h.P_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DOB_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT33.MatchCode.ExactMatch,
	SALT33.Fn_YearMatch(L_year,R_year,13) => SALT33.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	SALT33.MatchCode.NoMatch);
EXPORT match_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT33.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT33.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT33.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT33.MatchCode.NoMatch);
EXPORT match_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT33.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT33.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT33.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT33.MatchCode.NoMatch);
EXPORT match_DOB(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT33.MatchCode.ExactMatch,
	SALT33.Fn_YearMatch(L_year,R_year,13) AND L_month = R_month AND L_day = R_day => SALT33.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	L_month = R_day AND L_day = R_month => SALT33.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT33.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT33.MatchCode.NoMatch);
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DL_ST(TYPEOF(h.DL_ST) L, TYPEOF(h.DL_ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DL(TYPEOF(h.DL) L, TYPEOF(h.DL) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_LEXID(TYPEOF(h.LEXID) L, TYPEOF(h.LEXID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_POSSIBLE_SSN(TYPEOF(h.POSSIBLE_SSN) L, TYPEOF(h.POSSIBLE_SSN) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.WithinEditNew(L,LL,R,RL,1, 0) => SALT33.MatchCode.EditDistanceMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_CRIME(TYPEOF(h.CRIME) L, TYPEOF(h.CRIME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_NAME_TYPE(TYPEOF(h.NAME_TYPE) L, TYPEOF(h.NAME_TYPE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_CLEAN_GENDER(TYPEOF(h.CLEAN_GENDER) L, TYPEOF(h.CLEAN_GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_CLASS_CODE(TYPEOF(h.CLASS_CODE) L, TYPEOF(h.CLASS_CODE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DT_FIRST_SEEN(TYPEOF(h.DT_FIRST_SEEN) L, TYPEOF(h.DT_FIRST_SEEN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DT_LAST_SEEN(TYPEOF(h.DT_LAST_SEEN) L, TYPEOF(h.DT_LAST_SEEN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_DATA_PROVIDER_ORI(TYPEOF(h.DATA_PROVIDER_ORI) L, TYPEOF(h.DATA_PROVIDER_ORI) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_VIN(TYPEOF(h.VIN) L, TYPEOF(h.VIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_PLATE(TYPEOF(h.PLATE) L, TYPEOF(h.PLATE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_LATITUDE(TYPEOF(h.LATITUDE) L, TYPEOF(h.LATITUDE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_LONGITUDE(TYPEOF(h.LONGITUDE) L, TYPEOF(h.LONGITUDE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_SEARCH_ADDR1(TYPEOF(h.SEARCH_ADDR1) L, TYPEOF(h.SEARCH_ADDR1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_SEARCH_ADDR2(TYPEOF(h.SEARCH_ADDR2) L, TYPEOF(h.SEARCH_ADDR2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_CLEAN_COMPANY_NAME(TYPEOF(h.CLEAN_COMPANY_NAME) L, TYPEOF(h.CLEAN_COMPANY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT33.MatchCode.ExactMatch,
    SALT33.MatchCode.NoMatch),
        MAP(L = R => SALT33.MatchCode.ExactMatch, SALT33.MatchCode.NoMatch)
);
EXPORT match_MAINNAME(TYPEOF(h.MAINNAME) L,TYPEOF(h.MAINNAME) R,SALT33.StrType L_FNAME,TYPEOF(h.FNAME_weight100) L_FNAME_spec,BOOLEAN L_FNAME_allow_blank,INTEGER L_FNAME_force,BOOLEAN L_FNAME_use_init, UNSIGNED2 L_FNAME_initial_char_weight100 = 0,INTEGER L_FNAME_edit,SALT33.StrType L_MNAME,TYPEOF(h.MNAME_weight100) L_MNAME_spec,BOOLEAN L_MNAME_allow_blank,INTEGER L_MNAME_force,BOOLEAN L_MNAME_use_init, UNSIGNED2 L_MNAME_initial_char_weight100 = 0,INTEGER L_MNAME_edit,SALT33.StrType L_LNAME,TYPEOF(h.LNAME_weight100) L_LNAME_spec,BOOLEAN L_LNAME_allow_blank,INTEGER L_LNAME_force,BOOLEAN L_LNAME_use_init, UNSIGNED2 L_LNAME_initial_char_weight100 = 0,INTEGER L_LNAME_edit,SALT33.StrType R_FNAME,TYPEOF(h.FNAME_weight100) R_FNAME_spec,SALT33.StrType R_MNAME,TYPEOF(h.MNAME_weight100) R_MNAME_spec,SALT33.StrType R_LNAME,TYPEOF(h.LNAME_weight100) R_LNAME_spec,BOOLEAN el) := MAP(
	L = R => SALT33.MatchCode.ExactMatch,
	~el AND SALT33.fn_concept_wordbag_EditN.Match3((SALT33.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init,L_FNAME_edit,(SALT33.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init,L_MNAME_edit,(SALT33.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init,L_LNAME_edit, (SALT33.StrType)R_FNAME,R_FNAME_spec, (SALT33.StrType)R_MNAME,R_MNAME_spec, (SALT33.StrType)R_LNAME,R_LNAME_spec) <> 0 => SALT33.MatchCode.WordBagMatch,
	el AND SALT33.fn_concept_wordbag_EditN_EL.Match3((SALT33.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init, L_FNAME_initial_char_weight100,L_FNAME_edit,(SALT33.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init, L_MNAME_initial_char_weight100,L_MNAME_edit,(SALT33.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init, L_LNAME_initial_char_weight100,L_LNAME_edit, (SALT33.StrType)R_FNAME, (SALT33.StrType)R_MNAME, (SALT33.StrType)R_LNAME) <> 0 => SALT33.MatchCode.WordBagMatch,
	SALT33.MatchCode.NoMatch);
EXPORT match_FULLNAME(TYPEOF(h.FULLNAME) L,TYPEOF(h.FULLNAME) R) := MAP(
	L = R => SALT33.MatchCode.ExactMatch,
	SALT33.MatchCode.NoMatch);
END;
