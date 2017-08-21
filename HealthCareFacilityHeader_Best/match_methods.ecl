IMPORT SALT30,std;
EXPORT match_methods(DATASET(layout_HealthFacility) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_PHONE(TYPEOF(h.PHONE) L, TYPEOF(h.PHONE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_FAX(TYPEOF(h.FAX) L, TYPEOF(h.FAX) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_NPI_NUMBER(TYPEOF(h.NPI_NUMBER) L, TYPEOF(h.NPI_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_DEA_NUMBER(TYPEOF(h.DEA_NUMBER) L, TYPEOF(h.DEA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_CLIA_NUMBER(TYPEOF(h.CLIA_NUMBER) L, TYPEOF(h.CLIA_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_MEDICARE_FACILITY_NUMBER(TYPEOF(h.MEDICARE_FACILITY_NUMBER) L, TYPEOF(h.MEDICARE_FACILITY_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_NCPDP_NUMBER(TYPEOF(h.NCPDP_NUMBER) L, TYPEOF(h.NCPDP_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_TAX_ID(TYPEOF(h.TAX_ID) L, TYPEOF(h.TAX_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_FEIN(TYPEOF(h.FEIN) L, TYPEOF(h.FEIN) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_C_LIC_NBR(TYPEOF(h.C_LIC_NBR) L, TYPEOF(h.C_LIC_NBR) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_CNP_NAME(TYPEOF(h.CNP_NAME) L, TYPEOF(h.CNP_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.HyphenMatch(L,R,1)<=1 => SALT30.MatchCode.HyphenMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchBagOfWords(L,R,3407383,0) <> 0 => SALT30.MatchCode.WordBagMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_CNP_NUMBER(TYPEOF(h.CNP_NUMBER) L, TYPEOF(h.CNP_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_CNP_STORE_NUMBER(TYPEOF(h.CNP_STORE_NUMBER) L, TYPEOF(h.CNP_STORE_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_CNP_BTYPE(TYPEOF(h.CNP_BTYPE) L, TYPEOF(h.CNP_BTYPE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_PRIM_RANGE(TYPEOF(h.PRIM_RANGE) L, TYPEOF(h.PRIM_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_PRIM_NAME(TYPEOF(h.PRIM_NAME) L, TYPEOF(h.PRIM_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchBagOfWords(L,R,32019,1) <> 0 => SALT30.MatchCode.WordBagMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_SEC_RANGE(TYPEOF(h.SEC_RANGE) L, TYPEOF(h.SEC_RANGE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.HyphenMatch(L,R,1)<=2 => SALT30.MatchCode.HyphenMatch,
		SALT30.WithinEditN(L,R,1, 0) => SALT30.MatchCode.EditDistanceMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_ST(TYPEOF(h.ST) L, TYPEOF(h.ST) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_V_CITY_NAME(TYPEOF(h.V_CITY_NAME) L, TYPEOF(h.V_CITY_NAME) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_ZIP(TYPEOF(h.ZIP) L, TYPEOF(h.ZIP) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_TAXONOMY(TYPEOF(h.TAXONOMY) L, TYPEOF(h.TAXONOMY) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_TAXONOMY_CODE(TYPEOF(h.TAXONOMY_CODE) L, TYPEOF(h.TAXONOMY_CODE) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_MEDICAID_NUMBER(TYPEOF(h.MEDICAID_NUMBER) L, TYPEOF(h.MEDICAID_NUMBER) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_VENDOR_ID(TYPEOF(h.VENDOR_ID) L, TYPEOF(h.VENDOR_ID) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT30.MatchCode.ExactMatch,
		SALT30.MatchCode.NoMatch),
	MAP(L = R => SALT30.MatchCode.ExactMatch, SALT30.MatchCode.NoMatch)
);
EXPORT match_FAC_NAME(TYPEOF(h.FAC_NAME) L,TYPEOF(h.FAC_NAME) R,SALT30.StrType L_CNP_NAME,TYPEOF(h.CNP_NAME_weight100) L_CNP_NAME_spec,BOOLEAN L_CNP_NAME_allow_blank,INTEGER L_CNP_NAME_force,BOOLEAN L_CNP_NAME_use_init,INTEGER L_CNP_NAME_edit,SALT30.StrType L_CNP_NUMBER,TYPEOF(h.CNP_NUMBER_weight100) L_CNP_NUMBER_spec,BOOLEAN L_CNP_NUMBER_allow_blank,INTEGER L_CNP_NUMBER_force,BOOLEAN L_CNP_NUMBER_use_init,INTEGER L_CNP_NUMBER_edit,SALT30.StrType L_CNP_STORE_NUMBER,TYPEOF(h.CNP_STORE_NUMBER_weight100) L_CNP_STORE_NUMBER_spec,BOOLEAN L_CNP_STORE_NUMBER_allow_blank,INTEGER L_CNP_STORE_NUMBER_force,BOOLEAN L_CNP_STORE_NUMBER_use_init,INTEGER L_CNP_STORE_NUMBER_edit,SALT30.StrType L_CNP_BTYPE,TYPEOF(h.CNP_BTYPE_weight100) L_CNP_BTYPE_spec,BOOLEAN L_CNP_BTYPE_allow_blank,INTEGER L_CNP_BTYPE_force,BOOLEAN L_CNP_BTYPE_use_init,INTEGER L_CNP_BTYPE_edit,SALT30.StrType R_CNP_NAME,TYPEOF(h.CNP_NAME_weight100) R_CNP_NAME_spec,SALT30.StrType R_CNP_NUMBER,TYPEOF(h.CNP_NUMBER_weight100) R_CNP_NUMBER_spec,SALT30.StrType R_CNP_STORE_NUMBER,TYPEOF(h.CNP_STORE_NUMBER_weight100) R_CNP_STORE_NUMBER_spec,SALT30.StrType R_CNP_BTYPE,TYPEOF(h.CNP_BTYPE_weight100) R_CNP_BTYPE_spec) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.fn_concept_wordbag_EditN.Match4((SALT30.StrType)L_CNP_NAME,L_CNP_NAME_spec,L_CNP_NAME_allow_blank,L_CNP_NAME_force,L_CNP_NAME_use_init,L_CNP_NAME_edit,(SALT30.StrType)L_CNP_NUMBER,L_CNP_NUMBER_spec,L_CNP_NUMBER_allow_blank,L_CNP_NUMBER_force,L_CNP_NUMBER_use_init,L_CNP_NUMBER_edit,(SALT30.StrType)L_CNP_STORE_NUMBER,L_CNP_STORE_NUMBER_spec,L_CNP_STORE_NUMBER_allow_blank,L_CNP_STORE_NUMBER_force,L_CNP_STORE_NUMBER_use_init,L_CNP_STORE_NUMBER_edit,(SALT30.StrType)L_CNP_BTYPE,L_CNP_BTYPE_spec,L_CNP_BTYPE_allow_blank,L_CNP_BTYPE_force,L_CNP_BTYPE_use_init,L_CNP_BTYPE_edit, (SALT30.StrType)R_CNP_NAME,R_CNP_NAME_spec, (SALT30.StrType)R_CNP_NUMBER,R_CNP_NUMBER_spec, (SALT30.StrType)R_CNP_STORE_NUMBER,R_CNP_STORE_NUMBER_spec, (SALT30.StrType)R_CNP_BTYPE,R_CNP_BTYPE_spec) <> 0 => SALT30.MatchCode.WordBagMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_ADDR1(TYPEOF(h.ADDR1) L,TYPEOF(h.ADDR1) R,SALT30.StrType L_PRIM_RANGE,TYPEOF(h.PRIM_RANGE_weight100) L_PRIM_RANGE_spec,BOOLEAN L_PRIM_RANGE_allow_blank,INTEGER L_PRIM_RANGE_force,BOOLEAN L_PRIM_RANGE_use_init,INTEGER L_PRIM_RANGE_edit,SALT30.StrType L_PRIM_NAME,TYPEOF(h.PRIM_NAME_weight100) L_PRIM_NAME_spec,BOOLEAN L_PRIM_NAME_allow_blank,INTEGER L_PRIM_NAME_force,BOOLEAN L_PRIM_NAME_use_init,INTEGER L_PRIM_NAME_edit,SALT30.StrType L_SEC_RANGE,TYPEOF(h.SEC_RANGE_weight100) L_SEC_RANGE_spec,BOOLEAN L_SEC_RANGE_allow_blank,INTEGER L_SEC_RANGE_force,BOOLEAN L_SEC_RANGE_use_init,INTEGER L_SEC_RANGE_edit,SALT30.StrType R_PRIM_RANGE,TYPEOF(h.PRIM_RANGE_weight100) R_PRIM_RANGE_spec,SALT30.StrType R_PRIM_NAME,TYPEOF(h.PRIM_NAME_weight100) R_PRIM_NAME_spec,SALT30.StrType R_SEC_RANGE,TYPEOF(h.SEC_RANGE_weight100) R_SEC_RANGE_spec) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.fn_concept_wordbag_EditN.Match3((SALT30.StrType)L_PRIM_RANGE,L_PRIM_RANGE_spec,L_PRIM_RANGE_allow_blank,L_PRIM_RANGE_force,L_PRIM_RANGE_use_init,L_PRIM_RANGE_edit,(SALT30.StrType)L_PRIM_NAME,L_PRIM_NAME_spec,L_PRIM_NAME_allow_blank,L_PRIM_NAME_force,L_PRIM_NAME_use_init,L_PRIM_NAME_edit,(SALT30.StrType)L_SEC_RANGE,L_SEC_RANGE_spec,L_SEC_RANGE_allow_blank,L_SEC_RANGE_force,L_SEC_RANGE_use_init,L_SEC_RANGE_edit, (SALT30.StrType)R_PRIM_RANGE,R_PRIM_RANGE_spec, (SALT30.StrType)R_PRIM_NAME,R_PRIM_NAME_spec, (SALT30.StrType)R_SEC_RANGE,R_SEC_RANGE_spec) <> 0 => SALT30.MatchCode.WordBagMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_LOCALE(TYPEOF(h.LOCALE) L,TYPEOF(h.LOCALE) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
EXPORT match_ADDRESS(TYPEOF(h.ADDRESS) L,TYPEOF(h.ADDRESS) R) := MAP(
	L = R => SALT30.MatchCode.ExactMatch,
	SALT30.MatchCode.NoMatch);
END;
