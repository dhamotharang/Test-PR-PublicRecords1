IMPORT SALT31,std;
EXPORT match_methods(DATASET(layout_Property_Assessor) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_ln_fares_id(TYPEOF(h.ln_fares_id) L, TYPEOF(h.ln_fares_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_process_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_process_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_process_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_process_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_vendor_source_flag(TYPEOF(h.vendor_source_flag) L, TYPEOF(h.vendor_source_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_current_record(TYPEOF(h.current_record) L, TYPEOF(h.current_record) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fips_code(TYPEOF(h.fips_code) L, TYPEOF(h.fips_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_state_code(TYPEOF(h.state_code) L, TYPEOF(h.state_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_county_name(TYPEOF(h.county_name) L, TYPEOF(h.county_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_old_apn(TYPEOF(h.old_apn) L, TYPEOF(h.old_apn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_apna_or_pin_number(TYPEOF(h.apna_or_pin_number) L, TYPEOF(h.apna_or_pin_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fares_unformatted_apn(TYPEOF(h.fares_unformatted_apn) L, TYPEOF(h.fares_unformatted_apn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_duplicate_apn_multiple_address_id(TYPEOF(h.duplicate_apn_multiple_address_id) L, TYPEOF(h.duplicate_apn_multiple_address_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_name(TYPEOF(h.assessee_name) L, TYPEOF(h.assessee_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_second_assessee_name(TYPEOF(h.second_assessee_name) L, TYPEOF(h.second_assessee_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_ownership_rights_code(TYPEOF(h.assessee_ownership_rights_code) L, TYPEOF(h.assessee_ownership_rights_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_relationship_code(TYPEOF(h.assessee_relationship_code) L, TYPEOF(h.assessee_relationship_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_phone_number(TYPEOF(h.assessee_phone_number) L, TYPEOF(h.assessee_phone_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_account_number(TYPEOF(h.tax_account_number) L, TYPEOF(h.tax_account_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_contract_owner(TYPEOF(h.contract_owner) L, TYPEOF(h.contract_owner) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_name_type_code(TYPEOF(h.assessee_name_type_code) L, TYPEOF(h.assessee_name_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_second_assessee_name_type_code(TYPEOF(h.second_assessee_name_type_code) L, TYPEOF(h.second_assessee_name_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mail_care_of_name_type_code(TYPEOF(h.mail_care_of_name_type_code) L, TYPEOF(h.mail_care_of_name_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mailing_care_of_name(TYPEOF(h.mailing_care_of_name) L, TYPEOF(h.mailing_care_of_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mailing_full_street_address(TYPEOF(h.mailing_full_street_address) L, TYPEOF(h.mailing_full_street_address) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mailing_unit_number(TYPEOF(h.mailing_unit_number) L, TYPEOF(h.mailing_unit_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mailing_city_state_zip(TYPEOF(h.mailing_city_state_zip) L, TYPEOF(h.mailing_city_state_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_property_full_street_address(TYPEOF(h.property_full_street_address) L, TYPEOF(h.property_full_street_address) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_property_unit_number(TYPEOF(h.property_unit_number) L, TYPEOF(h.property_unit_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_property_city_state_zip(TYPEOF(h.property_city_state_zip) L, TYPEOF(h.property_city_state_zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_property_country_code(TYPEOF(h.property_country_code) L, TYPEOF(h.property_country_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_property_address_code(TYPEOF(h.property_address_code) L, TYPEOF(h.property_address_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_lot_code(TYPEOF(h.legal_lot_code) L, TYPEOF(h.legal_lot_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_lot_number(TYPEOF(h.legal_lot_number) L, TYPEOF(h.legal_lot_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_land_lot(TYPEOF(h.legal_land_lot) L, TYPEOF(h.legal_land_lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_block(TYPEOF(h.legal_block) L, TYPEOF(h.legal_block) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_section(TYPEOF(h.legal_section) L, TYPEOF(h.legal_section) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_district(TYPEOF(h.legal_district) L, TYPEOF(h.legal_district) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_unit(TYPEOF(h.legal_unit) L, TYPEOF(h.legal_unit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_city_municipality_township(TYPEOF(h.legal_city_municipality_township) L, TYPEOF(h.legal_city_municipality_township) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_subdivision_name(TYPEOF(h.legal_subdivision_name) L, TYPEOF(h.legal_subdivision_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_phase_number(TYPEOF(h.legal_phase_number) L, TYPEOF(h.legal_phase_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_tract_number(TYPEOF(h.legal_tract_number) L, TYPEOF(h.legal_tract_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_sec_twn_rng_mer(TYPEOF(h.legal_sec_twn_rng_mer) L, TYPEOF(h.legal_sec_twn_rng_mer) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_brief_description(TYPEOF(h.legal_brief_description) L, TYPEOF(h.legal_brief_description) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_legal_assessor_map_ref(TYPEOF(h.legal_assessor_map_ref) L, TYPEOF(h.legal_assessor_map_ref) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_census_tract(TYPEOF(h.census_tract) L, TYPEOF(h.census_tract) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_record_type_code(TYPEOF(h.record_type_code) L, TYPEOF(h.record_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ownership_type_code(TYPEOF(h.ownership_type_code) L, TYPEOF(h.ownership_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_new_record_type_code(TYPEOF(h.new_record_type_code) L, TYPEOF(h.new_record_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_state_land_use_code(TYPEOF(h.state_land_use_code) L, TYPEOF(h.state_land_use_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_county_land_use_code(TYPEOF(h.county_land_use_code) L, TYPEOF(h.county_land_use_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_county_land_use_description(TYPEOF(h.county_land_use_description) L, TYPEOF(h.county_land_use_description) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_standardized_land_use_code(TYPEOF(h.standardized_land_use_code) L, TYPEOF(h.standardized_land_use_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_timeshare_code(TYPEOF(h.timeshare_code) L, TYPEOF(h.timeshare_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_zoning(TYPEOF(h.zoning) L, TYPEOF(h.zoning) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_owner_occupied(TYPEOF(h.owner_occupied) L, TYPEOF(h.owner_occupied) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recorder_document_number(TYPEOF(h.recorder_document_number) L, TYPEOF(h.recorder_document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recorder_book_number(TYPEOF(h.recorder_book_number) L, TYPEOF(h.recorder_book_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_recorder_page_number(TYPEOF(h.recorder_page_number) L, TYPEOF(h.recorder_page_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_transfer_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_transfer_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_transfer_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_transfer_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_recording_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_recording_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_recording_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_recording_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_sale_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_sale_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_sale_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_sale_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_document_type(TYPEOF(h.document_type) L, TYPEOF(h.document_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sales_price(TYPEOF(h.sales_price) L, TYPEOF(h.sales_price) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sales_price_code(TYPEOF(h.sales_price_code) L, TYPEOF(h.sales_price_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mortgage_loan_amount(TYPEOF(h.mortgage_loan_amount) L, TYPEOF(h.mortgage_loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mortgage_loan_type_code(TYPEOF(h.mortgage_loan_type_code) L, TYPEOF(h.mortgage_loan_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mortgage_lender_name(TYPEOF(h.mortgage_lender_name) L, TYPEOF(h.mortgage_lender_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mortgage_lender_type_code(TYPEOF(h.mortgage_lender_type_code) L, TYPEOF(h.mortgage_lender_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prior_transfer_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_transfer_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_transfer_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_transfer_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_recording_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_recording_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_recording_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_recording_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_prior_sales_price(TYPEOF(h.prior_sales_price) L, TYPEOF(h.prior_sales_price) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prior_sales_price_code(TYPEOF(h.prior_sales_price_code) L, TYPEOF(h.prior_sales_price_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessed_land_value(TYPEOF(h.assessed_land_value) L, TYPEOF(h.assessed_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessed_improvement_value(TYPEOF(h.assessed_improvement_value) L, TYPEOF(h.assessed_improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessed_total_value(TYPEOF(h.assessed_total_value) L, TYPEOF(h.assessed_total_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessed_value_year(TYPEOF(h.assessed_value_year) L, TYPEOF(h.assessed_value_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_market_land_value(TYPEOF(h.market_land_value) L, TYPEOF(h.market_land_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_market_improvement_value(TYPEOF(h.market_improvement_value) L, TYPEOF(h.market_improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_market_total_value(TYPEOF(h.market_total_value) L, TYPEOF(h.market_total_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_market_value_year(TYPEOF(h.market_value_year) L, TYPEOF(h.market_value_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_homestead_homeowner_exemption(TYPEOF(h.homestead_homeowner_exemption) L, TYPEOF(h.homestead_homeowner_exemption) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_exemption1_code(TYPEOF(h.tax_exemption1_code) L, TYPEOF(h.tax_exemption1_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_exemption2_code(TYPEOF(h.tax_exemption2_code) L, TYPEOF(h.tax_exemption2_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_exemption3_code(TYPEOF(h.tax_exemption3_code) L, TYPEOF(h.tax_exemption3_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_exemption4_code(TYPEOF(h.tax_exemption4_code) L, TYPEOF(h.tax_exemption4_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_rate_code_area(TYPEOF(h.tax_rate_code_area) L, TYPEOF(h.tax_rate_code_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_amount(TYPEOF(h.tax_amount) L, TYPEOF(h.tax_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_year(TYPEOF(h.tax_year) L, TYPEOF(h.tax_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tax_delinquent_year(TYPEOF(h.tax_delinquent_year) L, TYPEOF(h.tax_delinquent_year) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district1(TYPEOF(h.school_tax_district1) L, TYPEOF(h.school_tax_district1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district1_indicator(TYPEOF(h.school_tax_district1_indicator) L, TYPEOF(h.school_tax_district1_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district2(TYPEOF(h.school_tax_district2) L, TYPEOF(h.school_tax_district2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district2_indicator(TYPEOF(h.school_tax_district2_indicator) L, TYPEOF(h.school_tax_district2_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district3(TYPEOF(h.school_tax_district3) L, TYPEOF(h.school_tax_district3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_school_tax_district3_indicator(TYPEOF(h.school_tax_district3_indicator) L, TYPEOF(h.school_tax_district3_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot_size(TYPEOF(h.lot_size) L, TYPEOF(h.lot_size) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot_size_acres(TYPEOF(h.lot_size_acres) L, TYPEOF(h.lot_size_acres) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot_size_frontage_feet(TYPEOF(h.lot_size_frontage_feet) L, TYPEOF(h.lot_size_frontage_feet) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_lot_size_depth_feet(TYPEOF(h.lot_size_depth_feet) L, TYPEOF(h.lot_size_depth_feet) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_land_acres(TYPEOF(h.land_acres) L, TYPEOF(h.land_acres) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_land_square_footage(TYPEOF(h.land_square_footage) L, TYPEOF(h.land_square_footage) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_land_dimensions(TYPEOF(h.land_dimensions) L, TYPEOF(h.land_dimensions) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area(TYPEOF(h.building_area) L, TYPEOF(h.building_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area_indicator(TYPEOF(h.building_area_indicator) L, TYPEOF(h.building_area_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area1(TYPEOF(h.building_area1) L, TYPEOF(h.building_area1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area1_indicator(TYPEOF(h.building_area1_indicator) L, TYPEOF(h.building_area1_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area2(TYPEOF(h.building_area2) L, TYPEOF(h.building_area2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area2_indicator(TYPEOF(h.building_area2_indicator) L, TYPEOF(h.building_area2_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area3(TYPEOF(h.building_area3) L, TYPEOF(h.building_area3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area3_indicator(TYPEOF(h.building_area3_indicator) L, TYPEOF(h.building_area3_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area4(TYPEOF(h.building_area4) L, TYPEOF(h.building_area4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area4_indicator(TYPEOF(h.building_area4_indicator) L, TYPEOF(h.building_area4_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area5(TYPEOF(h.building_area5) L, TYPEOF(h.building_area5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area5_indicator(TYPEOF(h.building_area5_indicator) L, TYPEOF(h.building_area5_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area6(TYPEOF(h.building_area6) L, TYPEOF(h.building_area6) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area6_indicator(TYPEOF(h.building_area6_indicator) L, TYPEOF(h.building_area6_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area7(TYPEOF(h.building_area7) L, TYPEOF(h.building_area7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_area7_indicator(TYPEOF(h.building_area7_indicator) L, TYPEOF(h.building_area7_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_year_built(TYPEOF(h.year_built) L, TYPEOF(h.year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_effective_year_built(TYPEOF(h.effective_year_built) L, TYPEOF(h.effective_year_built) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_buildings(TYPEOF(h.no_of_buildings) L, TYPEOF(h.no_of_buildings) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_stories(TYPEOF(h.no_of_stories) L, TYPEOF(h.no_of_stories) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_units(TYPEOF(h.no_of_units) L, TYPEOF(h.no_of_units) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_rooms(TYPEOF(h.no_of_rooms) L, TYPEOF(h.no_of_rooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_bedrooms(TYPEOF(h.no_of_bedrooms) L, TYPEOF(h.no_of_bedrooms) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_baths(TYPEOF(h.no_of_baths) L, TYPEOF(h.no_of_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_partial_baths(TYPEOF(h.no_of_partial_baths) L, TYPEOF(h.no_of_partial_baths) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_no_of_plumbing_fixtures(TYPEOF(h.no_of_plumbing_fixtures) L, TYPEOF(h.no_of_plumbing_fixtures) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_garage_type_code(TYPEOF(h.garage_type_code) L, TYPEOF(h.garage_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_parking_no_of_cars(TYPEOF(h.parking_no_of_cars) L, TYPEOF(h.parking_no_of_cars) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_pool_code(TYPEOF(h.pool_code) L, TYPEOF(h.pool_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_style_code(TYPEOF(h.style_code) L, TYPEOF(h.style_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_type_construction_code(TYPEOF(h.type_construction_code) L, TYPEOF(h.type_construction_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_foundation_code(TYPEOF(h.foundation_code) L, TYPEOF(h.foundation_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_quality_code(TYPEOF(h.building_quality_code) L, TYPEOF(h.building_quality_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_condition_code(TYPEOF(h.building_condition_code) L, TYPEOF(h.building_condition_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_exterior_walls_code(TYPEOF(h.exterior_walls_code) L, TYPEOF(h.exterior_walls_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_interior_walls_code(TYPEOF(h.interior_walls_code) L, TYPEOF(h.interior_walls_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_roof_cover_code(TYPEOF(h.roof_cover_code) L, TYPEOF(h.roof_cover_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_roof_type_code(TYPEOF(h.roof_type_code) L, TYPEOF(h.roof_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_floor_cover_code(TYPEOF(h.floor_cover_code) L, TYPEOF(h.floor_cover_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_water_code(TYPEOF(h.water_code) L, TYPEOF(h.water_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_sewer_code(TYPEOF(h.sewer_code) L, TYPEOF(h.sewer_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_heating_code(TYPEOF(h.heating_code) L, TYPEOF(h.heating_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_heating_fuel_type_code(TYPEOF(h.heating_fuel_type_code) L, TYPEOF(h.heating_fuel_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_air_conditioning_code(TYPEOF(h.air_conditioning_code) L, TYPEOF(h.air_conditioning_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_air_conditioning_type_code(TYPEOF(h.air_conditioning_type_code) L, TYPEOF(h.air_conditioning_type_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_elevator(TYPEOF(h.elevator) L, TYPEOF(h.elevator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fireplace_indicator(TYPEOF(h.fireplace_indicator) L, TYPEOF(h.fireplace_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fireplace_number(TYPEOF(h.fireplace_number) L, TYPEOF(h.fireplace_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_basement_code(TYPEOF(h.basement_code) L, TYPEOF(h.basement_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_building_class_code(TYPEOF(h.building_class_code) L, TYPEOF(h.building_class_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_site_influence1_code(TYPEOF(h.site_influence1_code) L, TYPEOF(h.site_influence1_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_site_influence2_code(TYPEOF(h.site_influence2_code) L, TYPEOF(h.site_influence2_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_site_influence3_code(TYPEOF(h.site_influence3_code) L, TYPEOF(h.site_influence3_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_site_influence4_code(TYPEOF(h.site_influence4_code) L, TYPEOF(h.site_influence4_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_site_influence5_code(TYPEOF(h.site_influence5_code) L, TYPEOF(h.site_influence5_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities1_code(TYPEOF(h.amenities1_code) L, TYPEOF(h.amenities1_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code(TYPEOF(h.amenities2_code) L, TYPEOF(h.amenities2_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities3_code(TYPEOF(h.amenities3_code) L, TYPEOF(h.amenities3_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities4_code(TYPEOF(h.amenities4_code) L, TYPEOF(h.amenities4_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities5_code(TYPEOF(h.amenities5_code) L, TYPEOF(h.amenities5_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code1(TYPEOF(h.amenities2_code1) L, TYPEOF(h.amenities2_code1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code2(TYPEOF(h.amenities2_code2) L, TYPEOF(h.amenities2_code2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code3(TYPEOF(h.amenities2_code3) L, TYPEOF(h.amenities2_code3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code4(TYPEOF(h.amenities2_code4) L, TYPEOF(h.amenities2_code4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_amenities2_code5(TYPEOF(h.amenities2_code5) L, TYPEOF(h.amenities2_code5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features1_area(TYPEOF(h.extra_features1_area) L, TYPEOF(h.extra_features1_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features1_indicator(TYPEOF(h.extra_features1_indicator) L, TYPEOF(h.extra_features1_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features2_area(TYPEOF(h.extra_features2_area) L, TYPEOF(h.extra_features2_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features2_indicator(TYPEOF(h.extra_features2_indicator) L, TYPEOF(h.extra_features2_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features3_area(TYPEOF(h.extra_features3_area) L, TYPEOF(h.extra_features3_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features3_indicator(TYPEOF(h.extra_features3_indicator) L, TYPEOF(h.extra_features3_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features4_area(TYPEOF(h.extra_features4_area) L, TYPEOF(h.extra_features4_area) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_extra_features4_indicator(TYPEOF(h.extra_features4_indicator) L, TYPEOF(h.extra_features4_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_buildings1_code(TYPEOF(h.other_buildings1_code) L, TYPEOF(h.other_buildings1_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_buildings2_code(TYPEOF(h.other_buildings2_code) L, TYPEOF(h.other_buildings2_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_buildings3_code(TYPEOF(h.other_buildings3_code) L, TYPEOF(h.other_buildings3_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_buildings4_code(TYPEOF(h.other_buildings4_code) L, TYPEOF(h.other_buildings4_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_buildings5_code(TYPEOF(h.other_buildings5_code) L, TYPEOF(h.other_buildings5_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building1_indicator(TYPEOF(h.other_impr_building1_indicator) L, TYPEOF(h.other_impr_building1_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building2_indicator(TYPEOF(h.other_impr_building2_indicator) L, TYPEOF(h.other_impr_building2_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building3_indicator(TYPEOF(h.other_impr_building3_indicator) L, TYPEOF(h.other_impr_building3_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building4_indicator(TYPEOF(h.other_impr_building4_indicator) L, TYPEOF(h.other_impr_building4_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building5_indicator(TYPEOF(h.other_impr_building5_indicator) L, TYPEOF(h.other_impr_building5_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building_area1(TYPEOF(h.other_impr_building_area1) L, TYPEOF(h.other_impr_building_area1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building_area2(TYPEOF(h.other_impr_building_area2) L, TYPEOF(h.other_impr_building_area2) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building_area3(TYPEOF(h.other_impr_building_area3) L, TYPEOF(h.other_impr_building_area3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building_area4(TYPEOF(h.other_impr_building_area4) L, TYPEOF(h.other_impr_building_area4) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_impr_building_area5(TYPEOF(h.other_impr_building_area5) L, TYPEOF(h.other_impr_building_area5) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_topograpy_code(TYPEOF(h.topograpy_code) L, TYPEOF(h.topograpy_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_neighborhood_code(TYPEOF(h.neighborhood_code) L, TYPEOF(h.neighborhood_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_condo_project_or_building_name(TYPEOF(h.condo_project_or_building_name) L, TYPEOF(h.condo_project_or_building_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessee_name_indicator(TYPEOF(h.assessee_name_indicator) L, TYPEOF(h.assessee_name_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_second_assessee_name_indicator(TYPEOF(h.second_assessee_name_indicator) L, TYPEOF(h.second_assessee_name_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_other_rooms_indicator(TYPEOF(h.other_rooms_indicator) L, TYPEOF(h.other_rooms_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_mail_care_of_name_indicator(TYPEOF(h.mail_care_of_name_indicator) L, TYPEOF(h.mail_care_of_name_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_comments(TYPEOF(h.comments) L, TYPEOF(h.comments) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_tape_cut_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_tape_cut_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_tape_cut_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_tape_cut_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_certification_date_year(INTEGER2 L_year,INTEGER2 R_year) := MAP(
	L_year= R_year => SALT31.MatchCode.ExactMatch,
	SALT31.MatchCode.NoMatch);
EXPORT match_certification_date_month(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_month = R_month => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day <= 1 AND L_month = 1 OR R_day <= 1 AND R_month = 1 => SALT31.MatchCode.SoftMatch, // Month may be a soft 1 if day is ... 
	SALT31.MatchCode.NoMatch);
EXPORT match_certification_date_day(INTEGER2 L_month,INTEGER2 R_month, INTEGER2 L_day,INTEGER2 R_day) := MAP(
	L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_certification_date(INTEGER2 L_year,INTEGER2 R_year, INTEGER1 L_month,INTEGER1 R_month,INTEGER1 L_day,INTEGER1 R_day) := MAP(
	L_year = R_year AND L_month = R_month AND L_day = R_day => SALT31.MatchCode.ExactMatch,
	L_month = R_day AND L_day = R_month => SALT31.MatchCode.MonthDaySwitch, // Performing M-D switch
	L_day = 1 OR R_day = 1 OR (L_day <= 1 AND L_month = 1) OR (R_day <= 1 AND R_month = 1) => SALT31.MatchCode.SoftMatch, // Treating as a 'soft' 1 
	SALT31.MatchCode.NoMatch);
EXPORT match_edition_number(TYPEOF(h.edition_number) L, TYPEOF(h.edition_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_prop_addr_propagated_ind(TYPEOF(h.prop_addr_propagated_ind) L, TYPEOF(h.prop_addr_propagated_ind) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_ownership_rights(TYPEOF(h.ln_ownership_rights) L, TYPEOF(h.ln_ownership_rights) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_relationship_type(TYPEOF(h.ln_relationship_type) L, TYPEOF(h.ln_relationship_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_mailing_country_code(TYPEOF(h.ln_mailing_country_code) L, TYPEOF(h.ln_mailing_country_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_property_name(TYPEOF(h.ln_property_name) L, TYPEOF(h.ln_property_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_property_name_type(TYPEOF(h.ln_property_name_type) L, TYPEOF(h.ln_property_name_type) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_land_use_category(TYPEOF(h.ln_land_use_category) L, TYPEOF(h.ln_land_use_category) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_lot(TYPEOF(h.ln_lot) L, TYPEOF(h.ln_lot) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_block(TYPEOF(h.ln_block) L, TYPEOF(h.ln_block) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_unit(TYPEOF(h.ln_unit) L, TYPEOF(h.ln_unit) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_subfloor(TYPEOF(h.ln_subfloor) L, TYPEOF(h.ln_subfloor) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_floor_cover(TYPEOF(h.ln_floor_cover) L, TYPEOF(h.ln_floor_cover) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_mobile_home_indicator(TYPEOF(h.ln_mobile_home_indicator) L, TYPEOF(h.ln_mobile_home_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_condo_indicator(TYPEOF(h.ln_condo_indicator) L, TYPEOF(h.ln_condo_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_property_tax_exemption(TYPEOF(h.ln_property_tax_exemption) L, TYPEOF(h.ln_property_tax_exemption) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_veteran_status(TYPEOF(h.ln_veteran_status) L, TYPEOF(h.ln_veteran_status) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_ln_old_apn_indicator(TYPEOF(h.ln_old_apn_indicator) L, TYPEOF(h.ln_old_apn_indicator) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_assessed_land_improvement_value(TYPEOF(h.assessed_land_improvement_value) L, TYPEOF(h.assessed_land_improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_market_land_improvement_value(TYPEOF(h.market_land_improvement_value) L, TYPEOF(h.market_land_improvement_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
EXPORT match_fips(TYPEOF(h.fips) L, TYPEOF(h.fips) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
	MAP(L = R => SALT31.MatchCode.ExactMatch,
		SALT31.MatchCode.NoMatch),
	MAP(L = R => SALT31.MatchCode.ExactMatch, SALT31.MatchCode.NoMatch)
);
END;

