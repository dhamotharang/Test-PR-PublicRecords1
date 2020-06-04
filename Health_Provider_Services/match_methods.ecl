IMPORT SALT311,std;
EXPORT match_methods(DATASET(layout_HealthProvider) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_FNAME(TYPEOF(h.FNAME) L, TYPEOF(h.FNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
	Config.WithinEditN(L,LL,R,RL,2,5)=> SALT311.MatchCode.EditDistanceMatch,
	metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT311.MatchCode.PhoneticMatch,
    fn_PreferredName(L) =  fn_PreferredName(R) => SALT311.MatchCode.CustomFuzzyMatch, // Compare fn_PreferredName values
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_MNAME(TYPEOF(h.MNAME) L, TYPEOF(h.MNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
	Config.WithinEditN(L,LL,R,RL,2,5)=> SALT311.MatchCode.EditDistanceMatch,
	metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT311.MatchCode.PhoneticMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_LNAME(TYPEOF(h.LNAME) L, TYPEOF(h.LNAME) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.HyphenMatch(L,R,1)<=2 => SALT311.MatchCode.HyphenMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT311.MatchCode.InitialLMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT311.MatchCode.InitialRMatch,
	Config.WithinEditN(L,LL,R,RL,2,5)=> SALT311.MatchCode.EditDistanceMatch,
	metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT311.MatchCode.PhoneticMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_SNAME(TYPEOF(h.SNAME) L, TYPEOF(h.SNAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    fn_clean_suffix(L) =  fn_clean_suffix(R) => SALT311.MatchCode.CustomFuzzyMatch, // Compare fn_clean_suffix values
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_GENDER(TYPEOF(h.GENDER) L, TYPEOF(h.GENDER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.HyphenMatch(L,R,1)<=2 => SALT311.MatchCode.HyphenMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_V_CITY_NAME(TYPEOF(h.V_CITY_NAME) L, TYPEOF(h.V_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_SSN(TYPEOF(h.SSN) L, TYPEOF(h.SSN) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_CNSMR_SSN(TYPEOF(h.CNSMR_SSN) L, TYPEOF(h.CNSMR_SSN) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_DOB_year(INTEGER2 L_year,INTEGER2 R_year,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_year= R_year => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_year= R_year => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_month = R_month => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_month = R_month => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_day = R_day => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_day = R_day => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_DOB_el(INTEGER2 L_year, INTEGER1 L_month, INTEGER1 L_day, INTEGER4 R, INTEGER2 AggWeight,BOOLEAN RequiredField = FALSE) := FUNCTION
 	RETURN SALT311.MatchCode.DateAggregate;
END;
EXPORT match_CNSMR_DOB_year(INTEGER2 L_year,INTEGER2 R_year,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_year= R_year => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_year= R_year => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_CNSMR_DOB_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_month = R_month => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_month = R_month => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_CNSMR_DOB_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day,BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(
	L_day = R_day => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch),
   MAP(	L_day = R_day => SALT311.MatchCode.ExactMatch,
	SALT311.MatchCode.NoMatch));
EXPORT match_CNSMR_DOB_el(INTEGER2 L_year, INTEGER1 L_month, INTEGER1 L_day, INTEGER4 R, INTEGER2 AggWeight,BOOLEAN RequiredField = FALSE) := FUNCTION
 	RETURN SALT311.MatchCode.DateAggregate;
END;
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    fn_cleanphone(L) =  fn_cleanphone(R) => SALT311.MatchCode.CustomFuzzyMatch, // Compare fn_cleanphone values
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_LIC_STATE(TYPEOF(h.LIC_STATE) L, TYPEOF(h.LIC_STATE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_C_LIC_NBR(TYPEOF(h.C_LIC_NBR) L, TYPEOF(h.C_LIC_NBR) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
	Config.WithinEditN(L,LL,R,RL,1,0)=> SALT311.MatchCode.EditDistanceMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_TAX_ID(TYPEOF(h.TAX_ID) L, TYPEOF(h.TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_BILLING_TAX_ID(TYPEOF(h.BILLING_TAX_ID) L, TYPEOF(h.BILLING_TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_DEA_NUMBER(TYPEOF(h.DEA_NUMBER) L, TYPEOF(h.DEA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_VENDOR_ID(TYPEOF(h.VENDOR_ID) L, TYPEOF(h.VENDOR_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_NPI_NUMBER(TYPEOF(h.NPI_NUMBER) L, TYPEOF(h.NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_BILLING_NPI_NUMBER(TYPEOF(h.BILLING_NPI_NUMBER) L, TYPEOF(h.BILLING_NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_UPIN(TYPEOF(h.UPIN) L, TYPEOF(h.UPIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_DID(TYPEOF(h.DID) L, TYPEOF(h.DID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_BDID(TYPEOF(h.BDID) L, TYPEOF(h.BDID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_SRC(TYPEOF(h.SRC) L, TYPEOF(h.SRC) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_SOURCE_RID(TYPEOF(h.SOURCE_RID) L, TYPEOF(h.SOURCE_RID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_RID(TYPEOF(h.RID) L, TYPEOF(h.RID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT311.MatchCode.ExactMatch,
    SALT311.MatchCode.NoMatch),
     MAP(L = R => SALT311.MatchCode.ExactMatch, SALT311.MatchCode.NoMatch)
);
EXPORT match_MAINNAME(TYPEOF(h.MAINNAME) L,TYPEOF(h.MAINNAME) R,SALT311.StrType L_FNAME = '',TYPEOF(h.FNAME_weight100) L_FNAME_spec = 0,BOOLEAN L_FNAME_allow_blank = FALSE,INTEGER L_FNAME_force = 0,BOOLEAN L_FNAME_use_init = FALSE, UNSIGNED2 L_FNAME_initial_char_weight100 = 0,INTEGER L_FNAME_edit = 0,UNSIGNED2 L_FNAME_edit_threshold = 0,UNSIGNED2 L_FNAME_length = 0,TYPEOF(h.FNAME_MAINNAME_weight100) L_FNAME_MAINNAME_fuzzy_weight100 = 0,SALT311.StrType L_MNAME = '',TYPEOF(h.MNAME_weight100) L_MNAME_spec = 0,BOOLEAN L_MNAME_allow_blank = FALSE,INTEGER L_MNAME_force = 0,BOOLEAN L_MNAME_use_init = FALSE, UNSIGNED2 L_MNAME_initial_char_weight100 = 0,INTEGER L_MNAME_edit = 0,UNSIGNED2 L_MNAME_edit_threshold = 0,UNSIGNED2 L_MNAME_length = 0,TYPEOF(h.MNAME_MAINNAME_weight100) L_MNAME_MAINNAME_fuzzy_weight100 = 0,SALT311.StrType L_LNAME = '',TYPEOF(h.LNAME_weight100) L_LNAME_spec = 0,BOOLEAN L_LNAME_allow_blank = FALSE,INTEGER L_LNAME_force = 0,BOOLEAN L_LNAME_use_init = FALSE, UNSIGNED2 L_LNAME_initial_char_weight100 = 0,INTEGER L_LNAME_edit = 0,UNSIGNED2 L_LNAME_edit_threshold = 0,UNSIGNED2 L_LNAME_length = 0,TYPEOF(h.LNAME_MAINNAME_weight100) L_LNAME_MAINNAME_fuzzy_weight100 = 0,SALT311.StrType R_FNAME = '',TYPEOF(h.FNAME_weight100) R_FNAME_spec = 0,UNSIGNED2 R_FNAME_length = 0,TYPEOF(h.FNAME_MAINNAME_weight100) R_FNAME_MAINNAME_fuzzy_weight100 = 0,SALT311.StrType R_MNAME = '',TYPEOF(h.MNAME_weight100) R_MNAME_spec = 0,UNSIGNED2 R_MNAME_length = 0,TYPEOF(h.MNAME_MAINNAME_weight100) R_MNAME_MAINNAME_fuzzy_weight100 = 0,SALT311.StrType R_LNAME = '',TYPEOF(h.LNAME_weight100) R_LNAME_spec = 0,UNSIGNED2 R_LNAME_length = 0,TYPEOF(h.LNAME_MAINNAME_weight100) R_LNAME_MAINNAME_fuzzy_weight100 = 0,BOOLEAN el, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
    ~el AND SALT311.fn_concept_wordbag_EditN.Match3((SALT311.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init,L_FNAME_edit,L_FNAME_edit_threshold,L_FNAME_length,L_FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init,L_MNAME_edit,L_MNAME_edit_threshold,L_MNAME_length,L_MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init,L_LNAME_edit,L_LNAME_edit_threshold,L_LNAME_length,L_LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)R_FNAME,R_FNAME_spec,R_FNAME_length,R_FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)R_MNAME,R_MNAME_spec,R_MNAME_length,R_MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)R_LNAME,R_LNAME_spec,R_LNAME_length,R_LNAME_MAINNAME_fuzzy_weight100,Health_Provider_Services.Config.WithinEditN) <> 0 => SALT311.MatchCode.WordBagMatch,
    el AND SALT311.fn_concept_wordbag_EditN_EL.Match3((SALT311.StrType)L_FNAME,L_FNAME_spec,L_FNAME_allow_blank,L_FNAME_force,L_FNAME_use_init, L_FNAME_initial_char_weight100,L_FNAME_edit,L_FNAME_edit_threshold,L_FNAME_length,L_FNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)L_MNAME,L_MNAME_spec,L_MNAME_allow_blank,L_MNAME_force,L_MNAME_use_init, L_MNAME_initial_char_weight100,L_MNAME_edit,L_MNAME_edit_threshold,L_MNAME_length,L_MNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)L_LNAME,L_LNAME_spec,L_LNAME_allow_blank,L_LNAME_force,L_LNAME_use_init, L_LNAME_initial_char_weight100,L_LNAME_edit,L_LNAME_edit_threshold,L_LNAME_length,L_LNAME_MAINNAME_fuzzy_weight100,(SALT311.StrType)R_FNAME,R_FNAME_length,(SALT311.StrType)R_MNAME,R_MNAME_length,(SALT311.StrType)R_LNAME,R_LNAME_length,Health_Provider_Services.Config.WithinEditN) <> 0 => SALT311.MatchCode.WordBagMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_FULLNAME(TYPEOF(h.FULLNAME) L,TYPEOF(h.FULLNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_ADDR1(TYPEOF(h.ADDR1) L,TYPEOF(h.ADDR1) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_LOCALE(TYPEOF(h.LOCALE) L,TYPEOF(h.LOCALE) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
EXPORT match_ADDRESS(TYPEOF(h.ADDRESS) L,TYPEOF(h.ADDRESS) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT311.MatchCode.ExactMatch,
      SALT311.MatchCode.NoMatch),
        MAP(L = R => SALT311.MatchCode.ExactMatch,SALT311.MatchCode.NoMatch)
);
END;
