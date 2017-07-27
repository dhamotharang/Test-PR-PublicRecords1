IMPORT SALT29,std;
EXPORT match_methods(DATASET(layout_HealthFacility) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_CNP_NAME(TYPEOF(h.CNP_NAME) L, TYPEOF(h.CNP_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.HyphenMatch(L,R,1)<=1 => SALT29.MatchCode.HyphenMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchBagOfWords(L,R,3407639,0) <> 0 => SALT29.MatchCode.WordBagMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CNP_NUMBER(TYPEOF(h.CNP_NUMBER) L, TYPEOF(h.CNP_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CNP_STORE_NUMBER(TYPEOF(h.CNP_STORE_NUMBER) L, TYPEOF(h.CNP_STORE_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CNP_BTYPE(TYPEOF(h.CNP_BTYPE) L, TYPEOF(h.CNP_BTYPE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CNP_LOWV(TYPEOF(h.CNP_LOWV) L, TYPEOF(h.CNP_LOWV) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,1, 0) => SALT29.MatchCode.EditDistanceMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.HyphenMatch(L,R,1)<=2 => SALT29.MatchCode.HyphenMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_V_CITY_NAME(TYPEOF(h.V_CITY_NAME) L, TYPEOF(h.V_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,2, 0) => SALT29.MatchCode.EditDistanceMatch,
		metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT29.MatchCode.PhoneticMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_TAX_ID(TYPEOF(h.TAX_ID) L, TYPEOF(h.TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_FEIN(TYPEOF(h.FEIN) L, TYPEOF(h.FEIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		fn_cleanphone(L) =  fn_cleanphone(R) => SALT29.MatchCode.CustomFuzzyMatch, // Compare fn_cleanphone values
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_FAX(TYPEOF(h.FAX) L, TYPEOF(h.FAX) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		fn_cleanphone(L) =  fn_cleanphone(R) => SALT29.MatchCode.CustomFuzzyMatch, // Compare fn_cleanphone values
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_LIC_STATE(TYPEOF(h.LIC_STATE) L, TYPEOF(h.LIC_STATE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_C_LIC_NBR(TYPEOF(h.C_LIC_NBR) L, TYPEOF(h.C_LIC_NBR) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.WithinEditN(L,R,2, 0) => SALT29.MatchCode.EditDistanceMatch,
		LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT29.MatchCode.InitialMatch,
		LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT29.MatchCode.InitialMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_DEA_NUMBER(TYPEOF(h.DEA_NUMBER) L, TYPEOF(h.DEA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_VENDOR_ID(TYPEOF(h.VENDOR_ID) L, TYPEOF(h.VENDOR_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_NPI_NUMBER(TYPEOF(h.NPI_NUMBER) L, TYPEOF(h.NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_CLIA_NUMBER(TYPEOF(h.CLIA_NUMBER) L, TYPEOF(h.CLIA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_MEDICARE_FACILITY_NUMBER(TYPEOF(h.MEDICARE_FACILITY_NUMBER) L, TYPEOF(h.MEDICARE_FACILITY_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_MEDICAID_NUMBER(TYPEOF(h.MEDICAID_NUMBER) L, TYPEOF(h.MEDICAID_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_NCPDP_NUMBER(TYPEOF(h.NCPDP_NUMBER) L, TYPEOF(h.NCPDP_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_TAXONOMY(TYPEOF(h.TAXONOMY) L, TYPEOF(h.TAXONOMY) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_TAXONOMY_CODE(TYPEOF(h.TAXONOMY_CODE) L, TYPEOF(h.TAXONOMY_CODE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_BDID(TYPEOF(h.BDID) L, TYPEOF(h.BDID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_SRC(TYPEOF(h.SRC) L, TYPEOF(h.SRC) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_SOURCE_RID(TYPEOF(h.SOURCE_RID) L, TYPEOF(h.SOURCE_RID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT29.MatchCode.ExactMatch,
		SALT29.MatchCode.NoMatch),
	MAP(L = R => SALT29.MatchCode.ExactMatch, SALT29.MatchCode.NoMatch)
);
EXPORT match_FAC_NAME(TYPEOF(h.FAC_NAME) L,TYPEOF(h.FAC_NAME) R,SALT29.StrType L_CNP_NAME,TYPEOF(h.CNP_NAME_weight100) L_CNP_NAME_spec,BOOLEAN L_CNP_NAME_allow_blank,INTEGER L_CNP_NAME_force,BOOLEAN L_CNP_NAME_use_init,INTEGER L_CNP_NAME_edit,SALT29.StrType L_CNP_NUMBER,TYPEOF(h.CNP_NUMBER_weight100) L_CNP_NUMBER_spec,BOOLEAN L_CNP_NUMBER_allow_blank,INTEGER L_CNP_NUMBER_force,BOOLEAN L_CNP_NUMBER_use_init,INTEGER L_CNP_NUMBER_edit,SALT29.StrType L_CNP_STORE_NUMBER,TYPEOF(h.CNP_STORE_NUMBER_weight100) L_CNP_STORE_NUMBER_spec,BOOLEAN L_CNP_STORE_NUMBER_allow_blank,INTEGER L_CNP_STORE_NUMBER_force,BOOLEAN L_CNP_STORE_NUMBER_use_init,INTEGER L_CNP_STORE_NUMBER_edit,SALT29.StrType L_CNP_BTYPE,TYPEOF(h.CNP_BTYPE_weight100) L_CNP_BTYPE_spec,BOOLEAN L_CNP_BTYPE_allow_blank,INTEGER L_CNP_BTYPE_force,BOOLEAN L_CNP_BTYPE_use_init,INTEGER L_CNP_BTYPE_edit,SALT29.StrType L_CNP_LOWV,TYPEOF(h.CNP_LOWV_weight100) L_CNP_LOWV_spec,BOOLEAN L_CNP_LOWV_allow_blank,INTEGER L_CNP_LOWV_force,BOOLEAN L_CNP_LOWV_use_init,INTEGER L_CNP_LOWV_edit,SALT29.StrType R_CNP_NAME,TYPEOF(h.CNP_NAME_weight100) R_CNP_NAME_spec,SALT29.StrType R_CNP_NUMBER,TYPEOF(h.CNP_NUMBER_weight100) R_CNP_NUMBER_spec,SALT29.StrType R_CNP_STORE_NUMBER,TYPEOF(h.CNP_STORE_NUMBER_weight100) R_CNP_STORE_NUMBER_spec,SALT29.StrType R_CNP_BTYPE,TYPEOF(h.CNP_BTYPE_weight100) R_CNP_BTYPE_spec,SALT29.StrType R_CNP_LOWV,TYPEOF(h.CNP_LOWV_weight100) R_CNP_LOWV_spec) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.fn_concept_wordbag_EditN.Match5((SALT29.StrType)L_CNP_NAME,L_CNP_NAME_spec,L_CNP_NAME_allow_blank,L_CNP_NAME_force,L_CNP_NAME_use_init,L_CNP_NAME_edit,(SALT29.StrType)L_CNP_NUMBER,L_CNP_NUMBER_spec,L_CNP_NUMBER_allow_blank,L_CNP_NUMBER_force,L_CNP_NUMBER_use_init,L_CNP_NUMBER_edit,(SALT29.StrType)L_CNP_STORE_NUMBER,L_CNP_STORE_NUMBER_spec,L_CNP_STORE_NUMBER_allow_blank,L_CNP_STORE_NUMBER_force,L_CNP_STORE_NUMBER_use_init,L_CNP_STORE_NUMBER_edit,(SALT29.StrType)L_CNP_BTYPE,L_CNP_BTYPE_spec,L_CNP_BTYPE_allow_blank,L_CNP_BTYPE_force,L_CNP_BTYPE_use_init,L_CNP_BTYPE_edit,(SALT29.StrType)L_CNP_LOWV,L_CNP_LOWV_spec,L_CNP_LOWV_allow_blank,L_CNP_LOWV_force,L_CNP_LOWV_use_init,L_CNP_LOWV_edit, (SALT29.StrType)R_CNP_NAME,R_CNP_NAME_spec, (SALT29.StrType)R_CNP_NUMBER,R_CNP_NUMBER_spec, (SALT29.StrType)R_CNP_STORE_NUMBER,R_CNP_STORE_NUMBER_spec, (SALT29.StrType)R_CNP_BTYPE,R_CNP_BTYPE_spec, (SALT29.StrType)R_CNP_LOWV,R_CNP_LOWV_spec) <> 0 => SALT29.MatchCode.WordBagMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_ADDR1(TYPEOF(h.ADDR1) L,TYPEOF(h.ADDR1) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_LOCALE(TYPEOF(h.LOCALE) L,TYPEOF(h.LOCALE) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
EXPORT match_ADDRES(TYPEOF(h.ADDRES) L,TYPEOF(h.ADDRES) R) := MAP(
	L = R => SALT29.MatchCode.ExactMatch,
	SALT29.MatchCode.NoMatch);
END;

