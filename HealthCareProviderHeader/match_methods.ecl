IMPORT SALT29,std;
EXPORT match_methods(DATASET(layout_HealthProvider) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_SSN(TYPEOF(h.SSN) L, TYPEOF(h.SSN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		fn_Right4(L) =  fn_Right4(R) => SALT29.MatchCode.CustomFuzzyMatch, // Compare fn_Right4 values
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_UPIN(TYPEOF(h.UPIN) L, TYPEOF(h.UPIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_NPI_NUMBER(TYPEOF(h.NPI_NUMBER) L, TYPEOF(h.NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_DEA_NUMBER(TYPEOF(h.DEA_NUMBER) L, TYPEOF(h.DEA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_DID(TYPEOF(h.DID) L, TYPEOF(h.DID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_VENDOR_ID(TYPEOF(h.VENDOR_ID) L, TYPEOF(h.VENDOR_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CNSMR_SSN(TYPEOF(h.CNSMR_SSN) L, TYPEOF(h.CNSMR_SSN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_MAINNAME(TYPEOF(h.MAINNAME) L,TYPEOF(h.MAINNAME) R,SALT29.StrType L_FNAME,TYPEOF(h.FNAME_weight100) L_FNAME_spec,BOOLEAN L_FNAME_allow_blank,INTEGER L_FNAME_force,BOOLEAN L_FNAME_use_init,INTEGER L_FNAME_edit,SALT29.StrType L_MNAME,TYPEOF(h.MNAME_weight100) L_MNAME_spec,BOOLEAN L_MNAME_allow_blank,INTEGER L_MNAME_force,BOOLEAN L_MNAME_use_init,INTEGER L_MNAME_edit,SALT29.StrType L_LNAME,TYPEOF(h.LNAME_weight100) L_LNAME_spec,BOOLEAN L_LNAME_allow_blank,INTEGER L_LNAME_force,BOOLEAN L_LNAME_use_init,INTEGER L_LNAME_edit,SALT29.StrType R_FNAME,TYPEOF(h.FNAME_weight100) R_FNAME_spec,SALT29.StrType R_MNAME,TYPEOF(h.MNAME_weight100) R_MNAME_spec,SALT29.StrType R_LNAME,TYPEOF(h.LNAME_weight100) R_LNAME_spec) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.fn_concept_wordbag_EditN.Match3((SALT29.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init,L_FNAME_edit,(SALT29.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init,L_MNAME_edit,(SALT29.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init,L_LNAME_edit, (SALT29.StrType)R_FNAME,R_FNAME_spec, (SALT29.StrType)R_MNAME,R_MNAME_spec, (SALT29.StrType)R_LNAME,R_LNAME_spec) <> 0 => SALT29.MatchCode.WordBagMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_FULLNAME(TYPEOF(h.FULLNAME) L,TYPEOF(h.FULLNAME) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_FAX(TYPEOF(h.FAX) L, TYPEOF(h.FAX) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_C_LIC_NBR(TYPEOF(h.C_LIC_NBR) L, TYPEOF(h.C_LIC_NBR) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_ADDRESS(TYPEOF(h.ADDRESS) L,TYPEOF(h.ADDRESS) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_ADDR1(TYPEOF(h.ADDR1) L,TYPEOF(h.ADDR1) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_DOB_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT29.MatchCode.ExactMatch,
	SALT29.Fn_YearMatch(L_year,R_year,12) => SALT29.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	SALT29.MatchCode.NoMatch);
EXPORT match_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT29.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT29.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT29.MatchCode.NoMatch);
EXPORT match_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT29.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT29.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT29.MatchCode.NoMatch);
EXPORT match_DOB(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT29.MatchCode.ExactMatch,
	SALT29.Fn_YearMatch(L_year,R_year,12) AND L_month = R_month AND L_day = R_day => SALT29.MatchCode.YearMatch, // assumes even year distribution - so 3x less specific
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT29.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT29.MatchCode.NoMatch);
EXPORT match_CNSMR_DOB_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_CNSMR_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT29.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT29.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT29.MatchCode.NoMatch);
EXPORT match_CNSMR_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT29.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT29.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT29.MatchCode.NoMatch);
EXPORT match_CNSMR_DOB(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT29.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT29.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT29.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT29.MatchCode.NoMatch);
EXPORT match_BILLING_TAX_ID(TYPEOF(h.BILLING_TAX_ID) L, TYPEOF(h.BILLING_TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_BILLING_NPI_NUMBER(TYPEOF(h.BILLING_NPI_NUMBER) L, TYPEOF(h.BILLING_NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_LOCALE(TYPEOF(h.LOCALE) L,TYPEOF(h.LOCALE) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_LNAME(TYPEOF(h.LNAME) L, TYPEOF(h.LNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.HyphenMatch(L,R,1)<=2 => SALT29.MatchCode.HyphenMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT29.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT29.MatchCode.InitialMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_V_CITY_NAME(TYPEOF(h.V_CITY_NAME) L, TYPEOF(h.V_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_LAT_LONG(TYPEOF(h.LAT_LONG) L, TYPEOF(h.LAT_LONG) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_SNAME(TYPEOF(h.SNAME) L, TYPEOF(h.SNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		fn_NormSuffix(L) =  fn_NormSuffix(R) => SALT29.MatchCode.CustomFuzzyMatch, // Compare fn_NormSuffix values
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_FNAME(TYPEOF(h.FNAME) L, TYPEOF(h.FNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		fn_PreferredName(L) =  fn_PreferredName(R) => SALT29.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT29.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT29.MatchCode.InitialMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_MNAME(TYPEOF(h.MNAME) L, TYPEOF(h.MNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT29.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT29.MatchCode.InitialMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_TAXONOMY(TYPEOF(h.TAXONOMY) L, TYPEOF(h.TAXONOMY) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.HyphenMatch(L,R,1)<=2 => SALT29.MatchCode.HyphenMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_LIC_TYPE(TYPEOF(h.LIC_TYPE) L, TYPEOF(h.LIC_TYPE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchBagOfWords(L,R,32019,1) <> 0 => SALT29.MatchCode.WordBagMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_GENDER(TYPEOF(h.GENDER) L, TYPEOF(h.GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_DERIVED_GENDER(TYPEOF(h.DERIVED_GENDER) L, TYPEOF(h.DERIVED_GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_TAX_ID(TYPEOF(h.TAX_ID) L, TYPEOF(h.TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
END;

