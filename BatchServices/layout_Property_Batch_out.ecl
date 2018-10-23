import BatchShare,FFD;
EXPORT layout_Property_Batch_out := 
	RECORD

		STRING30 acctno                     := '';
		FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		// INTEGER  error_code := 0;
		BatchShare.Layouts.shareErrors;
		STRING8   matchcodes := '';
		
//	***** 'CORE' SECTION *****
		
		STRING12 ln_fares_id := '';
		STRING1 fid_type := '';
		STRING8 fid_type_desc := ''; // 'Deed' or 'Assessed'
		UNSIGNED2 penalt := 0;
		STRING8 sortby_date := '';
		STRING1 vendor_source_flag := '';
		STRING5 vendor_source_desc := '';		
		STRING1 current_record := '';
		STRING3 assess_prop_addr_match_code := '';
		STRING3 assess_mail_addr_match_code := '';
		STRING3 assess_ownr_addr_match_code := '';
		STRING3 deed_prop_addr_match_code := '';
		STRING3 deed_buyr_addr_match_code := '';
		STRING3 deed_sell_addr_match_code := '';
			
//	***** DEEDS SECTION *****
		
	// filing info
		
		STRING2 deed_state := '';
		STRING30 deed_county_name := '';
		STRING45 deed_apnt_or_pin_number := '';					
		STRING5 deed_fips_code := '';
		STRING1 deed_record_type := '';
		STRING18 deed_record_type_desc := '';
		STRING4 deed_multi_apn_flag := '';					
		STRING1	deed_buyer_addendum_flag := '';
		STRING1 deed_seller_addendum_flag := '';						
								
	// lender info

		STRING40 deed_lender_name := '';					
		STRING6 deed_lender_name_id := '';
		STRING40 deed_lender_dba_aka_name := '';
		STRING39 deed_tax_id_number := '';
		
	// phone info
		
		STRING10 deed_phone_number := '';
	
	// propertyAddress info
	
		STRING1 deed_property_address_code := '';
		STRING76 deed_property_address_desc := '';					
		STRING60 deed_lender_full_street_address := '';
		STRING6 deed_lender_address_unit_number := '';
		STRING41 deed_lender_address_citystatezip := '';						
				
	// legal info		
		
		STRING100 deed_legal_brief_description := '';
		STRING8 deed_contract_date := '';
		STRING8 deed_recording_date := '';
		STRING3 deed_document_type_code := '';
		STRING70 deed_document_type_desc := '';					
		STRING8 deed_arm_reset_date := '';
		STRING20 deed_document_number := '';
		STRING10 deed_recorder_book_number := '';
		STRING10 deed_recorder_page_number := '';
		STRING10 deed_land_lot_size := '';
		STRING54 deed_legal_lot_desc := '';
		STRING10 deed_legal_lot_number := '';
		STRING7 deed_legal_block := '';
		STRING7 deed_legal_section := '';
		STRING7 deed_legal_district := '';
		STRING7 deed_legal_land_lot := '';
		STRING6 deed_legal_unit := '';
		STRING30 deed_legal_city_municipality_township := '';
		STRING50 deed_legal_subdivision_name := '';
		STRING7 deed_legal_phase_number := '';
		STRING10 deed_legal_tract_number := '';
		STRING30 deed_legal_sec_twn_rng_mer := '';
		STRING20 deed_recorder_map_reference := '';
		STRING1 deed_complete_legal_description_code := '';
		STRING20 deed_loan_number := '';
		STRING19 deed_concurrent_mortgage_book_page_document_number := '';
		STRING6 deed_hawaii_tct := '';
		STRING4 deed_hawaii_condo_cpr_code := '';
		STRING30 deed_hawaii_condo_name := '';
		STRING1 deed_filler_except_hawaii := '';									

	// sales info
		
		STRING11 deed_sales_price := '';
		STRING143 deed_sales_price_desc := '';
		STRING8 deed_city_transfer_tax := '';
		STRING8 deed_county_transfer_tax := '';
		STRING8 deed_total_transfer_tax := '';
		STRING10 deed_excise_tax_number := '';						

	// property info
	
		STRING41 deed_property_use_desc := '';
		STRING76 deed_assessment_match_land_use_desc := '';
		STRING17 deed_condo_desc := '';
		STRING1 deed_timeshare_flag := '';			
		
	// mortgage info
		
		STRING11 deed_first_td_loan_amount := '';					
		STRING39 deed_first_td_loan_type_desc := '';
		STRING4 deed_type_financing := '';
		STRING27 deed_type_financing_desc := '';
		STRING5 deed_first_td_interest_rate := '';
		STRING8 deed_first_td_due_date := '';
		STRING60 deed_title_company_name := '';
		STRING1 deed_rate_change_frequency := '';
		STRING27 deed_rate_change_frequency_desc := '';
		STRING10 deed_change_index := '';
		STRING15 deed_adjustable_rate_index := '';
		STRING55 deed_adjustable_rate_index_desc := '';
		STRING1 deed_adjustable_rate_rider := '';
		STRING1 deed_graduated_payment_rider := '';
		STRING1 deed_balloon_rider := '';
		STRING1 deed_fixed_step_rate_rider := '';
		STRING36 deed_fixed_step_rate_rider_desc := '';
		STRING1 deed_condominium_rider := '';
		STRING1 deed_planned_unit_development_rider := '';
		STRING1 deed_rate_improvement_rider := '';
		STRING1 deed_assumability_rider := '';
		STRING1 deed_prepayment_rider := '';
		STRING1 deed_one_four_family_rider := '';
		STRING1 deed_biweekly_payment_rider := '';
		STRING1 deed_second_home_rider := '';
		STRING11 deed_second_td_loan_amount := '';
		STRING26 deed_first_td_lender_type_desc := '';
		STRING26 deed_second_td_lender_type_desc := '';
		STRING3 deed_partial_interest_transferred := '';
		STRING5 deed_loan_term_months := '';
		STRING5 deed_loan_term_years := '';	
							
	// addl fares info
	
		STRING33 deed_transaction_type_desc := '';
		STRING69 deed_mortgage_deed_type_desc := '';
		STRING6 deed_mortgage_term_code_desc := '';
		STRING5 deed_mortgage_term := '';
		STRING60 deed_iris_apn := '';
		STRING60 deed_lender_address := '';
		STRING8 deed_mortgage_date := '';
		STRING9 deed_building_square_feet := '';
		STRING19 deed_foreclosure_desc := '';
		STRING22 deed_refi_flag_desc := '';
		STRING11 deed_equity_flag_desc := '';							
			
//	***** ASSESSMENT SECTION *****

	// filing info

		STRING2 assess_state_code := '';
		STRING30 assess_county_name := '';
		STRING45 assess_apna_or_pin_number := '';					
		STRING5 assess_fips_code := '';
		STRING2 assess_duplicate_apn_multiple_address_id := '';					
		STRING6 assess_tape_cut_date := '';
		STRING2 assess_edition_number := '';
		STRING8 assess_certification_date := '';

	// owner info

		STRING47 assess_assessee_ownership_rights_desc := '';
		STRING47 assess_assessee_relationship_desc := '';
		STRING10 assess_assessee_phone_number := '';
		STRING30 assess_tax_account_number := '';
		STRING45 assess_contract_owner := '';
		STRING10 assess_assessee_name_type_desc := '';
		STRING10 assess_second_assessee_name_type_desc := '';						
		
	// address info
		STRING10 assess_mail_care_of_name_type_desc := '';
		STRING60 assess_mailing_care_of_name := '';
		STRING76 assess_property_address_desc := '';	
		
	// legal info

		STRING1 assess_owner_occupied := '';
		STRING8 assess_recording_date := '';
		STRING8 assess_prior_recording_date := '';
		STRING45 assess_county_land_use_description := '';
		STRING76 assess_standardized_land_use_desc := '';
		STRING7 assess_legal_lot_number := '';
		STRING40 assess_legal_subdivision_name := '';
		STRING250 assess_legal_brief_description := '';
		STRING103 assess_record_type_desc := '';
		STRING10 assess_recorder_book_number := '';
		STRING10 assess_recorder_page_number := '';
		STRING54 assess_legal_lot_desc := '';
		STRING10 assess_legal_land_lot := '';
		STRING7 assess_legal_block := '';
		STRING7 assess_legal_section := '';
		STRING12 assess_legal_district := '';
		STRING6 assess_legal_unit := '';
		STRING30 assess_legal_city_municipality_township := '';
		STRING7 assess_legal_phase_number := '';
		STRING10 assess_legal_tract_number := '';
		STRING30 assess_legal_sec_twn_rng_mer := '';
		STRING15 assess_legal_assessor_map_ref := '';
		STRING10 assess_census_tract := '';
		STRING17 assess_ownership_type_desc := '';
		STRING35 assess_new_record_type_desc := '';
		STRING1 assess_timeshare_code := '';
		STRING25 assess_zoning := '';
		STRING20 assess_recorder_document_number := '';
		STRING8 assess_transfer_date := '';
		STRING25 assess_document_type := '';
		STRING36 assess_document_type_desc := '';
		STRING8 assess_prior_transfer_date := '';		
			
	// sales info	

		STRING8 assess_sale_date := '';
		STRING11 assess_sales_price := '';
		STRING108 assess_sales_price_desc := '';
		STRING11 assess_prior_sales_price := '';
		STRING108 assess_prior_sales_price_desc := '';
			
	// mortgage info

		STRING11 assess_mortgage_loan_amount := '';
		STRING31 assess_mortgage_loan_type_desc := '';		

	// lender info
			
		STRING60 assess_mortgage_lender_name := '';
		STRING30 assess_mortgage_lender_type_desc := '';
			
	// assessment info	
		
		STRING11 assess_assessed_total_value := '';
		STRING4 assess_assessed_value_year := '';
		STRING1 assess_homestead_homeowner_exemption := '';
		STRING11 assess_assessed_improvement_value := '';
		STRING11 assess_market_land_value := '';
		STRING11 assess_market_improvement_value := '';
		STRING11 assess_market_total_value := '';
		STRING4 assess_market_value_year := '';
		STRING11 assess_assessed_land_value := '';	
											
	// tax info
		
		STRING4 assess_tax_year := '';
		STRING13 assess_tax_amount := '';
		STRING21 assess_tax_exemption1_desc := '';
		STRING21 assess_tax_exemption2_desc := '';
		STRING21 assess_tax_exemption3_desc := '';
		STRING21 assess_tax_exemption4_desc := '';
		STRING18 assess_tax_rate_code_area := '';
		STRING4 assess_tax_delinquent_year := '';
		STRING15 assess_school_tax_district1 := '';
		STRING15 assess_school_tax_district2 := '';
		STRING15 assess_school_tax_district3 := '';										

	// property info			

		STRING30 assess_land_square_footage := '';
		STRING4 assess_year_built := '';
		STRING5 assess_no_of_stories := '';
		STRING28 assess_no_of_stories_desc := '';
		STRING5 assess_no_of_bedrooms := '';
		STRING8 assess_no_of_baths := '';
		STRING2 assess_no_of_partial_baths := '';
		STRING30 assess_garage_type_desc := '';
		STRING27 assess_pool_desc := '';
		STRING30 assess_exterior_walls_desc := '';
		STRING20 assess_roof_type_desc := '';
		STRING28 assess_heating_desc := '';
		STRING23 assess_heating_fuel_type_desc := '';
		STRING28 assess_air_conditioning_desc := '';
		STRING18 assess_air_conditioning_type_desc := '';
		STRING30 assess_land_acres := '';
		STRING30 assess_land_dimensions := '';
		STRING9 assess_building_area := '';
		STRING8 assess_building_area1 := '';
		STRING8 assess_building_area2 := '';
		STRING8 assess_building_area3 := '';
		STRING8 assess_building_area4 := '';
		STRING8 assess_building_area5 := '';
		STRING8 assess_building_area6 := '';
		STRING8 assess_building_area7 := '';
		STRING30 assess_building_area_desc := '';
		STRING30 assess_building_area1_desc := '';
		STRING30 assess_building_area2_desc := '';
		STRING30 assess_building_area3_desc := '';
		STRING30 assess_building_area4_desc := '';
		STRING30 assess_building_area5_desc := '';
		STRING30 assess_building_area6_desc := '';
		STRING30 assess_building_area7_desc := '';
		STRING4 assess_effective_year_built := '';
		STRING3 assess_no_of_buildings := '';
		STRING5 assess_no_of_units := '';
		STRING5 assess_no_of_rooms := '';
		STRING5 assess_parking_no_of_cars := '';

		STRING29 assess_style_desc := '';
		STRING27 assess_type_construction_desc := '';
		STRING31 assess_foundation_desc := '';
		STRING28 assess_roof_cover_desc := '';
		STRING1 assess_elevator := '';
		STRING3 assess_fireplace_indicator_desc := '';
		STRING3 assess_fireplace_number := '';
		STRING25 assess_basement_desc := '';
		STRING210 assess_building_class_desc := '';

		STRING29 assess_site_influence1_desc := '';
		STRING29 assess_site_influence2_desc := '';
		STRING29 assess_site_influence3_desc := '';
		STRING29 assess_site_influence4_desc := '';
		STRING29 assess_site_influence5_desc := '';

		STRING17 assess_amenities1_desc := '';
		STRING17 assess_amenities2_desc := '';
		STRING17 assess_amenities3_desc := '';
		STRING17 assess_amenities4_desc := '';
		STRING17 assess_amenities5_desc := '';

		STRING28 assess_other_buildings1_desc := '';
		STRING28 assess_other_buildings2_desc := '';
		STRING28 assess_other_buildings3_desc := '';
		STRING28 assess_other_buildings4_desc := '';
		STRING28 assess_other_buildings5_desc := '';

		STRING20 assess_condo_project_name := '';
		STRING20 assess_building_name := '';
		STRING120 assess_comments := '';

		STRING9 assess_neighborhood_code := '';

	// fares info

		STRING7 assess_living_square_feet := '';
		STRING60 assess_iris_apn := '';
		STRING1924 assess_addl_legal := '';					
		STRING11 assess_calculated_land_value := '';
		STRING11 assess_calculated_improvement_value := '';
		STRING11 assess_calculated_total_value := '';
		STRING7 assess_adjusted_gross_square_feet := '';
		STRING5 assess_no_of_full_baths := '';
		STRING5 assess_no_of_half_baths := '';
		STRING1 assess_pool_indicator := '';
		STRING25 assess_frame_desc := '';
		STRING20 assess_electric_energy_desc := '';
		STRING12 assess_sewer_desc := '';
		STRING12 assess_water_desc := '';
		STRING18 assess_condition_desc := '';		
					
//	***** PARTIES *****

/*
Parties may include up to twenty children, but in fact may have at most four. Possible party types are:
- Buyer    (type = 'O')
- Seller   (type = 'S')
- Owner    (type = 'O')
- Assessee (type = 'O')
- Property (type = 'P')
- Borrower (type = 'B')
- Care Of  (type = 'C') [ very rare...not considered in the code below! ]

Only 1 of each party type may be displayed in a property record, e.g., 
- Buyer, Seller, Property
- Borrower, Buyer, Seller, Property
- Assessee, Property

etc.
*/

		// Property
		
		STRING50  property_address1     := '';
		STRING19  property_address2     := '';
		STRING25  property_p_city_name  := '';
		STRING25  property_v_city_name  := '';
		STRING2   property_st           := '';
		STRING5   property_zip          := '';
		STRING4   property_zip4         := '';
		STRING18  property_county_name  := '';
		STRING10  property_geo_lat      := '';
		STRING11  property_geo_long     := '';
		STRING66  property_msa          := '';
		STRING80  property_orig_address := '';
		STRING6	  property_orig_unit    := '';
		STRING51  property_orig_csz     := '';
		
		// Buyer 
		
		STRING50  buyer_address1        := '';
		STRING19  buyer_address2        := '';
		STRING25  buyer_p_city_name     := '';
		STRING25  buyer_v_city_name     := '';
		STRING2   buyer_st              := '';
		STRING5   buyer_zip             := '';
		STRING4   buyer_zip4            := '';
		STRING18  buyer_county_name     := '';
		STRING10  buyer_geo_lat         := '';
		STRING11  buyer_geo_long        := '';
		STRING66  buyer_msa             := '';
		STRING80  buyer_orig_address    := '';
		STRING6	  buyer_orig_unit       := '';
		STRING51  buyer_orig_csz        := '';
		STRING10  buyer_phone_number    := '';
		STRING24  buyer_vesting_desc    := '';
		
		STRING120 buyer_1_orig_name     := '';
		STRING54  buyer_1_id_desc       := '';		
		STRING5   buyer_1_title         := '';
		STRING20  buyer_1_first_name    := '';
		STRING20  buyer_1_middle_name   := '';
		STRING20  buyer_1_last_name     := '';
		STRING5   buyer_1_name_suffix   := '';
		STRING80  buyer_1_company_name  := '';
		STRING12  buyer_1_did           := '';
		STRING12  buyer_1_bdid          := '';
		UNSIGNED6 buyer_1_ultid					:= 0;
		UNSIGNED6 buyer_1_orgid					:= 0;
		UNSIGNED6 buyer_1_seleid				:= 0;
		UNSIGNED6 buyer_1_proxid				:= 0;
		UNSIGNED6 buyer_1_powid					:= 0;
		UNSIGNED6 buyer_1_empid					:= 0;
		UNSIGNED6 buyer_1_dotid					:= 0;
		STRING9   buyer_1_ssn           := '';
	
		STRING120 buyer_2_orig_name     := '';
		STRING54  buyer_2_id_desc       := '';		
		STRING5   buyer_2_title         := '';
		STRING20  buyer_2_first_name    := '';
		STRING20  buyer_2_middle_name   := '';
		STRING20  buyer_2_last_name     := '';
		STRING5   buyer_2_name_suffix   := '';
		STRING80  buyer_2_company_name  := '';
		STRING12  buyer_2_did           := '';
		STRING12  buyer_2_bdid          := '';
		UNSIGNED6 buyer_2_ultid					:= 0;
		UNSIGNED6 buyer_2_orgid					:= 0;
		UNSIGNED6 buyer_2_seleid				:= 0;
		UNSIGNED6 buyer_2_proxid				:= 0;
		UNSIGNED6 buyer_2_powid					:= 0;
		UNSIGNED6 buyer_2_empid					:= 0;
		UNSIGNED6 buyer_2_dotid					:= 0;
		STRING9   buyer_2_ssn           := '';		
		                            
		// Seller
		
		STRING50  seller_address1       := '';
		STRING19  seller_address2       := '';
		STRING25  seller_p_city_name    := '';
		STRING25  seller_v_city_name    := '';
		STRING2   seller_st             := '';
		STRING5   seller_zip            := '';
		STRING4   seller_zip4           := '';
		STRING18  seller_county_name    := '';
		STRING10  seller_geo_lat        := '';
		STRING11  seller_geo_long       := '';
		STRING66  seller_msa            := '';
		STRING80  seller_orig_address   := '';
		STRING6	  seller_orig_unit      := '';
		STRING51  seller_orig_csz       := '';
		STRING10  seller_phone_number   := '';

		STRING120 seller_1_orig_name     := '';
		STRING54  seller_1_id_desc       := '';
		STRING5   seller_1_title         := '';
		STRING20  seller_1_first_name    := '';
		STRING20  seller_1_middle_name   := '';
		STRING20  seller_1_last_name     := '';
		STRING5   seller_1_name_suffix   := '';
		STRING80  seller_1_company_name  := '';
		STRING12  seller_1_did           := '';
		STRING12  seller_1_bdid          := '';
		UNSIGNED6 seller_1_ultid				 := 0;
		UNSIGNED6 seller_1_orgid				 := 0;
		UNSIGNED6 seller_1_seleid				 := 0;
		UNSIGNED6 seller_1_proxid				 := 0;
		UNSIGNED6 seller_1_powid				 := 0;
		UNSIGNED6 seller_1_empid				 := 0;
		UNSIGNED6 seller_1_dotid				 := 0;
		STRING9   seller_1_ssn           := '';
	
		STRING120 seller_2_orig_name     := '';
		STRING54  seller_2_id_desc       := '';
		STRING5   seller_2_title         := '';
		STRING20  seller_2_first_name    := '';
		STRING20  seller_2_middle_name   := '';
		STRING20  seller_2_last_name     := '';
		STRING5   seller_2_name_suffix   := '';
		STRING80  seller_2_company_name  := '';
		STRING12  seller_2_did           := '';
		STRING12  seller_2_bdid          := '';
		UNSIGNED6 seller_2_ultid				 := 0;
		UNSIGNED6 seller_2_orgid				 := 0;
		UNSIGNED6 seller_2_seleid				 := 0;
		UNSIGNED6 seller_2_proxid				 := 0;
		UNSIGNED6 seller_2_powid				 := 0;
		UNSIGNED6 seller_2_empid				 := 0;
		UNSIGNED6 seller_2_dotid				 := 0;
		STRING9   seller_2_ssn           := '';	
		
		// Owner
		                             
		STRING50  owner_address1        := '';
		STRING19  owner_address2        := '';
		STRING25  owner_p_city_name     := '';
		STRING25  owner_v_city_name     := '';
		STRING2   owner_st              := '';
		STRING5   owner_zip             := '';
		STRING4   owner_zip4            := '';
		STRING18  owner_county_name     := '';
		STRING10  owner_geo_lat         := '';
		STRING11  owner_geo_long        := '';
		STRING66  owner_msa             := '';
		STRING80  owner_orig_address    := '';
		STRING6	  owner_orig_unit       := '';
		STRING51  owner_orig_csz        := '';
		STRING10  owner_phone_number    := '';

		STRING120 owner_1_orig_name     := '';
		STRING5   owner_1_title         := '';
		STRING20  owner_1_first_name    := '';
		STRING20  owner_1_middle_name   := '';
		STRING20  owner_1_last_name     := '';
		STRING5   owner_1_name_suffix   := '';
		STRING80  owner_1_company_name  := '';
		STRING12  owner_1_did           := '';
		STRING12  owner_1_bdid          := '';
		UNSIGNED6 owner_1_ultid				  := 0;
		UNSIGNED6 owner_1_orgid				  := 0;
		UNSIGNED6 owner_1_seleid				:= 0;
		UNSIGNED6 owner_1_proxid				:= 0;
		UNSIGNED6 owner_1_powid				  := 0;
		UNSIGNED6 owner_1_empid				  := 0;
		UNSIGNED6 owner_1_dotid				  := 0;
		STRING9   owner_1_ssn           := '';
	
		STRING120 owner_2_orig_name     := '';
		STRING5   owner_2_title         := '';
		STRING20  owner_2_first_name    := '';
		STRING20  owner_2_middle_name   := '';
		STRING20  owner_2_last_name     := '';
		STRING5   owner_2_name_suffix   := '';
		STRING80  owner_2_company_name  := '';
		STRING12  owner_2_did           := '';
		STRING12  owner_2_bdid          := '';
		UNSIGNED6 owner_2_ultid				  := 0;
		UNSIGNED6 owner_2_orgid				  := 0;
		UNSIGNED6 owner_2_seleid				:= 0;
		UNSIGNED6 owner_2_proxid				:= 0;
		UNSIGNED6 owner_2_powid				  := 0;
		UNSIGNED6 owner_2_empid				  := 0;
		UNSIGNED6 owner_2_dotid				  := 0;
		STRING9   owner_2_ssn           := '';	
		
		// Assessee
		                            
		STRING50  assessee_address1     := '';
		STRING19  assessee_address2     := '';
		STRING25  assessee_p_city_name  := '';
		STRING25  assessee_v_city_name  := '';
		STRING2   assessee_st           := '';
		STRING5   assessee_zip          := '';
		STRING4   assessee_zip4         := '';
		STRING18  assessee_county_name  := '';
		STRING10  assessee_geo_lat      := '';
		STRING11  assessee_geo_long     := '';
		STRING66  assessee_msa          := '';
		STRING80  assessee_orig_address := '';
		STRING6	  assessee_orig_unit    := '';
		STRING51  assessee_orig_csz     := '';
		STRING10  assessee_phone_number := '';

		STRING120 assessee_1_orig_name     := '';
		STRING5   assessee_1_title         := '';
		STRING20  assessee_1_first_name    := '';
		STRING20  assessee_1_middle_name   := '';
		STRING20  assessee_1_last_name     := '';
		STRING5   assessee_1_name_suffix   := '';
		STRING80  assessee_1_company_name  := '';
		STRING12  assessee_1_did           := '';
		STRING12  assessee_1_bdid          := '';
		UNSIGNED6 assessee_1_ultid				 := 0;
		UNSIGNED6 assessee_1_orgid				 := 0;
		UNSIGNED6 assessee_1_seleid				 := 0;
		UNSIGNED6 assessee_1_proxid				 := 0;
		UNSIGNED6 assessee_1_powid				 := 0;
		UNSIGNED6 assessee_1_empid				 := 0;
		UNSIGNED6 assessee_1_dotid				 := 0;
		STRING9   assessee_1_ssn           := '';
	
		STRING120 assessee_2_orig_name     := '';
		STRING5   assessee_2_title         := '';
		STRING20  assessee_2_first_name    := '';
		STRING20  assessee_2_middle_name   := '';
		STRING20  assessee_2_last_name     := '';
		STRING5   assessee_2_name_suffix   := '';
		STRING80  assessee_2_company_name  := '';
		STRING12  assessee_2_did           := '';
		STRING12  assessee_2_bdid          := '';
		UNSIGNED6 assessee_2_ultid				 := 0;
		UNSIGNED6 assessee_2_orgid				 := 0;
		UNSIGNED6 assessee_2_seleid				 := 0;
		UNSIGNED6 assessee_2_proxid				 := 0;
		UNSIGNED6 assessee_2_powid				 := 0;
		UNSIGNED6 assessee_2_empid				 := 0;
		UNSIGNED6 assessee_2_dotid				 := 0;
		STRING9   assessee_2_ssn           := '';	
		
		// Borrower
		
		STRING50  borrower_address1     := '';
		STRING19  borrower_address2     := '';
		STRING25  borrower_p_city_name  := '';
		STRING25  borrower_v_city_name  := '';
		STRING2   borrower_st           := '';
		STRING5   borrower_zip          := '';
		STRING4   borrower_zip4         := '';
		STRING18  borrower_county_name  := '';
		STRING10  borrower_geo_lat      := '';
		STRING11  borrower_geo_long     := '';
		STRING66  borrower_msa          := '';
		STRING80  borrower_orig_address := '';
		STRING6	  borrower_orig_unit    := '';
		STRING51  borrower_orig_csz     := '';
		STRING10  borrower_phone_number := '';
		STRING24  borrower_vesting_desc := '';		

		STRING120 borrower_1_orig_name     := '';
		STRING54  borrower_1_id_desc       := '';
		STRING5   borrower_1_title         := '';
		STRING20  borrower_1_first_name    := '';
		STRING20  borrower_1_middle_name   := '';
		STRING20  borrower_1_last_name     := '';
		STRING5   borrower_1_name_suffix   := '';
		STRING80  borrower_1_company_name  := '';
		STRING12  borrower_1_did           := '';
		STRING12  borrower_1_bdid          := '';
		UNSIGNED6 borrower_1_ultid				 := 0;
		UNSIGNED6 borrower_1_orgid				 := 0;
		UNSIGNED6 borrower_1_seleid				 := 0;
		UNSIGNED6 borrower_1_proxid				 := 0;
		UNSIGNED6 borrower_1_powid				 := 0;
		UNSIGNED6 borrower_1_empid				 := 0;
		UNSIGNED6 borrower_1_dotid				 := 0;
		STRING9   borrower_1_ssn           := '';
	
		STRING120 borrower_2_orig_name     := '';
		STRING54  borrower_2_id_desc       := '';
		STRING5   borrower_2_title         := '';
		STRING20  borrower_2_first_name    := '';
		STRING20  borrower_2_middle_name   := '';
		STRING20  borrower_2_last_name     := '';
		STRING5   borrower_2_name_suffix   := '';
		STRING80  borrower_2_company_name  := '';
		STRING12  borrower_2_did           := '';
		STRING12  borrower_2_bdid          := '';
		UNSIGNED6 borrower_2_ultid				 := 0;
		UNSIGNED6 borrower_2_orgid				 := 0;
		UNSIGNED6 borrower_2_seleid				 := 0;
		UNSIGNED6 borrower_2_proxid				 := 0;
		UNSIGNED6 borrower_2_powid				 := 0;
		UNSIGNED6 borrower_2_empid				 := 0;
		UNSIGNED6 borrower_2_dotid				 := 0;
		STRING9   borrower_2_ssn           := '';			
		FFD.Layouts.ConsumerFlags;	
    STRING12  inquiry_lexid            := '';
	END;