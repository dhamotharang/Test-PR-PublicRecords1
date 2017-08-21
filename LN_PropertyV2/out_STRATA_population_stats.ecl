export out_STRATA_population_stats(pAsses
                                  ,Pdeed
																	,paddlftax
																	,paddlfdeed
																	,paddllegal
																	,paddlnames
                                  ,pParty
																	,pVersion
																	,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_pAsses);
	#uniquename(dPopulationStats_pAsses);
	#uniquename(rPopulationStats_pAssesPlus);
	#uniquename(dPopulationStats_pAssesPlus);
	#uniquename(rPopulationStats_Pdeed);
	#uniquename(dPopulationStats_Pdeed);
	#uniquename(rPopulationStats_paddlftax);
	#uniquename(dPopulationStats_paddlftax);
	#uniquename(rPopulationStats_paddlftaxPlus);
	#uniquename(dPopulationStats_paddlftaxPlus);
	#uniquename(rPopulationStats_paddlfdeed);
	#uniquename(dPopulationStats_paddlfdeed);
	#uniquename(rPopulationStats_paddlfdeedPlus);
	#uniquename(dPopulationStats_paddlfdeedPlus);
	#uniquename(rPopulationStats_paddllegal);
	#uniquename(dPopulationStats_paddllegal);
	#uniquename(rPopulationStats_paddlnames);
	#uniquename(dPopulationStats_paddlnames);
	#uniquename(rPopulationStats_pParty);
	#uniquename(dPopulationStats_pParty);
	
	#uniquename(zAssesStats);
	#uniquename(zAssesPlusStats);
	#uniquename(zdeedStats);
	#uniquename(zaddlftaxStats);
	#uniquename(zaddlftaxPlusStats);
	#uniquename(zaddlfdeedStats);
	#uniquename(zaddlfdeedPlusStats);
	#uniquename(zaddllegalStats);
	#uniquename(zaddlnamesStats);
	#uniquename(zPartyStats);
	
// TAX

%rPopulationStats_pAsses%
 :=
  record
    CountGroup                                                    := count(group);
		pAsses.vendor_source_flag;
    ln_fares_id_CountNonBlank                                     := sum(group,if(pAsses.ln_fares_id<>'',1,0));
    process_date_CountNonBlank                                    := sum(group,if(pAsses.process_date<>'',1,0));
    vendor_source_flag_CountNonBlank                              := sum(group,if(pAsses.vendor_source_flag<>'',1,0));
    current_record_CountNonBlank                                  := sum(group,if(pAsses.current_record<>'',1,0));
    fips_code_CountNonBlank                                       := sum(group,if(pAsses.fips_code<>'',1,0));
    state_code_CountNonBlank                                      := sum(group,if(pAsses.state_code<>'',1,0));
    county_name_CountNonBlank                                     := sum(group,if(pAsses.county_name<>'',1,0));
    apna_or_pin_number_CountNonBlank                              := sum(group,if(pAsses.apna_or_pin_number<>'',1,0));
    fares_unformatted_apn_CountNonBlank                           := sum(group,if(pAsses.fares_unformatted_apn<>'',1,0));
    duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(pAsses.duplicate_apn_multiple_address_id<>'',1,0));
    assessee_name_CountNonBlank                                   := sum(group,if(pAsses.assessee_name<>'',1,0));
    second_assessee_name_CountNonBlank                            := sum(group,if(pAsses.second_assessee_name<>'',1,0));
    assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(pAsses.assessee_ownership_rights_code<>'',1,0));
    assessee_relationship_code_CountNonBlank                      := sum(group,if(pAsses.assessee_relationship_code<>'',1,0));
    assessee_phone_number_CountNonBlank                           := sum(group,if(pAsses.assessee_phone_number<>'',1,0));
    tax_account_number_CountNonBlank                              := sum(group,if(pAsses.tax_account_number<>'',1,0));
    contract_owner_CountNonBlank                                  := sum(group,if(pAsses.contract_owner<>'',1,0));
    assessee_name_type_code_CountNonBlank                         := sum(group,if(pAsses.assessee_name_type_code<>'',1,0));
    second_assessee_name_type_code_CountNonBlank                  := sum(group,if(pAsses.second_assessee_name_type_code<>'',1,0));
    mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(pAsses.mail_care_of_name_type_code<>'',1,0));
    mailing_care_of_name_CountNonBlank                            := sum(group,if(pAsses.mailing_care_of_name<>'',1,0));
    mailing_full_street_address_CountNonBlank                     := sum(group,if(pAsses.mailing_full_street_address<>'',1,0));
    mailing_unit_number_CountNonBlank                             := sum(group,if(pAsses.mailing_unit_number<>'',1,0));
    mailing_city_state_zip_CountNonBlank                          := sum(group,if(pAsses.mailing_city_state_zip<>'',1,0));
    property_full_street_address_CountNonBlank                    := sum(group,if(pAsses.property_full_street_address<>'',1,0));
    property_unit_number_CountNonBlank                            := sum(group,if(pAsses.property_unit_number<>'',1,0));
    property_city_state_zip_CountNonBlank                         := sum(group,if(pAsses.property_city_state_zip<>'',1,0));
    property_country_code_CountNonBlank                           := sum(group,if(pAsses.property_country_code<>'',1,0));
    property_address_code_CountNonBlank                           := sum(group,if(pAsses.property_address_code<>'',1,0));
    legal_lot_code_CountNonBlank                                  := sum(group,if(pAsses.legal_lot_code<>'',1,0));
    legal_lot_number_CountNonBlank                                := sum(group,if(pAsses.legal_lot_number<>'',1,0));
    legal_land_lot_CountNonBlank                                  := sum(group,if(pAsses.legal_land_lot<>'',1,0));
    legal_block_CountNonBlank                                     := sum(group,if(pAsses.legal_block<>'',1,0));
    legal_section_CountNonBlank                                   := sum(group,if(pAsses.legal_section<>'',1,0));
    legal_district_CountNonBlank                                  := sum(group,if(pAsses.legal_district<>'',1,0));
    legal_unit_CountNonBlank                                      := sum(group,if(pAsses.legal_unit<>'',1,0));
    legal_city_municipality_township_CountNonBlank                := sum(group,if(pAsses.legal_city_municipality_township<>'',1,0));
    legal_subdivision_name_CountNonBlank                          := sum(group,if(pAsses.legal_subdivision_name<>'',1,0));
    legal_phase_number_CountNonBlank                              := sum(group,if(pAsses.legal_phase_number<>'',1,0));
    legal_tract_number_CountNonBlank                              := sum(group,if(pAsses.legal_tract_number<>'',1,0));
    legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(pAsses.legal_sec_twn_rng_mer<>'',1,0));
    legal_brief_description_CountNonBlank                         := sum(group,if(pAsses.legal_brief_description<>'',1,0));
    legal_assessor_map_ref_CountNonBlank                          := sum(group,if(pAsses.legal_assessor_map_ref<>'',1,0));
    census_tract_CountNonBlank                                    := sum(group,if(pAsses.census_tract<>'',1,0));
    record_type_code_CountNonBlank                                := sum(group,if(pAsses.record_type_code<>'',1,0));
    ownership_type_code_CountNonBlank                             := sum(group,if(pAsses.ownership_type_code<>'',1,0));
    new_record_type_code_CountNonBlank                            := sum(group,if(pAsses.new_record_type_code<>'',1,0));
    county_land_use_code_CountNonBlank                            := sum(group,if(pAsses.county_land_use_code<>'',1,0));
    county_land_use_description_CountNonBlank                     := sum(group,if(pAsses.county_land_use_description<>'',1,0));
    standardized_land_use_code_CountNonBlank                      := sum(group,if(pAsses.standardized_land_use_code<>'',1,0));
    timeshare_code_CountNonBlank                                  := sum(group,if(pAsses.timeshare_code<>'',1,0));
    zoning_CountNonBlank                                          := sum(group,if(pAsses.zoning<>'',1,0));
    owner_occupied_CountNonBlank                                  := sum(group,if(pAsses.owner_occupied<>'',1,0));
    recorder_document_number_CountNonBlank                        := sum(group,if(pAsses.recorder_document_number<>'',1,0));
    recorder_book_number_CountNonBlank                            := sum(group,if(pAsses.recorder_book_number<>'',1,0));
    recorder_page_number_CountNonBlank                            := sum(group,if(pAsses.recorder_page_number<>'',1,0));
    transfer_date_CountNonBlank                                   := sum(group,if(pAsses.transfer_date<>'',1,0));
    recording_date_CountNonBlank                                  := sum(group,if(pAsses.recording_date<>'',1,0));
    sale_date_CountNonBlank                                       := sum(group,if(pAsses.sale_date<>'',1,0));
    document_type_CountNonBlank                                   := sum(group,if(pAsses.document_type<>'',1,0));
    sales_price_CountNonBlank                                     := sum(group,if(pAsses.sales_price<>'',1,0));
    sales_price_code_CountNonBlank                                := sum(group,if(pAsses.sales_price_code<>'',1,0));
    mortgage_loan_amount_CountNonBlank                            := sum(group,if(pAsses.mortgage_loan_amount<>'',1,0));
    mortgage_loan_type_code_CountNonBlank                         := sum(group,if(pAsses.mortgage_loan_type_code<>'',1,0));
    mortgage_lender_name_CountNonBlank                            := sum(group,if(pAsses.mortgage_lender_name<>'',1,0));
    mortgage_lender_type_code_CountNonBlank                       := sum(group,if(pAsses.mortgage_lender_type_code<>'',1,0));
    prior_transfer_date_CountNonBlank                             := sum(group,if(pAsses.prior_transfer_date<>'',1,0));
    prior_recording_date_CountNonBlank                            := sum(group,if(pAsses.prior_recording_date<>'',1,0));
    prior_sales_price_CountNonBlank                               := sum(group,if(pAsses.prior_sales_price<>'',1,0));
    prior_sales_price_code_CountNonBlank                          := sum(group,if(pAsses.prior_sales_price_code<>'',1,0));
    assessed_land_value_CountNonBlank                             := sum(group,if(pAsses.assessed_land_value<>'',1,0));
    assessed_improvement_value_CountNonBlank                      := sum(group,if(pAsses.assessed_improvement_value<>'',1,0));
    assessed_total_value_CountNonBlank                            := sum(group,if(pAsses.assessed_total_value<>'',1,0));
    assessed_value_year_CountNonBlank                             := sum(group,if(pAsses.assessed_value_year<>'',1,0));
    market_land_value_CountNonBlank                               := sum(group,if(pAsses.market_land_value<>'',1,0));
    market_improvement_value_CountNonBlank                        := sum(group,if(pAsses.market_improvement_value<>'',1,0));
    market_total_value_CountNonBlank                              := sum(group,if(pAsses.market_total_value<>'',1,0));
    market_value_year_CountNonBlank                               := sum(group,if(pAsses.market_value_year<>'',1,0));
    homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(pAsses.homestead_homeowner_exemption<>'',1,0));
    tax_exemption1_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption1_code<>'',1,0));
    tax_exemption2_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption2_code<>'',1,0));
    tax_exemption3_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption3_code<>'',1,0));
    tax_exemption4_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption4_code<>'',1,0));
    tax_rate_code_area_CountNonBlank                              := sum(group,if(pAsses.tax_rate_code_area<>'',1,0));
    tax_amount_CountNonBlank                                      := sum(group,if(pAsses.tax_amount<>'',1,0));
    tax_year_CountNonBlank                                        := sum(group,if(pAsses.tax_year<>'',1,0));
    tax_delinquent_year_CountNonBlank                             := sum(group,if(pAsses.tax_delinquent_year<>'',1,0));
    school_tax_district1_CountNonBlank                            := sum(group,if(pAsses.school_tax_district1<>'',1,0));
    school_tax_district1_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district1_indicator<>'',1,0));
    school_tax_district2_CountNonBlank                            := sum(group,if(pAsses.school_tax_district2<>'',1,0));
    school_tax_district2_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district2_indicator<>'',1,0));
    school_tax_district3_CountNonBlank                            := sum(group,if(pAsses.school_tax_district3<>'',1,0));
    school_tax_district3_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district3_indicator<>'',1,0));
    land_acres_CountNonBlank                                      := sum(group,if(pAsses.land_acres<>'',1,0));
    land_square_footage_CountNonBlank                             := sum(group,if(pAsses.land_square_footage<>'',1,0));
    land_dimensions_CountNonBlank                                 := sum(group,if(pAsses.land_dimensions<>'',1,0));
    building_area_CountNonBlank                                   := sum(group,if(pAsses.building_area<>'',1,0));
    building_area_indicator_CountNonBlank                         := sum(group,if(pAsses.building_area_indicator<>'',1,0));
    building_area1_CountNonBlank                                  := sum(group,if(pAsses.building_area1<>'',1,0));
    building_area1_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area1_indicator<>'',1,0));
    building_area2_CountNonBlank                                  := sum(group,if(pAsses.building_area2<>'',1,0));
    building_area2_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area2_indicator<>'',1,0));
    building_area3_CountNonBlank                                  := sum(group,if(pAsses.building_area3<>'',1,0));
    building_area3_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area3_indicator<>'',1,0));
    building_area4_CountNonBlank                                  := sum(group,if(pAsses.building_area4<>'',1,0));
    building_area4_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area4_indicator<>'',1,0));
    building_area5_CountNonBlank                                  := sum(group,if(pAsses.building_area5<>'',1,0));
    building_area5_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area5_indicator<>'',1,0));
    building_area6_CountNonBlank                                  := sum(group,if(pAsses.building_area6<>'',1,0));
    building_area6_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area6_indicator<>'',1,0));
    building_area7_CountNonBlank                                  := sum(group,if(pAsses.building_area7<>'',1,0));
    building_area7_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area7_indicator<>'',1,0));
    year_built_CountNonBlank                                      := sum(group,if(pAsses.year_built<>'',1,0));
    effective_year_built_CountNonBlank                            := sum(group,if(pAsses.effective_year_built<>'',1,0));
    no_of_buildings_CountNonBlank                                 := sum(group,if(pAsses.no_of_buildings<>'',1,0));
    no_of_stories_CountNonBlank                                   := sum(group,if(pAsses.no_of_stories<>'',1,0));
    no_of_units_CountNonBlank                                     := sum(group,if(pAsses.no_of_units<>'',1,0));
    no_of_rooms_CountNonBlank                                     := sum(group,if(pAsses.no_of_rooms<>'',1,0));
    no_of_bedrooms_CountNonBlank                                  := sum(group,if(pAsses.no_of_bedrooms<>'',1,0));
    no_of_baths_CountNonBlank                                     := sum(group,if(pAsses.no_of_baths<>'',1,0));
    no_of_partial_baths_CountNonBlank                             := sum(group,if(pAsses.no_of_partial_baths<>'',1,0));
    garage_type_code_CountNonBlank                                := sum(group,if(pAsses.garage_type_code<>'',1,0));
    parking_no_of_cars_CountNonBlank                              := sum(group,if(pAsses.parking_no_of_cars<>'',1,0));
    pool_code_CountNonBlank                                       := sum(group,if(pAsses.pool_code<>'',1,0));
    style_code_CountNonBlank                                      := sum(group,if(pAsses.style_code<>'',1,0));
    type_construction_code_CountNonBlank                          := sum(group,if(pAsses.type_construction_code<>'',1,0));
    exterior_walls_code_CountNonBlank                             := sum(group,if(pAsses.exterior_walls_code<>'',1,0));
    foundation_code_CountNonBlank                                 := sum(group,if(pAsses.foundation_code<>'',1,0));
    roof_cover_code_CountNonBlank                                 := sum(group,if(pAsses.roof_cover_code<>'',1,0));
    roof_type_code_CountNonBlank                                  := sum(group,if(pAsses.roof_type_code<>'',1,0));
    heating_code_CountNonBlank                                    := sum(group,if(pAsses.heating_code<>'',1,0));
    heating_fuel_type_code_CountNonBlank                          := sum(group,if(pAsses.heating_fuel_type_code<>'',1,0));
    air_conditioning_code_CountNonBlank                           := sum(group,if(pAsses.air_conditioning_code<>'',1,0));
    air_conditioning_type_code_CountNonBlank                      := sum(group,if(pAsses.air_conditioning_type_code<>'',1,0));
    elevator_CountNonBlank                                        := sum(group,if(pAsses.elevator<>'',1,0));
    fireplace_indicator_CountNonBlank                             := sum(group,if(pAsses.fireplace_indicator<>'',1,0));
    fireplace_number_CountNonBlank                                := sum(group,if(pAsses.fireplace_number<>'',1,0));
    basement_code_CountNonBlank                                   := sum(group,if(pAsses.basement_code<>'',1,0));
    building_class_code_CountNonBlank                             := sum(group,if(pAsses.building_class_code<>'',1,0));
    site_influence1_code_CountNonBlank                            := sum(group,if(pAsses.site_influence1_code<>'',1,0));
    site_influence2_code_CountNonBlank                            := sum(group,if(pAsses.site_influence2_code<>'',1,0));
    site_influence3_code_CountNonBlank                            := sum(group,if(pAsses.site_influence3_code<>'',1,0));
    site_influence4_code_CountNonBlank                            := sum(group,if(pAsses.site_influence4_code<>'',1,0));
    site_influence5_code_CountNonBlank                            := sum(group,if(pAsses.site_influence5_code<>'',1,0));
    amenities1_code_CountNonBlank                                 := sum(group,if(pAsses.amenities1_code<>'',1,0));
    amenities2_code_CountNonBlank                                 := sum(group,if(pAsses.amenities2_code<>'',1,0));
    amenities3_code_CountNonBlank                                 := sum(group,if(pAsses.amenities3_code<>'',1,0));
    amenities4_code_CountNonBlank                                 := sum(group,if(pAsses.amenities4_code<>'',1,0));
    amenities5_code_CountNonBlank                                 := sum(group,if(pAsses.amenities5_code<>'',1,0));
    other_buildings1_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings1_code<>'',1,0));
    other_buildings2_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings2_code<>'',1,0));
    other_buildings3_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings3_code<>'',1,0));
    other_buildings4_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings4_code<>'',1,0));
    other_buildings5_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings5_code<>'',1,0));
    neighborhood_code_CountNonBlank                               := sum(group,if(pAsses.neighborhood_code<>'',1,0));
    condo_project_name_CountNonBlank                              := sum(group,if(pAsses.condo_project_or_building_name<>'',1,0));
    building_name_CountNonBlank                                   := sum(group,if(pAsses.condo_project_or_building_name<>'',1,0));
    assessee_name_indicator_CountNonBlank                         := sum(group,if(pAsses.assessee_name_indicator<>'',1,0));
    second_assessee_name_indicator_CountNonBlank                  := sum(group,if(pAsses.second_assessee_name_indicator<>'',1,0));
    mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(pAsses.mail_care_of_name_indicator<>'',1,0));
    comments_CountNonBlank                                        := sum(group,if(pAsses.comments<>'',1,0));
    tape_cut_date_CountNonBlank                                   := sum(group,if(pAsses.tape_cut_date<>'',1,0));
    certification_date_CountNonBlank                              := sum(group,if(pAsses.certification_date<>'',1,0));
    edition_number_CountNonBlank                                  := sum(group,if(pAsses.edition_number<>'',1,0));
    prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(pAsses.prop_addr_propagated_ind<>'',1,0));
end;

%rPopulationStats_pAssesPlus%
 :=
  record
    CountGroup                                                    := count(group);
		pAsses.vendor_source_flag;
    ln_fares_id_CountNonBlank                                     := sum(group,if(pAsses.ln_fares_id<>'',1,0));
    process_date_CountNonBlank                                    := sum(group,if(pAsses.process_date<>'',1,0));
    vendor_source_flag_CountNonBlank                              := sum(group,if(pAsses.vendor_source_flag<>'',1,0));
    current_record_CountNonBlank                                  := sum(group,if(pAsses.current_record<>'',1,0));
    fips_code_CountNonBlank                                       := sum(group,if(pAsses.fips_code<>'',1,0));
    state_code_CountNonBlank                                      := sum(group,if(pAsses.state_code<>'',1,0));
    county_name_CountNonBlank                                     := sum(group,if(pAsses.county_name<>'',1,0));
    apna_or_pin_number_CountNonBlank                              := sum(group,if(pAsses.apna_or_pin_number<>'',1,0));
    fares_unformatted_apn_CountNonBlank                           := sum(group,if(pAsses.fares_unformatted_apn<>'',1,0));
    duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(pAsses.duplicate_apn_multiple_address_id<>'',1,0));
    assessee_name_CountNonBlank                                   := sum(group,if(pAsses.assessee_name<>'',1,0));
    second_assessee_name_CountNonBlank                            := sum(group,if(pAsses.second_assessee_name<>'',1,0));
    assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(pAsses.assessee_ownership_rights_code<>'',1,0));
    assessee_relationship_code_CountNonBlank                      := sum(group,if(pAsses.assessee_relationship_code<>'',1,0));
    assessee_phone_number_CountNonBlank                           := sum(group,if(pAsses.assessee_phone_number<>'',1,0));
    tax_account_number_CountNonBlank                              := sum(group,if(pAsses.tax_account_number<>'',1,0));
    contract_owner_CountNonBlank                                  := sum(group,if(pAsses.contract_owner<>'',1,0));
    assessee_name_type_code_CountNonBlank                         := sum(group,if(pAsses.assessee_name_type_code<>'',1,0));
    second_assessee_name_type_code_CountNonBlank                  := sum(group,if(pAsses.second_assessee_name_type_code<>'',1,0));
    mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(pAsses.mail_care_of_name_type_code<>'',1,0));
    mailing_care_of_name_CountNonBlank                            := sum(group,if(pAsses.mailing_care_of_name<>'',1,0));
    mailing_full_street_address_CountNonBlank                     := sum(group,if(pAsses.mailing_full_street_address<>'',1,0));
    mailing_unit_number_CountNonBlank                             := sum(group,if(pAsses.mailing_unit_number<>'',1,0));
    mailing_city_state_zip_CountNonBlank                          := sum(group,if(pAsses.mailing_city_state_zip<>'',1,0));
    property_full_street_address_CountNonBlank                    := sum(group,if(pAsses.property_full_street_address<>'',1,0));
    property_unit_number_CountNonBlank                            := sum(group,if(pAsses.property_unit_number<>'',1,0));
    property_city_state_zip_CountNonBlank                         := sum(group,if(pAsses.property_city_state_zip<>'',1,0));
    property_country_code_CountNonBlank                           := sum(group,if(pAsses.property_country_code<>'',1,0));
    property_address_code_CountNonBlank                           := sum(group,if(pAsses.property_address_code<>'',1,0));
    legal_lot_code_CountNonBlank                                  := sum(group,if(pAsses.legal_lot_code<>'',1,0));
    legal_lot_number_CountNonBlank                                := sum(group,if(pAsses.legal_lot_number<>'',1,0));
    legal_land_lot_CountNonBlank                                  := sum(group,if(pAsses.legal_land_lot<>'',1,0));
    legal_block_CountNonBlank                                     := sum(group,if(pAsses.legal_block<>'',1,0));
    legal_section_CountNonBlank                                   := sum(group,if(pAsses.legal_section<>'',1,0));
    legal_district_CountNonBlank                                  := sum(group,if(pAsses.legal_district<>'',1,0));
    legal_unit_CountNonBlank                                      := sum(group,if(pAsses.legal_unit<>'',1,0));
    legal_city_municipality_township_CountNonBlank                := sum(group,if(pAsses.legal_city_municipality_township<>'',1,0));
    legal_subdivision_name_CountNonBlank                          := sum(group,if(pAsses.legal_subdivision_name<>'',1,0));
    legal_phase_number_CountNonBlank                              := sum(group,if(pAsses.legal_phase_number<>'',1,0));
    legal_tract_number_CountNonBlank                              := sum(group,if(pAsses.legal_tract_number<>'',1,0));
    legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(pAsses.legal_sec_twn_rng_mer<>'',1,0));
    legal_brief_description_CountNonBlank                         := sum(group,if(pAsses.legal_brief_description<>'',1,0));
    legal_assessor_map_ref_CountNonBlank                          := sum(group,if(pAsses.legal_assessor_map_ref<>'',1,0));
    census_tract_CountNonBlank                                    := sum(group,if(pAsses.census_tract<>'',1,0));
    record_type_code_CountNonBlank                                := sum(group,if(pAsses.record_type_code<>'',1,0));
    ownership_type_code_CountNonBlank                             := sum(group,if(pAsses.ownership_type_code<>'',1,0));
    new_record_type_code_CountNonBlank                            := sum(group,if(pAsses.new_record_type_code<>'',1,0));
    county_land_use_code_CountNonBlank                            := sum(group,if(pAsses.county_land_use_code<>'',1,0));
    county_land_use_description_CountNonBlank                     := sum(group,if(pAsses.county_land_use_description<>'',1,0));
    standardized_land_use_code_CountNonBlank                      := sum(group,if(pAsses.standardized_land_use_code<>'',1,0));
    timeshare_code_CountNonBlank                                  := sum(group,if(pAsses.timeshare_code<>'',1,0));
    zoning_CountNonBlank                                          := sum(group,if(pAsses.zoning<>'',1,0));
    owner_occupied_CountNonBlank                                  := sum(group,if(pAsses.owner_occupied<>'',1,0));
    recorder_document_number_CountNonBlank                        := sum(group,if(pAsses.recorder_document_number<>'',1,0));
    recorder_book_number_CountNonBlank                            := sum(group,if(pAsses.recorder_book_number<>'',1,0));
    recorder_page_number_CountNonBlank                            := sum(group,if(pAsses.recorder_page_number<>'',1,0));
    transfer_date_CountNonBlank                                   := sum(group,if(pAsses.transfer_date<>'',1,0));
    recording_date_CountNonBlank                                  := sum(group,if(pAsses.recording_date<>'',1,0));
    sale_date_CountNonBlank                                       := sum(group,if(pAsses.sale_date<>'',1,0));
    document_type_CountNonBlank                                   := sum(group,if(pAsses.document_type<>'',1,0));
    sales_price_CountNonBlank                                     := sum(group,if(pAsses.sales_price<>'',1,0));
    sales_price_code_CountNonBlank                                := sum(group,if(pAsses.sales_price_code<>'',1,0));
    mortgage_loan_amount_CountNonBlank                            := sum(group,if(pAsses.mortgage_loan_amount<>'',1,0));
    mortgage_loan_type_code_CountNonBlank                         := sum(group,if(pAsses.mortgage_loan_type_code<>'',1,0));
    mortgage_lender_name_CountNonBlank                            := sum(group,if(pAsses.mortgage_lender_name<>'',1,0));
    mortgage_lender_type_code_CountNonBlank                       := sum(group,if(pAsses.mortgage_lender_type_code<>'',1,0));
    prior_transfer_date_CountNonBlank                             := sum(group,if(pAsses.prior_transfer_date<>'',1,0));
    prior_recording_date_CountNonBlank                            := sum(group,if(pAsses.prior_recording_date<>'',1,0));
    prior_sales_price_CountNonBlank                               := sum(group,if(pAsses.prior_sales_price<>'',1,0));
    prior_sales_price_code_CountNonBlank                          := sum(group,if(pAsses.prior_sales_price_code<>'',1,0));
    assessed_land_value_CountNonBlank                             := sum(group,if(pAsses.assessed_land_value<>'',1,0));
    assessed_improvement_value_CountNonBlank                      := sum(group,if(pAsses.assessed_improvement_value<>'',1,0));
    assessed_total_value_CountNonBlank                            := sum(group,if(pAsses.assessed_total_value<>'',1,0));
    assessed_value_year_CountNonBlank                             := sum(group,if(pAsses.assessed_value_year<>'',1,0));
    market_land_value_CountNonBlank                               := sum(group,if(pAsses.market_land_value<>'',1,0));
    market_improvement_value_CountNonBlank                        := sum(group,if(pAsses.market_improvement_value<>'',1,0));
    market_total_value_CountNonBlank                              := sum(group,if(pAsses.market_total_value<>'',1,0));
    market_value_year_CountNonBlank                               := sum(group,if(pAsses.market_value_year<>'',1,0));
    homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(pAsses.homestead_homeowner_exemption<>'',1,0));
    tax_exemption1_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption1_code<>'',1,0));
    tax_exemption2_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption2_code<>'',1,0));
    tax_exemption3_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption3_code<>'',1,0));
    tax_exemption4_code_CountNonBlank                             := sum(group,if(pAsses.tax_exemption4_code<>'',1,0));
    tax_rate_code_area_CountNonBlank                              := sum(group,if(pAsses.tax_rate_code_area<>'',1,0));
    tax_amount_CountNonBlank                                      := sum(group,if(pAsses.tax_amount<>'',1,0));
    tax_year_CountNonBlank                                        := sum(group,if(pAsses.tax_year<>'',1,0));
    tax_delinquent_year_CountNonBlank                             := sum(group,if(pAsses.tax_delinquent_year<>'',1,0));
    school_tax_district1_CountNonBlank                            := sum(group,if(pAsses.school_tax_district1<>'',1,0));
    school_tax_district1_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district1_indicator<>'',1,0));
    school_tax_district2_CountNonBlank                            := sum(group,if(pAsses.school_tax_district2<>'',1,0));
    school_tax_district2_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district2_indicator<>'',1,0));
    school_tax_district3_CountNonBlank                            := sum(group,if(pAsses.school_tax_district3<>'',1,0));
    school_tax_district3_indicator_CountNonBlank                  := sum(group,if(pAsses.school_tax_district3_indicator<>'',1,0));
		lot_size_CountNonBlank																				:= sum(group,if(pAsses.lot_size<>'',1,0));
		lot_size_acres_CountNonBlank																	:= sum(group,if(pAsses.lot_size_acres<>'',1,0));
		lot_size_frontage_feet_CountNonBlank													:= sum(group,if(pAsses.lot_size_frontage_feet<>'',1,0));
		lot_size_depth_feet_CountNonBlank															:= sum(group,if(pAsses.lot_size_depth_feet<>'',1,0));
    land_acres_CountNonBlank                                      := sum(group,if(pAsses.land_acres<>'',1,0));
    land_square_footage_CountNonBlank                             := sum(group,if(pAsses.land_square_footage<>'',1,0));
    land_dimensions_CountNonBlank                                 := sum(group,if(pAsses.land_dimensions<>'',1,0));
    building_area_CountNonBlank                                   := sum(group,if(pAsses.building_area<>'',1,0));
    building_area_indicator_CountNonBlank                         := sum(group,if(pAsses.building_area_indicator<>'',1,0));
    building_area1_CountNonBlank                                  := sum(group,if(pAsses.building_area1<>'',1,0));
    building_area1_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area1_indicator<>'',1,0));
    building_area2_CountNonBlank                                  := sum(group,if(pAsses.building_area2<>'',1,0));
    building_area2_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area2_indicator<>'',1,0));
    building_area3_CountNonBlank                                  := sum(group,if(pAsses.building_area3<>'',1,0));
    building_area3_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area3_indicator<>'',1,0));
    building_area4_CountNonBlank                                  := sum(group,if(pAsses.building_area4<>'',1,0));
    building_area4_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area4_indicator<>'',1,0));
    building_area5_CountNonBlank                                  := sum(group,if(pAsses.building_area5<>'',1,0));
    building_area5_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area5_indicator<>'',1,0));
    building_area6_CountNonBlank                                  := sum(group,if(pAsses.building_area6<>'',1,0));
    building_area6_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area6_indicator<>'',1,0));
    building_area7_CountNonBlank                                  := sum(group,if(pAsses.building_area7<>'',1,0));
    building_area7_indicator_CountNonBlank                        := sum(group,if(pAsses.building_area7_indicator<>'',1,0));
    year_built_CountNonBlank                                      := sum(group,if(pAsses.year_built<>'',1,0));
    effective_year_built_CountNonBlank                            := sum(group,if(pAsses.effective_year_built<>'',1,0));
    no_of_buildings_CountNonBlank                                 := sum(group,if(pAsses.no_of_buildings<>'',1,0));
    no_of_stories_CountNonBlank                                   := sum(group,if(pAsses.no_of_stories<>'',1,0));
    no_of_units_CountNonBlank                                     := sum(group,if(pAsses.no_of_units<>'',1,0));
    no_of_rooms_CountNonBlank                                     := sum(group,if(pAsses.no_of_rooms<>'',1,0));
    no_of_bedrooms_CountNonBlank                                  := sum(group,if(pAsses.no_of_bedrooms<>'',1,0));
    no_of_baths_CountNonBlank                                     := sum(group,if(pAsses.no_of_baths<>'',1,0));
    no_of_partial_baths_CountNonBlank                             := sum(group,if(pAsses.no_of_partial_baths<>'',1,0));
		no_of_plumbing_fixtures_CountNonBlank                         := sum(group,if(pAsses.no_of_plumbing_fixtures<>'',1,0));
    garage_type_code_CountNonBlank                                := sum(group,if(pAsses.garage_type_code<>'',1,0));
    parking_no_of_cars_CountNonBlank                              := sum(group,if(pAsses.parking_no_of_cars<>'',1,0));
    pool_code_CountNonBlank                                       := sum(group,if(pAsses.pool_code<>'',1,0));
    style_code_CountNonBlank                                      := sum(group,if(pAsses.style_code<>'',1,0));
    type_construction_code_CountNonBlank                          := sum(group,if(pAsses.type_construction_code<>'',1,0));
    exterior_walls_code_CountNonBlank                             := sum(group,if(pAsses.exterior_walls_code<>'',1,0));
    foundation_code_CountNonBlank                                 := sum(group,if(pAsses.foundation_code<>'',1,0));
		building_quality_code_CountNonBlank                           := sum(group,if(pAsses.building_quality_code<>'',1,0));
		building_condition_code_CountNonBlank                         := sum(group,if(pAsses.building_condition_code<>'',1,0));
		interior_walls_code_CountNonBlank                             := sum(group,if(pAsses.interior_walls_code<>'',1,0));
    roof_cover_code_CountNonBlank                                 := sum(group,if(pAsses.roof_cover_code<>'',1,0));
    roof_type_code_CountNonBlank                                  := sum(group,if(pAsses.roof_type_code<>'',1,0));
		floor_cover_code_CountNonBlank                                := sum(group,if(pAsses.floor_cover_code<>'',1,0));
		water_code_CountNonBlank                                			:= sum(group,if(pAsses.water_code<>'',1,0));
		sewer_code_CountNonBlank                                			:= sum(group,if(pAsses.sewer_code<>'',1,0));
    heating_code_CountNonBlank                                    := sum(group,if(pAsses.heating_code<>'',1,0));
    heating_fuel_type_code_CountNonBlank                          := sum(group,if(pAsses.heating_fuel_type_code<>'',1,0));
    air_conditioning_code_CountNonBlank                           := sum(group,if(pAsses.air_conditioning_code<>'',1,0));
    air_conditioning_type_code_CountNonBlank                      := sum(group,if(pAsses.air_conditioning_type_code<>'',1,0));
    elevator_CountNonBlank                                        := sum(group,if(pAsses.elevator<>'',1,0));
    fireplace_indicator_CountNonBlank                             := sum(group,if(pAsses.fireplace_indicator<>'',1,0));
    fireplace_number_CountNonBlank                                := sum(group,if(pAsses.fireplace_number<>'',1,0));
    basement_code_CountNonBlank                                   := sum(group,if(pAsses.basement_code<>'',1,0));
    building_class_code_CountNonBlank                             := sum(group,if(pAsses.building_class_code<>'',1,0));
    site_influence1_code_CountNonBlank                            := sum(group,if(pAsses.site_influence1_code<>'',1,0));
    site_influence2_code_CountNonBlank                            := sum(group,if(pAsses.site_influence2_code<>'',1,0));
    site_influence3_code_CountNonBlank                            := sum(group,if(pAsses.site_influence3_code<>'',1,0));
    site_influence4_code_CountNonBlank                            := sum(group,if(pAsses.site_influence4_code<>'',1,0));
    site_influence5_code_CountNonBlank                            := sum(group,if(pAsses.site_influence5_code<>'',1,0));
    amenities1_code_CountNonBlank                                 := sum(group,if(pAsses.amenities1_code<>'',1,0));
    amenities2_code_CountNonBlank                                 := sum(group,if(pAsses.amenities2_code<>'',1,0));
    amenities3_code_CountNonBlank                                 := sum(group,if(pAsses.amenities3_code<>'',1,0));
    amenities4_code_CountNonBlank                                 := sum(group,if(pAsses.amenities4_code<>'',1,0));
    amenities5_code_CountNonBlank                                 := sum(group,if(pAsses.amenities5_code<>'',1,0));
		amenities2_code1_CountNonBlank                                := sum(group,if(pAsses.amenities2_code1<>'',1,0));
    amenities2_code2_CountNonBlank                                := sum(group,if(pAsses.amenities2_code2<>'',1,0));
    amenities2_code3_CountNonBlank                                := sum(group,if(pAsses.amenities2_code3<>'',1,0));
    amenities2_code4_CountNonBlank                                := sum(group,if(pAsses.amenities2_code4<>'',1,0));
    amenities2_code5_CountNonBlank                                := sum(group,if(pAsses.amenities2_code5<>'',1,0));
		extra_features1_area_CountNonBlank                            := sum(group,if(pAsses.extra_features1_area<>'',1,0));
		extra_features1_indicator_CountNonBlank                       := sum(group,if(pAsses.extra_features1_indicator<>'',1,0));
		extra_features2_area_CountNonBlank                            := sum(group,if(pAsses.extra_features2_area<>'',1,0));
		extra_features2_indicator_CountNonBlank                       := sum(group,if(pAsses.extra_features2_indicator<>'',1,0));
		extra_features3_area_CountNonBlank                            := sum(group,if(pAsses.extra_features3_area<>'',1,0));
		extra_features3_indicator_CountNonBlank                       := sum(group,if(pAsses.extra_features3_indicator<>'',1,0));
		extra_features4_area_CountNonBlank                            := sum(group,if(pAsses.extra_features4_area<>'',1,0));
		extra_features4_indicator_CountNonBlank                       := sum(group,if(pAsses.extra_features4_indicator<>'',1,0));
    other_buildings1_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings1_code<>'',1,0));
    other_buildings2_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings2_code<>'',1,0));
    other_buildings3_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings3_code<>'',1,0));
    other_buildings4_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings4_code<>'',1,0));
    other_buildings5_code_CountNonBlank                           := sum(group,if(pAsses.other_buildings5_code<>'',1,0));
		other_impr_building1_indicator_CountNonBlank									:= sum(group,if(pAsses.other_impr_building1_indicator<>'',1,0));
		other_impr_building2_indicator_CountNonBlank									:= sum(group,if(pAsses.other_impr_building2_indicator<>'',1,0));
		other_impr_building3_indicator_CountNonBlank									:= sum(group,if(pAsses.other_impr_building3_indicator<>'',1,0));
		other_impr_building4_indicator_CountNonBlank									:= sum(group,if(pAsses.other_impr_building4_indicator<>'',1,0));
		other_impr_building5_indicator_CountNonBlank									:= sum(group,if(pAsses.other_impr_building5_indicator<>'',1,0));
		other_impr_building_area1_CountNonBlank												:= sum(group,if(pAsses.other_impr_building_area1<>'',1,0));
		other_impr_building_area2_CountNonBlank												:= sum(group,if(pAsses.other_impr_building_area2<>'',1,0));
		other_impr_building_area3_CountNonBlank												:= sum(group,if(pAsses.other_impr_building_area3<>'',1,0));
		other_impr_building_area4_CountNonBlank												:= sum(group,if(pAsses.other_impr_building_area4<>'',1,0));
		other_impr_building_area5_CountNonBlank												:= sum(group,if(pAsses.other_impr_building_area5<>'',1,0));
    topography_code_CountNonBlank                               	:= sum(group,if(pAsses.topograpy_code<>'',1,0));
		neighborhood_code_CountNonBlank                               := sum(group,if(pAsses.neighborhood_code<>'',1,0));
    condo_project_or_building_name_CountNonBlank                  := sum(group,if(pAsses.condo_project_or_building_name<>'',1,0));
    assessee_name_indicator_CountNonBlank                         := sum(group,if(pAsses.assessee_name_indicator<>'',1,0));
    second_assessee_name_indicator_CountNonBlank                  := sum(group,if(pAsses.second_assessee_name_indicator<>'',1,0));
    mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(pAsses.mail_care_of_name_indicator<>'',1,0));
    comments_CountNonBlank                                        := sum(group,if(pAsses.comments<>'',1,0));
    tape_cut_date_CountNonBlank                                   := sum(group,if(pAsses.tape_cut_date<>'',1,0));
    certification_date_CountNonBlank                              := sum(group,if(pAsses.certification_date<>'',1,0));
    edition_number_CountNonBlank                                  := sum(group,if(pAsses.edition_number<>'',1,0));
    prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(pAsses.prop_addr_propagated_ind<>'',1,0));
end;

// deeds 

%rPopulationStats_Pdeed%
 :=
  record
    CountGroup                                                                := count(group);
    Pdeed.vendor_source_flag;
		ln_fares_id_CountNonBlank                                                 := sum(group,if(Pdeed.ln_fares_id<>'',1,0));
    process_date_CountNonBlank                                                := sum(group,if(Pdeed.process_date<>'',1,0));
    vendor_source_flag_CountNonBlank                                          := sum(group,if(Pdeed.vendor_source_flag<>'',1,0));
    current_record_CountNonBlank                                              := sum(group,if(Pdeed.current_record<>'',1,0));
    from_file_CountNonBlank                                                   := sum(group,if(Pdeed.from_file<>'',1,0));
    fips_code_CountNonBlank                                                   := sum(group,if(Pdeed.fips_code<>'',1,0));
    state_CountNonBlank                                                       := sum(group,if(Pdeed.state<>'',1,0));
    county_name_CountNonBlank                                                 := sum(group,if(Pdeed.county_name<>'',1,0));
    record_type_CountNonBlank                                                 := sum(group,if(Pdeed.record_type<>'',1,0));
    apnt_or_pin_number_CountNonBlank                                          := sum(group,if(Pdeed.apnt_or_pin_number<>'',1,0));
    fares_unformatted_apn_CountNonBlank                                       := sum(group,if(Pdeed.fares_unformatted_apn<>'',1,0));
    multi_apn_flag_CountNonBlank                                              := sum(group,if(Pdeed.multi_apn_flag<>'',1,0));
    tax_id_number_CountNonBlank                                               := sum(group,if(Pdeed.tax_id_number<>'',1,0));
    excise_tax_number_CountNonBlank                                           := sum(group,if(Pdeed.excise_tax_number<>'',1,0));
    buyer_or_borrower_ind_CountNonBlank                                       := sum(group,if(Pdeed.buyer_or_borrower_ind<>'',1,0));
    name1_CountNonBlank                                                       := sum(group,if(Pdeed.name1<>'',1,0));
    name1_id_code_CountNonBlank                                               := sum(group,if(Pdeed.name1_id_code<>'',1,0));
    name2_CountNonBlank                                                       := sum(group,if(Pdeed.name2<>'',1,0));
    name2_id_code_CountNonBlank                                               := sum(group,if(Pdeed.name2_id_code<>'',1,0));
    vesting_code_CountNonBlank                                                := sum(group,if(Pdeed.vesting_code<>'',1,0));
    addendum_flag_CountNonBlank                                               := sum(group,if(Pdeed.addendum_flag<>'',1,0));
    phone_number_CountNonBlank                                                := sum(group,if(Pdeed.phone_number<>'',1,0));
    mailing_care_of_CountNonBlank                                             := sum(group,if(Pdeed.mailing_care_of<>'',1,0));
    mailing_street_CountNonBlank                                              := sum(group,if(Pdeed.mailing_street<>'',1,0));
    mailing_unit_number_CountNonBlank                                         := sum(group,if(Pdeed.mailing_unit_number<>'',1,0));
    mailing_csz_CountNonBlank                                                 := sum(group,if(Pdeed.mailing_csz<>'',1,0));
    mailing_address_cd_CountNonBlank                                          := sum(group,if(Pdeed.mailing_address_cd<>'',1,0));
    seller1_CountNonBlank                                                     := sum(group,if(Pdeed.seller1<>'',1,0));
    seller1_id_code_CountNonBlank                                             := sum(group,if(Pdeed.seller1_id_code<>'',1,0));
    seller2_CountNonBlank                                                     := sum(group,if(Pdeed.seller2<>'',1,0));
    seller2_id_code_CountNonBlank                                             := sum(group,if(Pdeed.seller2_id_code<>'',1,0));
    seller_addendum_flag_CountNonBlank                                        := sum(group,if(Pdeed.seller_addendum_flag<>'',1,0));
    seller_mailing_full_street_address_CountNonBlank                          := sum(group,if(Pdeed.seller_mailing_full_street_address<>'',1,0));
    seller_mailing_address_unit_number_CountNonBlank                          := sum(group,if(Pdeed.seller_mailing_address_unit_number<>'',1,0));
    seller_mailing_address_citystatezip_CountNonBlank                         := sum(group,if(Pdeed.seller_mailing_address_citystatezip<>'',1,0));
    property_full_street_address_CountNonBlank                                := sum(group,if(Pdeed.property_full_street_address<>'',1,0));
    property_address_unit_number_CountNonBlank                                := sum(group,if(Pdeed.property_address_unit_number<>'',1,0));
    property_address_citystatezip_CountNonBlank                               := sum(group,if(Pdeed.property_address_citystatezip<>'',1,0));
    property_address_code_CountNonBlank                                       := sum(group,if(Pdeed.property_address_code<>'',1,0));
    legal_lot_code_CountNonBlank                                              := sum(group,if(Pdeed.legal_lot_code<>'',1,0));
    legal_lot_number_CountNonBlank                                            := sum(group,if(Pdeed.legal_lot_number<>'',1,0));
    legal_block_CountNonBlank                                                 := sum(group,if(Pdeed.legal_block<>'',1,0));
    legal_section_CountNonBlank                                               := sum(group,if(Pdeed.legal_section<>'',1,0));
    legal_district_CountNonBlank                                              := sum(group,if(Pdeed.legal_district<>'',1,0));
    legal_land_lot_CountNonBlank                                              := sum(group,if(Pdeed.legal_land_lot<>'',1,0));
    legal_unit_CountNonBlank                                                  := sum(group,if(Pdeed.legal_unit<>'',1,0));
    legal_city_municipality_township_CountNonBlank                            := sum(group,if(Pdeed.legal_city_municipality_township<>'',1,0));
    legal_subdivision_name_CountNonBlank                                      := sum(group,if(Pdeed.legal_subdivision_name<>'',1,0));
    legal_phase_number_CountNonBlank                                          := sum(group,if(Pdeed.legal_phase_number<>'',1,0));
    legal_tract_number_CountNonBlank                                          := sum(group,if(Pdeed.legal_tract_number<>'',1,0));
    legal_sec_twn_rng_mer_CountNonBlank                                       := sum(group,if(Pdeed.legal_sec_twn_rng_mer<>'',1,0));
    legal_brief_description_CountNonBlank                                     := sum(group,if(Pdeed.legal_brief_description<>'',1,0));
    recorder_map_reference_CountNonBlank                                      := sum(group,if(Pdeed.recorder_map_reference<>'',1,0));
    complete_legal_description_code_CountNonBlank                             := sum(group,if(Pdeed.complete_legal_description_code<>'',1,0));
    contract_date_CountNonBlank                                               := sum(group,if(Pdeed.contract_date<>'',1,0));
    recording_date_CountNonBlank                                              := sum(group,if(Pdeed.recording_date<>'',1,0));
		arm_reset_date_CountNonBlank                                              := sum(group,if(Pdeed.arm_reset_date<>'',1,0));
    document_number_CountNonBlank                                             := sum(group,if(Pdeed.document_number<>'',1,0));
    document_type_code_CountNonBlank                                          := sum(group,if(Pdeed.document_type_code<>'',1,0));
    loan_number_CountNonBlank                                                 := sum(group,if(Pdeed.loan_number<>'',1,0));
    recorder_book_number_CountNonBlank                                        := sum(group,if(Pdeed.recorder_book_number<>'',1,0));
    recorder_page_number_CountNonBlank                                        := sum(group,if(Pdeed.recorder_page_number<>'',1,0));
    concurrent_mortgage_book_page_document_number_CountNonBlank               := sum(group,if(Pdeed.concurrent_mortgage_book_page_document_number<>'',1,0));
    sales_price_CountNonBlank                                                 := sum(group,if(Pdeed.sales_price<>'',1,0));
    sales_price_code_CountNonBlank                                            := sum(group,if(Pdeed.sales_price_code<>'',1,0));
    city_transfer_tax_CountNonBlank                                           := sum(group,if(Pdeed.city_transfer_tax<>'',1,0));
    county_transfer_tax_CountNonBlank                                         := sum(group,if(Pdeed.county_transfer_tax<>'',1,0));
    total_transfer_tax_CountNonBlank                                          := sum(group,if(Pdeed.total_transfer_tax<>'',1,0));
    first_td_loan_amount_CountNonBlank                                        := sum(group,if(Pdeed.first_td_loan_amount<>'',1,0));
    second_td_loan_amount_CountNonBlank                                       := sum(group,if(Pdeed.second_td_loan_amount<>'',1,0));
    first_td_lender_type_code_CountNonBlank                                   := sum(group,if(Pdeed.first_td_lender_type_code<>'',1,0));
    second_td_lender_type_code_CountNonBlank                                  := sum(group,if(Pdeed.second_td_lender_type_code<>'',1,0));
    first_td_loan_type_code_CountNonBlank                                     := sum(group,if(Pdeed.first_td_loan_type_code<>'',1,0));
    type_financing_CountNonBlank                                              := sum(group,if(Pdeed.type_financing<>'',1,0));
    first_td_interest_rate_CountNonBlank                                      := sum(group,if(Pdeed.first_td_interest_rate<>'',1,0));
    first_td_due_date_CountNonBlank                                           := sum(group,if(Pdeed.first_td_due_date<>'',1,0));
    title_company_name_CountNonBlank                                          := sum(group,if(Pdeed.title_company_name<>'',1,0));
    partial_interest_transferred_CountNonBlank                                := sum(group,if(Pdeed.partial_interest_transferred<>'',1,0));
    loan_term_months_CountNonBlank                                            := sum(group,if(Pdeed.loan_term_months<>'',1,0));
    loan_term_years_CountNonBlank                                             := sum(group,if(Pdeed.loan_term_years<>'',1,0));
    lender_name_CountNonBlank                                                 := sum(group,if(Pdeed.lender_name<>'',1,0));
    lender_name_id_CountNonBlank                                              := sum(group,if(Pdeed.lender_name_id<>'',1,0));
    lender_dba_aka_name_CountNonBlank                                         := sum(group,if(Pdeed.lender_dba_aka_name<>'',1,0));
    lender_full_street_address_CountNonBlank                                  := sum(group,if(Pdeed.lender_full_street_address<>'',1,0));
    lender_address_unit_number_CountNonBlank                                  := sum(group,if(Pdeed.lender_address_unit_number<>'',1,0));
    lender_address_citystatezip_CountNonBlank                                 := sum(group,if(Pdeed.lender_address_citystatezip<>'',1,0));
    assessment_match_land_use_code_CountNonBlank                              := sum(group,if(Pdeed.assessment_match_land_use_code<>'',1,0));
    property_use_code_CountNonBlank                                           := sum(group,if(Pdeed.property_use_code<>'',1,0));
    condo_code_CountNonBlank                                                  := sum(group,if(Pdeed.condo_code<>'',1,0));
    timeshare_flag_CountNonBlank                                              := sum(group,if(Pdeed.timeshare_flag<>'',1,0));
    land_lot_size_CountNonBlank                                               := sum(group,if(Pdeed.land_lot_size<>'',1,0));
    hawaii_tct_CountNonBlank                                                  := sum(group,if(Pdeed.hawaii_tct<>'',1,0));
    hawaii_condo_cpr_code_CountNonBlank                                       := sum(group,if(Pdeed.hawaii_condo_cpr_code<>'',1,0));
    hawaii_condo_name_CountNonBlank                                           := sum(group,if(Pdeed.hawaii_condo_name<>'',1,0));
    filler_except_hawaii_CountNonBlank                                        := sum(group,if(Pdeed.filler_except_hawaii<>'',1,0));
    rate_change_frequency_CountNonBlank                                       := sum(group,if(Pdeed.rate_change_frequency<>'',1,0));
    change_index_CountNonBlank                                                := sum(group,if(Pdeed.change_index<>'',1,0));
    adjustable_rate_index_CountNonBlank                                       := sum(group,if(Pdeed.adjustable_rate_index<>'',1,0));
    adjustable_rate_rider_CountNonBlank                                       := sum(group,if(Pdeed.adjustable_rate_rider<>'',1,0));
    graduated_payment_rider_CountNonBlank                                     := sum(group,if(Pdeed.graduated_payment_rider<>'',1,0));
    balloon_rider_CountNonBlank                                               := sum(group,if(Pdeed.balloon_rider<>'',1,0));
    fixed_step_rate_rider_CountNonBlank                                       := sum(group,if(Pdeed.fixed_step_rate_rider<>'',1,0));
    condominium_rider_CountNonBlank                                           := sum(group,if(Pdeed.condominium_rider<>'',1,0));
    planned_unit_development_rider_CountNonBlank                              := sum(group,if(Pdeed.planned_unit_development_rider<>'',1,0));
    rate_improvement_rider_CountNonBlank                                      := sum(group,if(Pdeed.rate_improvement_rider<>'',1,0));
    assumability_rider_CountNonBlank                                          := sum(group,if(Pdeed.assumability_rider<>'',1,0));
    prepayment_rider_CountNonBlank                                            := sum(group,if(Pdeed.prepayment_rider<>'',1,0));
    one_four_family_rider_CountNonBlank                                       := sum(group,if(Pdeed.one_four_family_rider<>'',1,0));
    biweekly_payment_rider_CountNonBlank                                      := sum(group,if(Pdeed.biweekly_payment_rider<>'',1,0));
    second_home_rider_CountNonBlank                                           := sum(group,if(Pdeed.second_home_rider<>'',1,0));
    data_source_code_CountNonBlank                                            := sum(group,if(Pdeed.data_source_code<>'',1,0));
    main_record_id_code_CountNonBlank                                         := sum(group,if(Pdeed.main_record_id_code<>'',1,0));
    addl_name_flag_CountNonBlank                                              := sum(group,if(Pdeed.addl_name_flag<>'',1,0));
    prop_addr_propagated_ind_CountNonBlank                                    := sum(group,if(Pdeed.prop_addr_propagated_ind<>'',1,0));
  end;

// addl fares tax 

%rPopulationStats_paddlftax%
 :=
  record
    CountGroup                                                        := count(group);
    string3  grouping                                                 := 'ALL';   
    ln_fares_id_CountNonBlank                                         := sum(group,if(paddlftax.ln_fares_id<>'',1,0));
    fares_iris_apn_CountNonBlank                                      := sum(group,if(paddlftax.fares_iris_apn<>'',1,0));
    fares_non_parsed_assessee_name_CountNonBlank                      := sum(group,if(paddlftax.fares_non_parsed_assessee_name<>'',1,0));
    fares_non_parsed_second_assessee_name_CountNonBlank               := sum(group,if(paddlftax.fares_non_parsed_second_assessee_name<>'',1,0));
    fares_land_use_CountNonBlank                                      := sum(group,if(paddlftax.fares_land_use<>'',1,0));
    fares_seller_name_CountNonBlank                                   := sum(group,if(paddlftax.fares_seller_name<>'',1,0));
    fares_calculated_land_value_CountNonBlank                         := sum(group,if(paddlftax.fares_calculated_land_value<>'',1,0));
    fares_calculated_improvement_value_CountNonBlank                  := sum(group,if(paddlftax.fares_calculated_improvement_value<>'',1,0));
    fares_calculated_total_value_CountNonBlank                        := sum(group,if(paddlftax.fares_calculated_total_value<>'',1,0));
    fares_living_square_feet_CountNonBlank                            := sum(group,if(paddlftax.fares_living_square_feet<>'',1,0));
    fares_adjusted_gross_square_feet_CountNonBlank                    := sum(group,if(paddlftax.fares_adjusted_gross_square_feet<>'',1,0));
    fares_no_of_full_baths_CountNonBlank                              := sum(group,if(paddlftax.fares_no_of_full_baths<>'',1,0));
    fares_no_of_half_baths_CountNonBlank                              := sum(group,if(paddlftax.fares_no_of_half_baths<>'',1,0));
    fares_pool_indicator_CountNonBlank                                := sum(group,if(paddlftax.fares_pool_indicator<>'',1,0));
    fares_frame_CountNonBlank                                         := sum(group,if(paddlftax.fares_frame<>'',1,0));
    fares_electric_energy_CountNonBlank                               := sum(group,if(paddlftax.fares_electric_energy<>'',1,0));
    fares_sewer_CountNonBlank                                         := sum(group,if(paddlftax.fares_sewer<>'',1,0));
    fares_water_CountNonBlank                                         := sum(group,if(paddlftax.fares_water<>'',1,0));
    fares_condition_CountNonBlank                                     := sum(group,if(paddlftax.fares_condition<>'',1,0));
  end;
	
%rPopulationStats_paddlftaxPlus%
 :=
  record
    CountGroup                                                        := count(group);
    string3  grouping                                                 := 'ALL';   
    ln_fares_id_CountNonBlank                                         := sum(group,if(paddlftax.ln_fares_id<>'',1,0));
    fares_iris_apn_CountNonBlank                                      := sum(group,if(paddlftax.fares_iris_apn<>'',1,0));
		fares_map_ref_1_CountNonBlank                                     := sum(group,if(paddlftax.fares_map_ref_1<>'',1,0));
		fares_map_ref_2_CountNonBlank                                     := sum(group,if(paddlftax.fares_map_ref_2<>'',1,0));
		fares_quarter_CountNonBlank                                     	:= sum(group,if(paddlftax.fares_multi_apn_flag<>'',1,0));
		fares_multi_apn_flag_CountNonBlank                                := sum(group,if(paddlftax.fares_multi_apn_flag<>'',1,0));
    fares_non_parsed_assessee_name_CountNonBlank                      := sum(group,if(paddlftax.fares_non_parsed_assessee_name<>'',1,0));
    fares_non_parsed_second_assessee_name_CountNonBlank               := sum(group,if(paddlftax.fares_non_parsed_second_assessee_name<>'',1,0));
		fares_absentee_owner_CountNonBlank																:= sum(group,if(paddlftax.fares_absentee_owner<>'',1,0));
		fares_flood_zone_CountNonBlank																		:= sum(group,if(paddlftax.fares_flood_zone<>'',1,0));
		fares_county_use2_CountNonBlank																		:= sum(group,if(paddlftax.fares_county_use2<>'',1,0));
		fares_property_indicator_CountNonBlank														:= sum(group,if(paddlftax.fares_property_indicator<>'',1,0));
		fares_view_CountNonBlank																					:= sum(group,if(paddlftax.fares_view<>'',1,0));
		fares_subdiv_tract_num_CountNonBlank															:= sum(group,if(paddlftax.fares_subdiv_tract_num<>'',1,0));
		fares_subdiv_plat_book_CountNonBlank															:= sum(group,if(paddlftax.fares_subdiv_plat_book<>'',1,0));
		fares_subdiv_plat_page_CountNonBlank															:= sum(group,if(paddlftax.fares_subdiv_plat_page<>'',1,0));
		fares_owner_match_code_CountNonBlank															:= sum(group,if(paddlftax.fares_owner_match_code<>'',1,0));
		fares_owner_etal_indicator_CountNonBlank													:= sum(group,if(paddlftax.fares_owner_etal_indicator<>'',1,0));
		fares_owner_phone_opt_out_code_CountNonBlank											:= sum(group,if(paddlftax.fares_owner_phone_opt_out_code<>'',1,0));
		fares_owner_mailing_opt_out_code_CountNonBlank										:= sum(group,if(paddlftax.fares_owner_mailing_opt_out_code<>'',1,0));
    fares_land_use_CountNonBlank                                      := sum(group,if(paddlftax.fares_land_use<>'',1,0));
    fares_seller_name_CountNonBlank                                   := sum(group,if(paddlftax.fares_seller_name<>'',1,0));
    fares_calculated_land_value_ind_CountNonBlank                     := sum(group,if(paddlftax.fares_calculated_land_value_ind<>'',1,0));
		fares_calculated_land_value_CountNonBlank                         := sum(group,if(paddlftax.fares_calculated_land_value<>'',1,0));
    fares_calculated_improvement_value_ind_CountNonBlank              := sum(group,if(paddlftax.fares_calculated_improvement_value_ind<>'',1,0));
		fares_calculated_improvement_value_CountNonBlank                  := sum(group,if(paddlftax.fares_calculated_improvement_value<>'',1,0));
    fares_calculated_total_value_ind_CountNonBlank                    := sum(group,if(paddlftax.fares_calculated_total_value_ind<>'',1,0));
		fares_calculated_total_value_CountNonBlank                        := sum(group,if(paddlftax.fares_calculated_total_value<>'',1,0));
    fares_appr_total_value_CountNonBlank															:= sum(group,if(paddlftax.fares_appr_total_value<>'',1,0));
		fares_appr_land_value_CountNonBlank																:= sum(group,if(paddlftax.fares_appr_land_value<>'',1,0));
		fares_appr_improvement_value_CountNonBlank												:= sum(group,if(paddlftax.fares_appr_improvement_value<>'',1,0));
		fares_sales_deed_cat_type_CountNonBlank														:= sum(group,if(paddlftax.fares_sales_deed_cat_type<>'',1,0));
		fares_sale_transaction_code_CountNonBlank													:= sum(group,if(paddlftax.fares_sale_transaction_code<>'',1,0));
		fares_title_company_name_CountNonBlank														:= sum(group,if(paddlftax.fares_title_company_name<>'',1,0));
		fares_residential_model_ind_CountNonBlank													:= sum(group,if(paddlftax.fares_residential_model_ind<>'',1,0));
		fares_mortgage_date_CountNonBlank																	:= sum(group,if(paddlftax.fares_mortgage_date<>'',1,0));
		fares_mortgage_deed_type_CountNonBlank														:= sum(group,if(paddlftax.fares_mortgage_deed_type<>'',1,0));
		fares_mortgage_term_code_CountNonBlank														:= sum(group,if(paddlftax.fares_mortgage_term_code<>'',1,0));
		fares_mortgage_term_CountNonBlank																	:= sum(group,if(paddlftax.fares_mortgage_term<>'',1,0));
		fares_mortgage_due_date_CountNonBlank															:= sum(group,if(paddlftax.fares_mortgage_due_date<>'',1,0));
		fares_mortgage_assumption_amt_CountNonBlank												:= sum(group,if(paddlftax.fares_mortgage_assumption_amt<>'',1,0));
		fares_lender_code_CountNonBlank																		:= sum(group,if(paddlftax.fares_lender_code<>'',1,0));
		fares_second_mortgage_amt_CountNonBlank														:= sum(group,if(paddlftax.fares_second_mortgage_amt<>'',1,0));
		fares_second_mortgage_loan_type_code_CountNonBlank								:= sum(group,if(paddlftax.fares_second_mortgage_loan_type_code<>'',1,0));
		fares_second_deed_type_CountNonBlank															:= sum(group,if(paddlftax.fares_second_deed_type<>'',1,0));
		fares_prior_document_number_CountNonBlank													:= sum(group,if(paddlftax.fares_prior_document_number<>'',1,0));
		fares_prior_book_page_CountNonBlank																:= sum(group,if(paddlftax.fares_prior_book_page<>'',1,0));
		fares_prior_sales_deed_cat_type_CountNonBlank											:= sum(group,if(paddlftax.fares_prior_sales_deed_cat_type<>'',1,0));
		fares_prior_mortgage_amount_CountNonBlank													:= sum(group,if(paddlftax.fares_prior_mortgage_amount<>'',1,0));
		fares_prior_deed_type_CountNonBlank																:= sum(group,if(paddlftax.fares_prior_deed_type<>'',1,0));
		fares_bldg_code_CountNonBlank																			:= sum(group,if(paddlftax.fares_bldg_code<>'',1,0));
		fares_living_square_feet_CountNonBlank                            := sum(group,if(paddlftax.fares_living_square_feet<>'',1,0));
		fares_gross_square_feet_CountNonBlank                    					:= sum(group,if(paddlftax.fares_gross_square_feet<>'',1,0));
    fares_adjusted_gross_square_feet_CountNonBlank                    := sum(group,if(paddlftax.fares_adjusted_gross_square_feet<>'',1,0));
		fares_ground_floor_square_feet_CountNonBlank                    	:= sum(group,if(paddlftax.fares_ground_floor_square_feet<>'',1,0));
		fares_basement_square_feet_CountNonBlank                    			:= sum(group,if(paddlftax.fares_basement_square_feet<>'',1,0));
		fares_garage_square_feet_CountNonBlank                    				:= sum(group,if(paddlftax.fares_garage_square_feet<>'',1,0));
    fares_total_baths_calculated_CountNonBlank                        := sum(group,if(paddlftax.fares_total_baths_calculated<>'',1,0));
		fares_no_of_full_baths_CountNonBlank                              := sum(group,if(paddlftax.fares_no_of_full_baths<>'',1,0));
    fares_no_of_half_baths_CountNonBlank                              := sum(group,if(paddlftax.fares_no_of_half_baths<>'',1,0));
		fares_no_of_one_qtr_baths_CountNonBlank                           := sum(group,if(paddlftax.fares_no_of_one_qtr_baths<>'',1,0));
		fares_no_of_three_qtr_baths_CountNonBlank                         := sum(group,if(paddlftax.fares_no_of_three_qtr_baths<>'',1,0));
		fares_no_of_bath_fixtures_CountNonBlank                         	:= sum(group,if(paddlftax.fares_no_of_bath_fixtures<>'',1,0));
		fares_fire_place_type_CountNonBlank                         			:= sum(group,if(paddlftax.fares_fire_place_type<>'',1,0));
		fares_mobile_home_indicator_CountNonBlank                         := sum(group,if(paddlftax.fares_mobile_home_indicator<>'',1,0));
    fares_pool_indicator_CountNonBlank                                := sum(group,if(paddlftax.fares_pool_indicator<>'',1,0));
    fares_frame_CountNonBlank                                         := sum(group,if(paddlftax.fares_frame<>'',1,0));
    fares_electric_energy_CountNonBlank                               := sum(group,if(paddlftax.fares_electric_energy<>'',1,0));
		fares_parking_type_CountNonBlank                              		:= sum(group,if(paddlftax.fares_parking_type<>'',1,0));
		fares_stories_code_CountNonBlank                               		:= sum(group,if(paddlftax.fares_stories_code<>'',1,0));
    fares_sewer_CountNonBlank                                         := sum(group,if(paddlftax.fares_sewer<>'',1,0));
    fares_water_CountNonBlank                                         := sum(group,if(paddlftax.fares_water<>'',1,0));
    fares_condition_CountNonBlank                                     := sum(group,if(paddlftax.fares_condition<>'',1,0));    
  end;
	
// addl fares deeds 

%rPopulationStats_paddlfdeed%
 :=
  record
    CountGroup                                             := count(group);
    string3  grouping                                      := 'ALL';
    ln_fares_id_CountNonBlank                              := sum(group,if(paddlfdeed.ln_fares_id<>'',1,0));
    fares_corporate_indicator_CountNonBlank                := sum(group,if(paddlfdeed.fares_corporate_indicator<>'',1,0));
    fares_transaction_type_CountNonBlank                   := sum(group,if(paddlfdeed.fares_transaction_type<>'',1,0));
    fares_lender_address_CountNonBlank                     := sum(group,if(paddlfdeed.fares_lender_address<>'',1,0));
    fares_mortgage_date_CountNonBlank                      := sum(group,if(paddlfdeed.fares_mortgage_date<>'',1,0));
    fares_mortgage_deed_type_CountNonBlank                 := sum(group,if(paddlfdeed.fares_mortgage_deed_type<>'',1,0));
    fares_mortgage_term_code_CountNonBlank                 := sum(group,if(paddlfdeed.fares_mortgage_term_code<>'',1,0));
    fares_mortgage_term_CountNonBlank                      := sum(group,if(paddlfdeed.fares_mortgage_term<>'',1,0));
    fares_building_square_feet_CountNonBlank               := sum(group,if(paddlfdeed.fares_building_square_feet<>'',1,0));
    fares_foreclosure_CountNonBlank                        := sum(group,if(paddlfdeed.fares_foreclosure<>'',1,0));
    fares_refi_flag_CountNonBlank                          := sum(group,if(paddlfdeed.fares_refi_flag<>'',1,0));
    fares_equity_flag_CountNonBlank                        := sum(group,if(paddlfdeed.fares_equity_flag<>'',1,0));
    fares_iris_apn_CountNonBlank                           := sum(group,if(paddlfdeed.fares_iris_apn<>'',1,0));
  end;
	
%rPopulationStats_paddlfdeedPlus%
 :=
  record
    CountGroup                                             := count(group);
    string3  grouping                                      := 'ALL';
    ln_fares_id_CountNonBlank                              := sum(group,if(paddlfdeed.ln_fares_id<>'',1,0));
		fares_owner_etal_indicator_CountNonBlank							 := sum(group,if(paddlfdeed.fares_owner_etal_indicator<>'',1,0));
		fares_owner_relationship_code_CountNonBlank						 := sum(group,if(paddlfdeed.fares_owner_relationship_code<>'',1,0));
		fares_owner_relationship_type_CountNonBlank						 := sum(group,if(paddlfdeed.fares_owner_relationship_type<>'',1,0));
		fares_match_code_CountNonBlank												 := sum(group,if(paddlfdeed.fares_match_code<>'',1,0));
		fares_document_year_CountNonBlank											 := sum(group,if(paddlfdeed.fares_document_year<>'',1,0));
    fares_corporate_indicator_CountNonBlank                := sum(group,if(paddlfdeed.fares_corporate_indicator<>'',1,0));
    fares_transaction_type_CountNonBlank                   := sum(group,if(paddlfdeed.fares_transaction_type<>'',1,0));
    fares_lender_address_CountNonBlank                     := sum(group,if(paddlfdeed.fares_lender_address<>'',1,0));
		fares_sales_transaction_code_CountNonBlank						 := sum(group,if(paddlfdeed.fares_sales_transaction_code<>'',1,0));
		fares_residential_model_ind_CountNonBlank							 := sum(group,if(paddlfdeed.fares_residential_model_ind<>'',1,0));
    fares_mortgage_date_CountNonBlank                      := sum(group,if(paddlfdeed.fares_mortgage_date<>'',1,0));
    fares_mortgage_deed_type_CountNonBlank                 := sum(group,if(paddlfdeed.fares_mortgage_deed_type<>'',1,0));
    fares_mortgage_term_code_CountNonBlank                 := sum(group,if(paddlfdeed.fares_mortgage_term_code<>'',1,0));
    fares_mortgage_term_CountNonBlank                      := sum(group,if(paddlfdeed.fares_mortgage_term<>'',1,0));
		fares_mortgage_assumption_amt_CountNonBlank						 := sum(group,if(paddlfdeed.fares_mortgage_assumption_amt<>'',1,0));
		fares_second_mortgage_loan_type_code_CountNonBlank		 := sum(group,if(paddlfdeed.fares_second_mortgage_loan_type_code<>'',1,0));
		fares_second_deed_type_CountNonBlank									 := sum(group,if(paddlfdeed.fares_second_deed_type<>'',1,0));
		fares_prior_doc_year_CountNonBlank										 := sum(group,if(paddlfdeed.fares_prior_doc_year<>'',1,0));
		fares_prior_doc_number_CountNonBlank									 := sum(group,if(paddlfdeed.fares_prior_doc_number<>'',1,0));
		fares_prior_book_page_CountNonBlank										 := sum(group,if(paddlfdeed.fares_prior_book_page<>'',1,0));
		fares_prior_sales_deed_cat_code_CountNonBlank					 := sum(group,if(paddlfdeed.fares_prior_sales_deed_cat_code<>'',1,0));
		fares_prior_recording_date_CountNonBlank							 := sum(group,if(paddlfdeed.fares_prior_recording_date<>'',1,0));
		fares_prior_sales_date_CountNonBlank									 := sum(group,if(paddlfdeed.fares_prior_sales_date<>'',1,0));
		fares_prior_sales_price_CountNonBlank									 := sum(group,if(paddlfdeed.fares_prior_sales_price<>'',1,0));
		fares_prior_sales_code_CountNonBlank									 := sum(group,if(paddlfdeed.fares_prior_sales_code<>'',1,0));
		fares_prior_sales_transaction_code_CountNonBlank			 := sum(group,if(paddlfdeed.fares_prior_sales_transaction_code<>'',1,0));
		fares_prior_mortgage_amount_CountNonBlank							 := sum(group,if(paddlfdeed.fares_prior_mortgage_amount<>'',1,0));
		fares_prior_deed_type_CountNonBlank										 := sum(group,if(paddlfdeed.fares_prior_deed_type<>'',1,0));
		fares_absentee_indicator_CountNonBlank								 := sum(group,if(paddlfdeed.fares_absentee_indicator<>'',1,0));
		fares_partial_interest_ind_CountNonBlank							 := sum(group,if(paddlfdeed.fares_partial_interest_ind<>'',1,0));
		fares_pri_cat_code_CountNonBlank											 := sum(group,if(paddlfdeed.fares_pri_cat_code<>'',1,0));
		fares_private_party_lender_CountNonBlank							 := sum(group,if(paddlfdeed.fares_private_party_lender<>'',1,0));
		fares_construction_loan_CountNonBlank									 := sum(group,if(paddlfdeed.fares_construction_loan<>'',1,0));
		fares_resale_new_construction_CountNonBlank						 := sum(group,if(paddlfdeed.fares_resale_new_construction<>'',1,0));
		fares_inter_family_CountNonBlank											 := sum(group,if(paddlfdeed.fares_inter_family<>'',1,0));
		fares_cash_mortgage_purchase_CountNonBlank						 := sum(group,if(paddlfdeed.fares_cash_mortgage_purchase<>'',1,0));
    fares_building_square_feet_CountNonBlank               := sum(group,if(paddlfdeed.fares_building_square_feet<>'',1,0));
    fares_foreclosure_CountNonBlank                        := sum(group,if(paddlfdeed.fares_foreclosure<>'',1,0));
    fares_refi_flag_CountNonBlank                          := sum(group,if(paddlfdeed.fares_refi_flag<>'',1,0));
    fares_equity_flag_CountNonBlank                        := sum(group,if(paddlfdeed.fares_equity_flag<>'',1,0));
    fares_iris_apn_CountNonBlank                           := sum(group,if(paddlfdeed.fares_iris_apn<>'',1,0));  
  end;
	
// addl legal 

%rPopulationStats_paddllegal%
 :=
  record
    CountGroup                              := count(group);
    string3  grouping                       := 'ALL';
    ln_fares_id_CountNonBlank               := sum(group,if(paddllegal.ln_fares_id<>'',1,0));
    addl_legal_CountNonBlank                := sum(group,if(paddllegal.addl_legal<>'',1,0));    
  end;

// addl names 

%rPopulationStats_paddlnames%
 :=
  record
    CountGroup                                     := count(group);
    string3  grouping                              := 'ALL';
    ln_fares_id_CountNonBlank                      := sum(group,if(paddlnames.ln_fares_id<>'',1,0));
    apnt_or_pin_number_CountNonBlank               := sum(group,if(paddlnames.apnt_or_pin_number<>'',1,0));
    buyer_or_seller_CountNonBlank                  := sum(group,if(paddlnames.buyer_or_seller<>'',1,0));
    name_seq_CountNonBlank                         := sum(group,if(paddlnames.name_seq<>'',1,0));
    name_CountNonBlank                             := sum(group,if(paddlnames.name<>'',1,0));
    id_code_CountNonBlank                          := sum(group,if(paddlnames.id_code<>'',1,0));
  end;
  
// search file

%rPopulationStats_pParty%
 :=
  record
	CountGroup                                           := count(group);
	pParty.vendor_source_flag;
	dt_first_seen_CountNonZero                           := sum(group,if(pParty.dt_first_seen<>0,1,0));
	dt_last_seen_CountNonZero                            := sum(group,if(pParty.dt_last_seen<>0,1,0));
	dt_vendor_first_reported_CountNonZero                := sum(group,if(pParty.dt_vendor_first_reported<>0,1,0));
	dt_vendor_last_reported_CountNonZero                 := sum(group,if(pParty.dt_vendor_last_reported<>0,1,0));
	vendor_source_flag_CountNonBlank                     := sum(group,if(pParty.vendor_source_flag<>'',1,0));
	ln_fares_id_CountNonBlank                            := sum(group,if(pParty.ln_fares_id<>'',1,0));
	process_date_CountNonBlank                           := sum(group,if(pParty.process_date<>'',1,0));
	source_code_CountNonBlank                            := sum(group,if(pParty.source_code<>'',1,0));
	conjunctive_name_seq_CountNonBlank                   := sum(group,if(pParty.conjunctive_name_seq<>'',1,0));
	title_CountNonBlank                                  := sum(group,if(pParty.title<>'',1,0));
	fname_CountNonBlank                                  := sum(group,if(pParty.fname<>'',1,0));
	mname_CountNonBlank                                  := sum(group,if(pParty.mname<>'',1,0));
	lname_CountNonBlank                                  := sum(group,if(pParty.lname<>'',1,0));
	name_suffix_CountNonBlank                            := sum(group,if(pParty.name_suffix<>'',1,0));
	cname_CountNonBlank                                  := sum(group,if(pParty.cname<>'',1,0));
	nameasis_CountNonBlank                               := sum(group,if(pParty.nameasis<>'',1,0));
	prim_range_CountNonBlank                             := sum(group,if(pParty.prim_range<>'',1,0));
	predir_CountNonBlank                                 := sum(group,if(pParty.predir<>'',1,0));
	prim_name_CountNonBlank                              := sum(group,if(pParty.prim_name<>'',1,0));
	suffix_CountNonBlank                                 := sum(group,if(pParty.suffix<>'',1,0));
	postdir_CountNonBlank                                := sum(group,if(pParty.postdir<>'',1,0));
	unit_desig_CountNonBlank                             := sum(group,if(pParty.unit_desig<>'',1,0));
	sec_range_CountNonBlank                              := sum(group,if(pParty.sec_range<>'',1,0));
	p_city_name_CountNonBlank                            := sum(group,if(pParty.p_city_name<>'',1,0));
	v_city_name_CountNonBlank                            := sum(group,if(pParty.v_city_name<>'',1,0));
	st_CountNonBlank                                     := sum(group,if(pParty.st<>'',1,0));
	zip_CountNonBlank                                    := sum(group,if(pParty.zip<>'',1,0));
	zip4_CountNonBlank                                   := sum(group,if(pParty.zip4<>'',1,0));
	cart_CountNonBlank                                   := sum(group,if(pParty.cart<>'',1,0));
	cr_sort_sz_CountNonBlank                             := sum(group,if(pParty.cr_sort_sz<>'',1,0));
	lot_CountNonBlank                                    := sum(group,if(pParty.lot<>'',1,0));
	lot_order_CountNonBlank                              := sum(group,if(pParty.lot_order<>'',1,0));
	dbpc_CountNonBlank                                   := sum(group,if(pParty.dbpc<>'',1,0));
	chk_digit_CountNonBlank                              := sum(group,if(pParty.chk_digit<>'',1,0));
	rec_type_CountNonBlank                               := sum(group,if(pParty.rec_type<>'',1,0));
	county_CountNonBlank                                 := sum(group,if(pParty.county<>'',1,0));
	geo_lat_CountNonBlank                                := sum(group,if(pParty.geo_lat<>'',1,0));
	geo_long_CountNonBlank                               := sum(group,if(pParty.geo_long<>'',1,0));
	msa_CountNonBlank                                    := sum(group,if(pParty.msa<>'',1,0));
	geo_blk_CountNonBlank                                := sum(group,if(pParty.geo_blk<>'',1,0));
	geo_match_CountNonBlank                              := sum(group,if(pParty.geo_match<>'',1,0));
	err_stat_CountNonBlank                               := sum(group,if(pParty.err_stat<>'',1,0));
	phone_number_CountNonBlank                           := sum(group,if(pParty.phone_number<>'',1,0));
	did_CountNonZero                                     := sum(group,if(pParty.did<>0,1,0));
	bdid_CountNonZero                                    := sum(group,if(pParty.bdid<>0,1,0));
	app_SSN_CountNonBlank                                := sum(group,if(pParty.app_SSN<>'',1,0));
	app_tax_id_CountNonBlank                             := sum(group,if(pParty.app_tax_id<>'',1,0));	
	//BIPV2 fields have been added for Strata
	DotID_CountNonZeros	 																 := sum(group,if(pParty.DotID<>0,1,0));
	DotScore_CountNonZeros	  													 := sum(group,if(pParty.DotScore<>0,1,0));
	DotWeight_CountNonZeros	 														 := sum(group,if(pParty.DotWeight<>0,1,0));
	EmpID_CountNonZeros	   															 := sum(group,if(pParty.EmpID<>0,1,0));
	EmpScore_CountNonZeros	 														 := sum(group,if(pParty.EmpScore<>0,1,0));
	EmpWeight_CountNonZeros	 									           := sum(group,if(pParty.EmpWeight<>0,1,0));
	POWID_CountNonZeros	                                 := sum(group,if(pParty.POWID<>0,1,0));
	POWScore_CountNonZeros	                             := sum(group,if(pParty.POWScore<>0,1,0));
	POWWeight_CountNonZeros	                             := sum(group,if(pParty.POWWeight<>0,1,0));
	ProxID_CountNonZeros	                               := sum(group,if(pParty.ProxID<>0,1,0));
	ProxScore_CountNonZeros	                             := sum(group,if(pParty.ProxScore<>0,1,0));
	ProxWeight_CountNonZeros	                           := sum(group,if(pParty.ProxWeight<>0,1,0));
	SELEID_CountNonZeros	                        			 := sum(group,if(pParty.SELEID<>0,1,0));
	SELEScore_CountNonZeros	                      			 := sum(group,if(pParty.SELEScore<>0,1,0));
	SELEWeight_CountNonZeros	                    			 := sum(group,if(pParty.SELEWeight<>0,1,0));
	OrgID_CountNonZeros	                                 := sum(group,if(pParty.OrgID<>0,1,0));
	OrgScore_CountNonZeros	                             := sum(group,if(pParty.OrgScore<>0,1,0));
	OrgWeight_CountNonZeros	                             := sum(group,if(pParty.OrgWeight<>0,1,0));
	UltID_CountNonZeros	                                 := sum(group,if(pParty.UltID<>0,1,0));
	UltScore_CountNonZeros	                             := sum(group,if(pParty.UltScore<>0,1,0));
	UltWeight_CountNonZeros	                             := sum(group,if(pParty.UltWeight<>0,1,0));
	source_rec_id_CountNonZeros	   											 := sum(group,if(pParty.source_rec_id<>0,1,0));
	
end;


//output Asses stats

	%dPopulationStats_pAsses% := table(pAsses
																		,%rPopulationStats_pAsses%
																		,vendor_source_flag
																		,few);

	STRATA.createXMLStats(%dPopulationStats_pAsses%
	                     ,'LN Property V2'
											 ,'Asses'
											 ,pVersion
											 ,''
											 ,%zAssesStats%
											 ,'view'
											 ,'Population');
											 
	%dPopulationStats_pAssesPlus% := table(pAsses
																				,%rPopulationStats_pAssesPlus%
																				,vendor_source_flag
																				,few);

	STRATA.createXMLStats(%dPopulationStats_pAssesPlus%
	                     ,'LN Property V2'
											 ,'AssesPlus'
											 ,pVersion
											 ,''
											 ,%zAssesPlusStats%
											 ,'view'
											 ,'Population');

//output party stats
	%dPopulationStats_pParty% := table(pParty
	                                  ,%rPopulationStats_pParty%
																		,vendor_source_flag
																		,few);
																		
	STRATA.createXMLStats(%dPopulationStats_pParty%
	                     ,'LN Property V2'
											 ,'search_base'
											 ,pVersion
											 ,''
											 ,%zPartyStats%
											 ,'view'
											 ,'Population');
					 
// output deeds stats 

	%dPopulationStats_Pdeed% := table(Pdeed
	                                  ,%rPopulationStats_Pdeed%
																		,vendor_source_flag
																		,few);
																		
	STRATA.createXMLStats(%dPopulationStats_Pdeed%
	                     ,'LN Property V2 2'
											 ,'deeds'
											 ,pVersion
											 ,''
											 ,%zdeedStats%
											 ,'view'
											 ,'Population');
					 
// output addl fares tax stats 

	%dPopulationStats_paddlftax% := table(paddlftax
																				,%rPopulationStats_paddlftax%
																				,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlftax%
	                     ,'LN Property V2'
											 ,'addl fares tax'
											 ,pVersion
											 ,''
											 ,%zaddlftaxStats%
											 ,'view'
											 ,'Population');
											 
	%dPopulationStats_paddlftaxPlus% := table(paddlftax
																						,%rPopulationStats_paddlftaxPlus%
																						,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlftaxPlus%
	                     ,'LN Property V2'
											 ,'addl fares tax plus'
											 ,pVersion
											 ,''
											 ,%zaddlftaxPlusStats%
											 ,'view'
											 ,'Population');
					 
// 	output addl fares deeds stats 

	%dPopulationStats_paddlfdeed% := table(paddlfdeed
																				,%rPopulationStats_paddlfdeed%
																				,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlfdeed%
	                     ,'LN Property V2'
											 ,'addl fares deeds'
											 ,pVersion
											 ,''
											 ,%zaddlfdeedStats%
											 ,'view'
											 ,'Population');
											 
	%dPopulationStats_paddlfdeedPlus% := table(paddlfdeed
																						,%rPopulationStats_paddlfdeedPlus%
																						,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlfdeedPlus%
	                     ,'LN Property V2'
											 ,'addl fares deeds plus'
											 ,pVersion
											 ,''
											 ,%zaddlfdeedPlusStats%
											 ,'view'
											 ,'Population');

// 	output addl legal stats

 	%dPopulationStats_paddllegal% := table(paddllegal
																				,%rPopulationStats_paddllegal%
																				,few);
									  
	STRATA.createXMLStats(%dPopulationStats_paddllegal%
	                     ,'LN Property V2'
											 ,'addl legal'
											 ,pVersion
											 ,''
											 ,%zaddllegalStats%
											 ,'view'
											 ,'Population');
					 
// 	output addl legal names

 	%dPopulationStats_paddlnames% := table(paddlnames
																				,%rPopulationStats_paddlnames%
																				,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlnames%
	                     ,'LN Property V2'
											 ,'addl names'
											 ,pVersion
											 ,''
											 ,%zaddlnamesStats%
											 ,'view'
											 ,'Population');
					 
				 
zOut := parallel(%zAssesStats%,%zAssesPlusStats%,%zPartyStats%,%zdeedStats%,%zaddlftaxStats%,%zaddlftaxPlusStats%,%zaddlfdeedStats%,%zaddlfdeedPlusStats%,%zaddllegalStats%,%zaddlnamesStats% )

ENDMACRO;