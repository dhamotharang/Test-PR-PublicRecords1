IMPORT SALT30;
EXPORT Layout_Specificities := MODULE
SHARED L := Layout_Property_deed;
export ln_fares_id_ChildRec := record
  typeof(l.ln_fares_id) ln_fares_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export process_date_ChildRec := record
  typeof(l.process_date) process_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export vendor_source_flag_ChildRec := record
  typeof(l.vendor_source_flag) vendor_source_flag;
  unsigned8 cnt;
  unsigned4 id;
end;
export current_record_ChildRec := record
  typeof(l.current_record) current_record;
  unsigned8 cnt;
  unsigned4 id;
end;
export fips_code_ChildRec := record
  typeof(l.fips_code) fips_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export state_code_ChildRec := record
  typeof(l.state_code) state_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export county_name_ChildRec := record
  typeof(l.county_name) county_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export old_apn_ChildRec := record
  typeof(l.old_apn) old_apn;
  unsigned8 cnt;
  unsigned4 id;
end;
export apna_or_pin_number_ChildRec := record
  typeof(l.apna_or_pin_number) apna_or_pin_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export fares_unformatted_apn_ChildRec := record
  typeof(l.fares_unformatted_apn) fares_unformatted_apn;
  unsigned8 cnt;
  unsigned4 id;
end;
export duplicate_apn_multiple_address_id_ChildRec := record
  typeof(l.duplicate_apn_multiple_address_id) duplicate_apn_multiple_address_id;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessee_name_ChildRec := record
  typeof(l.assessee_name) assessee_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export second_assessee_name_ChildRec := record
  typeof(l.second_assessee_name) second_assessee_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessee_ownership_rights_code_ChildRec := record
  typeof(l.assessee_ownership_rights_code) assessee_ownership_rights_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessee_relationship_code_ChildRec := record
  typeof(l.assessee_relationship_code) assessee_relationship_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessee_phone_number_ChildRec := record
  typeof(l.assessee_phone_number) assessee_phone_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_account_number_ChildRec := record
  typeof(l.tax_account_number) tax_account_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export contract_owner_ChildRec := record
  typeof(l.contract_owner) contract_owner;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessee_name_type_code_ChildRec := record
  typeof(l.assessee_name_type_code) assessee_name_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export second_assessee_name_type_code_ChildRec := record
  typeof(l.second_assessee_name_type_code) second_assessee_name_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export mail_care_of_name_type_code_ChildRec := record
  typeof(l.mail_care_of_name_type_code) mail_care_of_name_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export mailing_care_of_name_ChildRec := record
  typeof(l.mailing_care_of_name) mailing_care_of_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export mailing_full_street_address_ChildRec := record
  typeof(l.mailing_full_street_address) mailing_full_street_address;
  unsigned8 cnt;
  unsigned4 id;
end;
export mailing_unit_number_ChildRec := record
  typeof(l.mailing_unit_number) mailing_unit_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export mailing_city_state_zip_ChildRec := record
  typeof(l.mailing_city_state_zip) mailing_city_state_zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export property_full_street_address_ChildRec := record
  typeof(l.property_full_street_address) property_full_street_address;
  unsigned8 cnt;
  unsigned4 id;
end;
export property_unit_number_ChildRec := record
  typeof(l.property_unit_number) property_unit_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export property_city_state_zip_ChildRec := record
  typeof(l.property_city_state_zip) property_city_state_zip;
  unsigned8 cnt;
  unsigned4 id;
end;
export property_country_code_ChildRec := record
  typeof(l.property_country_code) property_country_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export property_address_code_ChildRec := record
  typeof(l.property_address_code) property_address_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_lot_code_ChildRec := record
  typeof(l.legal_lot_code) legal_lot_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_lot_number_ChildRec := record
  typeof(l.legal_lot_number) legal_lot_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_land_lot_ChildRec := record
  typeof(l.legal_land_lot) legal_land_lot;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_block_ChildRec := record
  typeof(l.legal_block) legal_block;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_section_ChildRec := record
  typeof(l.legal_section) legal_section;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_district_ChildRec := record
  typeof(l.legal_district) legal_district;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_unit_ChildRec := record
  typeof(l.legal_unit) legal_unit;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_city_municipality_township_ChildRec := record
  typeof(l.legal_city_municipality_township) legal_city_municipality_township;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_subdivision_name_ChildRec := record
  typeof(l.legal_subdivision_name) legal_subdivision_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_phase_number_ChildRec := record
  typeof(l.legal_phase_number) legal_phase_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_tract_number_ChildRec := record
  typeof(l.legal_tract_number) legal_tract_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_sec_twn_rng_mer_ChildRec := record
  typeof(l.legal_sec_twn_rng_mer) legal_sec_twn_rng_mer;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_brief_description_ChildRec := record
  typeof(l.legal_brief_description) legal_brief_description;
  unsigned8 cnt;
  unsigned4 id;
end;
export legal_assessor_map_ref_ChildRec := record
  typeof(l.legal_assessor_map_ref) legal_assessor_map_ref;
  unsigned8 cnt;
  unsigned4 id;
end;
export census_tract_ChildRec := record
  typeof(l.census_tract) census_tract;
  unsigned8 cnt;
  unsigned4 id;
end;
export record_type_code_ChildRec := record
  typeof(l.record_type_code) record_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export ownership_type_code_ChildRec := record
  typeof(l.ownership_type_code) ownership_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export new_record_type_code_ChildRec := record
  typeof(l.new_record_type_code) new_record_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export state_land_use_code_ChildRec := record
  typeof(l.state_land_use_code) state_land_use_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export county_land_use_code_ChildRec := record
  typeof(l.county_land_use_code) county_land_use_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export county_land_use_description_ChildRec := record
  typeof(l.county_land_use_description) county_land_use_description;
  unsigned8 cnt;
  unsigned4 id;
end;
export standardized_land_use_code_ChildRec := record
  typeof(l.standardized_land_use_code) standardized_land_use_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export timeshare_code_ChildRec := record
  typeof(l.timeshare_code) timeshare_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export zoning_ChildRec := record
  typeof(l.zoning) zoning;
  unsigned8 cnt;
  unsigned4 id;
end;
export owner_occupied_ChildRec := record
  typeof(l.owner_occupied) owner_occupied;
  unsigned8 cnt;
  unsigned4 id;
end;
export recorder_document_number_ChildRec := record
  typeof(l.recorder_document_number) recorder_document_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export recorder_book_number_ChildRec := record
  typeof(l.recorder_book_number) recorder_book_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export recorder_page_number_ChildRec := record
  typeof(l.recorder_page_number) recorder_page_number;
  unsigned8 cnt;
  unsigned4 id;
end;
export transfer_date_ChildRec := record
  typeof(l.transfer_date) transfer_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export recording_date_ChildRec := record
  typeof(l.recording_date) recording_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export sale_date_ChildRec := record
  typeof(l.sale_date) sale_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export document_type_ChildRec := record
  typeof(l.document_type) document_type;
  unsigned8 cnt;
  unsigned4 id;
end;
export sales_price_ChildRec := record
  typeof(l.sales_price) sales_price;
  unsigned8 cnt;
  unsigned4 id;
end;
export sales_price_code_ChildRec := record
  typeof(l.sales_price_code) sales_price_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export mortgage_loan_amount_ChildRec := record
  typeof(l.mortgage_loan_amount) mortgage_loan_amount;
  unsigned8 cnt;
  unsigned4 id;
end;
export mortgage_loan_type_code_ChildRec := record
  typeof(l.mortgage_loan_type_code) mortgage_loan_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export mortgage_lender_name_ChildRec := record
  typeof(l.mortgage_lender_name) mortgage_lender_name;
  unsigned8 cnt;
  unsigned4 id;
end;
export mortgage_lender_type_code_ChildRec := record
  typeof(l.mortgage_lender_type_code) mortgage_lender_type_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export prior_transfer_date_ChildRec := record
  typeof(l.prior_transfer_date) prior_transfer_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export prior_recording_date_ChildRec := record
  typeof(l.prior_recording_date) prior_recording_date;
  unsigned8 cnt;
  unsigned4 id;
end;
export prior_sales_price_ChildRec := record
  typeof(l.prior_sales_price) prior_sales_price;
  unsigned8 cnt;
  unsigned4 id;
end;
export prior_sales_price_code_ChildRec := record
  typeof(l.prior_sales_price_code) prior_sales_price_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessed_land_value_ChildRec := record
  typeof(l.assessed_land_value) assessed_land_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessed_improvement_value_ChildRec := record
  typeof(l.assessed_improvement_value) assessed_improvement_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessed_total_value_ChildRec := record
  typeof(l.assessed_total_value) assessed_total_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export assessed_value_year_ChildRec := record
  typeof(l.assessed_value_year) assessed_value_year;
  unsigned8 cnt;
  unsigned4 id;
end;
export market_land_value_ChildRec := record
  typeof(l.market_land_value) market_land_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export market_improvement_value_ChildRec := record
  typeof(l.market_improvement_value) market_improvement_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export market_total_value_ChildRec := record
  typeof(l.market_total_value) market_total_value;
  unsigned8 cnt;
  unsigned4 id;
end;
export market_value_year_ChildRec := record
  typeof(l.market_value_year) market_value_year;
  unsigned8 cnt;
  unsigned4 id;
end;
export homestead_homeowner_exemption_ChildRec := record
  typeof(l.homestead_homeowner_exemption) homestead_homeowner_exemption;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_exemption1_code_ChildRec := record
  typeof(l.tax_exemption1_code) tax_exemption1_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_exemption2_code_ChildRec := record
  typeof(l.tax_exemption2_code) tax_exemption2_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_exemption3_code_ChildRec := record
  typeof(l.tax_exemption3_code) tax_exemption3_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_exemption4_code_ChildRec := record
  typeof(l.tax_exemption4_code) tax_exemption4_code;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_rate_code_area_ChildRec := record
  typeof(l.tax_rate_code_area) tax_rate_code_area;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_amount_ChildRec := record
  typeof(l.tax_amount) tax_amount;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_year_ChildRec := record
  typeof(l.tax_year) tax_year;
  unsigned8 cnt;
  unsigned4 id;
end;
export tax_delinquent_year_ChildRec := record
  typeof(l.tax_delinquent_year) tax_delinquent_year;
  unsigned8 cnt;
  unsigned4 id;
end;
export school_tax_district1_ChildRec := record
  typeof(l.school_tax_district1) school_tax_district1;
  unsigned8 cnt;
  unsigned4 id;
end;
EXPORT R := RECORD,MAXLENGTH(32000)
 UNSIGNED1 dummy;
  real4 ln_fares_id_specificity;
  real4 ln_fares_id_switch;
  real4 ln_fares_id_max;
  dataset(ln_fares_id_ChildRec) nulls_ln_fares_id {MAXCOUNT(100)};
  real4 process_date_specificity;
  real4 process_date_switch;
  real4 process_date_max;
  dataset(process_date_ChildRec) nulls_process_date {MAXCOUNT(100)};
  real4 vendor_source_flag_specificity;
  real4 vendor_source_flag_switch;
  real4 vendor_source_flag_max;
  dataset(vendor_source_flag_ChildRec) nulls_vendor_source_flag {MAXCOUNT(100)};
  real4 current_record_specificity;
  real4 current_record_switch;
  real4 current_record_max;
  dataset(current_record_ChildRec) nulls_current_record {MAXCOUNT(100)};
  real4 fips_code_specificity;
  real4 fips_code_switch;
  real4 fips_code_max;
  dataset(fips_code_ChildRec) nulls_fips_code {MAXCOUNT(100)};
  real4 state_code_specificity;
  real4 state_code_switch;
  real4 state_code_max;
  dataset(state_code_ChildRec) nulls_state_code {MAXCOUNT(100)};
  real4 county_name_specificity;
  real4 county_name_switch;
  real4 county_name_max;
  dataset(county_name_ChildRec) nulls_county_name {MAXCOUNT(100)};
  real4 old_apn_specificity;
  real4 old_apn_switch;
  real4 old_apn_max;
  dataset(old_apn_ChildRec) nulls_old_apn {MAXCOUNT(100)};
  real4 apna_or_pin_number_specificity;
  real4 apna_or_pin_number_switch;
  real4 apna_or_pin_number_max;
  dataset(apna_or_pin_number_ChildRec) nulls_apna_or_pin_number {MAXCOUNT(100)};
  real4 fares_unformatted_apn_specificity;
  real4 fares_unformatted_apn_switch;
  real4 fares_unformatted_apn_max;
  dataset(fares_unformatted_apn_ChildRec) nulls_fares_unformatted_apn {MAXCOUNT(100)};
  real4 duplicate_apn_multiple_address_id_specificity;
  real4 duplicate_apn_multiple_address_id_switch;
  real4 duplicate_apn_multiple_address_id_max;
  dataset(duplicate_apn_multiple_address_id_ChildRec) nulls_duplicate_apn_multiple_address_id {MAXCOUNT(100)};
  real4 assessee_name_specificity;
  real4 assessee_name_switch;
  real4 assessee_name_max;
  dataset(assessee_name_ChildRec) nulls_assessee_name {MAXCOUNT(100)};
  real4 second_assessee_name_specificity;
  real4 second_assessee_name_switch;
  real4 second_assessee_name_max;
  dataset(second_assessee_name_ChildRec) nulls_second_assessee_name {MAXCOUNT(100)};
  real4 assessee_ownership_rights_code_specificity;
  real4 assessee_ownership_rights_code_switch;
  real4 assessee_ownership_rights_code_max;
  dataset(assessee_ownership_rights_code_ChildRec) nulls_assessee_ownership_rights_code {MAXCOUNT(100)};
  real4 assessee_relationship_code_specificity;
  real4 assessee_relationship_code_switch;
  real4 assessee_relationship_code_max;
  dataset(assessee_relationship_code_ChildRec) nulls_assessee_relationship_code {MAXCOUNT(100)};
  real4 assessee_phone_number_specificity;
  real4 assessee_phone_number_switch;
  real4 assessee_phone_number_max;
  dataset(assessee_phone_number_ChildRec) nulls_assessee_phone_number {MAXCOUNT(100)};
  real4 tax_account_number_specificity;
  real4 tax_account_number_switch;
  real4 tax_account_number_max;
  dataset(tax_account_number_ChildRec) nulls_tax_account_number {MAXCOUNT(100)};
  real4 contract_owner_specificity;
  real4 contract_owner_switch;
  real4 contract_owner_max;
  dataset(contract_owner_ChildRec) nulls_contract_owner {MAXCOUNT(100)};
  real4 assessee_name_type_code_specificity;
  real4 assessee_name_type_code_switch;
  real4 assessee_name_type_code_max;
  dataset(assessee_name_type_code_ChildRec) nulls_assessee_name_type_code {MAXCOUNT(100)};
  real4 second_assessee_name_type_code_specificity;
  real4 second_assessee_name_type_code_switch;
  real4 second_assessee_name_type_code_max;
  dataset(second_assessee_name_type_code_ChildRec) nulls_second_assessee_name_type_code {MAXCOUNT(100)};
  real4 mail_care_of_name_type_code_specificity;
  real4 mail_care_of_name_type_code_switch;
  real4 mail_care_of_name_type_code_max;
  dataset(mail_care_of_name_type_code_ChildRec) nulls_mail_care_of_name_type_code {MAXCOUNT(100)};
  real4 mailing_care_of_name_specificity;
  real4 mailing_care_of_name_switch;
  real4 mailing_care_of_name_max;
  dataset(mailing_care_of_name_ChildRec) nulls_mailing_care_of_name {MAXCOUNT(100)};
  real4 mailing_full_street_address_specificity;
  real4 mailing_full_street_address_switch;
  real4 mailing_full_street_address_max;
  dataset(mailing_full_street_address_ChildRec) nulls_mailing_full_street_address {MAXCOUNT(100)};
  real4 mailing_unit_number_specificity;
  real4 mailing_unit_number_switch;
  real4 mailing_unit_number_max;
  dataset(mailing_unit_number_ChildRec) nulls_mailing_unit_number {MAXCOUNT(100)};
  real4 mailing_city_state_zip_specificity;
  real4 mailing_city_state_zip_switch;
  real4 mailing_city_state_zip_max;
  dataset(mailing_city_state_zip_ChildRec) nulls_mailing_city_state_zip {MAXCOUNT(100)};
  real4 property_full_street_address_specificity;
  real4 property_full_street_address_switch;
  real4 property_full_street_address_max;
  dataset(property_full_street_address_ChildRec) nulls_property_full_street_address {MAXCOUNT(100)};
  real4 property_unit_number_specificity;
  real4 property_unit_number_switch;
  real4 property_unit_number_max;
  dataset(property_unit_number_ChildRec) nulls_property_unit_number {MAXCOUNT(100)};
  real4 property_city_state_zip_specificity;
  real4 property_city_state_zip_switch;
  real4 property_city_state_zip_max;
  dataset(property_city_state_zip_ChildRec) nulls_property_city_state_zip {MAXCOUNT(100)};
  real4 property_country_code_specificity;
  real4 property_country_code_switch;
  real4 property_country_code_max;
  dataset(property_country_code_ChildRec) nulls_property_country_code {MAXCOUNT(100)};
  real4 property_address_code_specificity;
  real4 property_address_code_switch;
  real4 property_address_code_max;
  dataset(property_address_code_ChildRec) nulls_property_address_code {MAXCOUNT(100)};
  real4 legal_lot_code_specificity;
  real4 legal_lot_code_switch;
  real4 legal_lot_code_max;
  dataset(legal_lot_code_ChildRec) nulls_legal_lot_code {MAXCOUNT(100)};
  real4 legal_lot_number_specificity;
  real4 legal_lot_number_switch;
  real4 legal_lot_number_max;
  dataset(legal_lot_number_ChildRec) nulls_legal_lot_number {MAXCOUNT(100)};
  real4 legal_land_lot_specificity;
  real4 legal_land_lot_switch;
  real4 legal_land_lot_max;
  dataset(legal_land_lot_ChildRec) nulls_legal_land_lot {MAXCOUNT(100)};
  real4 legal_block_specificity;
  real4 legal_block_switch;
  real4 legal_block_max;
  dataset(legal_block_ChildRec) nulls_legal_block {MAXCOUNT(100)};
  real4 legal_section_specificity;
  real4 legal_section_switch;
  real4 legal_section_max;
  dataset(legal_section_ChildRec) nulls_legal_section {MAXCOUNT(100)};
  real4 legal_district_specificity;
  real4 legal_district_switch;
  real4 legal_district_max;
  dataset(legal_district_ChildRec) nulls_legal_district {MAXCOUNT(100)};
  real4 legal_unit_specificity;
  real4 legal_unit_switch;
  real4 legal_unit_max;
  dataset(legal_unit_ChildRec) nulls_legal_unit {MAXCOUNT(100)};
  real4 legal_city_municipality_township_specificity;
  real4 legal_city_municipality_township_switch;
  real4 legal_city_municipality_township_max;
  dataset(legal_city_municipality_township_ChildRec) nulls_legal_city_municipality_township {MAXCOUNT(100)};
  real4 legal_subdivision_name_specificity;
  real4 legal_subdivision_name_switch;
  real4 legal_subdivision_name_max;
  dataset(legal_subdivision_name_ChildRec) nulls_legal_subdivision_name {MAXCOUNT(100)};
  real4 legal_phase_number_specificity;
  real4 legal_phase_number_switch;
  real4 legal_phase_number_max;
  dataset(legal_phase_number_ChildRec) nulls_legal_phase_number {MAXCOUNT(100)};
  real4 legal_tract_number_specificity;
  real4 legal_tract_number_switch;
  real4 legal_tract_number_max;
  dataset(legal_tract_number_ChildRec) nulls_legal_tract_number {MAXCOUNT(100)};
  real4 legal_sec_twn_rng_mer_specificity;
  real4 legal_sec_twn_rng_mer_switch;
  real4 legal_sec_twn_rng_mer_max;
  dataset(legal_sec_twn_rng_mer_ChildRec) nulls_legal_sec_twn_rng_mer {MAXCOUNT(100)};
  real4 legal_brief_description_specificity;
  real4 legal_brief_description_switch;
  real4 legal_brief_description_max;
  dataset(legal_brief_description_ChildRec) nulls_legal_brief_description {MAXCOUNT(100)};
  real4 legal_assessor_map_ref_specificity;
  real4 legal_assessor_map_ref_switch;
  real4 legal_assessor_map_ref_max;
  dataset(legal_assessor_map_ref_ChildRec) nulls_legal_assessor_map_ref {MAXCOUNT(100)};
  real4 census_tract_specificity;
  real4 census_tract_switch;
  real4 census_tract_max;
  dataset(census_tract_ChildRec) nulls_census_tract {MAXCOUNT(100)};
  real4 record_type_code_specificity;
  real4 record_type_code_switch;
  real4 record_type_code_max;
  dataset(record_type_code_ChildRec) nulls_record_type_code {MAXCOUNT(100)};
  real4 ownership_type_code_specificity;
  real4 ownership_type_code_switch;
  real4 ownership_type_code_max;
  dataset(ownership_type_code_ChildRec) nulls_ownership_type_code {MAXCOUNT(100)};
  real4 new_record_type_code_specificity;
  real4 new_record_type_code_switch;
  real4 new_record_type_code_max;
  dataset(new_record_type_code_ChildRec) nulls_new_record_type_code {MAXCOUNT(100)};
  real4 state_land_use_code_specificity;
  real4 state_land_use_code_switch;
  real4 state_land_use_code_max;
  dataset(state_land_use_code_ChildRec) nulls_state_land_use_code {MAXCOUNT(100)};
  real4 county_land_use_code_specificity;
  real4 county_land_use_code_switch;
  real4 county_land_use_code_max;
  dataset(county_land_use_code_ChildRec) nulls_county_land_use_code {MAXCOUNT(100)};
  real4 county_land_use_description_specificity;
  real4 county_land_use_description_switch;
  real4 county_land_use_description_max;
  dataset(county_land_use_description_ChildRec) nulls_county_land_use_description {MAXCOUNT(100)};
  real4 standardized_land_use_code_specificity;
  real4 standardized_land_use_code_switch;
  real4 standardized_land_use_code_max;
  dataset(standardized_land_use_code_ChildRec) nulls_standardized_land_use_code {MAXCOUNT(100)};
  real4 timeshare_code_specificity;
  real4 timeshare_code_switch;
  real4 timeshare_code_max;
  dataset(timeshare_code_ChildRec) nulls_timeshare_code {MAXCOUNT(100)};
  real4 zoning_specificity;
  real4 zoning_switch;
  real4 zoning_max;
  dataset(zoning_ChildRec) nulls_zoning {MAXCOUNT(100)};
  real4 owner_occupied_specificity;
  real4 owner_occupied_switch;
  real4 owner_occupied_max;
  dataset(owner_occupied_ChildRec) nulls_owner_occupied {MAXCOUNT(100)};
  real4 recorder_document_number_specificity;
  real4 recorder_document_number_switch;
  real4 recorder_document_number_max;
  dataset(recorder_document_number_ChildRec) nulls_recorder_document_number {MAXCOUNT(100)};
  real4 recorder_book_number_specificity;
  real4 recorder_book_number_switch;
  real4 recorder_book_number_max;
  dataset(recorder_book_number_ChildRec) nulls_recorder_book_number {MAXCOUNT(100)};
  real4 recorder_page_number_specificity;
  real4 recorder_page_number_switch;
  real4 recorder_page_number_max;
  dataset(recorder_page_number_ChildRec) nulls_recorder_page_number {MAXCOUNT(100)};
  real4 transfer_date_specificity;
  real4 transfer_date_switch;
  real4 transfer_date_max;
  dataset(transfer_date_ChildRec) nulls_transfer_date {MAXCOUNT(100)};
  real4 recording_date_specificity;
  real4 recording_date_switch;
  real4 recording_date_max;
  dataset(recording_date_ChildRec) nulls_recording_date {MAXCOUNT(100)};
  real4 sale_date_specificity;
  real4 sale_date_switch;
  real4 sale_date_max;
  dataset(sale_date_ChildRec) nulls_sale_date {MAXCOUNT(100)};
  real4 document_type_specificity;
  real4 document_type_switch;
  real4 document_type_max;
  dataset(document_type_ChildRec) nulls_document_type {MAXCOUNT(100)};
  real4 sales_price_specificity;
  real4 sales_price_switch;
  real4 sales_price_max;
  dataset(sales_price_ChildRec) nulls_sales_price {MAXCOUNT(100)};
  real4 sales_price_code_specificity;
  real4 sales_price_code_switch;
  real4 sales_price_code_max;
  dataset(sales_price_code_ChildRec) nulls_sales_price_code {MAXCOUNT(100)};
  real4 mortgage_loan_amount_specificity;
  real4 mortgage_loan_amount_switch;
  real4 mortgage_loan_amount_max;
  dataset(mortgage_loan_amount_ChildRec) nulls_mortgage_loan_amount {MAXCOUNT(100)};
  real4 mortgage_loan_type_code_specificity;
  real4 mortgage_loan_type_code_switch;
  real4 mortgage_loan_type_code_max;
  dataset(mortgage_loan_type_code_ChildRec) nulls_mortgage_loan_type_code {MAXCOUNT(100)};
  real4 mortgage_lender_name_specificity;
  real4 mortgage_lender_name_switch;
  real4 mortgage_lender_name_max;
  dataset(mortgage_lender_name_ChildRec) nulls_mortgage_lender_name {MAXCOUNT(100)};
  real4 mortgage_lender_type_code_specificity;
  real4 mortgage_lender_type_code_switch;
  real4 mortgage_lender_type_code_max;
  dataset(mortgage_lender_type_code_ChildRec) nulls_mortgage_lender_type_code {MAXCOUNT(100)};
  real4 prior_transfer_date_specificity;
  real4 prior_transfer_date_switch;
  real4 prior_transfer_date_max;
  dataset(prior_transfer_date_ChildRec) nulls_prior_transfer_date {MAXCOUNT(100)};
  real4 prior_recording_date_specificity;
  real4 prior_recording_date_switch;
  real4 prior_recording_date_max;
  dataset(prior_recording_date_ChildRec) nulls_prior_recording_date {MAXCOUNT(100)};
  real4 prior_sales_price_specificity;
  real4 prior_sales_price_switch;
  real4 prior_sales_price_max;
  dataset(prior_sales_price_ChildRec) nulls_prior_sales_price {MAXCOUNT(100)};
  real4 prior_sales_price_code_specificity;
  real4 prior_sales_price_code_switch;
  real4 prior_sales_price_code_max;
  dataset(prior_sales_price_code_ChildRec) nulls_prior_sales_price_code {MAXCOUNT(100)};
  real4 assessed_land_value_specificity;
  real4 assessed_land_value_switch;
  real4 assessed_land_value_max;
  dataset(assessed_land_value_ChildRec) nulls_assessed_land_value {MAXCOUNT(100)};
  real4 assessed_improvement_value_specificity;
  real4 assessed_improvement_value_switch;
  real4 assessed_improvement_value_max;
  dataset(assessed_improvement_value_ChildRec) nulls_assessed_improvement_value {MAXCOUNT(100)};
  real4 assessed_total_value_specificity;
  real4 assessed_total_value_switch;
  real4 assessed_total_value_max;
  dataset(assessed_total_value_ChildRec) nulls_assessed_total_value {MAXCOUNT(100)};
  real4 assessed_value_year_specificity;
  real4 assessed_value_year_switch;
  real4 assessed_value_year_max;
  dataset(assessed_value_year_ChildRec) nulls_assessed_value_year {MAXCOUNT(100)};
  real4 market_land_value_specificity;
  real4 market_land_value_switch;
  real4 market_land_value_max;
  dataset(market_land_value_ChildRec) nulls_market_land_value {MAXCOUNT(100)};
  real4 market_improvement_value_specificity;
  real4 market_improvement_value_switch;
  real4 market_improvement_value_max;
  dataset(market_improvement_value_ChildRec) nulls_market_improvement_value {MAXCOUNT(100)};
  real4 market_total_value_specificity;
  real4 market_total_value_switch;
  real4 market_total_value_max;
  dataset(market_total_value_ChildRec) nulls_market_total_value {MAXCOUNT(100)};
  real4 market_value_year_specificity;
  real4 market_value_year_switch;
  real4 market_value_year_max;
  dataset(market_value_year_ChildRec) nulls_market_value_year {MAXCOUNT(100)};
  real4 homestead_homeowner_exemption_specificity;
  real4 homestead_homeowner_exemption_switch;
  real4 homestead_homeowner_exemption_max;
  dataset(homestead_homeowner_exemption_ChildRec) nulls_homestead_homeowner_exemption {MAXCOUNT(100)};
  real4 tax_exemption1_code_specificity;
  real4 tax_exemption1_code_switch;
  real4 tax_exemption1_code_max;
  dataset(tax_exemption1_code_ChildRec) nulls_tax_exemption1_code {MAXCOUNT(100)};
  real4 tax_exemption2_code_specificity;
  real4 tax_exemption2_code_switch;
  real4 tax_exemption2_code_max;
  dataset(tax_exemption2_code_ChildRec) nulls_tax_exemption2_code {MAXCOUNT(100)};
  real4 tax_exemption3_code_specificity;
  real4 tax_exemption3_code_switch;
  real4 tax_exemption3_code_max;
  dataset(tax_exemption3_code_ChildRec) nulls_tax_exemption3_code {MAXCOUNT(100)};
  real4 tax_exemption4_code_specificity;
  real4 tax_exemption4_code_switch;
  real4 tax_exemption4_code_max;
  dataset(tax_exemption4_code_ChildRec) nulls_tax_exemption4_code {MAXCOUNT(100)};
  real4 tax_rate_code_area_specificity;
  real4 tax_rate_code_area_switch;
  real4 tax_rate_code_area_max;
  dataset(tax_rate_code_area_ChildRec) nulls_tax_rate_code_area {MAXCOUNT(100)};
  real4 tax_amount_specificity;
  real4 tax_amount_switch;
  real4 tax_amount_max;
  dataset(tax_amount_ChildRec) nulls_tax_amount {MAXCOUNT(100)};
  real4 tax_year_specificity;
  real4 tax_year_switch;
  real4 tax_year_max;
  dataset(tax_year_ChildRec) nulls_tax_year {MAXCOUNT(100)};
  real4 tax_delinquent_year_specificity;
  real4 tax_delinquent_year_switch;
  real4 tax_delinquent_year_max;
  dataset(tax_delinquent_year_ChildRec) nulls_tax_delinquent_year {MAXCOUNT(100)};
  real4 school_tax_district1_specificity;
  real4 school_tax_district1_switch;
  real4 school_tax_district1_max;
  dataset(school_tax_district1_ChildRec) nulls_school_tax_district1 {MAXCOUNT(100)};
END;
END;
