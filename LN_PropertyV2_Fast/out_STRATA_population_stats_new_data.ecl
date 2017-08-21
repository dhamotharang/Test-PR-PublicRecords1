export out_STRATA_population_stats_new_data(pAssess
																						,PDeed
																						,pVersion
																						,zOut
																						,isFast) := MACRO

import STRATA;

	#uniquename(buildPrefix);
	#uniquename(startProcessDate);
	#uniquename(whichAssess);
	#uniquename(whichDeed);

	#uniquename(rPopulationStats_pAsses);
	#uniquename(dPopulationStats_pAsses);
	#uniquename(rPopulationStats_pAssesPlus);
	#uniquename(dPopulationStats_pAssesPlus);
	#uniquename(rPopulationStats_Pdeed);
	#uniquename(dPopulationStats_Pdeed);
	
	#uniquename(zAssesStats);
	#uniquename(zAssesPlusStats);
	#uniquename(zdeedStats);
	
	//DETERMINE FULL OR DELTA FILE
		%buildPrefix% 			:= if(isFast, 'LN Property V2 Delta - New Data', 'LN Property V2 - New Data');		
		%startProcessDate% 	:= '';//if(isFast, MAX(MAX(pAssess, process_date), MAX(pDeed, process_date)),'');
		
		%whichAssess% 			:= pAssess;//if(isFast, pAssess(process_date>%startProcessDate%), pAssess);												 
		%whichDeed% 				:= pDeed;//if(isFast, pDeed(process_date>%startProcessDate%), pDeed);

	//TAX
	%rPopulationStats_pAsses% := record
			CountGroup                                                    := count(group);
			%whichAssess%.vendor_source_flag;
			ln_fares_id_CountNonBlank                                     := sum(group,if(%whichAssess%.ln_fares_id<>'',1,0));
			process_date_CountNonBlank                                    := sum(group,if(%whichAssess%.process_date<>'',1,0));
			vendor_source_flag_CountNonBlank                              := sum(group,if(%whichAssess%.vendor_source_flag<>'',1,0));
			current_record_CountNonBlank                                  := sum(group,if(%whichAssess%.current_record<>'',1,0));
			fips_code_CountNonBlank                                       := sum(group,if(%whichAssess%.fips_code<>'',1,0));
			state_code_CountNonBlank                                      := sum(group,if(%whichAssess%.state_code<>'',1,0));
			county_name_CountNonBlank                                     := sum(group,if(%whichAssess%.county_name<>'',1,0));
			apna_or_pin_number_CountNonBlank                              := sum(group,if(%whichAssess%.apna_or_pin_number<>'',1,0));
			fares_unformatted_apn_CountNonBlank                           := sum(group,if(%whichAssess%.fares_unformatted_apn<>'',1,0));
			duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(%whichAssess%.duplicate_apn_multiple_address_id<>'',1,0));
			assessee_name_CountNonBlank                                   := sum(group,if(%whichAssess%.assessee_name<>'',1,0));
			second_assessee_name_CountNonBlank                            := sum(group,if(%whichAssess%.second_assessee_name<>'',1,0));
			assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(%whichAssess%.assessee_ownership_rights_code<>'',1,0));
			assessee_relationship_code_CountNonBlank                      := sum(group,if(%whichAssess%.assessee_relationship_code<>'',1,0));
			assessee_phone_number_CountNonBlank                           := sum(group,if(%whichAssess%.assessee_phone_number<>'',1,0));
			tax_account_number_CountNonBlank                              := sum(group,if(%whichAssess%.tax_account_number<>'',1,0));
			contract_owner_CountNonBlank                                  := sum(group,if(%whichAssess%.contract_owner<>'',1,0));
			assessee_name_type_code_CountNonBlank                         := sum(group,if(%whichAssess%.assessee_name_type_code<>'',1,0));
			second_assessee_name_type_code_CountNonBlank                  := sum(group,if(%whichAssess%.second_assessee_name_type_code<>'',1,0));
			mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(%whichAssess%.mail_care_of_name_type_code<>'',1,0));
			mailing_care_of_name_CountNonBlank                            := sum(group,if(%whichAssess%.mailing_care_of_name<>'',1,0));
			mailing_full_street_address_CountNonBlank                     := sum(group,if(%whichAssess%.mailing_full_street_address<>'',1,0));
			mailing_unit_number_CountNonBlank                             := sum(group,if(%whichAssess%.mailing_unit_number<>'',1,0));
			mailing_city_state_zip_CountNonBlank                          := sum(group,if(%whichAssess%.mailing_city_state_zip<>'',1,0));
			property_full_street_address_CountNonBlank                    := sum(group,if(%whichAssess%.property_full_street_address<>'',1,0));
			property_unit_number_CountNonBlank                            := sum(group,if(%whichAssess%.property_unit_number<>'',1,0));
			property_city_state_zip_CountNonBlank                         := sum(group,if(%whichAssess%.property_city_state_zip<>'',1,0));
			property_country_code_CountNonBlank                           := sum(group,if(%whichAssess%.property_country_code<>'',1,0));
			property_address_code_CountNonBlank                           := sum(group,if(%whichAssess%.property_address_code<>'',1,0));
			legal_lot_code_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_lot_code<>'',1,0));
			legal_lot_number_CountNonBlank                                := sum(group,if(%whichAssess%.legal_lot_number<>'',1,0));
			legal_land_lot_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_land_lot<>'',1,0));
			legal_block_CountNonBlank                                     := sum(group,if(%whichAssess%.legal_block<>'',1,0));
			legal_section_CountNonBlank                                   := sum(group,if(%whichAssess%.legal_section<>'',1,0));
			legal_district_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_district<>'',1,0));
			legal_unit_CountNonBlank                                      := sum(group,if(%whichAssess%.legal_unit<>'',1,0));
			legal_city_municipality_township_CountNonBlank                := sum(group,if(%whichAssess%.legal_city_municipality_township<>'',1,0));
			legal_subdivision_name_CountNonBlank                          := sum(group,if(%whichAssess%.legal_subdivision_name<>'',1,0));
			legal_phase_number_CountNonBlank                              := sum(group,if(%whichAssess%.legal_phase_number<>'',1,0));
			legal_tract_number_CountNonBlank                              := sum(group,if(%whichAssess%.legal_tract_number<>'',1,0));
			legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(%whichAssess%.legal_sec_twn_rng_mer<>'',1,0));
			legal_brief_description_CountNonBlank                         := sum(group,if(%whichAssess%.legal_brief_description<>'',1,0));
			legal_assessor_map_ref_CountNonBlank                          := sum(group,if(%whichAssess%.legal_assessor_map_ref<>'',1,0));
			census_tract_CountNonBlank                                    := sum(group,if(%whichAssess%.census_tract<>'',1,0));
			record_type_code_CountNonBlank                                := sum(group,if(%whichAssess%.record_type_code<>'',1,0));
			ownership_type_code_CountNonBlank                             := sum(group,if(%whichAssess%.ownership_type_code<>'',1,0));
			new_record_type_code_CountNonBlank                            := sum(group,if(%whichAssess%.new_record_type_code<>'',1,0));
			county_land_use_code_CountNonBlank                            := sum(group,if(%whichAssess%.county_land_use_code<>'',1,0));
			county_land_use_description_CountNonBlank                     := sum(group,if(%whichAssess%.county_land_use_description<>'',1,0));
			standardized_land_use_code_CountNonBlank                      := sum(group,if(%whichAssess%.standardized_land_use_code<>'',1,0));
			timeshare_code_CountNonBlank                                  := sum(group,if(%whichAssess%.timeshare_code<>'',1,0));
			zoning_CountNonBlank                                          := sum(group,if(%whichAssess%.zoning<>'',1,0));
			owner_occupied_CountNonBlank                                  := sum(group,if(%whichAssess%.owner_occupied<>'',1,0));
			recorder_document_number_CountNonBlank                        := sum(group,if(%whichAssess%.recorder_document_number<>'',1,0));
			recorder_book_number_CountNonBlank                            := sum(group,if(%whichAssess%.recorder_book_number<>'',1,0));
			recorder_page_number_CountNonBlank                            := sum(group,if(%whichAssess%.recorder_page_number<>'',1,0));
			transfer_date_CountNonBlank                                   := sum(group,if(%whichAssess%.transfer_date<>'',1,0));
			recording_date_CountNonBlank                                  := sum(group,if(%whichAssess%.recording_date<>'',1,0));
			sale_date_CountNonBlank                                       := sum(group,if(%whichAssess%.sale_date<>'',1,0));
			document_type_CountNonBlank                                   := sum(group,if(%whichAssess%.document_type<>'',1,0));
			sales_price_CountNonBlank                                     := sum(group,if(%whichAssess%.sales_price<>'',1,0));
			sales_price_code_CountNonBlank                                := sum(group,if(%whichAssess%.sales_price_code<>'',1,0));
			mortgage_loan_amount_CountNonBlank                            := sum(group,if(%whichAssess%.mortgage_loan_amount<>'',1,0));
			mortgage_loan_type_code_CountNonBlank                         := sum(group,if(%whichAssess%.mortgage_loan_type_code<>'',1,0));
			mortgage_lender_name_CountNonBlank                            := sum(group,if(%whichAssess%.mortgage_lender_name<>'',1,0));
			mortgage_lender_type_code_CountNonBlank                       := sum(group,if(%whichAssess%.mortgage_lender_type_code<>'',1,0));
			prior_transfer_date_CountNonBlank                             := sum(group,if(%whichAssess%.prior_transfer_date<>'',1,0));
			prior_recording_date_CountNonBlank                            := sum(group,if(%whichAssess%.prior_recording_date<>'',1,0));
			prior_sales_price_CountNonBlank                               := sum(group,if(%whichAssess%.prior_sales_price<>'',1,0));
			prior_sales_price_code_CountNonBlank                          := sum(group,if(%whichAssess%.prior_sales_price_code<>'',1,0));
			assessed_land_value_CountNonBlank                             := sum(group,if(%whichAssess%.assessed_land_value<>'',1,0));
			assessed_improvement_value_CountNonBlank                      := sum(group,if(%whichAssess%.assessed_improvement_value<>'',1,0));
			assessed_total_value_CountNonBlank                            := sum(group,if(%whichAssess%.assessed_total_value<>'',1,0));
			assessed_value_year_CountNonBlank                             := sum(group,if(%whichAssess%.assessed_value_year<>'',1,0));
			market_land_value_CountNonBlank                               := sum(group,if(%whichAssess%.market_land_value<>'',1,0));
			market_improvement_value_CountNonBlank                        := sum(group,if(%whichAssess%.market_improvement_value<>'',1,0));
			market_total_value_CountNonBlank                              := sum(group,if(%whichAssess%.market_total_value<>'',1,0));
			market_value_year_CountNonBlank                               := sum(group,if(%whichAssess%.market_value_year<>'',1,0));
			homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(%whichAssess%.homestead_homeowner_exemption<>'',1,0));
			tax_exemption1_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption1_code<>'',1,0));
			tax_exemption2_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption2_code<>'',1,0));
			tax_exemption3_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption3_code<>'',1,0));
			tax_exemption4_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption4_code<>'',1,0));
			tax_rate_code_area_CountNonBlank                              := sum(group,if(%whichAssess%.tax_rate_code_area<>'',1,0));
			tax_amount_CountNonBlank                                      := sum(group,if(%whichAssess%.tax_amount<>'',1,0));
			tax_year_CountNonBlank                                        := sum(group,if(%whichAssess%.tax_year<>'',1,0));
			tax_delinquent_year_CountNonBlank                             := sum(group,if(%whichAssess%.tax_delinquent_year<>'',1,0));
			school_tax_district1_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district1<>'',1,0));
			school_tax_district1_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district1_indicator<>'',1,0));
			school_tax_district2_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district2<>'',1,0));
			school_tax_district2_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district2_indicator<>'',1,0));
			school_tax_district3_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district3<>'',1,0));
			school_tax_district3_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district3_indicator<>'',1,0));
			land_acres_CountNonBlank                                      := sum(group,if(%whichAssess%.land_acres<>'',1,0));
			land_square_footage_CountNonBlank                             := sum(group,if(%whichAssess%.land_square_footage<>'',1,0));
			land_dimensions_CountNonBlank                                 := sum(group,if(%whichAssess%.land_dimensions<>'',1,0));
			building_area_CountNonBlank                                   := sum(group,if(%whichAssess%.building_area<>'',1,0));
			building_area_indicator_CountNonBlank                         := sum(group,if(%whichAssess%.building_area_indicator<>'',1,0));
			building_area1_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area1<>'',1,0));
			building_area1_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area1_indicator<>'',1,0));
			building_area2_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area2<>'',1,0));
			building_area2_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area2_indicator<>'',1,0));
			building_area3_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area3<>'',1,0));
			building_area3_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area3_indicator<>'',1,0));
			building_area4_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area4<>'',1,0));
			building_area4_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area4_indicator<>'',1,0));
			building_area5_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area5<>'',1,0));
			building_area5_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area5_indicator<>'',1,0));
			building_area6_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area6<>'',1,0));
			building_area6_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area6_indicator<>'',1,0));
			building_area7_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area7<>'',1,0));
			building_area7_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area7_indicator<>'',1,0));
			year_built_CountNonBlank                                      := sum(group,if(%whichAssess%.year_built<>'',1,0));
			effective_year_built_CountNonBlank                            := sum(group,if(%whichAssess%.effective_year_built<>'',1,0));
			no_of_buildings_CountNonBlank                                 := sum(group,if(%whichAssess%.no_of_buildings<>'',1,0));
			no_of_stories_CountNonBlank                                   := sum(group,if(%whichAssess%.no_of_stories<>'',1,0));
			no_of_units_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_units<>'',1,0));
			no_of_rooms_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_rooms<>'',1,0));
			no_of_bedrooms_CountNonBlank                                  := sum(group,if(%whichAssess%.no_of_bedrooms<>'',1,0));
			no_of_baths_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_baths<>'',1,0));
			no_of_partial_baths_CountNonBlank                             := sum(group,if(%whichAssess%.no_of_partial_baths<>'',1,0));
			garage_type_code_CountNonBlank                                := sum(group,if(%whichAssess%.garage_type_code<>'',1,0));
			parking_no_of_cars_CountNonBlank                              := sum(group,if(%whichAssess%.parking_no_of_cars<>'',1,0));
			pool_code_CountNonBlank                                       := sum(group,if(%whichAssess%.pool_code<>'',1,0));
			style_code_CountNonBlank                                      := sum(group,if(%whichAssess%.style_code<>'',1,0));
			type_construction_code_CountNonBlank                          := sum(group,if(%whichAssess%.type_construction_code<>'',1,0));
			exterior_walls_code_CountNonBlank                             := sum(group,if(%whichAssess%.exterior_walls_code<>'',1,0));
			foundation_code_CountNonBlank                                 := sum(group,if(%whichAssess%.foundation_code<>'',1,0));
			roof_cover_code_CountNonBlank                                 := sum(group,if(%whichAssess%.roof_cover_code<>'',1,0));
			roof_type_code_CountNonBlank                                  := sum(group,if(%whichAssess%.roof_type_code<>'',1,0));
			heating_code_CountNonBlank                                    := sum(group,if(%whichAssess%.heating_code<>'',1,0));
			heating_fuel_type_code_CountNonBlank                          := sum(group,if(%whichAssess%.heating_fuel_type_code<>'',1,0));
			air_conditioning_code_CountNonBlank                           := sum(group,if(%whichAssess%.air_conditioning_code<>'',1,0));
			air_conditioning_type_code_CountNonBlank                      := sum(group,if(%whichAssess%.air_conditioning_type_code<>'',1,0));
			elevator_CountNonBlank                                        := sum(group,if(%whichAssess%.elevator<>'',1,0));
			fireplace_indicator_CountNonBlank                             := sum(group,if(%whichAssess%.fireplace_indicator<>'',1,0));
			fireplace_number_CountNonBlank                                := sum(group,if(%whichAssess%.fireplace_number<>'',1,0));
			basement_code_CountNonBlank                                   := sum(group,if(%whichAssess%.basement_code<>'',1,0));
			building_class_code_CountNonBlank                             := sum(group,if(%whichAssess%.building_class_code<>'',1,0));
			site_influence1_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence1_code<>'',1,0));
			site_influence2_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence2_code<>'',1,0));
			site_influence3_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence3_code<>'',1,0));
			site_influence4_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence4_code<>'',1,0));
			site_influence5_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence5_code<>'',1,0));
			amenities1_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities1_code<>'',1,0));
			amenities2_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities2_code<>'',1,0));
			amenities3_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities3_code<>'',1,0));
			amenities4_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities4_code<>'',1,0));
			amenities5_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities5_code<>'',1,0));
			other_buildings1_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings1_code<>'',1,0));
			other_buildings2_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings2_code<>'',1,0));
			other_buildings3_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings3_code<>'',1,0));
			other_buildings4_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings4_code<>'',1,0));
			other_buildings5_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings5_code<>'',1,0));
			neighborhood_code_CountNonBlank                               := sum(group,if(%whichAssess%.neighborhood_code<>'',1,0));
			condo_project_name_CountNonBlank                              := sum(group,if(%whichAssess%.condo_project_or_building_name<>'',1,0));
			building_name_CountNonBlank                                   := sum(group,if(%whichAssess%.condo_project_or_building_name<>'',1,0));
			assessee_name_indicator_CountNonBlank                         := sum(group,if(%whichAssess%.assessee_name_indicator<>'',1,0));
			second_assessee_name_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.second_assessee_name_indicator<>'',1,0));
			mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(%whichAssess%.mail_care_of_name_indicator<>'',1,0));
			comments_CountNonBlank                                        := sum(group,if(%whichAssess%.comments<>'',1,0));
			tape_cut_date_CountNonBlank                                   := sum(group,if(%whichAssess%.tape_cut_date<>'',1,0));
			certification_date_CountNonBlank                              := sum(group,if(%whichAssess%.certification_date<>'',1,0));
			edition_number_CountNonBlank                                  := sum(group,if(%whichAssess%.edition_number<>'',1,0));
			prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(%whichAssess%.prop_addr_propagated_ind<>'',1,0));
			ln_ownership_rights_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_ownership_rights<>'',1,0));
			ln_relationship_type_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_relationship_type<>'',1,0));
			ln_mailing_country_code_CountNonBlank 												:= sum(group,if(%whichAssess%.ln_mailing_country_code<>'',1,0));
			ln_property_name_CountNonBlank 																:= sum(group,if(%whichAssess%.ln_property_name<>'',1,0));
			ln_property_name_type_CountNonBlank 													:= sum(group,if(%whichAssess%.ln_property_name_type<>'',1,0));
			ln_land_use_category_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_land_use_category<>'',1,0));
			ln_lot_CountNonBlank 																					:= sum(group,if(%whichAssess%.ln_lot<>'',1,0));
			ln_block_CountNonBlank 																				:= sum(group,if(%whichAssess%.ln_block<>'',1,0));
			ln_unit_CountNonBlank 																				:= sum(group,if(%whichAssess%.ln_unit<>'',1,0));
			ln_subfloor_CountNonBlank 																		:= sum(group,if(%whichAssess%.ln_subfloor<>'',1,0));
			ln_floor_cover_CountNonBlank 																	:= sum(group,if(%whichAssess%.ln_floor_cover<>'',1,0));
			ln_mobile_home_indicator_CountNonBlank 												:= sum(group,if(%whichAssess%.ln_mobile_home_indicator<>'',1,0));
			ln_condo_indicator_CountNonBlank 															:= sum(group,if(%whichAssess%.ln_condo_indicator<>'',1,0));
			ln_property_tax_exemption_CountNonBlank 											:= sum(group,if(%whichAssess%.ln_property_tax_exemption<>'',1,0));
			ln_veteran_status_CountNonBlank 															:= sum(group,if(%whichAssess%.ln_veteran_status<>'',1,0));
			ln_old_apn_indicator_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_old_apn_indicator<>'',1,0));
	end;

	%rPopulationStats_pAssesPlus% := record
			CountGroup                                                    := count(group);
			%whichAssess%.vendor_source_flag;
			ln_fares_id_CountNonBlank                                     := sum(group,if(%whichAssess%.ln_fares_id<>'',1,0));
			process_date_CountNonBlank                                    := sum(group,if(%whichAssess%.process_date<>'',1,0));
			vendor_source_flag_CountNonBlank                              := sum(group,if(%whichAssess%.vendor_source_flag<>'',1,0));
			current_record_CountNonBlank                                  := sum(group,if(%whichAssess%.current_record<>'',1,0));
			fips_code_CountNonBlank                                       := sum(group,if(%whichAssess%.fips_code<>'',1,0));
			state_code_CountNonBlank                                      := sum(group,if(%whichAssess%.state_code<>'',1,0));
			county_name_CountNonBlank                                     := sum(group,if(%whichAssess%.county_name<>'',1,0));
			apna_or_pin_number_CountNonBlank                              := sum(group,if(%whichAssess%.apna_or_pin_number<>'',1,0));
			fares_unformatted_apn_CountNonBlank                           := sum(group,if(%whichAssess%.fares_unformatted_apn<>'',1,0));
			duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(%whichAssess%.duplicate_apn_multiple_address_id<>'',1,0));
			assessee_name_CountNonBlank                                   := sum(group,if(%whichAssess%.assessee_name<>'',1,0));
			second_assessee_name_CountNonBlank                            := sum(group,if(%whichAssess%.second_assessee_name<>'',1,0));
			assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(%whichAssess%.assessee_ownership_rights_code<>'',1,0));
			assessee_relationship_code_CountNonBlank                      := sum(group,if(%whichAssess%.assessee_relationship_code<>'',1,0));
			assessee_phone_number_CountNonBlank                           := sum(group,if(%whichAssess%.assessee_phone_number<>'',1,0));
			tax_account_number_CountNonBlank                              := sum(group,if(%whichAssess%.tax_account_number<>'',1,0));
			contract_owner_CountNonBlank                                  := sum(group,if(%whichAssess%.contract_owner<>'',1,0));
			assessee_name_type_code_CountNonBlank                         := sum(group,if(%whichAssess%.assessee_name_type_code<>'',1,0));
			second_assessee_name_type_code_CountNonBlank                  := sum(group,if(%whichAssess%.second_assessee_name_type_code<>'',1,0));
			mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(%whichAssess%.mail_care_of_name_type_code<>'',1,0));
			mailing_care_of_name_CountNonBlank                            := sum(group,if(%whichAssess%.mailing_care_of_name<>'',1,0));
			mailing_full_street_address_CountNonBlank                     := sum(group,if(%whichAssess%.mailing_full_street_address<>'',1,0));
			mailing_unit_number_CountNonBlank                             := sum(group,if(%whichAssess%.mailing_unit_number<>'',1,0));
			mailing_city_state_zip_CountNonBlank                          := sum(group,if(%whichAssess%.mailing_city_state_zip<>'',1,0));
			property_full_street_address_CountNonBlank                    := sum(group,if(%whichAssess%.property_full_street_address<>'',1,0));
			property_unit_number_CountNonBlank                            := sum(group,if(%whichAssess%.property_unit_number<>'',1,0));
			property_city_state_zip_CountNonBlank                         := sum(group,if(%whichAssess%.property_city_state_zip<>'',1,0));
			property_country_code_CountNonBlank                           := sum(group,if(%whichAssess%.property_country_code<>'',1,0));
			property_address_code_CountNonBlank                           := sum(group,if(%whichAssess%.property_address_code<>'',1,0));
			legal_lot_code_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_lot_code<>'',1,0));
			legal_lot_number_CountNonBlank                                := sum(group,if(%whichAssess%.legal_lot_number<>'',1,0));
			legal_land_lot_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_land_lot<>'',1,0));
			legal_block_CountNonBlank                                     := sum(group,if(%whichAssess%.legal_block<>'',1,0));
			legal_section_CountNonBlank                                   := sum(group,if(%whichAssess%.legal_section<>'',1,0));
			legal_district_CountNonBlank                                  := sum(group,if(%whichAssess%.legal_district<>'',1,0));
			legal_unit_CountNonBlank                                      := sum(group,if(%whichAssess%.legal_unit<>'',1,0));
			legal_city_municipality_township_CountNonBlank                := sum(group,if(%whichAssess%.legal_city_municipality_township<>'',1,0));
			legal_subdivision_name_CountNonBlank                          := sum(group,if(%whichAssess%.legal_subdivision_name<>'',1,0));
			legal_phase_number_CountNonBlank                              := sum(group,if(%whichAssess%.legal_phase_number<>'',1,0));
			legal_tract_number_CountNonBlank                              := sum(group,if(%whichAssess%.legal_tract_number<>'',1,0));
			legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(%whichAssess%.legal_sec_twn_rng_mer<>'',1,0));
			legal_brief_description_CountNonBlank                         := sum(group,if(%whichAssess%.legal_brief_description<>'',1,0));
			legal_assessor_map_ref_CountNonBlank                          := sum(group,if(%whichAssess%.legal_assessor_map_ref<>'',1,0));
			census_tract_CountNonBlank                                    := sum(group,if(%whichAssess%.census_tract<>'',1,0));
			record_type_code_CountNonBlank                                := sum(group,if(%whichAssess%.record_type_code<>'',1,0));
			ownership_type_code_CountNonBlank                             := sum(group,if(%whichAssess%.ownership_type_code<>'',1,0));
			new_record_type_code_CountNonBlank                            := sum(group,if(%whichAssess%.new_record_type_code<>'',1,0));
			county_land_use_code_CountNonBlank                            := sum(group,if(%whichAssess%.county_land_use_code<>'',1,0));
			county_land_use_description_CountNonBlank                     := sum(group,if(%whichAssess%.county_land_use_description<>'',1,0));
			standardized_land_use_code_CountNonBlank                      := sum(group,if(%whichAssess%.standardized_land_use_code<>'',1,0));
			timeshare_code_CountNonBlank                                  := sum(group,if(%whichAssess%.timeshare_code<>'',1,0));
			zoning_CountNonBlank                                          := sum(group,if(%whichAssess%.zoning<>'',1,0));
			owner_occupied_CountNonBlank                                  := sum(group,if(%whichAssess%.owner_occupied<>'',1,0));
			recorder_document_number_CountNonBlank                        := sum(group,if(%whichAssess%.recorder_document_number<>'',1,0));
			recorder_book_number_CountNonBlank                            := sum(group,if(%whichAssess%.recorder_book_number<>'',1,0));
			recorder_page_number_CountNonBlank                            := sum(group,if(%whichAssess%.recorder_page_number<>'',1,0));
			transfer_date_CountNonBlank                                   := sum(group,if(%whichAssess%.transfer_date<>'',1,0));
			recording_date_CountNonBlank                                  := sum(group,if(%whichAssess%.recording_date<>'',1,0));
			sale_date_CountNonBlank                                       := sum(group,if(%whichAssess%.sale_date<>'',1,0));
			document_type_CountNonBlank                                   := sum(group,if(%whichAssess%.document_type<>'',1,0));
			sales_price_CountNonBlank                                     := sum(group,if(%whichAssess%.sales_price<>'',1,0));
			sales_price_code_CountNonBlank                                := sum(group,if(%whichAssess%.sales_price_code<>'',1,0));
			mortgage_loan_amount_CountNonBlank                            := sum(group,if(%whichAssess%.mortgage_loan_amount<>'',1,0));
			mortgage_loan_type_code_CountNonBlank                         := sum(group,if(%whichAssess%.mortgage_loan_type_code<>'',1,0));
			mortgage_lender_name_CountNonBlank                            := sum(group,if(%whichAssess%.mortgage_lender_name<>'',1,0));
			mortgage_lender_type_code_CountNonBlank                       := sum(group,if(%whichAssess%.mortgage_lender_type_code<>'',1,0));
			prior_transfer_date_CountNonBlank                             := sum(group,if(%whichAssess%.prior_transfer_date<>'',1,0));
			prior_recording_date_CountNonBlank                            := sum(group,if(%whichAssess%.prior_recording_date<>'',1,0));
			prior_sales_price_CountNonBlank                               := sum(group,if(%whichAssess%.prior_sales_price<>'',1,0));
			prior_sales_price_code_CountNonBlank                          := sum(group,if(%whichAssess%.prior_sales_price_code<>'',1,0));
			assessed_land_value_CountNonBlank                             := sum(group,if(%whichAssess%.assessed_land_value<>'',1,0));
			assessed_improvement_value_CountNonBlank                      := sum(group,if(%whichAssess%.assessed_improvement_value<>'',1,0));
			assessed_total_value_CountNonBlank                            := sum(group,if(%whichAssess%.assessed_total_value<>'',1,0));
			assessed_value_year_CountNonBlank                             := sum(group,if(%whichAssess%.assessed_value_year<>'',1,0));
			market_land_value_CountNonBlank                               := sum(group,if(%whichAssess%.market_land_value<>'',1,0));
			market_improvement_value_CountNonBlank                        := sum(group,if(%whichAssess%.market_improvement_value<>'',1,0));
			market_total_value_CountNonBlank                              := sum(group,if(%whichAssess%.market_total_value<>'',1,0));
			market_value_year_CountNonBlank                               := sum(group,if(%whichAssess%.market_value_year<>'',1,0));
			homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(%whichAssess%.homestead_homeowner_exemption<>'',1,0));
			tax_exemption1_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption1_code<>'',1,0));
			tax_exemption2_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption2_code<>'',1,0));
			tax_exemption3_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption3_code<>'',1,0));
			tax_exemption4_code_CountNonBlank                             := sum(group,if(%whichAssess%.tax_exemption4_code<>'',1,0));
			tax_rate_code_area_CountNonBlank                              := sum(group,if(%whichAssess%.tax_rate_code_area<>'',1,0));
			tax_amount_CountNonBlank                                      := sum(group,if(%whichAssess%.tax_amount<>'',1,0));
			tax_year_CountNonBlank                                        := sum(group,if(%whichAssess%.tax_year<>'',1,0));
			tax_delinquent_year_CountNonBlank                             := sum(group,if(%whichAssess%.tax_delinquent_year<>'',1,0));
			school_tax_district1_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district1<>'',1,0));
			school_tax_district1_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district1_indicator<>'',1,0));
			school_tax_district2_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district2<>'',1,0));
			school_tax_district2_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district2_indicator<>'',1,0));
			school_tax_district3_CountNonBlank                            := sum(group,if(%whichAssess%.school_tax_district3<>'',1,0));
			school_tax_district3_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.school_tax_district3_indicator<>'',1,0));
			lot_size_CountNonBlank																				:= sum(group,if(%whichAssess%.lot_size<>'',1,0));
			lot_size_acres_CountNonBlank																	:= sum(group,if(%whichAssess%.lot_size_acres<>'',1,0));
			lot_size_frontage_feet_CountNonBlank													:= sum(group,if(%whichAssess%.lot_size_frontage_feet<>'',1,0));
			lot_size_depth_feet_CountNonBlank															:= sum(group,if(%whichAssess%.lot_size_depth_feet<>'',1,0));
			land_acres_CountNonBlank                                      := sum(group,if(%whichAssess%.land_acres<>'',1,0));
			land_square_footage_CountNonBlank                             := sum(group,if(%whichAssess%.land_square_footage<>'',1,0));
			land_dimensions_CountNonBlank                                 := sum(group,if(%whichAssess%.land_dimensions<>'',1,0));
			building_area_CountNonBlank                                   := sum(group,if(%whichAssess%.building_area<>'',1,0));
			building_area_indicator_CountNonBlank                         := sum(group,if(%whichAssess%.building_area_indicator<>'',1,0));
			building_area1_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area1<>'',1,0));
			building_area1_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area1_indicator<>'',1,0));
			building_area2_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area2<>'',1,0));
			building_area2_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area2_indicator<>'',1,0));
			building_area3_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area3<>'',1,0));
			building_area3_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area3_indicator<>'',1,0));
			building_area4_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area4<>'',1,0));
			building_area4_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area4_indicator<>'',1,0));
			building_area5_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area5<>'',1,0));
			building_area5_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area5_indicator<>'',1,0));
			building_area6_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area6<>'',1,0));
			building_area6_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area6_indicator<>'',1,0));
			building_area7_CountNonBlank                                  := sum(group,if(%whichAssess%.building_area7<>'',1,0));
			building_area7_indicator_CountNonBlank                        := sum(group,if(%whichAssess%.building_area7_indicator<>'',1,0));
			year_built_CountNonBlank                                      := sum(group,if(%whichAssess%.year_built<>'',1,0));
			effective_year_built_CountNonBlank                            := sum(group,if(%whichAssess%.effective_year_built<>'',1,0));
			no_of_buildings_CountNonBlank                                 := sum(group,if(%whichAssess%.no_of_buildings<>'',1,0));
			no_of_stories_CountNonBlank                                   := sum(group,if(%whichAssess%.no_of_stories<>'',1,0));
			no_of_units_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_units<>'',1,0));
			no_of_rooms_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_rooms<>'',1,0));
			no_of_bedrooms_CountNonBlank                                  := sum(group,if(%whichAssess%.no_of_bedrooms<>'',1,0));
			no_of_baths_CountNonBlank                                     := sum(group,if(%whichAssess%.no_of_baths<>'',1,0));
			no_of_partial_baths_CountNonBlank                             := sum(group,if(%whichAssess%.no_of_partial_baths<>'',1,0));
			no_of_plumbing_fixtures_CountNonBlank                         := sum(group,if(%whichAssess%.no_of_plumbing_fixtures<>'',1,0));
			garage_type_code_CountNonBlank                                := sum(group,if(%whichAssess%.garage_type_code<>'',1,0));
			parking_no_of_cars_CountNonBlank                              := sum(group,if(%whichAssess%.parking_no_of_cars<>'',1,0));
			pool_code_CountNonBlank                                       := sum(group,if(%whichAssess%.pool_code<>'',1,0));
			style_code_CountNonBlank                                      := sum(group,if(%whichAssess%.style_code<>'',1,0));
			type_construction_code_CountNonBlank                          := sum(group,if(%whichAssess%.type_construction_code<>'',1,0));
			exterior_walls_code_CountNonBlank                             := sum(group,if(%whichAssess%.exterior_walls_code<>'',1,0));
			foundation_code_CountNonBlank                                 := sum(group,if(%whichAssess%.foundation_code<>'',1,0));
			building_quality_code_CountNonBlank                           := sum(group,if(%whichAssess%.building_quality_code<>'',1,0));
			building_condition_code_CountNonBlank                         := sum(group,if(%whichAssess%.building_condition_code<>'',1,0));
			interior_walls_code_CountNonBlank                             := sum(group,if(%whichAssess%.interior_walls_code<>'',1,0));
			roof_cover_code_CountNonBlank                                 := sum(group,if(%whichAssess%.roof_cover_code<>'',1,0));
			roof_type_code_CountNonBlank                                  := sum(group,if(%whichAssess%.roof_type_code<>'',1,0));
			floor_cover_code_CountNonBlank                                := sum(group,if(%whichAssess%.floor_cover_code<>'',1,0));
			water_code_CountNonBlank                                			:= sum(group,if(%whichAssess%.water_code<>'',1,0));
			sewer_code_CountNonBlank                                			:= sum(group,if(%whichAssess%.sewer_code<>'',1,0));
			heating_code_CountNonBlank                                    := sum(group,if(%whichAssess%.heating_code<>'',1,0));
			heating_fuel_type_code_CountNonBlank                          := sum(group,if(%whichAssess%.heating_fuel_type_code<>'',1,0));
			air_conditioning_code_CountNonBlank                           := sum(group,if(%whichAssess%.air_conditioning_code<>'',1,0));
			air_conditioning_type_code_CountNonBlank                      := sum(group,if(%whichAssess%.air_conditioning_type_code<>'',1,0));
			elevator_CountNonBlank                                        := sum(group,if(%whichAssess%.elevator<>'',1,0));
			fireplace_indicator_CountNonBlank                             := sum(group,if(%whichAssess%.fireplace_indicator<>'',1,0));
			fireplace_number_CountNonBlank                                := sum(group,if(%whichAssess%.fireplace_number<>'',1,0));
			basement_code_CountNonBlank                                   := sum(group,if(%whichAssess%.basement_code<>'',1,0));
			building_class_code_CountNonBlank                             := sum(group,if(%whichAssess%.building_class_code<>'',1,0));
			site_influence1_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence1_code<>'',1,0));
			site_influence2_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence2_code<>'',1,0));
			site_influence3_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence3_code<>'',1,0));
			site_influence4_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence4_code<>'',1,0));
			site_influence5_code_CountNonBlank                            := sum(group,if(%whichAssess%.site_influence5_code<>'',1,0));
			amenities1_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities1_code<>'',1,0));
			amenities2_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities2_code<>'',1,0));
			amenities3_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities3_code<>'',1,0));
			amenities4_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities4_code<>'',1,0));
			amenities5_code_CountNonBlank                                 := sum(group,if(%whichAssess%.amenities5_code<>'',1,0));
			amenities2_code1_CountNonBlank                                := sum(group,if(%whichAssess%.amenities2_code1<>'',1,0));
			amenities2_code2_CountNonBlank                                := sum(group,if(%whichAssess%.amenities2_code2<>'',1,0));
			amenities2_code3_CountNonBlank                                := sum(group,if(%whichAssess%.amenities2_code3<>'',1,0));
			amenities2_code4_CountNonBlank                                := sum(group,if(%whichAssess%.amenities2_code4<>'',1,0));
			amenities2_code5_CountNonBlank                                := sum(group,if(%whichAssess%.amenities2_code5<>'',1,0));
			extra_features1_area_CountNonBlank                            := sum(group,if(%whichAssess%.extra_features1_area<>'',1,0));
			extra_features1_indicator_CountNonBlank                       := sum(group,if(%whichAssess%.extra_features1_indicator<>'',1,0));
			extra_features2_area_CountNonBlank                            := sum(group,if(%whichAssess%.extra_features2_area<>'',1,0));
			extra_features2_indicator_CountNonBlank                       := sum(group,if(%whichAssess%.extra_features2_indicator<>'',1,0));
			extra_features3_area_CountNonBlank                            := sum(group,if(%whichAssess%.extra_features3_area<>'',1,0));
			extra_features3_indicator_CountNonBlank                       := sum(group,if(%whichAssess%.extra_features3_indicator<>'',1,0));
			extra_features4_area_CountNonBlank                            := sum(group,if(%whichAssess%.extra_features4_area<>'',1,0));
			extra_features4_indicator_CountNonBlank                       := sum(group,if(%whichAssess%.extra_features4_indicator<>'',1,0));
			other_buildings1_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings1_code<>'',1,0));
			other_buildings2_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings2_code<>'',1,0));
			other_buildings3_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings3_code<>'',1,0));
			other_buildings4_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings4_code<>'',1,0));
			other_buildings5_code_CountNonBlank                           := sum(group,if(%whichAssess%.other_buildings5_code<>'',1,0));
			other_impr_building1_indicator_CountNonBlank									:= sum(group,if(%whichAssess%.other_impr_building1_indicator<>'',1,0));
			other_impr_building2_indicator_CountNonBlank									:= sum(group,if(%whichAssess%.other_impr_building2_indicator<>'',1,0));
			other_impr_building3_indicator_CountNonBlank									:= sum(group,if(%whichAssess%.other_impr_building3_indicator<>'',1,0));
			other_impr_building4_indicator_CountNonBlank									:= sum(group,if(%whichAssess%.other_impr_building4_indicator<>'',1,0));
			other_impr_building5_indicator_CountNonBlank									:= sum(group,if(%whichAssess%.other_impr_building5_indicator<>'',1,0));
			other_impr_building_area1_CountNonBlank												:= sum(group,if(%whichAssess%.other_impr_building_area1<>'',1,0));
			other_impr_building_area2_CountNonBlank												:= sum(group,if(%whichAssess%.other_impr_building_area2<>'',1,0));
			other_impr_building_area3_CountNonBlank												:= sum(group,if(%whichAssess%.other_impr_building_area3<>'',1,0));
			other_impr_building_area4_CountNonBlank												:= sum(group,if(%whichAssess%.other_impr_building_area4<>'',1,0));
			other_impr_building_area5_CountNonBlank												:= sum(group,if(%whichAssess%.other_impr_building_area5<>'',1,0));
			topography_code_CountNonBlank                               	:= sum(group,if(%whichAssess%.topograpy_code<>'',1,0));
			neighborhood_code_CountNonBlank                               := sum(group,if(%whichAssess%.neighborhood_code<>'',1,0));
			condo_project_or_building_name_CountNonBlank                  := sum(group,if(%whichAssess%.condo_project_or_building_name<>'',1,0));
			assessee_name_indicator_CountNonBlank                         := sum(group,if(%whichAssess%.assessee_name_indicator<>'',1,0));
			second_assessee_name_indicator_CountNonBlank                  := sum(group,if(%whichAssess%.second_assessee_name_indicator<>'',1,0));
			mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(%whichAssess%.mail_care_of_name_indicator<>'',1,0));
			comments_CountNonBlank                                        := sum(group,if(%whichAssess%.comments<>'',1,0));
			tape_cut_date_CountNonBlank                                   := sum(group,if(%whichAssess%.tape_cut_date<>'',1,0));
			certification_date_CountNonBlank                              := sum(group,if(%whichAssess%.certification_date<>'',1,0));
			edition_number_CountNonBlank                                  := sum(group,if(%whichAssess%.edition_number<>'',1,0));
			prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(%whichAssess%.prop_addr_propagated_ind<>'',1,0));
			ln_ownership_rights_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_ownership_rights<>'',1,0));
			ln_relationship_type_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_relationship_type<>'',1,0));
			ln_mailing_country_code_CountNonBlank 												:= sum(group,if(%whichAssess%.ln_mailing_country_code<>'',1,0));
			ln_property_name_CountNonBlank 																:= sum(group,if(%whichAssess%.ln_property_name<>'',1,0));
			ln_property_name_type_CountNonBlank 													:= sum(group,if(%whichAssess%.ln_property_name_type<>'',1,0));
			ln_land_use_category_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_land_use_category<>'',1,0));
			ln_lot_CountNonBlank 																					:= sum(group,if(%whichAssess%.ln_lot<>'',1,0));
			ln_block_CountNonBlank 																				:= sum(group,if(%whichAssess%.ln_block<>'',1,0));
			ln_unit_CountNonBlank 																				:= sum(group,if(%whichAssess%.ln_unit<>'',1,0));
			ln_subfloor_CountNonBlank 																		:= sum(group,if(%whichAssess%.ln_subfloor<>'',1,0));
			ln_floor_cover_CountNonBlank 																	:= sum(group,if(%whichAssess%.ln_floor_cover<>'',1,0));
			ln_mobile_home_indicator_CountNonBlank 												:= sum(group,if(%whichAssess%.ln_mobile_home_indicator<>'',1,0));
			ln_condo_indicator_CountNonBlank 															:= sum(group,if(%whichAssess%.ln_condo_indicator<>'',1,0));
			ln_property_tax_exemption_CountNonBlank 											:= sum(group,if(%whichAssess%.ln_property_tax_exemption<>'',1,0));
			ln_veteran_status_CountNonBlank 															:= sum(group,if(%whichAssess%.ln_veteran_status<>'',1,0));
			ln_old_apn_indicator_CountNonBlank 														:= sum(group,if(%whichAssess%.ln_old_apn_indicator<>'',1,0));
	end;

	//DEEDS
	%rPopulationStats_Pdeed% := record
			CountGroup                                                                := count(group);
			%whichdeed%.vendor_source_flag;
			ln_fares_id_CountNonBlank                                                 := sum(group,if(%whichdeed%.ln_fares_id<>'',1,0));
			process_date_CountNonBlank                                                := sum(group,if(%whichdeed%.process_date<>'',1,0));
			vendor_source_flag_CountNonBlank                                          := sum(group,if(%whichdeed%.vendor_source_flag<>'',1,0));
			current_record_CountNonBlank                                              := sum(group,if(%whichdeed%.current_record<>'',1,0));
			from_file_CountNonBlank                                                   := sum(group,if(%whichdeed%.from_file<>'',1,0));
			fips_code_CountNonBlank                                                   := sum(group,if(%whichdeed%.fips_code<>'',1,0));
			state_CountNonBlank                                                       := sum(group,if(%whichdeed%.state<>'',1,0));
			county_name_CountNonBlank                                                 := sum(group,if(%whichdeed%.county_name<>'',1,0));
			record_type_CountNonBlank                                                 := sum(group,if(%whichdeed%.record_type<>'',1,0));
			apnt_or_pin_number_CountNonBlank                                          := sum(group,if(%whichdeed%.apnt_or_pin_number<>'',1,0));
			fares_unformatted_apn_CountNonBlank                                       := sum(group,if(%whichdeed%.fares_unformatted_apn<>'',1,0));
			multi_apn_flag_CountNonBlank                                              := sum(group,if(%whichdeed%.multi_apn_flag<>'',1,0));
			tax_id_number_CountNonBlank                                               := sum(group,if(%whichdeed%.tax_id_number<>'',1,0));
			excise_tax_number_CountNonBlank                                           := sum(group,if(%whichdeed%.excise_tax_number<>'',1,0));
			buyer_or_borrower_ind_CountNonBlank                                       := sum(group,if(%whichdeed%.buyer_or_borrower_ind<>'',1,0));
			name1_CountNonBlank                                                       := sum(group,if(%whichdeed%.name1<>'',1,0));
			name1_id_code_CountNonBlank                                               := sum(group,if(%whichdeed%.name1_id_code<>'',1,0));
			name2_CountNonBlank                                                       := sum(group,if(%whichdeed%.name2<>'',1,0));
			name2_id_code_CountNonBlank                                               := sum(group,if(%whichdeed%.name2_id_code<>'',1,0));
			vesting_code_CountNonBlank                                                := sum(group,if(%whichdeed%.vesting_code<>'',1,0));
			addendum_flag_CountNonBlank                                               := sum(group,if(%whichdeed%.addendum_flag<>'',1,0));
			phone_number_CountNonBlank                                                := sum(group,if(%whichdeed%.phone_number<>'',1,0));
			mailing_care_of_CountNonBlank                                             := sum(group,if(%whichdeed%.mailing_care_of<>'',1,0));
			mailing_street_CountNonBlank                                              := sum(group,if(%whichdeed%.mailing_street<>'',1,0));
			mailing_unit_number_CountNonBlank                                         := sum(group,if(%whichdeed%.mailing_unit_number<>'',1,0));
			mailing_csz_CountNonBlank                                                 := sum(group,if(%whichdeed%.mailing_csz<>'',1,0));
			mailing_address_cd_CountNonBlank                                          := sum(group,if(%whichdeed%.mailing_address_cd<>'',1,0));
			seller1_CountNonBlank                                                     := sum(group,if(%whichdeed%.seller1<>'',1,0));
			seller1_id_code_CountNonBlank                                             := sum(group,if(%whichdeed%.seller1_id_code<>'',1,0));
			seller2_CountNonBlank                                                     := sum(group,if(%whichdeed%.seller2<>'',1,0));
			seller2_id_code_CountNonBlank                                             := sum(group,if(%whichdeed%.seller2_id_code<>'',1,0));
			seller_addendum_flag_CountNonBlank                                        := sum(group,if(%whichdeed%.seller_addendum_flag<>'',1,0));
			seller_mailing_full_street_address_CountNonBlank                          := sum(group,if(%whichdeed%.seller_mailing_full_street_address<>'',1,0));
			seller_mailing_address_unit_number_CountNonBlank                          := sum(group,if(%whichdeed%.seller_mailing_address_unit_number<>'',1,0));
			seller_mailing_address_citystatezip_CountNonBlank                         := sum(group,if(%whichdeed%.seller_mailing_address_citystatezip<>'',1,0));
			property_full_street_address_CountNonBlank                                := sum(group,if(%whichdeed%.property_full_street_address<>'',1,0));
			property_address_unit_number_CountNonBlank                                := sum(group,if(%whichdeed%.property_address_unit_number<>'',1,0));
			property_address_citystatezip_CountNonBlank                               := sum(group,if(%whichdeed%.property_address_citystatezip<>'',1,0));
			property_address_code_CountNonBlank                                       := sum(group,if(%whichdeed%.property_address_code<>'',1,0));
			legal_lot_code_CountNonBlank                                              := sum(group,if(%whichdeed%.legal_lot_code<>'',1,0));
			legal_lot_number_CountNonBlank                                            := sum(group,if(%whichdeed%.legal_lot_number<>'',1,0));
			legal_block_CountNonBlank                                                 := sum(group,if(%whichdeed%.legal_block<>'',1,0));
			legal_section_CountNonBlank                                               := sum(group,if(%whichdeed%.legal_section<>'',1,0));
			legal_district_CountNonBlank                                              := sum(group,if(%whichdeed%.legal_district<>'',1,0));
			legal_land_lot_CountNonBlank                                              := sum(group,if(%whichdeed%.legal_land_lot<>'',1,0));
			legal_unit_CountNonBlank                                                  := sum(group,if(%whichdeed%.legal_unit<>'',1,0));
			legal_city_municipality_township_CountNonBlank                            := sum(group,if(%whichdeed%.legal_city_municipality_township<>'',1,0));
			legal_subdivision_name_CountNonBlank                                      := sum(group,if(%whichdeed%.legal_subdivision_name<>'',1,0));
			legal_phase_number_CountNonBlank                                          := sum(group,if(%whichdeed%.legal_phase_number<>'',1,0));
			legal_tract_number_CountNonBlank                                          := sum(group,if(%whichdeed%.legal_tract_number<>'',1,0));
			legal_sec_twn_rng_mer_CountNonBlank                                       := sum(group,if(%whichdeed%.legal_sec_twn_rng_mer<>'',1,0));
			legal_brief_description_CountNonBlank                                     := sum(group,if(%whichdeed%.legal_brief_description<>'',1,0));
			recorder_map_reference_CountNonBlank                                      := sum(group,if(%whichdeed%.recorder_map_reference<>'',1,0));
			complete_legal_description_code_CountNonBlank                             := sum(group,if(%whichdeed%.complete_legal_description_code<>'',1,0));
			contract_date_CountNonBlank                                               := sum(group,if(%whichdeed%.contract_date<>'',1,0));
			recording_date_CountNonBlank                                              := sum(group,if(%whichdeed%.recording_date<>'',1,0));
			arm_reset_date_CountNonBlank                                              := sum(group,if(%whichdeed%.arm_reset_date<>'',1,0));
			document_number_CountNonBlank                                             := sum(group,if(%whichdeed%.document_number<>'',1,0));
			document_type_code_CountNonBlank                                          := sum(group,if(%whichdeed%.document_type_code<>'',1,0));
			loan_number_CountNonBlank                                                 := sum(group,if(%whichdeed%.loan_number<>'',1,0));
			recorder_book_number_CountNonBlank                                        := sum(group,if(%whichdeed%.recorder_book_number<>'',1,0));
			recorder_page_number_CountNonBlank                                        := sum(group,if(%whichdeed%.recorder_page_number<>'',1,0));
			concurrent_mortgage_book_page_document_number_CountNonBlank               := sum(group,if(%whichdeed%.concurrent_mortgage_book_page_document_number<>'',1,0));
			sales_price_CountNonBlank                                                 := sum(group,if(%whichdeed%.sales_price<>'',1,0));
			sales_price_code_CountNonBlank                                            := sum(group,if(%whichdeed%.sales_price_code<>'',1,0));
			city_transfer_tax_CountNonBlank                                           := sum(group,if(%whichdeed%.city_transfer_tax<>'',1,0));
			county_transfer_tax_CountNonBlank                                         := sum(group,if(%whichdeed%.county_transfer_tax<>'',1,0));
			total_transfer_tax_CountNonBlank                                          := sum(group,if(%whichdeed%.total_transfer_tax<>'',1,0));
			first_td_loan_amount_CountNonBlank                                        := sum(group,if(%whichdeed%.first_td_loan_amount<>'',1,0));
			second_td_loan_amount_CountNonBlank                                       := sum(group,if(%whichdeed%.second_td_loan_amount<>'',1,0));
			first_td_lender_type_code_CountNonBlank                                   := sum(group,if(%whichdeed%.first_td_lender_type_code<>'',1,0));
			second_td_lender_type_code_CountNonBlank                                  := sum(group,if(%whichdeed%.second_td_lender_type_code<>'',1,0));
			first_td_loan_type_code_CountNonBlank                                     := sum(group,if(%whichdeed%.first_td_loan_type_code<>'',1,0));
			type_financing_CountNonBlank                                              := sum(group,if(%whichdeed%.type_financing<>'',1,0));
			first_td_interest_rate_CountNonBlank                                      := sum(group,if(%whichdeed%.first_td_interest_rate<>'',1,0));
			first_td_due_date_CountNonBlank                                           := sum(group,if(%whichdeed%.first_td_due_date<>'',1,0));
			title_company_name_CountNonBlank                                          := sum(group,if(%whichdeed%.title_company_name<>'',1,0));
			partial_interest_transferred_CountNonBlank                                := sum(group,if(%whichdeed%.partial_interest_transferred<>'',1,0));
			loan_term_months_CountNonBlank                                            := sum(group,if(%whichdeed%.loan_term_months<>'',1,0));
			loan_term_years_CountNonBlank                                             := sum(group,if(%whichdeed%.loan_term_years<>'',1,0));
			lender_name_CountNonBlank                                                 := sum(group,if(%whichdeed%.lender_name<>'',1,0));
			lender_name_id_CountNonBlank                                              := sum(group,if(%whichdeed%.lender_name_id<>'',1,0));
			lender_dba_aka_name_CountNonBlank                                         := sum(group,if(%whichdeed%.lender_dba_aka_name<>'',1,0));
			lender_full_street_address_CountNonBlank                                  := sum(group,if(%whichdeed%.lender_full_street_address<>'',1,0));
			lender_address_unit_number_CountNonBlank                                  := sum(group,if(%whichdeed%.lender_address_unit_number<>'',1,0));
			lender_address_citystatezip_CountNonBlank                                 := sum(group,if(%whichdeed%.lender_address_citystatezip<>'',1,0));
			assessment_match_land_use_code_CountNonBlank                              := sum(group,if(%whichdeed%.assessment_match_land_use_code<>'',1,0));
			property_use_code_CountNonBlank                                           := sum(group,if(%whichdeed%.property_use_code<>'',1,0));
			condo_code_CountNonBlank                                                  := sum(group,if(%whichdeed%.condo_code<>'',1,0));
			timeshare_flag_CountNonBlank                                              := sum(group,if(%whichdeed%.timeshare_flag<>'',1,0));
			land_lot_size_CountNonBlank                                               := sum(group,if(%whichdeed%.land_lot_size<>'',1,0));
			hawaii_tct_CountNonBlank                                                  := sum(group,if(%whichdeed%.hawaii_tct<>'',1,0));
			hawaii_condo_cpr_code_CountNonBlank                                       := sum(group,if(%whichdeed%.hawaii_condo_cpr_code<>'',1,0));
			hawaii_condo_name_CountNonBlank                                           := sum(group,if(%whichdeed%.hawaii_condo_name<>'',1,0));
			filler_except_hawaii_CountNonBlank                                        := sum(group,if(%whichdeed%.filler_except_hawaii<>'',1,0));
			rate_change_frequency_CountNonBlank                                       := sum(group,if(%whichdeed%.rate_change_frequency<>'',1,0));
			change_index_CountNonBlank                                                := sum(group,if(%whichdeed%.change_index<>'',1,0));
			adjustable_rate_index_CountNonBlank                                       := sum(group,if(%whichdeed%.adjustable_rate_index<>'',1,0));
			adjustable_rate_rider_CountNonBlank                                       := sum(group,if(%whichdeed%.adjustable_rate_rider<>'',1,0));
			graduated_payment_rider_CountNonBlank                                     := sum(group,if(%whichdeed%.graduated_payment_rider<>'',1,0));
			balloon_rider_CountNonBlank                                               := sum(group,if(%whichdeed%.balloon_rider<>'',1,0));
			fixed_step_rate_rider_CountNonBlank                                       := sum(group,if(%whichdeed%.fixed_step_rate_rider<>'',1,0));
			condominium_rider_CountNonBlank                                           := sum(group,if(%whichdeed%.condominium_rider<>'',1,0));
			planned_unit_development_rider_CountNonBlank                              := sum(group,if(%whichdeed%.planned_unit_development_rider<>'',1,0));
			rate_improvement_rider_CountNonBlank                                      := sum(group,if(%whichdeed%.rate_improvement_rider<>'',1,0));
			assumability_rider_CountNonBlank                                          := sum(group,if(%whichdeed%.assumability_rider<>'',1,0));
			prepayment_rider_CountNonBlank                                            := sum(group,if(%whichdeed%.prepayment_rider<>'',1,0));
			one_four_family_rider_CountNonBlank                                       := sum(group,if(%whichdeed%.one_four_family_rider<>'',1,0));
			biweekly_payment_rider_CountNonBlank                                      := sum(group,if(%whichdeed%.biweekly_payment_rider<>'',1,0));
			second_home_rider_CountNonBlank                                           := sum(group,if(%whichdeed%.second_home_rider<>'',1,0));
			data_source_code_CountNonBlank                                            := sum(group,if(%whichdeed%.data_source_code<>'',1,0));
			main_record_id_code_CountNonBlank                                         := sum(group,if(%whichdeed%.main_record_id_code<>'',1,0));
			addl_name_flag_CountNonBlank                                              := sum(group,if(%whichdeed%.addl_name_flag<>'',1,0));
			prop_addr_propagated_ind_CountNonBlank                                    := sum(group,if(%whichdeed%.prop_addr_propagated_ind<>'',1,0));
			ln_ownership_rights_CountNonBlank																					:= sum(group,if(%whichdeed%.ln_ownership_rights<>'',1,0));
			ln_relationship_type_CountNonBlank																				:= sum(group,if(%whichdeed%.ln_relationship_type<>'',1,0));
			ln_buyer_mailing_country_code_CountNonBlank																:= sum(group,if(%whichdeed%.ln_buyer_mailing_country_code<>'',1,0));
			ln_seller_mailing_country_code_CountNonBlank															:= sum(group,if(%whichdeed%.ln_seller_mailing_country_code<>'',1,0));
	end;

	//OUTPUT ASSESS STATS
		%dPopulationStats_pAsses% 		:= table(%whichAssess%
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
											 
		%dPopulationStats_pAssesPlus% := table(%whichAssess%
																						,%rPopulationStats_pAssesPlus%
																						,vendor_source_flag
																						,few);

		STRATA.createXMLStats(%dPopulationStats_pAssesPlus%
													 ,if(isFast, %buildPrefix%+ ' 2', %buildPrefix%)
													 ,'AssesPlus'
													 ,pVersion
													 ,''
													 ,%zAssesPlusStats%
													 ,'view'
													 ,'Population');
					 
	// output deeds stats 
		%dPopulationStats_Pdeed% 			:= table(%whichDeed%
																						,%rPopulationStats_Pdeed%
																						,vendor_source_flag
																						,few);
										
		STRATA.createXMLStats(%dPopulationStats_Pdeed%
													 ,%buildPrefix%
													 ,'deeds'
													 ,pVersion
													 ,''
													 ,%zdeedStats%
													 ,'view'
													 ,'Population');
											 
zOut := parallel(%zAssesStats%,%zAssesPlusStats%,%zdeedStats%);
/*zOut := parallel(output(%dPopulationStats_pAsses%, named('assessNew')),
									output(%dPopulationStats_pAssesPlus%, named('assessPlusNew')),
									output(%dPopulationStats_Pdeed%, named('deedNew')));*/

ENDMACRO;