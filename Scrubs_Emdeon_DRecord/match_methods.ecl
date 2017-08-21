IMPORT SALT31,std;
EXPORT match_methods(DATASET(layout_DRecord) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_claim_num(TYPEOF(h.claim_num) L, TYPEOF(h.claim_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_claim_rec_type(TYPEOF(h.claim_rec_type) L, TYPEOF(h.claim_rec_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code9(TYPEOF(h.diag_code9) L, TYPEOF(h.diag_code9) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code10(TYPEOF(h.diag_code10) L, TYPEOF(h.diag_code10) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code11(TYPEOF(h.diag_code11) L, TYPEOF(h.diag_code11) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code12(TYPEOF(h.diag_code12) L, TYPEOF(h.diag_code12) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code13(TYPEOF(h.diag_code13) L, TYPEOF(h.diag_code13) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code14(TYPEOF(h.diag_code14) L, TYPEOF(h.diag_code14) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code15(TYPEOF(h.diag_code15) L, TYPEOF(h.diag_code15) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code16(TYPEOF(h.diag_code16) L, TYPEOF(h.diag_code16) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code17(TYPEOF(h.diag_code17) L, TYPEOF(h.diag_code17) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code18(TYPEOF(h.diag_code18) L, TYPEOF(h.diag_code18) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code19(TYPEOF(h.diag_code19) L, TYPEOF(h.diag_code19) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code20(TYPEOF(h.diag_code20) L, TYPEOF(h.diag_code20) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code21(TYPEOF(h.diag_code21) L, TYPEOF(h.diag_code21) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code22(TYPEOF(h.diag_code22) L, TYPEOF(h.diag_code22) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code23(TYPEOF(h.diag_code23) L, TYPEOF(h.diag_code23) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code24(TYPEOF(h.diag_code24) L, TYPEOF(h.diag_code24) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc7(TYPEOF(h.other_proc7) L, TYPEOF(h.other_proc7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc8(TYPEOF(h.other_proc8) L, TYPEOF(h.other_proc8) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc9(TYPEOF(h.other_proc9) L, TYPEOF(h.other_proc9) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc10(TYPEOF(h.other_proc10) L, TYPEOF(h.other_proc10) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc11(TYPEOF(h.other_proc11) L, TYPEOF(h.other_proc11) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc12(TYPEOF(h.other_proc12) L, TYPEOF(h.other_proc12) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc13(TYPEOF(h.other_proc13) L, TYPEOF(h.other_proc13) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc14(TYPEOF(h.other_proc14) L, TYPEOF(h.other_proc14) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc15(TYPEOF(h.other_proc15) L, TYPEOF(h.other_proc15) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc16(TYPEOF(h.other_proc16) L, TYPEOF(h.other_proc16) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc17(TYPEOF(h.other_proc17) L, TYPEOF(h.other_proc17) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc18(TYPEOF(h.other_proc18) L, TYPEOF(h.other_proc18) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc19(TYPEOF(h.other_proc19) L, TYPEOF(h.other_proc19) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc20(TYPEOF(h.other_proc20) L, TYPEOF(h.other_proc20) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc21(TYPEOF(h.other_proc21) L, TYPEOF(h.other_proc21) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_proc22(TYPEOF(h.other_proc22) L, TYPEOF(h.other_proc22) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_claim_indicator_code(TYPEOF(h.claim_indicator_code) L, TYPEOF(h.claim_indicator_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ref_prov_state_lic(TYPEOF(h.ref_prov_state_lic) L, TYPEOF(h.ref_prov_state_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ref_prov_upin(TYPEOF(h.ref_prov_upin) L, TYPEOF(h.ref_prov_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ref_prov_commercial_id(TYPEOF(h.ref_prov_commercial_id) L, TYPEOF(h.ref_prov_commercial_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_address1(TYPEOF(h.pay_to_address1) L, TYPEOF(h.pay_to_address1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_address2(TYPEOF(h.pay_to_address2) L, TYPEOF(h.pay_to_address2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_city(TYPEOF(h.pay_to_city) L, TYPEOF(h.pay_to_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_zip(TYPEOF(h.pay_to_zip) L, TYPEOF(h.pay_to_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_state(TYPEOF(h.pay_to_state) L, TYPEOF(h.pay_to_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_org_name(TYPEOF(h.supervising_prov_org_name) L, TYPEOF(h.supervising_prov_org_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_last_name(TYPEOF(h.supervising_prov_last_name) L, TYPEOF(h.supervising_prov_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_first_name(TYPEOF(h.supervising_prov_first_name) L, TYPEOF(h.supervising_prov_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_middle_name(TYPEOF(h.supervising_prov_middle_name) L, TYPEOF(h.supervising_prov_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_npi(TYPEOF(h.supervising_prov_npi) L, TYPEOF(h.supervising_prov_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_state_lic(TYPEOF(h.supervising_prov_state_lic) L, TYPEOF(h.supervising_prov_state_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_upin(TYPEOF(h.supervising_prov_upin) L, TYPEOF(h.supervising_prov_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_commercial_id(TYPEOF(h.supervising_prov_commercial_id) L, TYPEOF(h.supervising_prov_commercial_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_supervising_prov_location(TYPEOF(h.supervising_prov_location) L, TYPEOF(h.supervising_prov_location) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_org_name(TYPEOF(h.operating_prov_org_name) L, TYPEOF(h.operating_prov_org_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_last_name(TYPEOF(h.operating_prov_last_name) L, TYPEOF(h.operating_prov_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_first_name(TYPEOF(h.operating_prov_first_name) L, TYPEOF(h.operating_prov_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_middle_name(TYPEOF(h.operating_prov_middle_name) L, TYPEOF(h.operating_prov_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_npi(TYPEOF(h.operating_prov_npi) L, TYPEOF(h.operating_prov_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_state_lic(TYPEOF(h.operating_prov_state_lic) L, TYPEOF(h.operating_prov_state_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_upin(TYPEOF(h.operating_prov_upin) L, TYPEOF(h.operating_prov_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_commercial_id(TYPEOF(h.operating_prov_commercial_id) L, TYPEOF(h.operating_prov_commercial_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_operating_prov_location(TYPEOF(h.operating_prov_location) L, TYPEOF(h.operating_prov_location) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_org_name(TYPEOF(h.other_operating_prov_org_name) L, TYPEOF(h.other_operating_prov_org_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_last_name(TYPEOF(h.other_operating_prov_last_name) L, TYPEOF(h.other_operating_prov_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_first_name(TYPEOF(h.other_operating_prov_first_name) L, TYPEOF(h.other_operating_prov_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_middle_name(TYPEOF(h.other_operating_prov_middle_name) L, TYPEOF(h.other_operating_prov_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_npi(TYPEOF(h.other_operating_prov_npi) L, TYPEOF(h.other_operating_prov_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_state_lic(TYPEOF(h.other_operating_prov_state_lic) L, TYPEOF(h.other_operating_prov_state_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_upin(TYPEOF(h.other_operating_prov_upin) L, TYPEOF(h.other_operating_prov_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_commercial_id(TYPEOF(h.other_operating_prov_commercial_id) L, TYPEOF(h.other_operating_prov_commercial_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_operating_prov_location(TYPEOF(h.other_operating_prov_location) L, TYPEOF(h.other_operating_prov_location) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_name(TYPEOF(h.pay_to_plan_name) L, TYPEOF(h.pay_to_plan_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_address1(TYPEOF(h.pay_to_plan_address1) L, TYPEOF(h.pay_to_plan_address1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_address2(TYPEOF(h.pay_to_plan_address2) L, TYPEOF(h.pay_to_plan_address2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_city(TYPEOF(h.pay_to_plan_city) L, TYPEOF(h.pay_to_plan_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_zip(TYPEOF(h.pay_to_plan_zip) L, TYPEOF(h.pay_to_plan_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_state(TYPEOF(h.pay_to_plan_state) L, TYPEOF(h.pay_to_plan_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_naic_id(TYPEOF(h.pay_to_plan_naic_id) L, TYPEOF(h.pay_to_plan_naic_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_payer_id(TYPEOF(h.pay_to_plan_payer_id) L, TYPEOF(h.pay_to_plan_payer_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_plan_id(TYPEOF(h.pay_to_plan_plan_id) L, TYPEOF(h.pay_to_plan_plan_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_claim_ofc_num(TYPEOF(h.pay_to_plan_claim_ofc_num) L, TYPEOF(h.pay_to_plan_claim_ofc_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_plan_tax_id(TYPEOF(h.pay_to_plan_tax_id) L, TYPEOF(h.pay_to_plan_tax_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_payer_name(TYPEOF(h.cob1_payer_name) L, TYPEOF(h.cob1_payer_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_payer_id(TYPEOF(h.cob1_payer_id) L, TYPEOF(h.cob1_payer_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_hpid(TYPEOF(h.cob1_hpid) L, TYPEOF(h.cob1_hpid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_resp_seq_code(TYPEOF(h.cob1_resp_seq_code) L, TYPEOF(h.cob1_resp_seq_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_relationship_code(TYPEOF(h.cob1_relationship_code) L, TYPEOF(h.cob1_relationship_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_group_policy_num(TYPEOF(h.cob1_group_policy_num) L, TYPEOF(h.cob1_group_policy_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_group_name(TYPEOF(h.cob1_group_name) L, TYPEOF(h.cob1_group_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_ins_type_code(TYPEOF(h.cob1_ins_type_code) L, TYPEOF(h.cob1_ins_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_cob1_claim_filing_indicator(TYPEOF(h.cob1_claim_filing_indicator) L, TYPEOF(h.cob1_claim_filing_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
END;

