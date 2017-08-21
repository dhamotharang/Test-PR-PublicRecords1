import ut,ln_propertyv2;
EXPORT Populate_Property_Overrides := module

assess_ds := dataset ('~thor_data400::base::override::fcra::qa::property_assessment_v2',
               FCRA.Layout_Override_Assessment, flat);

assessment_override_layout := record
	string20 flag_file_id;
	ln_propertyv2.layout_property_common_model_base;
end;

assessment_override_layout proj_assess_recs(assess_ds l) := transform
	SELF.amenities1_code := '';
SELF.amenities2_code := '';
SELF.amenities2_code1 := '';
SELF.amenities2_code2 := '';
SELF.amenities2_code3 := '';
SELF.amenities2_code4 := '';
SELF.amenities2_code5 := '';
SELF.amenities3_code := '';
SELF.amenities4_code := '';
SELF.amenities5_code := '';
SELF.assessee_name_indicator := '';
SELF.assessee_ownership_rights_code := '';
SELF.assessee_phone_number := '';
SELF.assessee_relationship_code := '';
SELF.building_area1 := '';
SELF.building_area1_indicator := '';
SELF.building_area2 := '';
SELF.building_area2_indicator := '';
SELF.building_area3 := '';
SELF.building_area3_indicator := '';
SELF.building_area4 := '';
SELF.building_area4_indicator := '';
SELF.building_area5 := '';
SELF.building_area5_indicator := '';
SELF.building_area6 := '';
SELF.building_area6_indicator := '';
SELF.building_area7 := '';
SELF.building_area7_indicator := '';
SELF.building_condition_code := '';
SELF.building_quality_code := '';
SELF.census_tract := '';
SELF.certification_date := '';
SELF.comments := '';
SELF.condo_project_or_building_name := '';
SELF.contract_owner := '';
SELF.county_land_use_code := '';
SELF.county_land_use_description := '';
SELF.current_record := '';
SELF.document_type := '';
SELF.duplicate_apn_multiple_address_id := '';
SELF.edition_number := '';
SELF.effective_year_built := '';
SELF.extra_features1_area := '';
SELF.extra_features1_indicator := '';
SELF.extra_features2_area := '';
SELF.extra_features2_indicator := '';
SELF.extra_features3_area := '';
SELF.extra_features3_indicator := '';
SELF.extra_features4_area := '';
SELF.extra_features4_indicator := '';
SELF.fares_unformatted_apn := '';
SELF.fips_code := '';
SELF.floor_cover_code := '';
SELF.interior_walls_code := '';
SELF.legal_assessor_map_ref := '';
SELF.legal_block := '';
SELF.legal_district := '';
SELF.legal_land_lot := '';
SELF.legal_lot_code := '';
SELF.legal_lot_number := '';
SELF.legal_phase_number := '';
SELF.legal_sec_twn_rng_mer := '';
SELF.legal_section := '';
SELF.legal_tract_number := '';
SELF.legal_unit := '';
SELF.lot_size := '';
SELF.lot_size_acres := '';
SELF.lot_size_depth_feet := '';
SELF.lot_size_frontage_feet := '';
SELF.mail_care_of_name_indicator := '';
SELF.mortgage_lender_type_code := '';
SELF.mortgage_loan_type_code := '';
SELF.neighborhood_code := '';
SELF.new_record_type_code := '';
SELF.no_of_plumbing_fixtures := '';
SELF.old_apn := '';
SELF.other_buildings1_code := '';
SELF.other_buildings2_code := '';
SELF.other_buildings3_code := '';
SELF.other_buildings4_code := '';
SELF.other_buildings5_code := '';
SELF.other_impr_building1_indicator := '';
SELF.other_impr_building2_indicator := '';
SELF.other_impr_building3_indicator := '';
SELF.other_impr_building4_indicator := '';
SELF.other_impr_building5_indicator := '';
SELF.other_impr_building_area1 := '';
SELF.other_impr_building_area2 := '';
SELF.other_impr_building_area3 := '';
SELF.other_impr_building_area4 := '';
SELF.other_impr_building_area5 := '';
SELF.other_rooms_indicator := '';
SELF.ownership_type_code := '';
SELF.prior_recording_date := '';
SELF.prior_sales_price := '';
SELF.prior_sales_price_code := '';
SELF.prior_transfer_date := '';
SELF.process_date := '';
SELF.prop_addr_propagated_ind := '';
SELF.property_address_code := '';
SELF.property_country_code := '';
SELF.record_type_code := '';
SELF.sales_price_code := '';
SELF.school_tax_district1 := '';
SELF.school_tax_district1_indicator := '';
SELF.school_tax_district2 := '';
SELF.school_tax_district2_indicator := '';
SELF.school_tax_district3 := '';
SELF.school_tax_district3_indicator := '';
SELF.second_assessee_name_indicator := '';
SELF.sewer_code := '';
SELF.site_influence1_code := '';
SELF.site_influence2_code := '';
SELF.site_influence3_code := '';
SELF.site_influence4_code := '';
SELF.site_influence5_code := '';
SELF.state_code := '';
SELF.state_land_use_code := '';
SELF.tape_cut_date := '';
SELF.tax_account_number := '';
SELF.tax_delinquent_year := '';
SELF.tax_exemption2_code := '';
SELF.tax_exemption3_code := '';
SELF.tax_exemption4_code := '';
SELF.timeshare_code := '';
SELF.topograpy_code := '';
SELF.transfer_date := '';
SELF.water_code := '';
SELF.zoning := '';

	self := l;
end;
							 
export assessment := project(assess_ds,proj_assess_recs(left));


deed_ds := dataset ('~thor_data400::base::override::fcra::qa::property_deeds_v2',
               FCRA.Layout_Override_Deed, flat);

deed_override_layout := record
		string20 flag_file_id;
	ln_propertyv2.layout_deed_mortgage_common_model_base;
end;

deed_override_layout proj_deed_recs(deed_ds l) := transform
	SELF.addendum_flag := '';
SELF.addl_name_flag := '';
SELF.adjustable_rate_index := '';
SELF.adjustable_rate_rider := '';
SELF.arm_reset_date := '';
SELF.assumability_rider := '';
SELF.balloon_rider := '';
SELF.biweekly_payment_rider := '';
SELF.change_index := '';
SELF.city_transfer_tax := '';
SELF.complete_legal_description_code := '';
SELF.concurrent_mortgage_book_page_document_number := '';
SELF.condo_code := '';
SELF.condominium_rider := '';
SELF.county_transfer_tax := '';
SELF.current_record := '';
SELF.data_source_code := '';
SELF.document_number := '';
SELF.document_type_code := '';
SELF.excise_tax_number := '';
SELF.fares_unformatted_apn := '';
SELF.filler_except_hawaii := '';
SELF.fips_code := '';
SELF.first_td_interest_rate := '';
SELF.first_td_lender_type_code := '';
SELF.fixed_step_rate_rider := '';
SELF.from_file := '';
SELF.graduated_payment_rider := '';
SELF.hawaii_condo_cpr_code := '';
SELF.hawaii_condo_name := '';
SELF.hawaii_tct := '';
SELF.land_lot_size := '';
SELF.legal_block := '';
SELF.legal_district := '';
SELF.legal_land_lot := '';
SELF.legal_lot_code := '';
SELF.legal_lot_number := '';
SELF.legal_phase_number := '';
SELF.legal_sec_twn_rng_mer := '';
SELF.legal_section := '';
SELF.legal_tract_number := '';
SELF.legal_unit := '';
SELF.lender_address_citystatezip := '';
SELF.lender_address_unit_number := '';
SELF.lender_dba_aka_name := '';
SELF.lender_full_street_address := '';
SELF.lender_name := '';
SELF.lender_name_id := '';
SELF.loan_number := '';
SELF.loan_term_months := '';
SELF.loan_term_years := '';
SELF.mailing_address_cd := '';
SELF.mailing_care_of := '';
SELF.main_record_id_code := '';
SELF.multi_apn_flag := '';
SELF.name1_id_code := '';
SELF.name2_id_code := '';
SELF.one_four_family_rider := '';
SELF.partial_interest_transferred := '';
SELF.phone_number := '';
SELF.planned_unit_development_rider := '';
SELF.prepayment_rider := '';
SELF.process_date := '';
SELF.prop_addr_propagated_ind := '';
SELF.property_address_code := '';
SELF.property_use_code := '';
SELF.rate_change_frequency := '';
SELF.rate_improvement_rider := '';
SELF.record_type := '';
SELF.recorder_map_reference := '';
SELF.second_home_rider := '';
SELF.second_td_lender_type_code := '';
SELF.second_td_loan_amount := '';
SELF.seller1_id_code := '';
SELF.seller2_id_code := '';
SELF.seller_addendum_flag := '';
SELF.state := '';
SELF.tax_id_number := '';
SELF.timeshare_flag := '';
SELF.title_company_name := '';
SELF.total_transfer_tax := '';
SELF.vesting_code := '';



	self := l;
end;
							 
export deed := project(deed_ds,proj_deed_recs(left));

search_ds := FCRA.Convert_Property_Search_V2;

key_search_ds := ln_propertyv2.key_search_fid(true);

search_override_layout := record
		string20 flag_file_id;
	ln_propertyv2.layout_search_building;

end;

search_override_layout project_search_recs(search_ds l,key_search_ds r) := transform
	self.persistent_record_id := r.persistent_record_id;
	self := l;
end;

export search := dedup(sort(distribute(join(search_ds,key_search_ds,
																	keyed(left.ln_fares_id = right.ln_fares_id) and
																	left.did = right.did and left.source_code = right.source_code,
																	project_search_recs(left,right)
																),hash(ln_fares_id)),ln_fares_id,persistent_record_id,local),record,local);

end;