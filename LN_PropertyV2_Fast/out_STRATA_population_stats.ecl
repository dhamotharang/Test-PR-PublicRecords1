export out_STRATA_population_stats(pAssess
                                  ,pDeed
																	,pAddlftax
																	,pAddlfdeed
																	,pAddllegal
																	,pAddlnames
                                  ,pParty
																	//,pAddlNameInfo
																	,pVersion
																	,zOut
																	,isFast) := MACRO

import STRATA;
	
	#uniquename(buildPrefix);
	#uniquename(startProcessDate);
	
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
	//#uniquename(rPopulationStats_pAddlNameInfo);
	//#uniquename(dPopulationStats_pAddlNameInfo);
	
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
	#uniquename(zaddlNameInfoStats);

	//DETERMINE FULL OR DELTA FILE
		%buildPrefix% 			:= if(isFast, 'LN Property V2 Delta', 'LN Property V2');
			
	//TAX
		%rPopulationStats_pAsses% := record
				CountGroup                                                    := count(group);
				pAssess.vendor_source_flag;
				ln_fares_id_CountNonBlank                                     := sum(group,if(pAssess.ln_fares_id<>'',1,0));
				process_date_CountNonBlank                                    := sum(group,if(pAssess.process_date<>'',1,0));
				vendor_source_flag_CountNonBlank                              := sum(group,if(pAssess.vendor_source_flag<>'',1,0));
				current_record_CountNonBlank                                  := sum(group,if(pAssess.current_record<>'',1,0));
				fips_code_CountNonBlank                                       := sum(group,if(pAssess.fips_code<>'',1,0));
				state_code_CountNonBlank                                      := sum(group,if(pAssess.state_code<>'',1,0));
				county_name_CountNonBlank                                     := sum(group,if(pAssess.county_name<>'',1,0));
				apna_or_pin_number_CountNonBlank                              := sum(group,if(pAssess.apna_or_pin_number<>'',1,0));
				fares_unformatted_apn_CountNonBlank                           := sum(group,if(pAssess.fares_unformatted_apn<>'',1,0));
				duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(pAssess.duplicate_apn_multiple_address_id<>'',1,0));
				assessee_name_CountNonBlank                                   := sum(group,if(pAssess.assessee_name<>'',1,0));
				second_assessee_name_CountNonBlank                            := sum(group,if(pAssess.second_assessee_name<>'',1,0));
				assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(pAssess.assessee_ownership_rights_code<>'',1,0));
				assessee_relationship_code_CountNonBlank                      := sum(group,if(pAssess.assessee_relationship_code<>'',1,0));
				assessee_phone_number_CountNonBlank                           := sum(group,if(pAssess.assessee_phone_number<>'',1,0));
				tax_account_number_CountNonBlank                              := sum(group,if(pAssess.tax_account_number<>'',1,0));
				contract_owner_CountNonBlank                                  := sum(group,if(pAssess.contract_owner<>'',1,0));
				assessee_name_type_code_CountNonBlank                         := sum(group,if(pAssess.assessee_name_type_code<>'',1,0));
				second_assessee_name_type_code_CountNonBlank                  := sum(group,if(pAssess.second_assessee_name_type_code<>'',1,0));
				mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(pAssess.mail_care_of_name_type_code<>'',1,0));
				mailing_care_of_name_CountNonBlank                            := sum(group,if(pAssess.mailing_care_of_name<>'',1,0));
				mailing_full_street_address_CountNonBlank                     := sum(group,if(pAssess.mailing_full_street_address<>'',1,0));
				mailing_unit_number_CountNonBlank                             := sum(group,if(pAssess.mailing_unit_number<>'',1,0));
				mailing_city_state_zip_CountNonBlank                          := sum(group,if(pAssess.mailing_city_state_zip<>'',1,0));
				property_full_street_address_CountNonBlank                    := sum(group,if(pAssess.property_full_street_address<>'',1,0));
				property_unit_number_CountNonBlank                            := sum(group,if(pAssess.property_unit_number<>'',1,0));
				property_city_state_zip_CountNonBlank                         := sum(group,if(pAssess.property_city_state_zip<>'',1,0));
				property_country_code_CountNonBlank                           := sum(group,if(pAssess.property_country_code<>'',1,0));
				property_address_code_CountNonBlank                           := sum(group,if(pAssess.property_address_code<>'',1,0));
				legal_lot_code_CountNonBlank                                  := sum(group,if(pAssess.legal_lot_code<>'',1,0));
				legal_lot_number_CountNonBlank                                := sum(group,if(pAssess.legal_lot_number<>'',1,0));
				legal_land_lot_CountNonBlank                                  := sum(group,if(pAssess.legal_land_lot<>'',1,0));
				legal_block_CountNonBlank                                     := sum(group,if(pAssess.legal_block<>'',1,0));
				legal_section_CountNonBlank                                   := sum(group,if(pAssess.legal_section<>'',1,0));
				legal_district_CountNonBlank                                  := sum(group,if(pAssess.legal_district<>'',1,0));
				legal_unit_CountNonBlank                                      := sum(group,if(pAssess.legal_unit<>'',1,0));
				legal_city_municipality_township_CountNonBlank                := sum(group,if(pAssess.legal_city_municipality_township<>'',1,0));
				legal_subdivision_name_CountNonBlank                          := sum(group,if(pAssess.legal_subdivision_name<>'',1,0));
				legal_phase_number_CountNonBlank                              := sum(group,if(pAssess.legal_phase_number<>'',1,0));
				legal_tract_number_CountNonBlank                              := sum(group,if(pAssess.legal_tract_number<>'',1,0));
				legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(pAssess.legal_sec_twn_rng_mer<>'',1,0));
				legal_brief_description_CountNonBlank                         := sum(group,if(pAssess.legal_brief_description<>'',1,0));
				legal_assessor_map_ref_CountNonBlank                          := sum(group,if(pAssess.legal_assessor_map_ref<>'',1,0));
				census_tract_CountNonBlank                                    := sum(group,if(pAssess.census_tract<>'',1,0));
				record_type_code_CountNonBlank                                := sum(group,if(pAssess.record_type_code<>'',1,0));
				ownership_type_code_CountNonBlank                             := sum(group,if(pAssess.ownership_type_code<>'',1,0));
				new_record_type_code_CountNonBlank                            := sum(group,if(pAssess.new_record_type_code<>'',1,0));
				county_land_use_code_CountNonBlank                            := sum(group,if(pAssess.county_land_use_code<>'',1,0));
				county_land_use_description_CountNonBlank                     := sum(group,if(pAssess.county_land_use_description<>'',1,0));
				standardized_land_use_code_CountNonBlank                      := sum(group,if(pAssess.standardized_land_use_code<>'',1,0));
				timeshare_code_CountNonBlank                                  := sum(group,if(pAssess.timeshare_code<>'',1,0));
				zoning_CountNonBlank                                          := sum(group,if(pAssess.zoning<>'',1,0));
				owner_occupied_CountNonBlank                                  := sum(group,if(pAssess.owner_occupied<>'',1,0));
				recorder_document_number_CountNonBlank                        := sum(group,if(pAssess.recorder_document_number<>'',1,0));
				recorder_book_number_CountNonBlank                            := sum(group,if(pAssess.recorder_book_number<>'',1,0));
				recorder_page_number_CountNonBlank                            := sum(group,if(pAssess.recorder_page_number<>'',1,0));
				transfer_date_CountNonBlank                                   := sum(group,if(pAssess.transfer_date<>'',1,0));
				recording_date_CountNonBlank                                  := sum(group,if(pAssess.recording_date<>'',1,0));
				sale_date_CountNonBlank                                       := sum(group,if(pAssess.sale_date<>'',1,0));
				document_type_CountNonBlank                                   := sum(group,if(pAssess.document_type<>'',1,0));
				sales_price_CountNonBlank                                     := sum(group,if(pAssess.sales_price<>'',1,0));
				sales_price_code_CountNonBlank                                := sum(group,if(pAssess.sales_price_code<>'',1,0));
				mortgage_loan_amount_CountNonBlank                            := sum(group,if(pAssess.mortgage_loan_amount<>'',1,0));
				mortgage_loan_type_code_CountNonBlank                         := sum(group,if(pAssess.mortgage_loan_type_code<>'',1,0));
				mortgage_lender_name_CountNonBlank                            := sum(group,if(pAssess.mortgage_lender_name<>'',1,0));
				mortgage_lender_type_code_CountNonBlank                       := sum(group,if(pAssess.mortgage_lender_type_code<>'',1,0));
				prior_transfer_date_CountNonBlank                             := sum(group,if(pAssess.prior_transfer_date<>'',1,0));
				prior_recording_date_CountNonBlank                            := sum(group,if(pAssess.prior_recording_date<>'',1,0));
				prior_sales_price_CountNonBlank                               := sum(group,if(pAssess.prior_sales_price<>'',1,0));
				prior_sales_price_code_CountNonBlank                          := sum(group,if(pAssess.prior_sales_price_code<>'',1,0));
				assessed_land_value_CountNonBlank                             := sum(group,if(pAssess.assessed_land_value<>'',1,0));
				assessed_improvement_value_CountNonBlank                      := sum(group,if(pAssess.assessed_improvement_value<>'',1,0));
				assessed_total_value_CountNonBlank                            := sum(group,if(pAssess.assessed_total_value<>'',1,0));
				assessed_value_year_CountNonBlank                             := sum(group,if(pAssess.assessed_value_year<>'',1,0));
				market_land_value_CountNonBlank                               := sum(group,if(pAssess.market_land_value<>'',1,0));
				market_improvement_value_CountNonBlank                        := sum(group,if(pAssess.market_improvement_value<>'',1,0));
				market_total_value_CountNonBlank                              := sum(group,if(pAssess.market_total_value<>'',1,0));
				market_value_year_CountNonBlank                               := sum(group,if(pAssess.market_value_year<>'',1,0));
				homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(pAssess.homestead_homeowner_exemption<>'',1,0));
				tax_exemption1_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption1_code<>'',1,0));
				tax_exemption2_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption2_code<>'',1,0));
				tax_exemption3_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption3_code<>'',1,0));
				tax_exemption4_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption4_code<>'',1,0));
				tax_rate_code_area_CountNonBlank                              := sum(group,if(pAssess.tax_rate_code_area<>'',1,0));
				tax_amount_CountNonBlank                                      := sum(group,if(pAssess.tax_amount<>'',1,0));
				tax_year_CountNonBlank                                        := sum(group,if(pAssess.tax_year<>'',1,0));
				tax_delinquent_year_CountNonBlank                             := sum(group,if(pAssess.tax_delinquent_year<>'',1,0));
				school_tax_district1_CountNonBlank                            := sum(group,if(pAssess.school_tax_district1<>'',1,0));
				school_tax_district1_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district1_indicator<>'',1,0));
				school_tax_district2_CountNonBlank                            := sum(group,if(pAssess.school_tax_district2<>'',1,0));
				school_tax_district2_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district2_indicator<>'',1,0));
				school_tax_district3_CountNonBlank                            := sum(group,if(pAssess.school_tax_district3<>'',1,0));
				school_tax_district3_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district3_indicator<>'',1,0));
				land_acres_CountNonBlank                                      := sum(group,if(pAssess.land_acres<>'',1,0));
				land_square_footage_CountNonBlank                             := sum(group,if(pAssess.land_square_footage<>'',1,0));
				land_dimensions_CountNonBlank                                 := sum(group,if(pAssess.land_dimensions<>'',1,0));
				building_area_CountNonBlank                                   := sum(group,if(pAssess.building_area<>'',1,0));
				building_area_indicator_CountNonBlank                         := sum(group,if(pAssess.building_area_indicator<>'',1,0));
				building_area1_CountNonBlank                                  := sum(group,if(pAssess.building_area1<>'',1,0));
				building_area1_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area1_indicator<>'',1,0));
				building_area2_CountNonBlank                                  := sum(group,if(pAssess.building_area2<>'',1,0));
				building_area2_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area2_indicator<>'',1,0));
				building_area3_CountNonBlank                                  := sum(group,if(pAssess.building_area3<>'',1,0));
				building_area3_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area3_indicator<>'',1,0));
				building_area4_CountNonBlank                                  := sum(group,if(pAssess.building_area4<>'',1,0));
				building_area4_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area4_indicator<>'',1,0));
				building_area5_CountNonBlank                                  := sum(group,if(pAssess.building_area5<>'',1,0));
				building_area5_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area5_indicator<>'',1,0));
				building_area6_CountNonBlank                                  := sum(group,if(pAssess.building_area6<>'',1,0));
				building_area6_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area6_indicator<>'',1,0));
				building_area7_CountNonBlank                                  := sum(group,if(pAssess.building_area7<>'',1,0));
				building_area7_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area7_indicator<>'',1,0));
				year_built_CountNonBlank                                      := sum(group,if(pAssess.year_built<>'',1,0));
				effective_year_built_CountNonBlank                            := sum(group,if(pAssess.effective_year_built<>'',1,0));
				no_of_buildings_CountNonBlank                                 := sum(group,if(pAssess.no_of_buildings<>'',1,0));
				no_of_stories_CountNonBlank                                   := sum(group,if(pAssess.no_of_stories<>'',1,0));
				no_of_units_CountNonBlank                                     := sum(group,if(pAssess.no_of_units<>'',1,0));
				no_of_rooms_CountNonBlank                                     := sum(group,if(pAssess.no_of_rooms<>'',1,0));
				no_of_bedrooms_CountNonBlank                                  := sum(group,if(pAssess.no_of_bedrooms<>'',1,0));
				no_of_baths_CountNonBlank                                     := sum(group,if(pAssess.no_of_baths<>'',1,0));
				no_of_partial_baths_CountNonBlank                             := sum(group,if(pAssess.no_of_partial_baths<>'',1,0));
				garage_type_code_CountNonBlank                                := sum(group,if(pAssess.garage_type_code<>'',1,0));
				parking_no_of_cars_CountNonBlank                              := sum(group,if(pAssess.parking_no_of_cars<>'',1,0));
				pool_code_CountNonBlank                                       := sum(group,if(pAssess.pool_code<>'',1,0));
				style_code_CountNonBlank                                      := sum(group,if(pAssess.style_code<>'',1,0));
				type_construction_code_CountNonBlank                          := sum(group,if(pAssess.type_construction_code<>'',1,0));
				exterior_walls_code_CountNonBlank                             := sum(group,if(pAssess.exterior_walls_code<>'',1,0));
				foundation_code_CountNonBlank                                 := sum(group,if(pAssess.foundation_code<>'',1,0));
				roof_cover_code_CountNonBlank                                 := sum(group,if(pAssess.roof_cover_code<>'',1,0));
				roof_type_code_CountNonBlank                                  := sum(group,if(pAssess.roof_type_code<>'',1,0));
				heating_code_CountNonBlank                                    := sum(group,if(pAssess.heating_code<>'',1,0));
				heating_fuel_type_code_CountNonBlank                          := sum(group,if(pAssess.heating_fuel_type_code<>'',1,0));
				air_conditioning_code_CountNonBlank                           := sum(group,if(pAssess.air_conditioning_code<>'',1,0));
				air_conditioning_type_code_CountNonBlank                      := sum(group,if(pAssess.air_conditioning_type_code<>'',1,0));
				elevator_CountNonBlank                                        := sum(group,if(pAssess.elevator<>'',1,0));
				fireplace_indicator_CountNonBlank                             := sum(group,if(pAssess.fireplace_indicator<>'',1,0));
				fireplace_number_CountNonBlank                                := sum(group,if(pAssess.fireplace_number<>'',1,0));
				basement_code_CountNonBlank                                   := sum(group,if(pAssess.basement_code<>'',1,0));
				building_class_code_CountNonBlank                             := sum(group,if(pAssess.building_class_code<>'',1,0));
				site_influence1_code_CountNonBlank                            := sum(group,if(pAssess.site_influence1_code<>'',1,0));
				site_influence2_code_CountNonBlank                            := sum(group,if(pAssess.site_influence2_code<>'',1,0));
				site_influence3_code_CountNonBlank                            := sum(group,if(pAssess.site_influence3_code<>'',1,0));
				site_influence4_code_CountNonBlank                            := sum(group,if(pAssess.site_influence4_code<>'',1,0));
				site_influence5_code_CountNonBlank                            := sum(group,if(pAssess.site_influence5_code<>'',1,0));
				amenities1_code_CountNonBlank                                 := sum(group,if(pAssess.amenities1_code<>'',1,0));
				amenities2_code_CountNonBlank                                 := sum(group,if(pAssess.amenities2_code<>'',1,0));
				amenities3_code_CountNonBlank                                 := sum(group,if(pAssess.amenities3_code<>'',1,0));
				amenities4_code_CountNonBlank                                 := sum(group,if(pAssess.amenities4_code<>'',1,0));
				amenities5_code_CountNonBlank                                 := sum(group,if(pAssess.amenities5_code<>'',1,0));
				other_buildings1_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings1_code<>'',1,0));
				other_buildings2_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings2_code<>'',1,0));
				other_buildings3_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings3_code<>'',1,0));
				other_buildings4_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings4_code<>'',1,0));
				other_buildings5_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings5_code<>'',1,0));
				neighborhood_code_CountNonBlank                               := sum(group,if(pAssess.neighborhood_code<>'',1,0));
				condo_project_name_CountNonBlank                              := sum(group,if(pAssess.condo_project_or_building_name<>'',1,0));
				building_name_CountNonBlank                                   := sum(group,if(pAssess.condo_project_or_building_name<>'',1,0));
				assessee_name_indicator_CountNonBlank                         := sum(group,if(pAssess.assessee_name_indicator<>'',1,0));
				second_assessee_name_indicator_CountNonBlank                  := sum(group,if(pAssess.second_assessee_name_indicator<>'',1,0));
				mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(pAssess.mail_care_of_name_indicator<>'',1,0));
				comments_CountNonBlank                                        := sum(group,if(pAssess.comments<>'',1,0));
				tape_cut_date_CountNonBlank                                   := sum(group,if(pAssess.tape_cut_date<>'',1,0));
				certification_date_CountNonBlank                              := sum(group,if(pAssess.certification_date<>'',1,0));
				edition_number_CountNonBlank                                  := sum(group,if(pAssess.edition_number<>'',1,0));
				prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(pAssess.prop_addr_propagated_ind<>'',1,0));
				ln_ownership_rights_CountNonBlank 														:= sum(group,if(pAssess.ln_ownership_rights<>'',1,0));
				ln_relationship_type_CountNonBlank 														:= sum(group,if(pAssess.ln_relationship_type<>'',1,0));
				ln_mailing_country_code_CountNonBlank 												:= sum(group,if(pAssess.ln_mailing_country_code<>'',1,0));
				ln_property_name_CountNonBlank 																:= sum(group,if(pAssess.ln_property_name<>'',1,0));
				ln_property_name_type_CountNonBlank 													:= sum(group,if(pAssess.ln_property_name_type<>'',1,0));
				ln_land_use_category_CountNonBlank 														:= sum(group,if(pAssess.ln_land_use_category<>'',1,0));
				ln_lot_CountNonBlank 																					:= sum(group,if(pAssess.ln_lot<>'',1,0));
				ln_block_CountNonBlank 																				:= sum(group,if(pAssess.ln_block<>'',1,0));
				ln_unit_CountNonBlank 																				:= sum(group,if(pAssess.ln_unit<>'',1,0));
				ln_subfloor_CountNonBlank 																		:= sum(group,if(pAssess.ln_subfloor<>'',1,0));
				ln_floor_cover_CountNonBlank 																	:= sum(group,if(pAssess.ln_floor_cover<>'',1,0));
				ln_mobile_home_indicator_CountNonBlank 												:= sum(group,if(pAssess.ln_mobile_home_indicator<>'',1,0));
				ln_condo_indicator_CountNonBlank 															:= sum(group,if(pAssess.ln_condo_indicator<>'',1,0));
				ln_property_tax_exemption_CountNonBlank 											:= sum(group,if(pAssess.ln_property_tax_exemption<>'',1,0));
				ln_veteran_status_CountNonBlank 															:= sum(group,if(pAssess.ln_veteran_status<>'',1,0));
				ln_old_apn_indicator_CountNonBlank 														:= sum(group,if(pAssess.ln_old_apn_indicator<>'',1,0));
		end;

		%rPopulationStats_pAssesPlus% := record
				CountGroup                                                    := count(group);
				pAssess.vendor_source_flag;
				ln_fares_id_CountNonBlank                                     := sum(group,if(pAssess.ln_fares_id<>'',1,0));
				process_date_CountNonBlank                                    := sum(group,if(pAssess.process_date<>'',1,0));
				vendor_source_flag_CountNonBlank                              := sum(group,if(pAssess.vendor_source_flag<>'',1,0));
				current_record_CountNonBlank                                  := sum(group,if(pAssess.current_record<>'',1,0));
				fips_code_CountNonBlank                                       := sum(group,if(pAssess.fips_code<>'',1,0));
				state_code_CountNonBlank                                      := sum(group,if(pAssess.state_code<>'',1,0));
				county_name_CountNonBlank                                     := sum(group,if(pAssess.county_name<>'',1,0));
				apna_or_pin_number_CountNonBlank                              := sum(group,if(pAssess.apna_or_pin_number<>'',1,0));
				fares_unformatted_apn_CountNonBlank                           := sum(group,if(pAssess.fares_unformatted_apn<>'',1,0));
				duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(pAssess.duplicate_apn_multiple_address_id<>'',1,0));
				assessee_name_CountNonBlank                                   := sum(group,if(pAssess.assessee_name<>'',1,0));
				second_assessee_name_CountNonBlank                            := sum(group,if(pAssess.second_assessee_name<>'',1,0));
				assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(pAssess.assessee_ownership_rights_code<>'',1,0));
				assessee_relationship_code_CountNonBlank                      := sum(group,if(pAssess.assessee_relationship_code<>'',1,0));
				assessee_phone_number_CountNonBlank                           := sum(group,if(pAssess.assessee_phone_number<>'',1,0));
				tax_account_number_CountNonBlank                              := sum(group,if(pAssess.tax_account_number<>'',1,0));
				contract_owner_CountNonBlank                                  := sum(group,if(pAssess.contract_owner<>'',1,0));
				assessee_name_type_code_CountNonBlank                         := sum(group,if(pAssess.assessee_name_type_code<>'',1,0));
				second_assessee_name_type_code_CountNonBlank                  := sum(group,if(pAssess.second_assessee_name_type_code<>'',1,0));
				mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(pAssess.mail_care_of_name_type_code<>'',1,0));
				mailing_care_of_name_CountNonBlank                            := sum(group,if(pAssess.mailing_care_of_name<>'',1,0));
				mailing_full_street_address_CountNonBlank                     := sum(group,if(pAssess.mailing_full_street_address<>'',1,0));
				mailing_unit_number_CountNonBlank                             := sum(group,if(pAssess.mailing_unit_number<>'',1,0));
				mailing_city_state_zip_CountNonBlank                          := sum(group,if(pAssess.mailing_city_state_zip<>'',1,0));
				property_full_street_address_CountNonBlank                    := sum(group,if(pAssess.property_full_street_address<>'',1,0));
				property_unit_number_CountNonBlank                            := sum(group,if(pAssess.property_unit_number<>'',1,0));
				property_city_state_zip_CountNonBlank                         := sum(group,if(pAssess.property_city_state_zip<>'',1,0));
				property_country_code_CountNonBlank                           := sum(group,if(pAssess.property_country_code<>'',1,0));
				property_address_code_CountNonBlank                           := sum(group,if(pAssess.property_address_code<>'',1,0));
				legal_lot_code_CountNonBlank                                  := sum(group,if(pAssess.legal_lot_code<>'',1,0));
				legal_lot_number_CountNonBlank                                := sum(group,if(pAssess.legal_lot_number<>'',1,0));
				legal_land_lot_CountNonBlank                                  := sum(group,if(pAssess.legal_land_lot<>'',1,0));
				legal_block_CountNonBlank                                     := sum(group,if(pAssess.legal_block<>'',1,0));
				legal_section_CountNonBlank                                   := sum(group,if(pAssess.legal_section<>'',1,0));
				legal_district_CountNonBlank                                  := sum(group,if(pAssess.legal_district<>'',1,0));
				legal_unit_CountNonBlank                                      := sum(group,if(pAssess.legal_unit<>'',1,0));
				legal_city_municipality_township_CountNonBlank                := sum(group,if(pAssess.legal_city_municipality_township<>'',1,0));
				legal_subdivision_name_CountNonBlank                          := sum(group,if(pAssess.legal_subdivision_name<>'',1,0));
				legal_phase_number_CountNonBlank                              := sum(group,if(pAssess.legal_phase_number<>'',1,0));
				legal_tract_number_CountNonBlank                              := sum(group,if(pAssess.legal_tract_number<>'',1,0));
				legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(pAssess.legal_sec_twn_rng_mer<>'',1,0));
				legal_brief_description_CountNonBlank                         := sum(group,if(pAssess.legal_brief_description<>'',1,0));
				legal_assessor_map_ref_CountNonBlank                          := sum(group,if(pAssess.legal_assessor_map_ref<>'',1,0));
				census_tract_CountNonBlank                                    := sum(group,if(pAssess.census_tract<>'',1,0));
				record_type_code_CountNonBlank                                := sum(group,if(pAssess.record_type_code<>'',1,0));
				ownership_type_code_CountNonBlank                             := sum(group,if(pAssess.ownership_type_code<>'',1,0));
				new_record_type_code_CountNonBlank                            := sum(group,if(pAssess.new_record_type_code<>'',1,0));
				county_land_use_code_CountNonBlank                            := sum(group,if(pAssess.county_land_use_code<>'',1,0));
				county_land_use_description_CountNonBlank                     := sum(group,if(pAssess.county_land_use_description<>'',1,0));
				standardized_land_use_code_CountNonBlank                      := sum(group,if(pAssess.standardized_land_use_code<>'',1,0));
				timeshare_code_CountNonBlank                                  := sum(group,if(pAssess.timeshare_code<>'',1,0));
				zoning_CountNonBlank                                          := sum(group,if(pAssess.zoning<>'',1,0));
				owner_occupied_CountNonBlank                                  := sum(group,if(pAssess.owner_occupied<>'',1,0));
				recorder_document_number_CountNonBlank                        := sum(group,if(pAssess.recorder_document_number<>'',1,0));
				recorder_book_number_CountNonBlank                            := sum(group,if(pAssess.recorder_book_number<>'',1,0));
				recorder_page_number_CountNonBlank                            := sum(group,if(pAssess.recorder_page_number<>'',1,0));
				transfer_date_CountNonBlank                                   := sum(group,if(pAssess.transfer_date<>'',1,0));
				recording_date_CountNonBlank                                  := sum(group,if(pAssess.recording_date<>'',1,0));
				sale_date_CountNonBlank                                       := sum(group,if(pAssess.sale_date<>'',1,0));
				document_type_CountNonBlank                                   := sum(group,if(pAssess.document_type<>'',1,0));
				sales_price_CountNonBlank                                     := sum(group,if(pAssess.sales_price<>'',1,0));
				sales_price_code_CountNonBlank                                := sum(group,if(pAssess.sales_price_code<>'',1,0));
				mortgage_loan_amount_CountNonBlank                            := sum(group,if(pAssess.mortgage_loan_amount<>'',1,0));
				mortgage_loan_type_code_CountNonBlank                         := sum(group,if(pAssess.mortgage_loan_type_code<>'',1,0));
				mortgage_lender_name_CountNonBlank                            := sum(group,if(pAssess.mortgage_lender_name<>'',1,0));
				mortgage_lender_type_code_CountNonBlank                       := sum(group,if(pAssess.mortgage_lender_type_code<>'',1,0));
				prior_transfer_date_CountNonBlank                             := sum(group,if(pAssess.prior_transfer_date<>'',1,0));
				prior_recording_date_CountNonBlank                            := sum(group,if(pAssess.prior_recording_date<>'',1,0));
				prior_sales_price_CountNonBlank                               := sum(group,if(pAssess.prior_sales_price<>'',1,0));
				prior_sales_price_code_CountNonBlank                          := sum(group,if(pAssess.prior_sales_price_code<>'',1,0));
				assessed_land_value_CountNonBlank                             := sum(group,if(pAssess.assessed_land_value<>'',1,0));
				assessed_improvement_value_CountNonBlank                      := sum(group,if(pAssess.assessed_improvement_value<>'',1,0));
				assessed_total_value_CountNonBlank                            := sum(group,if(pAssess.assessed_total_value<>'',1,0));
				assessed_value_year_CountNonBlank                             := sum(group,if(pAssess.assessed_value_year<>'',1,0));
				market_land_value_CountNonBlank                               := sum(group,if(pAssess.market_land_value<>'',1,0));
				market_improvement_value_CountNonBlank                        := sum(group,if(pAssess.market_improvement_value<>'',1,0));
				market_total_value_CountNonBlank                              := sum(group,if(pAssess.market_total_value<>'',1,0));
				market_value_year_CountNonBlank                               := sum(group,if(pAssess.market_value_year<>'',1,0));
				homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(pAssess.homestead_homeowner_exemption<>'',1,0));
				tax_exemption1_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption1_code<>'',1,0));
				tax_exemption2_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption2_code<>'',1,0));
				tax_exemption3_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption3_code<>'',1,0));
				tax_exemption4_code_CountNonBlank                             := sum(group,if(pAssess.tax_exemption4_code<>'',1,0));
				tax_rate_code_area_CountNonBlank                              := sum(group,if(pAssess.tax_rate_code_area<>'',1,0));
				tax_amount_CountNonBlank                                      := sum(group,if(pAssess.tax_amount<>'',1,0));
				tax_year_CountNonBlank                                        := sum(group,if(pAssess.tax_year<>'',1,0));
				tax_delinquent_year_CountNonBlank                             := sum(group,if(pAssess.tax_delinquent_year<>'',1,0));
				school_tax_district1_CountNonBlank                            := sum(group,if(pAssess.school_tax_district1<>'',1,0));
				school_tax_district1_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district1_indicator<>'',1,0));
				school_tax_district2_CountNonBlank                            := sum(group,if(pAssess.school_tax_district2<>'',1,0));
				school_tax_district2_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district2_indicator<>'',1,0));
				school_tax_district3_CountNonBlank                            := sum(group,if(pAssess.school_tax_district3<>'',1,0));
				school_tax_district3_indicator_CountNonBlank                  := sum(group,if(pAssess.school_tax_district3_indicator<>'',1,0));
				lot_size_CountNonBlank																				:= sum(group,if(pAssess.lot_size<>'',1,0));
				lot_size_acres_CountNonBlank																	:= sum(group,if(pAssess.lot_size_acres<>'',1,0));
				lot_size_frontage_feet_CountNonBlank													:= sum(group,if(pAssess.lot_size_frontage_feet<>'',1,0));
				lot_size_depth_feet_CountNonBlank															:= sum(group,if(pAssess.lot_size_depth_feet<>'',1,0));
				land_acres_CountNonBlank                                      := sum(group,if(pAssess.land_acres<>'',1,0));
				land_square_footage_CountNonBlank                             := sum(group,if(pAssess.land_square_footage<>'',1,0));
				land_dimensions_CountNonBlank                                 := sum(group,if(pAssess.land_dimensions<>'',1,0));
				building_area_CountNonBlank                                   := sum(group,if(pAssess.building_area<>'',1,0));
				building_area_indicator_CountNonBlank                         := sum(group,if(pAssess.building_area_indicator<>'',1,0));
				building_area1_CountNonBlank                                  := sum(group,if(pAssess.building_area1<>'',1,0));
				building_area1_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area1_indicator<>'',1,0));
				building_area2_CountNonBlank                                  := sum(group,if(pAssess.building_area2<>'',1,0));
				building_area2_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area2_indicator<>'',1,0));
				building_area3_CountNonBlank                                  := sum(group,if(pAssess.building_area3<>'',1,0));
				building_area3_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area3_indicator<>'',1,0));
				building_area4_CountNonBlank                                  := sum(group,if(pAssess.building_area4<>'',1,0));
				building_area4_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area4_indicator<>'',1,0));
				building_area5_CountNonBlank                                  := sum(group,if(pAssess.building_area5<>'',1,0));
				building_area5_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area5_indicator<>'',1,0));
				building_area6_CountNonBlank                                  := sum(group,if(pAssess.building_area6<>'',1,0));
				building_area6_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area6_indicator<>'',1,0));
				building_area7_CountNonBlank                                  := sum(group,if(pAssess.building_area7<>'',1,0));
				building_area7_indicator_CountNonBlank                        := sum(group,if(pAssess.building_area7_indicator<>'',1,0));
				year_built_CountNonBlank                                      := sum(group,if(pAssess.year_built<>'',1,0));
				effective_year_built_CountNonBlank                            := sum(group,if(pAssess.effective_year_built<>'',1,0));
				no_of_buildings_CountNonBlank                                 := sum(group,if(pAssess.no_of_buildings<>'',1,0));
				no_of_stories_CountNonBlank                                   := sum(group,if(pAssess.no_of_stories<>'',1,0));
				no_of_units_CountNonBlank                                     := sum(group,if(pAssess.no_of_units<>'',1,0));
				no_of_rooms_CountNonBlank                                     := sum(group,if(pAssess.no_of_rooms<>'',1,0));
				no_of_bedrooms_CountNonBlank                                  := sum(group,if(pAssess.no_of_bedrooms<>'',1,0));
				no_of_baths_CountNonBlank                                     := sum(group,if(pAssess.no_of_baths<>'',1,0));
				no_of_partial_baths_CountNonBlank                             := sum(group,if(pAssess.no_of_partial_baths<>'',1,0));
				no_of_plumbing_fixtures_CountNonBlank                         := sum(group,if(pAssess.no_of_plumbing_fixtures<>'',1,0));
				garage_type_code_CountNonBlank                                := sum(group,if(pAssess.garage_type_code<>'',1,0));
				parking_no_of_cars_CountNonBlank                              := sum(group,if(pAssess.parking_no_of_cars<>'',1,0));
				pool_code_CountNonBlank                                       := sum(group,if(pAssess.pool_code<>'',1,0));
				style_code_CountNonBlank                                      := sum(group,if(pAssess.style_code<>'',1,0));
				type_construction_code_CountNonBlank                          := sum(group,if(pAssess.type_construction_code<>'',1,0));
				exterior_walls_code_CountNonBlank                             := sum(group,if(pAssess.exterior_walls_code<>'',1,0));
				foundation_code_CountNonBlank                                 := sum(group,if(pAssess.foundation_code<>'',1,0));
				building_quality_code_CountNonBlank                           := sum(group,if(pAssess.building_quality_code<>'',1,0));
				building_condition_code_CountNonBlank                         := sum(group,if(pAssess.building_condition_code<>'',1,0));
				interior_walls_code_CountNonBlank                             := sum(group,if(pAssess.interior_walls_code<>'',1,0));
				roof_cover_code_CountNonBlank                                 := sum(group,if(pAssess.roof_cover_code<>'',1,0));
				roof_type_code_CountNonBlank                                  := sum(group,if(pAssess.roof_type_code<>'',1,0));
				floor_cover_code_CountNonBlank                                := sum(group,if(pAssess.floor_cover_code<>'',1,0));
				water_code_CountNonBlank                                			:= sum(group,if(pAssess.water_code<>'',1,0));
				sewer_code_CountNonBlank                                			:= sum(group,if(pAssess.sewer_code<>'',1,0));
				heating_code_CountNonBlank                                    := sum(group,if(pAssess.heating_code<>'',1,0));
				heating_fuel_type_code_CountNonBlank                          := sum(group,if(pAssess.heating_fuel_type_code<>'',1,0));
				air_conditioning_code_CountNonBlank                           := sum(group,if(pAssess.air_conditioning_code<>'',1,0));
				air_conditioning_type_code_CountNonBlank                      := sum(group,if(pAssess.air_conditioning_type_code<>'',1,0));
				elevator_CountNonBlank                                        := sum(group,if(pAssess.elevator<>'',1,0));
				fireplace_indicator_CountNonBlank                             := sum(group,if(pAssess.fireplace_indicator<>'',1,0));
				fireplace_number_CountNonBlank                                := sum(group,if(pAssess.fireplace_number<>'',1,0));
				basement_code_CountNonBlank                                   := sum(group,if(pAssess.basement_code<>'',1,0));
				building_class_code_CountNonBlank                             := sum(group,if(pAssess.building_class_code<>'',1,0));
				site_influence1_code_CountNonBlank                            := sum(group,if(pAssess.site_influence1_code<>'',1,0));
				site_influence2_code_CountNonBlank                            := sum(group,if(pAssess.site_influence2_code<>'',1,0));
				site_influence3_code_CountNonBlank                            := sum(group,if(pAssess.site_influence3_code<>'',1,0));
				site_influence4_code_CountNonBlank                            := sum(group,if(pAssess.site_influence4_code<>'',1,0));
				site_influence5_code_CountNonBlank                            := sum(group,if(pAssess.site_influence5_code<>'',1,0));
				amenities1_code_CountNonBlank                                 := sum(group,if(pAssess.amenities1_code<>'',1,0));
				amenities2_code_CountNonBlank                                 := sum(group,if(pAssess.amenities2_code<>'',1,0));
				amenities3_code_CountNonBlank                                 := sum(group,if(pAssess.amenities3_code<>'',1,0));
				amenities4_code_CountNonBlank                                 := sum(group,if(pAssess.amenities4_code<>'',1,0));
				amenities5_code_CountNonBlank                                 := sum(group,if(pAssess.amenities5_code<>'',1,0));
				amenities2_code1_CountNonBlank                                := sum(group,if(pAssess.amenities2_code1<>'',1,0));
				amenities2_code2_CountNonBlank                                := sum(group,if(pAssess.amenities2_code2<>'',1,0));
				amenities2_code3_CountNonBlank                                := sum(group,if(pAssess.amenities2_code3<>'',1,0));
				amenities2_code4_CountNonBlank                                := sum(group,if(pAssess.amenities2_code4<>'',1,0));
				amenities2_code5_CountNonBlank                                := sum(group,if(pAssess.amenities2_code5<>'',1,0));
				extra_features1_area_CountNonBlank                            := sum(group,if(pAssess.extra_features1_area<>'',1,0));
				extra_features1_indicator_CountNonBlank                       := sum(group,if(pAssess.extra_features1_indicator<>'',1,0));
				extra_features2_area_CountNonBlank                            := sum(group,if(pAssess.extra_features2_area<>'',1,0));
				extra_features2_indicator_CountNonBlank                       := sum(group,if(pAssess.extra_features2_indicator<>'',1,0));
				extra_features3_area_CountNonBlank                            := sum(group,if(pAssess.extra_features3_area<>'',1,0));
				extra_features3_indicator_CountNonBlank                       := sum(group,if(pAssess.extra_features3_indicator<>'',1,0));
				extra_features4_area_CountNonBlank                            := sum(group,if(pAssess.extra_features4_area<>'',1,0));
				extra_features4_indicator_CountNonBlank                       := sum(group,if(pAssess.extra_features4_indicator<>'',1,0));
				other_buildings1_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings1_code<>'',1,0));
				other_buildings2_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings2_code<>'',1,0));
				other_buildings3_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings3_code<>'',1,0));
				other_buildings4_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings4_code<>'',1,0));
				other_buildings5_code_CountNonBlank                           := sum(group,if(pAssess.other_buildings5_code<>'',1,0));
				other_impr_building1_indicator_CountNonBlank									:= sum(group,if(pAssess.other_impr_building1_indicator<>'',1,0));
				other_impr_building2_indicator_CountNonBlank									:= sum(group,if(pAssess.other_impr_building2_indicator<>'',1,0));
				other_impr_building3_indicator_CountNonBlank									:= sum(group,if(pAssess.other_impr_building3_indicator<>'',1,0));
				other_impr_building4_indicator_CountNonBlank									:= sum(group,if(pAssess.other_impr_building4_indicator<>'',1,0));
				other_impr_building5_indicator_CountNonBlank									:= sum(group,if(pAssess.other_impr_building5_indicator<>'',1,0));
				other_impr_building_area1_CountNonBlank												:= sum(group,if(pAssess.other_impr_building_area1<>'',1,0));
				other_impr_building_area2_CountNonBlank												:= sum(group,if(pAssess.other_impr_building_area2<>'',1,0));
				other_impr_building_area3_CountNonBlank												:= sum(group,if(pAssess.other_impr_building_area3<>'',1,0));
				other_impr_building_area4_CountNonBlank												:= sum(group,if(pAssess.other_impr_building_area4<>'',1,0));
				other_impr_building_area5_CountNonBlank												:= sum(group,if(pAssess.other_impr_building_area5<>'',1,0));
				topography_code_CountNonBlank                               	:= sum(group,if(pAssess.topograpy_code<>'',1,0));
				neighborhood_code_CountNonBlank                               := sum(group,if(pAssess.neighborhood_code<>'',1,0));
				condo_project_or_building_name_CountNonBlank                  := sum(group,if(pAssess.condo_project_or_building_name<>'',1,0));
				assessee_name_indicator_CountNonBlank                         := sum(group,if(pAssess.assessee_name_indicator<>'',1,0));
				second_assessee_name_indicator_CountNonBlank                  := sum(group,if(pAssess.second_assessee_name_indicator<>'',1,0));
				mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(pAssess.mail_care_of_name_indicator<>'',1,0));
				comments_CountNonBlank                                        := sum(group,if(pAssess.comments<>'',1,0));
				tape_cut_date_CountNonBlank                                   := sum(group,if(pAssess.tape_cut_date<>'',1,0));
				certification_date_CountNonBlank                              := sum(group,if(pAssess.certification_date<>'',1,0));
				edition_number_CountNonBlank                                  := sum(group,if(pAssess.edition_number<>'',1,0));
				prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(pAssess.prop_addr_propagated_ind<>'',1,0));
				ln_ownership_rights_CountNonBlank 														:= sum(group,if(pAssess.ln_ownership_rights<>'',1,0));
				ln_relationship_type_CountNonBlank 														:= sum(group,if(pAssess.ln_relationship_type<>'',1,0));
				ln_mailing_country_code_CountNonBlank 												:= sum(group,if(pAssess.ln_mailing_country_code<>'',1,0));
				ln_property_name_CountNonBlank 																:= sum(group,if(pAssess.ln_property_name<>'',1,0));
				ln_property_name_type_CountNonBlank 													:= sum(group,if(pAssess.ln_property_name_type<>'',1,0));
				ln_land_use_category_CountNonBlank 														:= sum(group,if(pAssess.ln_land_use_category<>'',1,0));
				ln_lot_CountNonBlank 																					:= sum(group,if(pAssess.ln_lot<>'',1,0));
				ln_block_CountNonBlank 																				:= sum(group,if(pAssess.ln_block<>'',1,0));
				ln_unit_CountNonBlank 																				:= sum(group,if(pAssess.ln_unit<>'',1,0));
				ln_subfloor_CountNonBlank 																		:= sum(group,if(pAssess.ln_subfloor<>'',1,0));
				ln_floor_cover_CountNonBlank 																	:= sum(group,if(pAssess.ln_floor_cover<>'',1,0));
				ln_mobile_home_indicator_CountNonBlank 												:= sum(group,if(pAssess.ln_mobile_home_indicator<>'',1,0));
				ln_condo_indicator_CountNonBlank 															:= sum(group,if(pAssess.ln_condo_indicator<>'',1,0));
				ln_property_tax_exemption_CountNonBlank 											:= sum(group,if(pAssess.ln_property_tax_exemption<>'',1,0));
				ln_veteran_status_CountNonBlank 															:= sum(group,if(pAssess.ln_veteran_status<>'',1,0));
				ln_old_apn_indicator_CountNonBlank 														:= sum(group,if(pAssess.ln_old_apn_indicator<>'',1,0));
		end;

	//DEEDS
		%rPopulationStats_Pdeed% := record
				CountGroup                                                                := count(group);
				pDeed.vendor_source_flag;
				ln_fares_id_CountNonBlank                                                 := sum(group,if(pDeed.ln_fares_id<>'',1,0));
				process_date_CountNonBlank                                                := sum(group,if(pDeed.process_date<>'',1,0));
				vendor_source_flag_CountNonBlank                                          := sum(group,if(pDeed.vendor_source_flag<>'',1,0));
				current_record_CountNonBlank                                              := sum(group,if(pDeed.current_record<>'',1,0));
				from_file_CountNonBlank                                                   := sum(group,if(pDeed.from_file<>'',1,0));
				fips_code_CountNonBlank                                                   := sum(group,if(pDeed.fips_code<>'',1,0));
				state_CountNonBlank                                                       := sum(group,if(pDeed.state<>'',1,0));
				county_name_CountNonBlank                                                 := sum(group,if(pDeed.county_name<>'',1,0));
				record_type_CountNonBlank                                                 := sum(group,if(pDeed.record_type<>'',1,0));
				apnt_or_pin_number_CountNonBlank                                          := sum(group,if(pDeed.apnt_or_pin_number<>'',1,0));
				fares_unformatted_apn_CountNonBlank                                       := sum(group,if(pDeed.fares_unformatted_apn<>'',1,0));
				multi_apn_flag_CountNonBlank                                              := sum(group,if(pDeed.multi_apn_flag<>'',1,0));
				tax_id_number_CountNonBlank                                               := sum(group,if(pDeed.tax_id_number<>'',1,0));
				excise_tax_number_CountNonBlank                                           := sum(group,if(pDeed.excise_tax_number<>'',1,0));
				buyer_or_borrower_ind_CountNonBlank                                       := sum(group,if(pDeed.buyer_or_borrower_ind<>'',1,0));
				name1_CountNonBlank                                                       := sum(group,if(pDeed.name1<>'',1,0));
				name1_id_code_CountNonBlank                                               := sum(group,if(pDeed.name1_id_code<>'',1,0));
				name2_CountNonBlank                                                       := sum(group,if(pDeed.name2<>'',1,0));
				name2_id_code_CountNonBlank                                               := sum(group,if(pDeed.name2_id_code<>'',1,0));
				vesting_code_CountNonBlank                                                := sum(group,if(pDeed.vesting_code<>'',1,0));
				addendum_flag_CountNonBlank                                               := sum(group,if(pDeed.addendum_flag<>'',1,0));
				phone_number_CountNonBlank                                                := sum(group,if(pDeed.phone_number<>'',1,0));
				mailing_care_of_CountNonBlank                                             := sum(group,if(pDeed.mailing_care_of<>'',1,0));
				mailing_street_CountNonBlank                                              := sum(group,if(pDeed.mailing_street<>'',1,0));
				mailing_unit_number_CountNonBlank                                         := sum(group,if(pDeed.mailing_unit_number<>'',1,0));
				mailing_csz_CountNonBlank                                                 := sum(group,if(pDeed.mailing_csz<>'',1,0));
				mailing_address_cd_CountNonBlank                                          := sum(group,if(pDeed.mailing_address_cd<>'',1,0));
				seller1_CountNonBlank                                                     := sum(group,if(pDeed.seller1<>'',1,0));
				seller1_id_code_CountNonBlank                                             := sum(group,if(pDeed.seller1_id_code<>'',1,0));
				seller2_CountNonBlank                                                     := sum(group,if(pDeed.seller2<>'',1,0));
				seller2_id_code_CountNonBlank                                             := sum(group,if(pDeed.seller2_id_code<>'',1,0));
				seller_addendum_flag_CountNonBlank                                        := sum(group,if(pDeed.seller_addendum_flag<>'',1,0));
				seller_mailing_full_street_address_CountNonBlank                          := sum(group,if(pDeed.seller_mailing_full_street_address<>'',1,0));
				seller_mailing_address_unit_number_CountNonBlank                          := sum(group,if(pDeed.seller_mailing_address_unit_number<>'',1,0));
				seller_mailing_address_citystatezip_CountNonBlank                         := sum(group,if(pDeed.seller_mailing_address_citystatezip<>'',1,0));
				property_full_street_address_CountNonBlank                                := sum(group,if(pDeed.property_full_street_address<>'',1,0));
				property_address_unit_number_CountNonBlank                                := sum(group,if(pDeed.property_address_unit_number<>'',1,0));
				property_address_citystatezip_CountNonBlank                               := sum(group,if(pDeed.property_address_citystatezip<>'',1,0));
				property_address_code_CountNonBlank                                       := sum(group,if(pDeed.property_address_code<>'',1,0));
				legal_lot_code_CountNonBlank                                              := sum(group,if(pDeed.legal_lot_code<>'',1,0));
				legal_lot_number_CountNonBlank                                            := sum(group,if(pDeed.legal_lot_number<>'',1,0));
				legal_block_CountNonBlank                                                 := sum(group,if(pDeed.legal_block<>'',1,0));
				legal_section_CountNonBlank                                               := sum(group,if(pDeed.legal_section<>'',1,0));
				legal_district_CountNonBlank                                              := sum(group,if(pDeed.legal_district<>'',1,0));
				legal_land_lot_CountNonBlank                                              := sum(group,if(pDeed.legal_land_lot<>'',1,0));
				legal_unit_CountNonBlank                                                  := sum(group,if(pDeed.legal_unit<>'',1,0));
				legal_city_municipality_township_CountNonBlank                            := sum(group,if(pDeed.legal_city_municipality_township<>'',1,0));
				legal_subdivision_name_CountNonBlank                                      := sum(group,if(pDeed.legal_subdivision_name<>'',1,0));
				legal_phase_number_CountNonBlank                                          := sum(group,if(pDeed.legal_phase_number<>'',1,0));
				legal_tract_number_CountNonBlank                                          := sum(group,if(pDeed.legal_tract_number<>'',1,0));
				legal_sec_twn_rng_mer_CountNonBlank                                       := sum(group,if(pDeed.legal_sec_twn_rng_mer<>'',1,0));
				legal_brief_description_CountNonBlank                                     := sum(group,if(pDeed.legal_brief_description<>'',1,0));
				recorder_map_reference_CountNonBlank                                      := sum(group,if(pDeed.recorder_map_reference<>'',1,0));
				complete_legal_description_code_CountNonBlank                             := sum(group,if(pDeed.complete_legal_description_code<>'',1,0));
				contract_date_CountNonBlank                                               := sum(group,if(pDeed.contract_date<>'',1,0));
				recording_date_CountNonBlank                                              := sum(group,if(pDeed.recording_date<>'',1,0));
				arm_reset_date_CountNonBlank                                              := sum(group,if(pDeed.arm_reset_date<>'',1,0));
				document_number_CountNonBlank                                             := sum(group,if(pDeed.document_number<>'',1,0));
				document_type_code_CountNonBlank                                          := sum(group,if(pDeed.document_type_code<>'',1,0));
				loan_number_CountNonBlank                                                 := sum(group,if(pDeed.loan_number<>'',1,0));
				recorder_book_number_CountNonBlank                                        := sum(group,if(pDeed.recorder_book_number<>'',1,0));
				recorder_page_number_CountNonBlank                                        := sum(group,if(pDeed.recorder_page_number<>'',1,0));
				concurrent_mortgage_book_page_document_number_CountNonBlank               := sum(group,if(pDeed.concurrent_mortgage_book_page_document_number<>'',1,0));
				sales_price_CountNonBlank                                                 := sum(group,if(pDeed.sales_price<>'',1,0));
				sales_price_code_CountNonBlank                                            := sum(group,if(pDeed.sales_price_code<>'',1,0));
				city_transfer_tax_CountNonBlank                                           := sum(group,if(pDeed.city_transfer_tax<>'',1,0));
				county_transfer_tax_CountNonBlank                                         := sum(group,if(pDeed.county_transfer_tax<>'',1,0));
				total_transfer_tax_CountNonBlank                                          := sum(group,if(pDeed.total_transfer_tax<>'',1,0));
				first_td_loan_amount_CountNonBlank                                        := sum(group,if(pDeed.first_td_loan_amount<>'',1,0));
				second_td_loan_amount_CountNonBlank                                       := sum(group,if(pDeed.second_td_loan_amount<>'',1,0));
				first_td_lender_type_code_CountNonBlank                                   := sum(group,if(pDeed.first_td_lender_type_code<>'',1,0));
				second_td_lender_type_code_CountNonBlank                                  := sum(group,if(pDeed.second_td_lender_type_code<>'',1,0));
				first_td_loan_type_code_CountNonBlank                                     := sum(group,if(pDeed.first_td_loan_type_code<>'',1,0));
				type_financing_CountNonBlank                                              := sum(group,if(pDeed.type_financing<>'',1,0));
				first_td_interest_rate_CountNonBlank                                      := sum(group,if(pDeed.first_td_interest_rate<>'',1,0));
				first_td_due_date_CountNonBlank                                           := sum(group,if(pDeed.first_td_due_date<>'',1,0));
				title_company_name_CountNonBlank                                          := sum(group,if(pDeed.title_company_name<>'',1,0));
				partial_interest_transferred_CountNonBlank                                := sum(group,if(pDeed.partial_interest_transferred<>'',1,0));
				loan_term_months_CountNonBlank                                            := sum(group,if(pDeed.loan_term_months<>'',1,0));
				loan_term_years_CountNonBlank                                             := sum(group,if(pDeed.loan_term_years<>'',1,0));
				lender_name_CountNonBlank                                                 := sum(group,if(pDeed.lender_name<>'',1,0));
				lender_name_id_CountNonBlank                                              := sum(group,if(pDeed.lender_name_id<>'',1,0));
				lender_dba_aka_name_CountNonBlank                                         := sum(group,if(pDeed.lender_dba_aka_name<>'',1,0));
				lender_full_street_address_CountNonBlank                                  := sum(group,if(pDeed.lender_full_street_address<>'',1,0));
				lender_address_unit_number_CountNonBlank                                  := sum(group,if(pDeed.lender_address_unit_number<>'',1,0));
				lender_address_citystatezip_CountNonBlank                                 := sum(group,if(pDeed.lender_address_citystatezip<>'',1,0));
				assessment_match_land_use_code_CountNonBlank                              := sum(group,if(pDeed.assessment_match_land_use_code<>'',1,0));
				property_use_code_CountNonBlank                                           := sum(group,if(pDeed.property_use_code<>'',1,0));
				condo_code_CountNonBlank                                                  := sum(group,if(pDeed.condo_code<>'',1,0));
				timeshare_flag_CountNonBlank                                              := sum(group,if(pDeed.timeshare_flag<>'',1,0));
				land_lot_size_CountNonBlank                                               := sum(group,if(pDeed.land_lot_size<>'',1,0));
				hawaii_tct_CountNonBlank                                                  := sum(group,if(pDeed.hawaii_tct<>'',1,0));
				hawaii_condo_cpr_code_CountNonBlank                                       := sum(group,if(pDeed.hawaii_condo_cpr_code<>'',1,0));
				hawaii_condo_name_CountNonBlank                                           := sum(group,if(pDeed.hawaii_condo_name<>'',1,0));
				filler_except_hawaii_CountNonBlank                                        := sum(group,if(pDeed.filler_except_hawaii<>'',1,0));
				rate_change_frequency_CountNonBlank                                       := sum(group,if(pDeed.rate_change_frequency<>'',1,0));
				change_index_CountNonBlank                                                := sum(group,if(pDeed.change_index<>'',1,0));
				adjustable_rate_index_CountNonBlank                                       := sum(group,if(pDeed.adjustable_rate_index<>'',1,0));
				adjustable_rate_rider_CountNonBlank                                       := sum(group,if(pDeed.adjustable_rate_rider<>'',1,0));
				graduated_payment_rider_CountNonBlank                                     := sum(group,if(pDeed.graduated_payment_rider<>'',1,0));
				balloon_rider_CountNonBlank                                               := sum(group,if(pDeed.balloon_rider<>'',1,0));
				fixed_step_rate_rider_CountNonBlank                                       := sum(group,if(pDeed.fixed_step_rate_rider<>'',1,0));
				condominium_rider_CountNonBlank                                           := sum(group,if(pDeed.condominium_rider<>'',1,0));
				planned_unit_development_rider_CountNonBlank                              := sum(group,if(pDeed.planned_unit_development_rider<>'',1,0));
				rate_improvement_rider_CountNonBlank                                      := sum(group,if(pDeed.rate_improvement_rider<>'',1,0));
				assumability_rider_CountNonBlank                                          := sum(group,if(pDeed.assumability_rider<>'',1,0));
				prepayment_rider_CountNonBlank                                            := sum(group,if(pDeed.prepayment_rider<>'',1,0));
				one_four_family_rider_CountNonBlank                                       := sum(group,if(pDeed.one_four_family_rider<>'',1,0));
				biweekly_payment_rider_CountNonBlank                                      := sum(group,if(pDeed.biweekly_payment_rider<>'',1,0));
				second_home_rider_CountNonBlank                                           := sum(group,if(pDeed.second_home_rider<>'',1,0));
				data_source_code_CountNonBlank                                            := sum(group,if(pDeed.data_source_code<>'',1,0));
				main_record_id_code_CountNonBlank                                         := sum(group,if(pDeed.main_record_id_code<>'',1,0));
				addl_name_flag_CountNonBlank                                              := sum(group,if(pDeed.addl_name_flag<>'',1,0));
				prop_addr_propagated_ind_CountNonBlank                                    := sum(group,if(pDeed.prop_addr_propagated_ind<>'',1,0));
				ln_ownership_rights_CountNonBlank																					:= sum(group,if(pDeed.ln_ownership_rights<>'',1,0));
				ln_relationship_type_CountNonBlank																				:= sum(group,if(pDeed.ln_relationship_type<>'',1,0));
				ln_buyer_mailing_country_code_CountNonBlank																:= sum(group,if(pDeed.ln_buyer_mailing_country_code<>'',1,0));
				ln_seller_mailing_country_code_CountNonBlank															:= sum(group,if(pDeed.ln_seller_mailing_country_code<>'',1,0));
		end;

	//ADDL FARES TAX
		%rPopulationStats_paddlftax% := record
				CountGroup                                                        := count(group);
				string3  grouping                                                 := 'ALL';   
				ln_fares_id_CountNonBlank                                         := sum(group,if(pAddlftax.ln_fares_id<>'',1,0));
				fares_iris_apn_CountNonBlank                                      := sum(group,if(pAddlftax.fares_iris_apn<>'',1,0));
				fares_non_parsed_assessee_name_CountNonBlank                      := sum(group,if(pAddlftax.fares_non_parsed_assessee_name<>'',1,0));
				fares_non_parsed_second_assessee_name_CountNonBlank               := sum(group,if(pAddlftax.fares_non_parsed_second_assessee_name<>'',1,0));
				fares_land_use_CountNonBlank                                      := sum(group,if(pAddlftax.fares_land_use<>'',1,0));
				fares_seller_name_CountNonBlank                                   := sum(group,if(pAddlftax.fares_seller_name<>'',1,0));
				fares_calculated_land_value_CountNonBlank                         := sum(group,if(pAddlftax.fares_calculated_land_value<>'',1,0));
				fares_calculated_improvement_value_CountNonBlank                  := sum(group,if(pAddlftax.fares_calculated_improvement_value<>'',1,0));
				fares_calculated_total_value_CountNonBlank                        := sum(group,if(pAddlftax.fares_calculated_total_value<>'',1,0));
				fares_living_square_feet_CountNonBlank                            := sum(group,if(pAddlftax.fares_living_square_feet<>'',1,0));
				fares_adjusted_gross_square_feet_CountNonBlank                    := sum(group,if(pAddlftax.fares_adjusted_gross_square_feet<>'',1,0));
				fares_no_of_full_baths_CountNonBlank                              := sum(group,if(pAddlftax.fares_no_of_full_baths<>'',1,0));
				fares_no_of_half_baths_CountNonBlank                              := sum(group,if(pAddlftax.fares_no_of_half_baths<>'',1,0));
				fares_pool_indicator_CountNonBlank                                := sum(group,if(pAddlftax.fares_pool_indicator<>'',1,0));
				fares_frame_CountNonBlank                                         := sum(group,if(pAddlftax.fares_frame<>'',1,0));
				fares_electric_energy_CountNonBlank                               := sum(group,if(pAddlftax.fares_electric_energy<>'',1,0));
				fares_sewer_CountNonBlank                                         := sum(group,if(pAddlftax.fares_sewer<>'',1,0));
				fares_water_CountNonBlank                                         := sum(group,if(pAddlftax.fares_water<>'',1,0));
				fares_condition_CountNonBlank                                     := sum(group,if(pAddlftax.fares_condition<>'',1,0));
		end;
	
		%rPopulationStats_paddlftaxPlus% := record
				CountGroup                                                        := count(group);
				string3  grouping                                                 := 'ALL';   
				ln_fares_id_CountNonBlank                                         := sum(group,if(pAddlftax.ln_fares_id<>'',1,0));
				fares_iris_apn_CountNonBlank                                      := sum(group,if(pAddlftax.fares_iris_apn<>'',1,0));
				fares_map_ref_1_CountNonBlank                                     := sum(group,if(pAddlftax.fares_map_ref_1<>'',1,0));
				fares_map_ref_2_CountNonBlank                                     := sum(group,if(pAddlftax.fares_map_ref_2<>'',1,0));
				fares_quarter_CountNonBlank                                     	:= sum(group,if(pAddlftax.fares_multi_apn_flag<>'',1,0));
				fares_multi_apn_flag_CountNonBlank                                := sum(group,if(pAddlftax.fares_multi_apn_flag<>'',1,0));
				fares_non_parsed_assessee_name_CountNonBlank                      := sum(group,if(pAddlftax.fares_non_parsed_assessee_name<>'',1,0));
				fares_non_parsed_second_assessee_name_CountNonBlank               := sum(group,if(pAddlftax.fares_non_parsed_second_assessee_name<>'',1,0));
				fares_absentee_owner_CountNonBlank																:= sum(group,if(pAddlftax.fares_absentee_owner<>'',1,0));
				fares_flood_zone_CountNonBlank																		:= sum(group,if(pAddlftax.fares_flood_zone<>'',1,0));
				fares_county_use2_CountNonBlank																		:= sum(group,if(pAddlftax.fares_county_use2<>'',1,0));
				fares_property_indicator_CountNonBlank														:= sum(group,if(pAddlftax.fares_property_indicator<>'',1,0));
				fares_view_CountNonBlank																					:= sum(group,if(pAddlftax.fares_view<>'',1,0));
				fares_subdiv_tract_num_CountNonBlank															:= sum(group,if(pAddlftax.fares_subdiv_tract_num<>'',1,0));
				fares_subdiv_plat_book_CountNonBlank															:= sum(group,if(pAddlftax.fares_subdiv_plat_book<>'',1,0));
				fares_subdiv_plat_page_CountNonBlank															:= sum(group,if(pAddlftax.fares_subdiv_plat_page<>'',1,0));
				fares_owner_match_code_CountNonBlank															:= sum(group,if(pAddlftax.fares_owner_match_code<>'',1,0));
				fares_owner_etal_indicator_CountNonBlank													:= sum(group,if(pAddlftax.fares_owner_etal_indicator<>'',1,0));
				fares_owner_phone_opt_out_code_CountNonBlank											:= sum(group,if(pAddlftax.fares_owner_phone_opt_out_code<>'',1,0));
				fares_owner_mailing_opt_out_code_CountNonBlank										:= sum(group,if(pAddlftax.fares_owner_mailing_opt_out_code<>'',1,0));
				fares_land_use_CountNonBlank                                      := sum(group,if(pAddlftax.fares_land_use<>'',1,0));
				fares_seller_name_CountNonBlank                                   := sum(group,if(pAddlftax.fares_seller_name<>'',1,0));
				fares_calculated_land_value_ind_CountNonBlank                     := sum(group,if(pAddlftax.fares_calculated_land_value_ind<>'',1,0));
				fares_calculated_land_value_CountNonBlank                         := sum(group,if(pAddlftax.fares_calculated_land_value<>'',1,0));
				fares_calculated_improvement_value_ind_CountNonBlank              := sum(group,if(pAddlftax.fares_calculated_improvement_value_ind<>'',1,0));
				fares_calculated_improvement_value_CountNonBlank                  := sum(group,if(pAddlftax.fares_calculated_improvement_value<>'',1,0));
				fares_calculated_total_value_ind_CountNonBlank                    := sum(group,if(pAddlftax.fares_calculated_total_value_ind<>'',1,0));
				fares_calculated_total_value_CountNonBlank                        := sum(group,if(pAddlftax.fares_calculated_total_value<>'',1,0));
				fares_appr_total_value_CountNonBlank															:= sum(group,if(pAddlftax.fares_appr_total_value<>'',1,0));
				fares_appr_land_value_CountNonBlank																:= sum(group,if(pAddlftax.fares_appr_land_value<>'',1,0));
				fares_appr_improvement_value_CountNonBlank												:= sum(group,if(pAddlftax.fares_appr_improvement_value<>'',1,0));
				fares_sales_deed_cat_type_CountNonBlank														:= sum(group,if(pAddlftax.fares_sales_deed_cat_type<>'',1,0));
				fares_sale_transaction_code_CountNonBlank													:= sum(group,if(pAddlftax.fares_sale_transaction_code<>'',1,0));
				fares_title_company_name_CountNonBlank														:= sum(group,if(pAddlftax.fares_title_company_name<>'',1,0));
				fares_residential_model_ind_CountNonBlank													:= sum(group,if(pAddlftax.fares_residential_model_ind<>'',1,0));
				fares_mortgage_date_CountNonBlank																	:= sum(group,if(pAddlftax.fares_mortgage_date<>'',1,0));
				fares_mortgage_deed_type_CountNonBlank														:= sum(group,if(pAddlftax.fares_mortgage_deed_type<>'',1,0));
				fares_mortgage_term_code_CountNonBlank														:= sum(group,if(pAddlftax.fares_mortgage_term_code<>'',1,0));
				fares_mortgage_term_CountNonBlank																	:= sum(group,if(pAddlftax.fares_mortgage_term<>'',1,0));
				fares_mortgage_due_date_CountNonBlank															:= sum(group,if(pAddlftax.fares_mortgage_due_date<>'',1,0));
				fares_mortgage_assumption_amt_CountNonBlank												:= sum(group,if(pAddlftax.fares_mortgage_assumption_amt<>'',1,0));
				fares_lender_code_CountNonBlank																		:= sum(group,if(pAddlftax.fares_lender_code<>'',1,0));
				fares_second_mortgage_amt_CountNonBlank														:= sum(group,if(pAddlftax.fares_second_mortgage_amt<>'',1,0));
				fares_second_mortgage_loan_type_code_CountNonBlank								:= sum(group,if(pAddlftax.fares_second_mortgage_loan_type_code<>'',1,0));
				fares_second_deed_type_CountNonBlank															:= sum(group,if(pAddlftax.fares_second_deed_type<>'',1,0));
				fares_prior_document_number_CountNonBlank													:= sum(group,if(pAddlftax.fares_prior_document_number<>'',1,0));
				fares_prior_book_page_CountNonBlank																:= sum(group,if(pAddlftax.fares_prior_book_page<>'',1,0));
				fares_prior_sales_deed_cat_type_CountNonBlank											:= sum(group,if(pAddlftax.fares_prior_sales_deed_cat_type<>'',1,0));
				fares_prior_mortgage_amount_CountNonBlank													:= sum(group,if(pAddlftax.fares_prior_mortgage_amount<>'',1,0));
				fares_prior_deed_type_CountNonBlank																:= sum(group,if(pAddlftax.fares_prior_deed_type<>'',1,0));
				fares_bldg_code_CountNonBlank																			:= sum(group,if(pAddlftax.fares_bldg_code<>'',1,0));
				fares_living_square_feet_CountNonBlank                            := sum(group,if(pAddlftax.fares_living_square_feet<>'',1,0));
				fares_gross_square_feet_CountNonBlank                    					:= sum(group,if(pAddlftax.fares_gross_square_feet<>'',1,0));
				fares_adjusted_gross_square_feet_CountNonBlank                    := sum(group,if(pAddlftax.fares_adjusted_gross_square_feet<>'',1,0));
				fares_ground_floor_square_feet_CountNonBlank                    	:= sum(group,if(pAddlftax.fares_ground_floor_square_feet<>'',1,0));
				fares_basement_square_feet_CountNonBlank                    			:= sum(group,if(pAddlftax.fares_basement_square_feet<>'',1,0));
				fares_garage_square_feet_CountNonBlank                    				:= sum(group,if(pAddlftax.fares_garage_square_feet<>'',1,0));
				fares_total_baths_calculated_CountNonBlank                        := sum(group,if(pAddlftax.fares_total_baths_calculated<>'',1,0));
				fares_no_of_full_baths_CountNonBlank                              := sum(group,if(pAddlftax.fares_no_of_full_baths<>'',1,0));
				fares_no_of_half_baths_CountNonBlank                              := sum(group,if(pAddlftax.fares_no_of_half_baths<>'',1,0));
				fares_no_of_one_qtr_baths_CountNonBlank                           := sum(group,if(pAddlftax.fares_no_of_one_qtr_baths<>'',1,0));
				fares_no_of_three_qtr_baths_CountNonBlank                         := sum(group,if(pAddlftax.fares_no_of_three_qtr_baths<>'',1,0));
				fares_no_of_bath_fixtures_CountNonBlank                         	:= sum(group,if(pAddlftax.fares_no_of_bath_fixtures<>'',1,0));
				fares_fire_place_type_CountNonBlank                         			:= sum(group,if(pAddlftax.fares_fire_place_type<>'',1,0));
				fares_mobile_home_indicator_CountNonBlank                         := sum(group,if(pAddlftax.fares_mobile_home_indicator<>'',1,0));
				fares_pool_indicator_CountNonBlank                                := sum(group,if(pAddlftax.fares_pool_indicator<>'',1,0));
				fares_frame_CountNonBlank                                         := sum(group,if(pAddlftax.fares_frame<>'',1,0));
				fares_electric_energy_CountNonBlank                               := sum(group,if(pAddlftax.fares_electric_energy<>'',1,0));
				fares_parking_type_CountNonBlank                              		:= sum(group,if(pAddlftax.fares_parking_type<>'',1,0));
				fares_stories_code_CountNonBlank                               		:= sum(group,if(pAddlftax.fares_stories_code<>'',1,0));
				fares_sewer_CountNonBlank                                         := sum(group,if(pAddlftax.fares_sewer<>'',1,0));
				fares_water_CountNonBlank                                         := sum(group,if(pAddlftax.fares_water<>'',1,0));
				fares_condition_CountNonBlank                                     := sum(group,if(pAddlftax.fares_condition<>'',1,0));    
		end;
	
	//ADDL FARES DEEDS 
		%rPopulationStats_paddlfdeed% := record
				CountGroup                                             := count(group);
				string3  grouping                                      := 'ALL';
				ln_fares_id_CountNonBlank                              := sum(group,if(pAddlfdeed.ln_fares_id<>'',1,0));
				fares_corporate_indicator_CountNonBlank                := sum(group,if(pAddlfdeed.fares_corporate_indicator<>'',1,0));
				fares_transaction_type_CountNonBlank                   := sum(group,if(pAddlfdeed.fares_transaction_type<>'',1,0));
				fares_lender_address_CountNonBlank                     := sum(group,if(pAddlfdeed.fares_lender_address<>'',1,0));
				fares_mortgage_date_CountNonBlank                      := sum(group,if(pAddlfdeed.fares_mortgage_date<>'',1,0));
				fares_mortgage_deed_type_CountNonBlank                 := sum(group,if(pAddlfdeed.fares_mortgage_deed_type<>'',1,0));
				fares_mortgage_term_code_CountNonBlank                 := sum(group,if(pAddlfdeed.fares_mortgage_term_code<>'',1,0));
				fares_mortgage_term_CountNonBlank                      := sum(group,if(pAddlfdeed.fares_mortgage_term<>'',1,0));
				fares_building_square_feet_CountNonBlank               := sum(group,if(pAddlfdeed.fares_building_square_feet<>'',1,0));
				fares_foreclosure_CountNonBlank                        := sum(group,if(pAddlfdeed.fares_foreclosure<>'',1,0));
				fares_refi_flag_CountNonBlank                          := sum(group,if(pAddlfdeed.fares_refi_flag<>'',1,0));
				fares_equity_flag_CountNonBlank                        := sum(group,if(pAddlfdeed.fares_equity_flag<>'',1,0));
				fares_iris_apn_CountNonBlank                           := sum(group,if(pAddlfdeed.fares_iris_apn<>'',1,0));
		end;
	
		%rPopulationStats_paddlfdeedPlus% := record
				CountGroup                                             := count(group);
				string3  grouping                                      := 'ALL';
				ln_fares_id_CountNonBlank                              := sum(group,if(pAddlfdeed.ln_fares_id<>'',1,0));
				fares_owner_etal_indicator_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_owner_etal_indicator<>'',1,0));
				fares_owner_relationship_code_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_owner_relationship_code<>'',1,0));
				fares_owner_relationship_type_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_owner_relationship_type<>'',1,0));
				fares_match_code_CountNonBlank												 := sum(group,if(pAddlfdeed.fares_match_code<>'',1,0));
				fares_document_year_CountNonBlank											 := sum(group,if(pAddlfdeed.fares_document_year<>'',1,0));
				fares_corporate_indicator_CountNonBlank                := sum(group,if(pAddlfdeed.fares_corporate_indicator<>'',1,0));
				fares_transaction_type_CountNonBlank                   := sum(group,if(pAddlfdeed.fares_transaction_type<>'',1,0));
				fares_lender_address_CountNonBlank                     := sum(group,if(pAddlfdeed.fares_lender_address<>'',1,0));
				fares_sales_transaction_code_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_sales_transaction_code<>'',1,0));
				fares_residential_model_ind_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_residential_model_ind<>'',1,0));
				fares_mortgage_date_CountNonBlank                      := sum(group,if(pAddlfdeed.fares_mortgage_date<>'',1,0));
				fares_mortgage_deed_type_CountNonBlank                 := sum(group,if(pAddlfdeed.fares_mortgage_deed_type<>'',1,0));
				fares_mortgage_term_code_CountNonBlank                 := sum(group,if(pAddlfdeed.fares_mortgage_term_code<>'',1,0));
				fares_mortgage_term_CountNonBlank                      := sum(group,if(pAddlfdeed.fares_mortgage_term<>'',1,0));
				fares_mortgage_assumption_amt_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_mortgage_assumption_amt<>'',1,0));
				fares_second_mortgage_loan_type_code_CountNonBlank		 := sum(group,if(pAddlfdeed.fares_second_mortgage_loan_type_code<>'',1,0));
				fares_second_deed_type_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_second_deed_type<>'',1,0));
				fares_prior_doc_year_CountNonBlank										 := sum(group,if(pAddlfdeed.fares_prior_doc_year<>'',1,0));
				fares_prior_doc_number_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_prior_doc_number<>'',1,0));
				fares_prior_book_page_CountNonBlank										 := sum(group,if(pAddlfdeed.fares_prior_book_page<>'',1,0));
				fares_prior_sales_deed_cat_code_CountNonBlank					 := sum(group,if(pAddlfdeed.fares_prior_sales_deed_cat_code<>'',1,0));
				fares_prior_recording_date_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_prior_recording_date<>'',1,0));
				fares_prior_sales_date_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_prior_sales_date<>'',1,0));
				fares_prior_sales_price_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_prior_sales_price<>'',1,0));
				fares_prior_sales_code_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_prior_sales_code<>'',1,0));
				fares_prior_sales_transaction_code_CountNonBlank			 := sum(group,if(pAddlfdeed.fares_prior_sales_transaction_code<>'',1,0));
				fares_prior_mortgage_amount_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_prior_mortgage_amount<>'',1,0));
				fares_prior_deed_type_CountNonBlank										 := sum(group,if(pAddlfdeed.fares_prior_deed_type<>'',1,0));
				fares_absentee_indicator_CountNonBlank								 := sum(group,if(pAddlfdeed.fares_absentee_indicator<>'',1,0));
				fares_partial_interest_ind_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_partial_interest_ind<>'',1,0));
				fares_pri_cat_code_CountNonBlank											 := sum(group,if(pAddlfdeed.fares_pri_cat_code<>'',1,0));
				fares_private_party_lender_CountNonBlank							 := sum(group,if(pAddlfdeed.fares_private_party_lender<>'',1,0));
				fares_construction_loan_CountNonBlank									 := sum(group,if(pAddlfdeed.fares_construction_loan<>'',1,0));
				fares_resale_new_construction_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_resale_new_construction<>'',1,0));
				fares_inter_family_CountNonBlank											 := sum(group,if(pAddlfdeed.fares_inter_family<>'',1,0));
				fares_cash_mortgage_purchase_CountNonBlank						 := sum(group,if(pAddlfdeed.fares_cash_mortgage_purchase<>'',1,0));
				fares_building_square_feet_CountNonBlank               := sum(group,if(pAddlfdeed.fares_building_square_feet<>'',1,0));
				fares_foreclosure_CountNonBlank                        := sum(group,if(pAddlfdeed.fares_foreclosure<>'',1,0));
				fares_refi_flag_CountNonBlank                          := sum(group,if(pAddlfdeed.fares_refi_flag<>'',1,0));
				fares_equity_flag_CountNonBlank                        := sum(group,if(pAddlfdeed.fares_equity_flag<>'',1,0));
				fares_iris_apn_CountNonBlank                           := sum(group,if(pAddlfdeed.fares_iris_apn<>'',1,0));  
		end;
	
	//ADDL LEGAL
		%rPopulationStats_paddllegal% := record
				CountGroup                              := count(group);
				string3  grouping                       := 'ALL';
				ln_fares_id_CountNonBlank               := sum(group,if(pAddllegal.ln_fares_id<>'',1,0));
				addl_legal_CountNonBlank                := sum(group,if(pAddllegal.addl_legal<>'',1,0));    
		end;

	//ADDL NAMES 
		%rPopulationStats_paddlnames% := record
				CountGroup                                     := count(group);
				string3  grouping                              := 'ALL';
				ln_fares_id_CountNonBlank                      := sum(group,if(pAddlnames.ln_fares_id<>'',1,0));
				apnt_or_pin_number_CountNonBlank               := sum(group,if(pAddlnames.apnt_or_pin_number<>'',1,0));
				buyer_or_seller_CountNonBlank                  := sum(group,if(pAddlnames.buyer_or_seller<>'',1,0));
				name_seq_CountNonBlank                         := sum(group,if(pAddlnames.name_seq<>'',1,0));
				name_CountNonBlank                             := sum(group,if(pAddlnames.name<>'',1,0));
				id_code_CountNonBlank                          := sum(group,if(pAddlnames.id_code<>'',1,0));
		end;
  
	//SEARCH
		%rPopulationStats_pParty% := record
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
				ln_party_status_CountNonBlank												 := sum(group,if(pParty.ln_party_status<>'',1,0));
				ln_percentage_ownership_CountNonBlank								 := sum(group,if(pParty.ln_percentage_ownership<>'',1,0));
				ln_entity_type_CountNonBlank												 := sum(group,if(pParty.ln_entity_type<>'',1,0));
				ln_estate_trust_date_CountNonBlank									 := sum(group,if(pParty.ln_estate_trust_date<>'',1,0));
				ln_goverment_type_CountNonBlank											 := sum(group,if(pParty.ln_goverment_type<>'',1,0));
		end;
		
		//ADDL NAME INFO -future use
	/*	%rPopulationStats_pAddlNameInfo% := record
				CountGroup                              := count(group);
				string3  grouping                       := 'ALL';
				ln_fares_id_CountNonBlank               := sum(group,if(pAddlNameInfo.ln_fares_id<>'',1,0));
				other_borrower_names_CountNonBlank      := sum(group,if(pAddlNameInfo.other_borrower_names<>'',1,0));
				other_lender_names_CountNonBlank        := sum(group,if(pAddlNameInfo.other_lender_names<>'',1,0));    
		end;
	*/

	//OUTPUT ASSESS STATS
		%dPopulationStats_pAsses% 		:= table(pAssess
																					,%rPopulationStats_pAsses%
																					,vendor_source_flag
																					,few);

		STRATA.createXMLStats(%dPopulationStats_pAsses%
													 ,%buildPrefix%
													 ,'Asses'
													 ,pVersion
													 ,''
													 ,%zAssesStats%
													 ,'view'
													 ,'Population');
											 
		%dPopulationStats_pAssesPlus% := table(pAssess
																					,%rPopulationStats_pAssesPlus%
																					,vendor_source_flag
																					,few);

		STRATA.createXMLStats(%dPopulationStats_pAssesPlus%
													 ,%buildPrefix%
													 ,'AssesPlus'
													 ,pVersion
													 ,''
													 ,%zAssesPlusStats%
													 ,'view'
													 ,'Population');

	//OUTPUT PARTY STATS
		%dPopulationStats_pParty% 		:= table(pParty
																						,%rPopulationStats_pParty%
																						,vendor_source_flag
																						,few);
																		
		STRATA.createXMLStats(%dPopulationStats_pParty%
													 ,%buildPrefix%
													 ,'search_base'
													 ,pVersion
													 ,''
													 ,%zPartyStats%
													 ,'view'
													 ,'Population');
					 
	//OUTPUT DEEDS STATS 
		%dPopulationStats_Pdeed% 		:= table(pDeed
																					,%rPopulationStats_Pdeed%
																					,vendor_source_flag
																					,few);
																		
		STRATA.createXMLStats(%dPopulationStats_Pdeed%
													 ,if(isFast, %buildPrefix%, %buildPrefix%+ ' 2')
													 ,'deeds'
													 ,pVersion
													 ,''
													 ,%zdeedStats%
													 ,'view'
													 ,'Population');
					 
	//OUTPUT ADDL FARES TAX STATS 
		%dPopulationStats_paddlftax% := table(pAddlftax
																					,%rPopulationStats_paddlftax%
																					,few);
																				
		STRATA.createXMLStats(%dPopulationStats_paddlftax%
													 ,%buildPrefix%
													 ,'addl fares tax'
													 ,pVersion
													 ,''
													 ,%zaddlftaxStats%
													 ,'view'
													 ,'Population');
											 
		%dPopulationStats_paddlftaxPlus% := table(pAddlftax
																						,%rPopulationStats_paddlftaxPlus%
																						,few);
																				
		STRATA.createXMLStats(%dPopulationStats_paddlftaxPlus%
													 ,%buildPrefix%
													 ,'addl fares tax plus'
													 ,pVersion
													 ,''
													 ,%zaddlftaxPlusStats%
													 ,'view'
													 ,'Population');
					 
	//OUTPUT ADDL FARES DEED STATS 
	%dPopulationStats_paddlfdeed% := table(pAddlfdeed
																				,%rPopulationStats_paddlfdeed%
																				,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlfdeed%
													 ,%buildPrefix%
													 ,'addl fares deeds'
													 ,pVersion
													 ,''
													 ,%zaddlfdeedStats%
													 ,'view'
													 ,'Population');
											 
	%dPopulationStats_paddlfdeedPlus% := table(pAddlfdeed
																						,%rPopulationStats_paddlfdeedPlus%
																						,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlfdeedPlus%
													 ,%buildPrefix%
													 ,'addl fares deeds plus'
													 ,pVersion
													 ,''
													 ,%zaddlfdeedPlusStats%
													 ,'view'
													 ,'Population');

	//OUTPUT ADDL LEGAL STATS
 	%dPopulationStats_paddllegal% 		:= table(pAddllegal
																						,%rPopulationStats_paddllegal%
																						,few);
									  
	STRATA.createXMLStats(%dPopulationStats_paddllegal%
													 ,%buildPrefix%
													 ,'addl legal'
													 ,pVersion
													 ,''
													 ,%zaddllegalStats%
													 ,'view'
													 ,'Population');
					 
	//OUTPUT ADDL LEGAL NAMES STATS
 	%dPopulationStats_paddlnames% 		:= table(pAddlnames
																						,%rPopulationStats_paddlnames%
																						,few);
																				
	STRATA.createXMLStats(%dPopulationStats_paddlnames%
													 ,%buildPrefix%
													 ,'addl names'
													 ,pVersion
													 ,''
													 ,%zaddlnamesStats%
													 ,'view'
													 ,'Population');
													 
	//OUTPUT ADDL NAMES INFO STATS
/* 	%dPopulationStats_pAddlNameInfo% 		:= table(pAddlNameInfo
																						,%rPopulationStats_pAddlNameInfo%
																						,few);
																				
	STRATA.createXMLStats(%dPopulationStats_pAddlNameInfo%
													 ,%buildPrefix%
													 ,'addl name info'
													 ,pVersion
													 ,''
													 ,%zaddlNameInfoStats%
													 ,'view'
													 ,'Population');
*/					 				 
zOut := parallel(%zAssesStats%,%zAssesPlusStats%,%zPartyStats%,%zdeedStats%,%zaddlftaxStats%,%zaddlftaxPlusStats%,%zaddlfdeedStats%,%zaddlfdeedPlusStats%,%zaddllegalStats%,%zaddlnamesStats%/*,%zaddlNameInfoStats% */)

/*zOut := parallel(output(%dPopulationStats_pAsses%, named('assess')),
									output(%dPopulationStats_pAssesPlus%, named('assessPlus')),
									output(%dPopulationStats_pParty%, named('party')),
									output(%dPopulationStats_Pdeed%, named('deed')),
									output(%dPopulationStats_paddlftax%, named('addlTax')),
									output(%dPopulationStats_paddlftaxPlus%, named('addlTaxPlus')),
									output(%dPopulationStats_paddlfdeed%, named('addlDeed')),
									output(%dPopulationStats_paddlfdeedPlus%, named('addlDeedPlus')),
									output(%dPopulationStats_paddllegal%, named('addlLegal')),
									output(%dPopulationStats_paddlnames%, named('addlNames')));*/

ENDMACRO;