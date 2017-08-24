IMPORT SALT37,std;
EXPORT match_methods(DATASET(layout_Classify_PS) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_NAME_SUFFIX(TYPEOF(h.NAME_SUFFIX) L, TYPEOF(h.NAME_SUFFIX) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_FNAME(TYPEOF(h.FNAME) L, TYPEOF(h.FNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
	metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT37.MatchCode.PhoneticMatch,
    fn_PreferredName(L) =  fn_PreferredName(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_MNAME(TYPEOF(h.MNAME) L, TYPEOF(h.MNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config.WithinEditN(L,LL,R,RL,2, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LNAME(TYPEOF(h.LNAME) L, TYPEOF(h.LNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchBagOfWords(L,R,31744,3) <> 0  => SALT37.MatchCode.WordBagMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=2 => SALT37.MatchCode.HyphenMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_P_CITY_NAME(TYPEOF(h.P_CITY_NAME) L, TYPEOF(h.P_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DOB_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT37.MatchCode.ExactMatch,
	SALT37.Fn_YearMatch(L_year,R_year,13) => SALT37.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
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
	SALT37.Fn_YearMatch(L_year,R_year,13) AND L_month = R_month AND L_day = R_day => SALT37.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	L_month = R_day AND L_day = R_month => SALT37.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT37.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT37.MatchCode.NoMatch);
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DL_ST(TYPEOF(h.DL_ST) L, TYPEOF(h.DL_ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DL(TYPEOF(h.DL) L, TYPEOF(h.DL) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LEXID(TYPEOF(h.LEXID) L, TYPEOF(h.LEXID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_POSSIBLE_SSN(TYPEOF(h.POSSIBLE_SSN) L, TYPEOF(h.POSSIBLE_SSN) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CRIME(TYPEOF(h.CRIME) L, TYPEOF(h.CRIME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_NAME_TYPE(TYPEOF(h.NAME_TYPE) L, TYPEOF(h.NAME_TYPE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CLEAN_GENDER(TYPEOF(h.CLEAN_GENDER) L, TYPEOF(h.CLEAN_GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CLASS_CODE(TYPEOF(h.CLASS_CODE) L, TYPEOF(h.CLASS_CODE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DT_FIRST_SEEN(TYPEOF(h.DT_FIRST_SEEN) L, TYPEOF(h.DT_FIRST_SEEN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DT_LAST_SEEN(TYPEOF(h.DT_LAST_SEEN) L, TYPEOF(h.DT_LAST_SEEN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_DATA_PROVIDER_ORI(TYPEOF(h.DATA_PROVIDER_ORI) L, TYPEOF(h.DATA_PROVIDER_ORI) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_VIN(TYPEOF(h.VIN) L, TYPEOF(h.VIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_PLATE(TYPEOF(h.PLATE) L, TYPEOF(h.PLATE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LATITUDE(TYPEOF(h.LATITUDE) L, TYPEOF(h.LATITUDE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_LONGITUDE(TYPEOF(h.LONGITUDE) L, TYPEOF(h.LONGITUDE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_SEARCH_ADDR1(TYPEOF(h.SEARCH_ADDR1) L, TYPEOF(h.SEARCH_ADDR1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_SEARCH_ADDR2(TYPEOF(h.SEARCH_ADDR2) L, TYPEOF(h.SEARCH_ADDR2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CLEAN_COMPANY_NAME(TYPEOF(h.CLEAN_COMPANY_NAME) L, TYPEOF(h.CLEAN_COMPANY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_MAINNAME(TYPEOF(h.MAINNAME) L,TYPEOF(h.MAINNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_FULLNAME(TYPEOF(h.FULLNAME) L,TYPEOF(h.FULLNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
END;
