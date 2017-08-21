IMPORT SALT31,std;
EXPORT match_methods(DATASET(layout_MX) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_claim_type(TYPEOF(h.claim_type) L, TYPEOF(h.claim_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_claim_num(TYPEOF(h.claim_num) L, TYPEOF(h.claim_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_pay_to_taxonomy(TYPEOF(h.billing_pay_to_taxonomy) L, TYPEOF(h.billing_pay_to_taxonomy) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_addr(TYPEOF(h.billing_addr) L, TYPEOF(h.billing_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_anesth_lic(TYPEOF(h.billing_anesth_lic) L, TYPEOF(h.billing_anesth_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_city(TYPEOF(h.billing_city) L, TYPEOF(h.billing_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_dentist_lic(TYPEOF(h.billing_dentist_lic) L, TYPEOF(h.billing_dentist_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_first_name(TYPEOF(h.billing_first_name) L, TYPEOF(h.billing_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_last_name(TYPEOF(h.billing_last_name) L, TYPEOF(h.billing_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_middle_name(TYPEOF(h.billing_middle_name) L, TYPEOF(h.billing_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_npi(TYPEOF(h.billing_npi) L, TYPEOF(h.billing_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_org_name(TYPEOF(h.billing_org_name) L, TYPEOF(h.billing_org_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_service_phone(TYPEOF(h.billing_service_phone) L, TYPEOF(h.billing_service_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_specialty_code(TYPEOF(h.billing_specialty_code) L, TYPEOF(h.billing_specialty_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_specialty_lic(TYPEOF(h.billing_specialty_lic) L, TYPEOF(h.billing_specialty_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_state(TYPEOF(h.billing_state) L, TYPEOF(h.billing_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_state_lic(TYPEOF(h.billing_state_lic) L, TYPEOF(h.billing_state_lic) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_tax_id(TYPEOF(h.billing_tax_id) L, TYPEOF(h.billing_tax_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_upin(TYPEOF(h.billing_upin) L, TYPEOF(h.billing_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_billing_zip(TYPEOF(h.billing_zip) L, TYPEOF(h.billing_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code1(TYPEOF(h.diag_code1) L, TYPEOF(h.diag_code1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code2(TYPEOF(h.diag_code2) L, TYPEOF(h.diag_code2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code3(TYPEOF(h.diag_code3) L, TYPEOF(h.diag_code3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code4(TYPEOF(h.diag_code4) L, TYPEOF(h.diag_code4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code5(TYPEOF(h.diag_code5) L, TYPEOF(h.diag_code5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code6(TYPEOF(h.diag_code6) L, TYPEOF(h.diag_code6) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code7(TYPEOF(h.diag_code7) L, TYPEOF(h.diag_code7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_diag_code8(TYPEOF(h.diag_code8) L, TYPEOF(h.diag_code8) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_dme_hcpcs_proc_code(TYPEOF(h.dme_hcpcs_proc_code) L, TYPEOF(h.dme_hcpcs_proc_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_emt_paramedic_first_name(TYPEOF(h.emt_paramedic_first_name) L, TYPEOF(h.emt_paramedic_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_emt_paramedic_last_name(TYPEOF(h.emt_paramedic_last_name) L, TYPEOF(h.emt_paramedic_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_emt_paramedic_middle_name(TYPEOF(h.emt_paramedic_middle_name) L, TYPEOF(h.emt_paramedic_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ext_injury_diag_code(TYPEOF(h.ext_injury_diag_code) L, TYPEOF(h.ext_injury_diag_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_addr(TYPEOF(h.facility_lab_addr) L, TYPEOF(h.facility_lab_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_city(TYPEOF(h.facility_lab_city) L, TYPEOF(h.facility_lab_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_name(TYPEOF(h.facility_lab_name) L, TYPEOF(h.facility_lab_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_npi(TYPEOF(h.facility_lab_npi) L, TYPEOF(h.facility_lab_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_state(TYPEOF(h.facility_lab_state) L, TYPEOF(h.facility_lab_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_tax_id(TYPEOF(h.facility_lab_tax_id) L, TYPEOF(h.facility_lab_tax_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_type_code(TYPEOF(h.facility_lab_type_code) L, TYPEOF(h.facility_lab_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_facility_lab_zip(TYPEOF(h.facility_lab_zip) L, TYPEOF(h.facility_lab_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_addr(TYPEOF(h.ordering_prov_addr) L, TYPEOF(h.ordering_prov_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_city(TYPEOF(h.ordering_prov_city) L, TYPEOF(h.ordering_prov_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_first_name(TYPEOF(h.ordering_prov_first_name) L, TYPEOF(h.ordering_prov_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_last_name(TYPEOF(h.ordering_prov_last_name) L, TYPEOF(h.ordering_prov_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_middle_name(TYPEOF(h.ordering_prov_middle_name) L, TYPEOF(h.ordering_prov_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_npi(TYPEOF(h.ordering_prov_npi) L, TYPEOF(h.ordering_prov_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_state(TYPEOF(h.ordering_prov_state) L, TYPEOF(h.ordering_prov_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_upin(TYPEOF(h.ordering_prov_upin) L, TYPEOF(h.ordering_prov_upin) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ordering_prov_zip(TYPEOF(h.ordering_prov_zip) L, TYPEOF(h.ordering_prov_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_addr(TYPEOF(h.pay_to_addr) L, TYPEOF(h.pay_to_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_city(TYPEOF(h.pay_to_city) L, TYPEOF(h.pay_to_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_first_name(TYPEOF(h.pay_to_first_name) L, TYPEOF(h.pay_to_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_last_name(TYPEOF(h.pay_to_last_name) L, TYPEOF(h.pay_to_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_middle_name(TYPEOF(h.pay_to_middle_name) L, TYPEOF(h.pay_to_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_npi(TYPEOF(h.pay_to_npi) L, TYPEOF(h.pay_to_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_service_phone(TYPEOF(h.pay_to_service_phone) L, TYPEOF(h.pay_to_service_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_state(TYPEOF(h.pay_to_state) L, TYPEOF(h.pay_to_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_tax_id(TYPEOF(h.pay_to_tax_id) L, TYPEOF(h.pay_to_tax_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pay_to_zip(TYPEOF(h.pay_to_zip) L, TYPEOF(h.pay_to_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_performing_prov_phone(TYPEOF(h.performing_prov_phone) L, TYPEOF(h.performing_prov_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_performing_prov_specialty(TYPEOF(h.performing_prov_specialty) L, TYPEOF(h.performing_prov_specialty) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_performing_prov_tax_id(TYPEOF(h.performing_prov_tax_id) L, TYPEOF(h.performing_prov_tax_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_place_of_service_code(TYPEOF(h.place_of_service_code) L, TYPEOF(h.place_of_service_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_place_of_service_name(TYPEOF(h.place_of_service_name) L, TYPEOF(h.place_of_service_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_a_addr(TYPEOF(h.prov_a_addr) L, TYPEOF(h.prov_a_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_a_city(TYPEOF(h.prov_a_city) L, TYPEOF(h.prov_a_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_a_service_role_code(TYPEOF(h.prov_a_service_role_code) L, TYPEOF(h.prov_a_service_role_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_a_state(TYPEOF(h.prov_a_state) L, TYPEOF(h.prov_a_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_a_zip(TYPEOF(h.prov_a_zip) L, TYPEOF(h.prov_a_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_b_addr(TYPEOF(h.prov_b_addr) L, TYPEOF(h.prov_b_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_b_city(TYPEOF(h.prov_b_city) L, TYPEOF(h.prov_b_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_b_service_role_code(TYPEOF(h.prov_b_service_role_code) L, TYPEOF(h.prov_b_service_role_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_b_state(TYPEOF(h.prov_b_state) L, TYPEOF(h.prov_b_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_b_zip(TYPEOF(h.prov_b_zip) L, TYPEOF(h.prov_b_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_c_addr(TYPEOF(h.prov_c_addr) L, TYPEOF(h.prov_c_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_c_city(TYPEOF(h.prov_c_city) L, TYPEOF(h.prov_c_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_c_service_role_code(TYPEOF(h.prov_c_service_role_code) L, TYPEOF(h.prov_c_service_role_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_c_state(TYPEOF(h.prov_c_state) L, TYPEOF(h.prov_c_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prov_c_zip(TYPEOF(h.prov_c_zip) L, TYPEOF(h.prov_c_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_first_name(TYPEOF(h.purch_service_first_name) L, TYPEOF(h.purch_service_first_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_last_name(TYPEOF(h.purch_service_last_name) L, TYPEOF(h.purch_service_last_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_middle_name(TYPEOF(h.purch_service_middle_name) L, TYPEOF(h.purch_service_middle_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_npi(TYPEOF(h.purch_service_npi) L, TYPEOF(h.purch_service_npi) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_addr(TYPEOF(h.purch_service_prov_addr) L, TYPEOF(h.purch_service_prov_addr) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_city(TYPEOF(h.purch_service_prov_city) L, TYPEOF(h.purch_service_prov_city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_name(TYPEOF(h.purch_service_prov_name) L, TYPEOF(h.purch_service_prov_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_phone(TYPEOF(h.purch_service_prov_phone) L, TYPEOF(h.purch_service_prov_phone) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_state(TYPEOF(h.purch_service_prov_state) L, TYPEOF(h.purch_service_prov_state) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_purch_service_prov_zip(TYPEOF(h.purch_service_prov_zip) L, TYPEOF(h.purch_service_prov_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
END;

