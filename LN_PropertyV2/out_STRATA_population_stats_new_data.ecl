export out_STRATA_population_stats_new_data(pAsses
																						,Pdeed
																						,pVersion
																						,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_pAsses);
	#uniquename(dPopulationStats_pAsses);
	#uniquename(rPopulationStats_pAssesPlus);
	#uniquename(dPopulationStats_pAssesPlus);
	#uniquename(rPopulationStats_Pdeed);
	#uniquename(dPopulationStats_Pdeed);
	
	
	#uniquename(zAssesStats);
	#uniquename(zAssesPlusStats);
	#uniquename(zdeedStats);
	
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

	//output Asses stats

	%dPopulationStats_pAsses% := table(pAsses
	                                  ,%rPopulationStats_pAsses%
																		,vendor_source_flag
																		,few);

	STRATA.createXMLStats(%dPopulationStats_pAsses%
	                     ,'LN Property V2 - New Data'
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
	                     ,'LN Property V2 - New Data'
											 ,'AssesPlus'
											 ,pVersion
											 ,''
											 ,%zAssesPlusStats%
											 ,'view'
											 ,'Population');
					 
	// output deeds stats 

	%dPopulationStats_Pdeed% := table(Pdeed
	                                  ,%rPopulationStats_Pdeed%
																		,vendor_source_flag
																		,few);
										
	STRATA.createXMLStats(%dPopulationStats_Pdeed%
	                     ,'LN Property V2 - New Data'
											 ,'deeds'
											 ,pVersion
											 ,''
											 ,%zdeedStats%
											 ,'view'
											 ,'Population');
											 
zOut := parallel(%zAssesStats%,%zAssesPlusStats%,%zdeedStats%)

ENDMACRO;