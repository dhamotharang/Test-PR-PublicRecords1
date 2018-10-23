
IMPORT LN_PropertyV2_Services, BatchServices, FFD;

STRING DISPLAY_NOTHING := '';
LCase                  := StringLib.StringToLowerCase;
Currency               := BatchServices.Functions.convert_to_currency;
Rate                   := BatchServices.Functions.convert_to_rate;

STRING fn_DisplayAddr1( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party) :=
	FUNCTION
		RETURN TRIM(party[1].prim_range) 
				 + IF( TRIM(party[1].predir)    != '', ' ' + TRIM(party[1].predir), '' )
				 + IF( TRIM(party[1].prim_name) != '', ' ' + TRIM(party[1].prim_name), '' )
				 + IF( TRIM(party[1].suffix)    != '', ' ' + TRIM(party[1].suffix), '' )
				 + IF( TRIM(party[1].postdir)   != '', ' ' + TRIM(party[1].postdir), '' );
	END;

STRING fn_DisplayAddr2( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party) :=
	FUNCTION
		RETURN TRIM(party[1].unit_desig) + IF(TRIM(party[1].sec_range) != '', ' ' + TRIM(party[1].sec_range), '' );
	END;
		
STRING fn_GetMsaPlusDesc(STRING msa) := 
		FUNCTION
			RETURN TRIM( msa + IF( TRIM(msa) <> '' AND TRIM(msa) <> '0000', 
			                       '--' + ziplib.MSAToCityState(msa), 
			                       DISPLAY_NOTHING) 
														);
		END;
		
	
EXPORT BatchServices.layout_Property_Batch_out_pre xfm_Property_make_flat(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes l, 
																																			BOOLEAN return_unformatted_values,
																																			integer c = 0 ) := 
	TRANSFORM
	
		property_party := l.parties( LCase(party_type_name) = 'property' )[1];
		buyer_party    := l.parties( LCase(party_type_name) = 'buyer' )[1];
		seller_party   := l.parties( LCase(party_type_name) = 'seller' )[1];
		owner_party    := l.parties( LCase(party_type_name) IN ['buyer','assessee'] )[1];
		assessee_party := l.parties( LCase(party_type_name) = 'assessee' )[1];
		borrower_party := l.parties( LCase(party_type_name) = 'borrower' )[1];

		SELF.acctno             := l.acctno;
		SELF.sequencenumber 		:= c;
		SELF.error_code         := l.error_code;
		SELF.matchcodes         := l.matchcodes;
		
//	***** 'CORE' SECTION *****
			
		SELF.ln_fares_id        := l.ln_fares_id;
		SELF.fid_type           := l.fid_type;
		SELF.fid_type_desc      := l.fid_type_desc; // Deed or Assessed
		SELF.penalt             := l.penalt;
		SELF.sortby_date        := l.sortby_date;
		SELF.vendor_source_flag := l.vendor_source_flag;
		SELF.vendor_source_desc := l.vendor_source_desc;		
		SELF.current_record     := l.current_record;
			
//	***** DEEDS SECTION *****

	// filing info
		
		SELF.deed_state                 := l.deeds[1].state;
		SELF.deed_county_name           := l.deeds[1].county_name;
		SELF.deed_apnt_or_pin_number    := l.deeds[1].apnt_or_pin_number;					
		SELF.deed_fips_code             := l.deeds[1].fips_code;
		SELF.deed_record_type           := l.deeds[1].record_type;
		SELF.deed_record_type_desc      := l.deeds[1].record_type_desc;
		SELF.deed_multi_apn_flag        := l.deeds[1].multi_apn_flag;			
		SELF.deed_buyer_addendum_flag   := l.deeds[1].buyer_addendum_flag;
		SELF.deed_seller_addendum_flag  := l.deeds[1].seller_addendum_flag;						
								
	// lender info

		SELF.deed_lender_name         := l.deeds[1].lender_name;					
		SELF.deed_lender_name_id      := l.deeds[1].lender_name_id;
		SELF.deed_lender_dba_aka_name := l.deeds[1].lender_dba_aka_name;
		SELF.deed_tax_id_number       := l.deeds[1].tax_id_number;
		
	// phone info
		
		SELF.deed_phone_number := l.deeds[1].phone_number;
	
	// propertyAddress info
	
		SELF.deed_property_address_code       := l.deeds[1].property_address_code;      
		SELF.deed_property_address_desc       := l.deeds[1].property_address_desc;      
		SELF.deed_lender_full_street_address  := l.deeds[1].lender_full_street_address; 
		SELF.deed_lender_address_unit_number  := l.deeds[1].lender_address_unit_number; 
		SELF.deed_lender_address_citystatezip := l.deeds[1].lender_address_citystatezip;	
				
	// legal info		
		
		SELF.deed_legal_brief_description                       := l.deeds[1].legal_brief_description;                      
		SELF.deed_contract_date                                 := l.deeds[1].contract_date;                                
		SELF.deed_recording_date                                := l.deeds[1].recording_date;  
		SELF.deed_document_type_code                            := l.deeds[1].document_type_code;
		SELF.deed_document_type_desc                            := l.deeds[1].document_type_desc;                          
		SELF.deed_arm_reset_date                                := l.deeds[1].arm_reset_date;                           
		SELF.deed_document_number                               := l.deeds[1].document_number;                              
		SELF.deed_recorder_book_number                          := l.deeds[1].recorder_book_number;                         
		SELF.deed_recorder_page_number                          := l.deeds[1].recorder_page_number;                         
		SELF.deed_land_lot_size                                 := l.deeds[1].land_lot_size;                                
		SELF.deed_legal_lot_desc                                := l.deeds[1].legal_lot_desc;                               
		SELF.deed_legal_lot_number                              := l.deeds[1].legal_lot_number;                             
		SELF.deed_legal_block                                   := l.deeds[1].legal_block;                                  
		SELF.deed_legal_section                                 := l.deeds[1].legal_section;                                
		SELF.deed_legal_district                                := l.deeds[1].legal_district;                               
		SELF.deed_legal_land_lot                                := l.deeds[1].legal_land_lot;                               
		SELF.deed_legal_unit                                    := l.deeds[1].legal_unit;                                   
		SELF.deed_legal_city_municipality_township              := l.deeds[1].legal_city_municipality_township;             
		SELF.deed_legal_subdivision_name                        := l.deeds[1].legal_subdivision_name;                       
		SELF.deed_legal_phase_number                            := l.deeds[1].legal_phase_number;                           
		SELF.deed_legal_tract_number                            := l.deeds[1].legal_tract_number;                           
		SELF.deed_legal_sec_twn_rng_mer                         := l.deeds[1].legal_sec_twn_rng_mer;                        
		SELF.deed_recorder_map_reference                        := l.deeds[1].recorder_map_reference;                       
		SELF.deed_complete_legal_description_code               := l.deeds[1].complete_legal_description_code;              
		SELF.deed_loan_number                                   := l.deeds[1].loan_number;                                  
		SELF.deed_concurrent_mortgage_book_page_document_number := l.deeds[1].concurrent_mortgage_book_page_document_number;
		SELF.deed_hawaii_tct                                    := l.deeds[1].hawaii_tct;                                   
		SELF.deed_hawaii_condo_cpr_code                         := l.deeds[1].hawaii_condo_cpr_code;                        
		SELF.deed_hawaii_condo_name                             := l.deeds[1].hawaii_condo_name;                            
		SELF.deed_filler_except_hawaii                          := l.deeds[1].filler_except_hawaii;                         

	// sales info
		
		SELF.deed_sales_price         := IF( return_unformatted_values, l.deeds[1].sales_price, Currency( l.deeds[1].sales_price ) );
		SELF.deed_sales_price_desc    := l.deeds[1].sales_price_desc;   		
		SELF.deed_city_transfer_tax   := IF( return_unformatted_values, l.deeds[1].city_transfer_tax, Currency( l.deeds[1].city_transfer_tax ) );  
		SELF.deed_county_transfer_tax := IF( return_unformatted_values, l.deeds[1].county_transfer_tax, Currency( l.deeds[1].county_transfer_tax ) );
		SELF.deed_total_transfer_tax  := IF( return_unformatted_values, l.deeds[1].total_transfer_tax, Currency( l.deeds[1].total_transfer_tax ) ); 
		SELF.deed_excise_tax_number   := l.deeds[1].excise_tax_number;  						

	// property info
	
		SELF.deed_property_use_desc              := l.deeds[1].property_use_desc;             
		SELF.deed_assessment_match_land_use_desc := l.deeds[1].assessment_match_land_use_desc;
		SELF.deed_condo_desc                     := l.deeds[1].condo_desc;                    
		SELF.deed_timeshare_flag                 := l.deeds[1].timeshare_flag;                			
		
	// mortgage info
		
		SELF.deed_first_td_loan_amount           := IF( return_unformatted_values, l.deeds[1].first_td_loan_amount, Currency( l.deeds[1].first_td_loan_amount ) );
		SELF.deed_first_td_loan_type_desc        := l.deeds[1].first_td_loan_type_desc;       
		SELF.deed_type_financing                 := l.deeds[1].type_financing;                
		SELF.deed_type_financing_desc            := l.deeds[1].type_financing_desc;           
		SELF.deed_first_td_interest_rate         := IF( return_unformatted_values, l.deeds[1].first_td_interest_rate, Rate( l.deeds[1].first_td_interest_rate ) );
		SELF.deed_first_td_due_date              := l.deeds[1].first_td_due_date;             
		SELF.deed_title_company_name             := l.deeds[1].title_company_name;            
		SELF.deed_rate_change_frequency          := l.deeds[1].rate_change_frequency;         
		SELF.deed_rate_change_frequency_desc     := l.deeds[1].rate_change_frequency_desc;    
		SELF.deed_change_index                   := IF( return_unformatted_values, l.deeds[1].change_index, Rate( l.deeds[1].change_index ) );
		SELF.deed_adjustable_rate_index          := IF( return_unformatted_values, l.deeds[1].adjustable_rate_index, Rate( l.deeds[1].adjustable_rate_index ) );         
		SELF.deed_adjustable_rate_index_desc     := l.deeds[1].adjustable_rate_index_desc;    
		SELF.deed_adjustable_rate_rider          := l.deeds[1].adjustable_rate_rider;         
		SELF.deed_graduated_payment_rider        := l.deeds[1].graduated_payment_rider;       
		SELF.deed_balloon_rider                  := l.deeds[1].balloon_rider;                 
		SELF.deed_fixed_step_rate_rider          := l.deeds[1].fixed_step_rate_rider;         
		SELF.deed_fixed_step_rate_rider_desc     := l.deeds[1].fixed_step_rate_rider_desc;    
		SELF.deed_condominium_rider              := l.deeds[1].condominium_rider;             
		SELF.deed_planned_unit_development_rider := l.deeds[1].planned_unit_development_rider;
		SELF.deed_rate_improvement_rider         := l.deeds[1].rate_improvement_rider;        
		SELF.deed_assumability_rider             := l.deeds[1].assumability_rider;            
		SELF.deed_prepayment_rider               := l.deeds[1].prepayment_rider;              
		SELF.deed_one_four_family_rider          := l.deeds[1].one_four_family_rider;         
		SELF.deed_biweekly_payment_rider         := l.deeds[1].biweekly_payment_rider;        
		SELF.deed_second_home_rider              := l.deeds[1].second_home_rider;             
		SELF.deed_second_td_loan_amount          := IF( return_unformatted_values, l.deeds[1].second_td_loan_amount, Currency( l.deeds[1].second_td_loan_amount ) );
		SELF.deed_first_td_lender_type_desc      := l.deeds[1].first_td_lender_type_desc;     
		SELF.deed_second_td_lender_type_desc     := l.deeds[1].second_td_lender_type_desc;    
		SELF.deed_partial_interest_transferred   := l.deeds[1].partial_interest_transferred;  
		SELF.deed_loan_term_months               := l.deeds[1].loan_term_months;              
		SELF.deed_loan_term_years                := l.deeds[1].loan_term_years;               	
							
	// addl fares info
	
		SELF.deed_transaction_type_desc   := l.deeds[1].fares_transaction_type_desc;  
		SELF.deed_mortgage_deed_type_desc := l.deeds[1].fares_mortgage_deed_type_desc;
		SELF.deed_mortgage_term_code_desc := l.deeds[1].fares_mortgage_term_code_desc;
		SELF.deed_mortgage_term           := l.deeds[1].fares_mortgage_term;          
		SELF.deed_iris_apn                := l.deeds[1].fares_iris_apn;               
		SELF.deed_lender_address          := l.deeds[1].fares_lender_address;         
		SELF.deed_mortgage_date           := l.deeds[1].fares_mortgage_date;          
		SELF.deed_building_square_feet    := l.deeds[1].fares_building_square_feet;   
		SELF.deed_foreclosure_desc        := l.deeds[1].fares_foreclosure_desc;      
		SELF.deed_refi_flag_desc          := l.deeds[1].fares_refi_flag_desc;        
		SELF.deed_equity_flag_desc        := l.deeds[1].fares_equity_flag_desc;       					
		DeedStatements := project(l.deeds[1].statementids,
																FFD.InitializeConsumerStatementBatch
																	(
																		left,
																		FFD.Constants.RecordType.RS ,
																		'deed',	
																		FFD.Constants.DataGroups.DEED, 
																		c ,
																		l.acctno ));
			
		DeedDisputes    := if(l.deeds[1].isDisputed , row(FFD.InitializeConsumerStatementBatch(
																									FFD.Constants.BlankStatementid,
																									FFD.Constants.RecordType.DR ,
																									'deed',	
																									FFD.Constants.DataGroups.DEED, 
																									c ,
																									l.acctno)));
		
//	***** ASSESSMENT SECTION *****

	// filing info

		SELF.assess_state_code                        := l.assessments[1].state_code;                       
		SELF.assess_county_name                       := l.assessments[1].county_name;                      
		SELF.assess_apna_or_pin_number                := l.assessments[1].apna_or_pin_number;               					
		SELF.assess_fips_code                         := l.assessments[1].fips_code;                        
		SELF.assess_duplicate_apn_multiple_address_id := l.assessments[1].duplicate_apn_multiple_address_id;					
		SELF.assess_tape_cut_date                     := l.assessments[1].tape_cut_date;                    
		SELF.assess_edition_number                    := l.assessments[1].edition_number;                   
		SELF.assess_certification_date                := l.assessments[1].certification_date;               

	// owner info

		SELF.assess_assessee_ownership_rights_desc := l.assessments[1].assessee_ownership_rights_desc;
		SELF.assess_assessee_relationship_desc     := l.assessments[1].assessee_relationship_desc;    
		SELF.assess_assessee_phone_number          := l.assessments[1].assessee_phone_number;         
		SELF.assess_tax_account_number             := l.assessments[1].tax_account_number;            
		SELF.assess_contract_owner                 := l.assessments[1].contract_owner;                
		SELF.assess_assessee_name_type_desc        := l.assessments[1].assessee_name_type_desc;       
		SELF.assess_second_assessee_name_type_desc := l.assessments[1].second_assessee_name_type_desc;						
		
	// address info
	
		SELF.assess_mail_care_of_name_type_desc := l.assessments[1].mail_care_of_name_type_desc;
		SELF.assess_mailing_care_of_name        := l.assessments[1].mailing_care_of_name;       
		SELF.assess_property_address_desc       := l.assessments[1].property_address_desc;      	
		
	// legal info

		SELF.assess_owner_occupied                   := l.assessments[1].owner_occupied;                  
		SELF.assess_recording_date                   := l.assessments[1].recording_date;                  
		SELF.assess_prior_recording_date             := l.assessments[1].prior_recording_date;            
		SELF.assess_county_land_use_description      := l.assessments[1].county_land_use_description;     
		SELF.assess_standardized_land_use_desc       := l.assessments[1].standardized_land_use_desc;      
		SELF.assess_legal_lot_number                 := l.assessments[1].legal_lot_number;                
		SELF.assess_legal_subdivision_name           := l.assessments[1].legal_subdivision_name;          
		SELF.assess_legal_brief_description          := l.assessments[1].legal_brief_description;         
		SELF.assess_record_type_desc                 := l.assessments[1].record_type_desc;                
		SELF.assess_recorder_book_number             := l.assessments[1].recorder_book_number;            
		SELF.assess_recorder_page_number             := l.assessments[1].recorder_page_number;            
		SELF.assess_legal_lot_desc                   := l.assessments[1].legal_lot_desc;                  
		SELF.assess_legal_land_lot                   := l.assessments[1].legal_land_lot;                  
		SELF.assess_legal_block                      := l.assessments[1].legal_block;                     
		SELF.assess_legal_section                    := l.assessments[1].legal_section;                   
		SELF.assess_legal_district                   := l.assessments[1].legal_district;                  
		SELF.assess_legal_unit                       := l.assessments[1].legal_unit;                      
		SELF.assess_legal_city_municipality_township := l.assessments[1].legal_city_municipality_township;
		SELF.assess_legal_phase_number               := l.assessments[1].legal_phase_number;              
		SELF.assess_legal_tract_number               := l.assessments[1].legal_tract_number;              
		SELF.assess_legal_sec_twn_rng_mer            := l.assessments[1].legal_sec_twn_rng_mer;           
		SELF.assess_legal_assessor_map_ref           := l.assessments[1].legal_assessor_map_ref;          
		SELF.assess_census_tract                     := l.assessments[1].census_tract;                    
		SELF.assess_ownership_type_desc              := l.assessments[1].ownership_type_desc;             
		SELF.assess_new_record_type_desc             := l.assessments[1].new_record_type_desc;            
		SELF.assess_timeshare_code                   := l.assessments[1].timeshare_code;                  
		SELF.assess_zoning                           := l.assessments[1].zoning;                          
		SELF.assess_recorder_document_number         := l.assessments[1].recorder_document_number;        
		SELF.assess_transfer_date                    := l.assessments[1].transfer_date;                   
		SELF.assess_document_type                    := l.assessments[1].document_type;                   
		SELF.assess_document_type_desc               := l.assessments[1].document_type_desc;              
		SELF.assess_prior_transfer_date              := l.assessments[1].prior_transfer_date;             
		
	// sales info

		SELF.assess_sale_date              := l.assessments[1].sale_date;             
		SELF.assess_sales_price            := IF( return_unformatted_values, l.assessments[1].sales_price, Currency( l.assessments[1].sales_price ) );
		SELF.assess_sales_price_desc       := l.assessments[1].sales_price_desc;      
		SELF.assess_prior_sales_price      := IF( return_unformatted_values, l.assessments[1].prior_sales_price, Currency( l.assessments[1].prior_sales_price ) );     
		SELF.assess_prior_sales_price_desc := l.assessments[1].prior_sales_price_desc;
		
	// mortgage info

		SELF.assess_mortgage_loan_amount    := IF( return_unformatted_values, l.assessments[1].mortgage_loan_amount, Currency( l.assessments[1].mortgage_loan_amount ) );
		SELF.assess_mortgage_loan_type_desc := l.assessments[1].mortgage_loan_type_desc;
		
	// lender info

		SELF.assess_mortgage_lender_name      := l.assessments[1].mortgage_lender_name;
		SELF.assess_mortgage_lender_type_desc := l.assessments[1].mortgage_lender_type_desc;	
		
	// assessment info	
		
		SELF.assess_assessed_total_value          := IF( return_unformatted_values, l.assessments[1].assessed_total_value, Currency( l.assessments[1].assessed_total_value ) );
		SELF.assess_assessed_value_year           := l.assessments[1].assessed_value_year;          
		SELF.assess_homestead_homeowner_exemption := l.assessments[1].homestead_homeowner_exemption;
		SELF.assess_assessed_improvement_value    := IF( return_unformatted_values, l.assessments[1].assessed_improvement_value, Currency( l.assessments[1].assessed_improvement_value ) );   
		SELF.assess_market_land_value             := IF( return_unformatted_values, l.assessments[1].market_land_value, Currency( l.assessments[1].market_land_value ) );            
		SELF.assess_market_improvement_value      := IF( return_unformatted_values, l.assessments[1].market_improvement_value, Currency( l.assessments[1].market_improvement_value ) );     
		SELF.assess_market_total_value            := IF( return_unformatted_values, l.assessments[1].market_total_value, Currency( l.assessments[1].market_total_value ) );           
		SELF.assess_market_value_year             := l.assessments[1].market_value_year;            
		SELF.assess_assessed_land_value           := IF( return_unformatted_values, l.assessments[1].assessed_land_value, Currency( l.assessments[1].assessed_land_value ) );          	
											
	// tax info
		
		SELF.assess_tax_year             := l.assessments[1].tax_year;            
		SELF.assess_tax_amount           := IF( return_unformatted_values, l.assessments[1].tax_amount, Currency( l.assessments[1].tax_amount ) );          
		SELF.assess_tax_exemption1_desc  := l.assessments[1].tax_exemption1_desc; 
		SELF.assess_tax_exemption2_desc  := l.assessments[1].tax_exemption2_desc; 
		SELF.assess_tax_exemption3_desc  := l.assessments[1].tax_exemption3_desc; 
		SELF.assess_tax_exemption4_desc  := l.assessments[1].tax_exemption4_desc; 
		SELF.assess_tax_rate_code_area   := l.assessments[1].tax_rate_code_area;  
		SELF.assess_tax_delinquent_year  := l.assessments[1].tax_delinquent_year; 
		SELF.assess_school_tax_district1 := l.assessments[1].school_tax_district1;
		SELF.assess_school_tax_district2 := l.assessments[1].school_tax_district2;
		SELF.assess_school_tax_district3 := l.assessments[1].school_tax_district3;										

	// property info

		SELF.assess_land_square_footage        := l.assessments[1].land_square_footage;        
		SELF.assess_year_built                 := l.assessments[1].year_built;                 
		SELF.assess_no_of_stories              := l.assessments[1].no_of_stories;              
		SELF.assess_no_of_stories_desc         := l.assessments[1].no_of_stories_desc;         
		SELF.assess_no_of_bedrooms             := l.assessments[1].no_of_bedrooms;             
		SELF.assess_no_of_baths                := l.assessments[1].no_of_baths;                
		SELF.assess_no_of_partial_baths        := l.assessments[1].no_of_partial_baths;        
		SELF.assess_garage_type_desc           := l.assessments[1].garage_type_desc;           
		SELF.assess_pool_desc                  := l.assessments[1].pool_desc;                  
		SELF.assess_exterior_walls_desc        := l.assessments[1].exterior_walls_desc;        
		SELF.assess_roof_type_desc             := l.assessments[1].roof_type_desc;             
		SELF.assess_heating_desc               := l.assessments[1].heating_desc;               
		SELF.assess_heating_fuel_type_desc     := l.assessments[1].heating_fuel_type_desc;     
		SELF.assess_air_conditioning_desc      := l.assessments[1].air_conditioning_desc;      
		SELF.assess_air_conditioning_type_desc := l.assessments[1].air_conditioning_type_desc; 
		SELF.assess_land_acres                 := l.assessments[1].land_acres;                 
		SELF.assess_land_dimensions            := l.assessments[1].land_dimensions;            
		SELF.assess_building_area              := l.assessments[1].building_area;              
		SELF.assess_building_area1             := l.assessments[1].building_area1;             
		SELF.assess_building_area2             := l.assessments[1].building_area2;             
		SELF.assess_building_area3             := l.assessments[1].building_area3;             
		SELF.assess_building_area4             := l.assessments[1].building_area4;             
		SELF.assess_building_area5             := l.assessments[1].building_area5;             
		SELF.assess_building_area6             := l.assessments[1].building_area6;             
		SELF.assess_building_area7             := l.assessments[1].building_area7;             
		SELF.assess_building_area_desc         := l.assessments[1].building_area_desc;         
		SELF.assess_building_area1_desc        := l.assessments[1].building_area1_desc;        
		SELF.assess_building_area2_desc        := l.assessments[1].building_area2_desc;        
		SELF.assess_building_area3_desc        := l.assessments[1].building_area3_desc;        
		SELF.assess_building_area4_desc        := l.assessments[1].building_area4_desc;        
		SELF.assess_building_area5_desc        := l.assessments[1].building_area5_desc;        
		SELF.assess_building_area6_desc        := l.assessments[1].building_area6_desc;        
		SELF.assess_building_area7_desc        := l.assessments[1].building_area7_desc;        
		SELF.assess_effective_year_built       := l.assessments[1].effective_year_built;       
		SELF.assess_no_of_buildings            := l.assessments[1].no_of_buildings;            
		SELF.assess_no_of_units                := l.assessments[1].no_of_units;                
		SELF.assess_no_of_rooms                := l.assessments[1].no_of_rooms;                
		SELF.assess_parking_no_of_cars         := l.assessments[1].parking_no_of_cars;         

		SELF.assess_style_desc                 := l.assessments[1].style_desc;                 
		SELF.assess_type_construction_desc     := l.assessments[1].type_construction_desc;     
		SELF.assess_foundation_desc            := l.assessments[1].foundation_desc;            
		SELF.assess_roof_cover_desc            := l.assessments[1].roof_cover_desc;            
		SELF.assess_elevator                   := l.assessments[1].elevator;                   
		SELF.assess_fireplace_indicator_desc   := l.assessments[1].fireplace_indicator_desc;   
		SELF.assess_fireplace_number           := l.assessments[1].fireplace_number;           
		SELF.assess_basement_desc              := l.assessments[1].basement_desc;              
		SELF.assess_building_class_desc        := l.assessments[1].building_class_desc;        

		SELF.assess_site_influence1_desc       := l.assessments[1].site_influence1_desc;       
		SELF.assess_site_influence2_desc       := l.assessments[1].site_influence2_desc;       
		SELF.assess_site_influence3_desc       := l.assessments[1].site_influence3_desc;       
		SELF.assess_site_influence4_desc       := l.assessments[1].site_influence4_desc;       
		SELF.assess_site_influence5_desc       := l.assessments[1].site_influence5_desc;       

		SELF.assess_amenities1_desc            := l.assessments[1].amenities1_desc;           
		SELF.assess_amenities2_desc            := l.assessments[1].amenities2_desc;           
		SELF.assess_amenities3_desc            := l.assessments[1].amenities3_desc;           
		SELF.assess_amenities4_desc            := l.assessments[1].amenities4_desc;           
		SELF.assess_amenities5_desc            := l.assessments[1].amenities5_desc;           

		SELF.assess_other_buildings1_desc      := l.assessments[1].other_buildings1_desc;     
		SELF.assess_other_buildings2_desc      := l.assessments[1].other_buildings2_desc;     
		SELF.assess_other_buildings3_desc      := l.assessments[1].other_buildings3_desc;     
		SELF.assess_other_buildings4_desc      := l.assessments[1].other_buildings4_desc;     
		SELF.assess_other_buildings5_desc      := l.assessments[1].other_buildings5_desc;     

		SELF.assess_condo_project_name         := l.assessments[1].condo_project_name;         
		SELF.assess_building_name              := l.assessments[1].building_name;              
		SELF.assess_comments                   := l.assessments[1].comments;                   

		SELF.assess_neighborhood_code          := l.assessments[1].neighborhood_code;          
		
	// fares info

		SELF.assess_living_square_feet           := l.assessments[1].fares_living_square_feet;          
		SELF.assess_iris_apn                     := l.assessments[1].fares_iris_apn;                    
		SELF.assess_addl_legal                   := l.assessments[1].addl_legal;                        					
		SELF.assess_calculated_land_value        := IF( return_unformatted_values, l.assessments[1].fares_calculated_land_value, Currency( l.assessments[1].fares_calculated_land_value ) );       
		SELF.assess_calculated_improvement_value := IF( return_unformatted_values, l.assessments[1].fares_calculated_improvement_value, Currency( l.assessments[1].fares_calculated_improvement_value ) );
		SELF.assess_calculated_total_value       := IF( return_unformatted_values, l.assessments[1].fares_calculated_total_value, Currency( l.assessments[1].fares_calculated_total_value ) );      
		SELF.assess_adjusted_gross_square_feet   := l.assessments[1].fares_adjusted_gross_square_feet;  
		SELF.assess_no_of_full_baths             := l.assessments[1].fares_no_of_full_baths;            
		SELF.assess_no_of_half_baths             := l.assessments[1].fares_no_of_half_baths;            
		SELF.assess_pool_indicator               := l.assessments[1].fares_pool_indicator;              
		SELF.assess_frame_desc                   := l.assessments[1].fares_frame_desc;                  
		SELF.assess_electric_energy_desc         := l.assessments[1].fares_electric_energy_desc;        
		SELF.assess_sewer_desc                   := l.assessments[1].fares_sewer_desc;                  
		SELF.assess_water_desc                   := l.assessments[1].fares_water_desc;                  
		SELF.assess_condition_desc               := l.assessments[1].fares_condition_desc;                  		

		assessStatements := project(l.assessments[1].statementids, FFD.InitializeConsumerStatementBatch
		(left
			,
			FFD.Constants.RecordType.RS ,
			'assess',	
			FFD.Constants.DataGroups.ASSESSMENT, 
			c ,
			l.acctno ));
		assessDisputes := if(l.assessments[1].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'assess',	
			FFD.Constants.DataGroups.ASSESSMENT, 
			c ,
			l.acctno )));
		
//	***** PARTIES *****

		// Property
		
		SELF.property_address1      := fn_DisplayAddr1(l.parties( LCase(party_type_name) = 'property' ));
		SELF.property_address2      := fn_DisplayAddr2(l.parties( LCase(party_type_name) = 'property' ));
		SELF.property_p_city_name   := property_party.p_city_name;    	
		SELF.property_v_city_name   := property_party.v_city_name;    	
		SELF.property_st            := property_party.st;             
		SELF.property_zip           := property_party.zip;            
		SELF.property_zip4          := property_party.zip4;           
		SELF.property_county_name   := property_party.county_name;    	
		SELF.property_geo_lat       := property_party.geo_lat;        
		SELF.property_geo_long      := property_party.geo_long;       
		SELF.property_msa           := fn_GetMsaPlusDesc(property_party.msa); 
		SELF.property_orig_address  := property_party.orig_addr;
		SELF.property_orig_unit     := property_party.orig_unit;
		SELF.property_orig_csz      := property_party.orig_csz;
/* 	Don't have statements or disputes for property  party */
		// Buyer 
		
		SELF.buyer_address1         := fn_DisplayAddr1(l.parties( LCase(party_type_name) = 'buyer' ));
		SELF.buyer_address2         := fn_DisplayAddr2(l.parties( LCase(party_type_name) = 'buyer' ));
		SELF.buyer_p_city_name      := buyer_party.p_city_name;    
		SELF.buyer_v_city_name      := buyer_party.v_city_name;    
		SELF.buyer_st               := buyer_party.st;             
		SELF.buyer_zip              := buyer_party.zip;            
		SELF.buyer_zip4             := buyer_party.zip4;           
		SELF.buyer_county_name      := buyer_party.county_name;    
		SELF.buyer_geo_lat          := buyer_party.geo_lat;        
		SELF.buyer_geo_long         := buyer_party.geo_long;       
		SELF.buyer_msa              := fn_GetMsaPlusDesc(buyer_party.msa);    
		SELF.buyer_orig_address     := buyer_party.orig_addr;
		SELF.buyer_orig_unit        := buyer_party.orig_unit;
		SELF.buyer_orig_csz         := buyer_party.orig_csz;
		SELF.buyer_phone_number     := buyer_party.phone_number;   	
		SELF.buyer_vesting_desc     := l.deeds[1].buyer_vesting_desc;
			
		SELF.buyer_1_orig_name      := StringLib.StringCleanSpaces( buyer_party.orig_names[1].orig_name );
		SELF.buyer_1_id_desc        := l.deeds[1].buyer1_id_desc;
		SELF.buyer_1_title          := buyer_party.entity[1].title;     
		SELF.buyer_1_first_name     := buyer_party.entity[1].fname;     
		SELF.buyer_1_middle_name    := buyer_party.entity[1].mname;     
		SELF.buyer_1_last_name      := buyer_party.entity[1].lname;      
		SELF.buyer_1_name_suffix    := buyer_party.entity[1].name_suffix;
		SELF.buyer_1_company_name   := buyer_party.entity[1].cname;     
		SELF.buyer_1_did            := buyer_party.entity[1].did;       
		SELF.buyer_1_bdid           := buyer_party.entity[1].bdid;
		SELF.buyer_1_ultid					:= buyer_party.entity[1].ultid;
		SELF.buyer_1_orgid					:= buyer_party.entity[1].orgid;
		SELF.buyer_1_seleid					:= buyer_party.entity[1].seleid;
		SELF.buyer_1_proxid					:= buyer_party.entity[1].proxid;
		SELF.buyer_1_powid					:= buyer_party.entity[1].powid;
		SELF.buyer_1_empid					:= buyer_party.entity[1].empid;
		SELF.buyer_1_dotid					:= buyer_party.entity[1].dotid;
		SELF.buyer_1_ssn            := buyer_party.entity[1].app_ssn;       
    
		buyer_1_Statements := project(buyer_party.entity[1].statementids,FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'buyer_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		 ));
		 
			buyer_1_Disputes := if(buyer_party.entity[1].isDisputed, row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'buyer_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno 
		)));
		
		SELF.buyer_2_orig_name      := StringLib.StringCleanSpaces( buyer_party.orig_names[2].orig_name );   
		SELF.buyer_2_id_desc        := l.deeds[1].buyer2_id_desc;
		SELF.buyer_2_title          := buyer_party.entity[2].title;     
		SELF.buyer_2_first_name     := buyer_party.entity[2].fname;     
		SELF.buyer_2_middle_name    := buyer_party.entity[2].mname;     
		SELF.buyer_2_last_name      := buyer_party.entity[2].lname;      
		SELF.buyer_2_name_suffix    := buyer_party.entity[2].name_suffix;
		SELF.buyer_2_company_name   := buyer_party.entity[2].cname;     
		SELF.buyer_2_did            := buyer_party.entity[2].did;       
		SELF.buyer_2_bdid           := buyer_party.entity[2].bdid;
		SELF.buyer_2_ultid					:= buyer_party.entity[2].ultid;
		SELF.buyer_2_orgid					:= buyer_party.entity[2].orgid;
		SELF.buyer_2_seleid					:= buyer_party.entity[2].seleid;
		SELF.buyer_2_proxid					:= buyer_party.entity[2].proxid;
		SELF.buyer_2_powid					:= buyer_party.entity[2].powid;
		SELF.buyer_2_empid					:= buyer_party.entity[2].empid;
		SELF.buyer_2_dotid					:= buyer_party.entity[2].dotid;
		SELF.buyer_2_ssn            := buyer_party.entity[2].app_ssn;    			
		buyer_2_Statements := project(buyer_party.entity[2].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'buyer_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		 ));
		 
		buyer_2_Disputes := if(buyer_party.entity[2].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'buyer_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno )));
		

		                                                                                                    
		// Seller
		
		SELF.seller_address1         := fn_DisplayAddr1(l.parties( LCase(party_type_name) = 'seller' ));
		SELF.seller_address2         := fn_DisplayAddr2(l.parties( LCase(party_type_name) = 'seller' ));
		SELF.seller_p_city_name      := seller_party.p_city_name;    	
		SELF.seller_v_city_name      := seller_party.v_city_name;    	
		SELF.seller_st               := seller_party.st;             
		SELF.seller_zip              := seller_party.zip;            
		SELF.seller_zip4             := seller_party.zip4;           
		SELF.seller_county_name      := seller_party.county_name;    	
		SELF.seller_geo_lat          := seller_party.geo_lat;        
		SELF.seller_geo_long         := seller_party.geo_long;       
		SELF.seller_msa              := fn_GetMsaPlusDesc(seller_party.msa);      
		SELF.seller_orig_address     := seller_party.orig_addr;
		SELF.seller_orig_unit        := seller_party.orig_unit;
		SELF.seller_orig_csz         := seller_party.orig_csz;
		SELF.seller_phone_number     := seller_party.phone_number;   	

		SELF.seller_1_orig_name      := StringLib.StringCleanSpaces( seller_party.orig_names[1].orig_name );    
		SELF.seller_1_id_desc        := l.deeds[1].seller1_id_desc;
		SELF.seller_1_title          := seller_party.entity[1].title;     
		SELF.seller_1_first_name     := seller_party.entity[1].fname;     
		SELF.seller_1_middle_name    := seller_party.entity[1].mname;     
		SELF.seller_1_last_name      := seller_party.entity[1].lname;      
		SELF.seller_1_name_suffix    := seller_party.entity[1].name_suffix;
		SELF.seller_1_company_name   := seller_party.entity[1].cname;     
		SELF.seller_1_did            := seller_party.entity[1].did;   
		SELF.seller_1_bdid           := seller_party.entity[1].bdid; 
		SELF.seller_1_ultid					 := seller_party.entity[1].ultid;
		SELF.seller_1_orgid					 := seller_party.entity[1].orgid;
		SELF.seller_1_seleid				 := seller_party.entity[1].seleid;
		SELF.seller_1_proxid				 := seller_party.entity[1].proxid;
		SELF.seller_1_powid					 := seller_party.entity[1].powid;
		SELF.seller_1_empid					 := seller_party.entity[1].empid;
		SELF.seller_1_dotid					 := seller_party.entity[1].dotid;
		SELF.seller_1_ssn            := seller_party.entity[1].app_ssn;       
		seller_1_Statements := project(seller_party.entity[1].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'seller_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
		seller_1_Disputes := if(seller_party.entity[1].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'seller_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno )));
		
		
		SELF.seller_2_orig_name      := StringLib.StringCleanSpaces( seller_party.orig_names[2].orig_name );
		SELF.seller_2_id_desc        := l.deeds[1].seller2_id_desc;
		SELF.seller_2_title          := seller_party.entity[2].title;     
		SELF.seller_2_first_name     := seller_party.entity[2].fname;     
		SELF.seller_2_middle_name    := seller_party.entity[2].mname;     
		SELF.seller_2_last_name      := seller_party.entity[2].lname;      
		SELF.seller_2_name_suffix    := seller_party.entity[2].name_suffix;
		SELF.seller_2_company_name   := seller_party.entity[2].cname;     
		SELF.seller_2_did            := seller_party.entity[2].did;       
		SELF.seller_2_bdid           := seller_party.entity[2].bdid;
	 	SELF.seller_2_ultid					 := seller_party.entity[2].ultid;
		SELF.seller_2_orgid					 := seller_party.entity[2].orgid;
		SELF.seller_2_seleid				 := seller_party.entity[2].seleid;
		SELF.seller_2_proxid				 := seller_party.entity[2].proxid;
		SELF.seller_2_powid					 := seller_party.entity[2].powid;
		SELF.seller_2_empid					 := seller_party.entity[2].empid;
		SELF.seller_2_dotid					 := seller_party.entity[2].dotid;
		SELF.seller_2_ssn            := seller_party.entity[2].app_ssn; 
		seller_2_Statements := project( seller_party.entity[2].statementids,FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'seller_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
		seller_2_Disputes := if(seller_party.entity[2].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'seller_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		)));
		
		// Owner
		
		SELF.owner_address1         := fn_DisplayAddr1(l.parties( LCase(party_type_name) IN ['buyer','assessee']));
		SELF.owner_address2         := fn_DisplayAddr2(l.parties( LCase(party_type_name) IN ['buyer','assessee']));
		SELF.owner_p_city_name      := owner_party.p_city_name;    
		SELF.owner_v_city_name      := owner_party.v_city_name;    
		SELF.owner_st               := owner_party.st;             
		SELF.owner_zip              := owner_party.zip;            
		SELF.owner_zip4             := owner_party.zip4;           
		SELF.owner_county_name      := owner_party.county_name;    
		SELF.owner_geo_lat          := owner_party.geo_lat;        
		SELF.owner_geo_long         := owner_party.geo_long;       
		SELF.owner_msa              := fn_GetMsaPlusDesc(owner_party.msa);   
		SELF.owner_orig_address     := owner_party.orig_addr;
		SELF.owner_orig_unit        := owner_party.orig_unit;
		SELF.owner_orig_csz         := owner_party.orig_csz;
		SELF.owner_phone_number     := owner_party.phone_number;   	

		SELF.owner_1_orig_name      := StringLib.StringCleanSpaces( owner_party.orig_names[1].orig_name );    
		SELF.owner_1_title          := owner_party.entity[1].title;     
		SELF.owner_1_first_name     := owner_party.entity[1].fname;     
		SELF.owner_1_middle_name    := owner_party.entity[1].mname;     
		SELF.owner_1_last_name      := owner_party.entity[1].lname;      
		SELF.owner_1_name_suffix    := owner_party.entity[1].name_suffix;
		SELF.owner_1_company_name   := owner_party.entity[1].cname;     
		SELF.owner_1_did            := owner_party.entity[1].did;       
		SELF.owner_1_bdid           := owner_party.entity[1].bdid;
		SELF.owner_1_ultid					:= owner_party.entity[1].ultid;
		SELF.owner_1_orgid					:= owner_party.entity[1].orgid;
		SELF.owner_1_seleid				  := owner_party.entity[1].seleid;
		SELF.owner_1_proxid				  := owner_party.entity[1].proxid;
		SELF.owner_1_powid					:= owner_party.entity[1].powid;
		SELF.owner_1_empid					:= owner_party.entity[1].empid;
		SELF.owner_1_dotid					:= owner_party.entity[1].dotid;
		SELF.owner_1_ssn            := owner_party.entity[1].app_ssn;       
		owner_1_Statements := project(owner_party.entity[1].statementids ,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'owner_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
			owner_1_Disputes := if(owner_party.entity[1].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'owner_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		)));
		
		SELF.owner_2_orig_name      := StringLib.StringCleanSpaces( owner_party.orig_names[2].orig_name );    
		SELF.owner_2_title          := owner_party.entity[2].title;     
		SELF.owner_2_first_name     := owner_party.entity[2].fname;     
		SELF.owner_2_middle_name    := owner_party.entity[2].mname;     
		SELF.owner_2_last_name      := owner_party.entity[2].lname;      
		SELF.owner_2_name_suffix    := owner_party.entity[2].name_suffix;
		SELF.owner_2_company_name   := owner_party.entity[2].cname;     
		SELF.owner_2_did            := owner_party.entity[2].did;       
		SELF.owner_2_bdid           := owner_party.entity[2].bdid;
   	SELF.owner_2_ultid					:= owner_party.entity[2].ultid;
		SELF.owner_2_orgid					:= owner_party.entity[2].orgid;
		SELF.owner_2_seleid				  := owner_party.entity[2].seleid;
		SELF.owner_2_proxid				  := owner_party.entity[2].proxid;
		SELF.owner_2_powid					:= owner_party.entity[2].powid;
		SELF.owner_2_empid					:= owner_party.entity[2].empid;
		SELF.owner_2_dotid					:= owner_party.entity[2].dotid;
		SELF.owner_2_ssn            := owner_party.entity[2].app_ssn; 
		owner_2_Statements := project(owner_party.entity[2].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'owner_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		));
		 
		owner_2_Disputes := if(owner_party.entity[2].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'owner_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		)));
		
		SELF.assessee_address1         := fn_DisplayAddr1(l.parties( LCase(party_type_name) = 'assessee' ));
		SELF.assessee_address2         := fn_DisplayAddr2(l.parties( LCase(party_type_name) = 'assessee' ));
		SELF.assessee_p_city_name      := assessee_party.p_city_name;    	
		SELF.assessee_v_city_name      := assessee_party.v_city_name;    	
		SELF.assessee_st               := assessee_party.st;             
		SELF.assessee_zip              := assessee_party.zip;            
		SELF.assessee_zip4             := assessee_party.zip4;           
		SELF.assessee_county_name      := assessee_party.county_name;    	
		SELF.assessee_geo_lat          := assessee_party.geo_lat;        
		SELF.assessee_geo_long         := assessee_party.geo_long;       
		SELF.assessee_msa              := fn_GetMsaPlusDesc(assessee_party.msa);  
    SELF.assessee_orig_address     := assessee_party.orig_addr;
		SELF.assessee_orig_unit        := assessee_party.orig_unit;
		SELF.assessee_orig_csz         := assessee_party.orig_csz;
		SELF.assessee_phone_number     := assessee_party.phone_number;   	

		SELF.assessee_1_orig_name      := StringLib.StringCleanSpaces( assessee_party.orig_names[1].orig_name );    
		SELF.assessee_1_title          := assessee_party.entity[1].title;     
		SELF.assessee_1_first_name     := assessee_party.entity[1].fname;     
		SELF.assessee_1_middle_name    := assessee_party.entity[1].mname;     
		SELF.assessee_1_last_name      := assessee_party.entity[1].lname;      
		SELF.assessee_1_name_suffix    := assessee_party.entity[1].name_suffix;
		SELF.assessee_1_company_name   := assessee_party.entity[1].cname;     
		SELF.assessee_1_did            := assessee_party.entity[1].did;       
		SELF.assessee_1_bdid           := assessee_party.entity[1].bdid;
		SELF.assessee_1_ultid					 := assessee_party.entity[1].ultid;
		SELF.assessee_1_orgid					 := assessee_party.entity[1].orgid;
		SELF.assessee_1_seleid				 := assessee_party.entity[1].seleid;
		SELF.assessee_1_proxid				 := assessee_party.entity[1].proxid;
		SELF.assessee_1_powid					 := assessee_party.entity[1].powid;
		SELF.assessee_1_empid					 := assessee_party.entity[1].empid;
		SELF.assessee_1_dotid					 := assessee_party.entity[1].dotid;
		SELF.assessee_1_ssn            := assessee_party.entity[1].app_ssn;       
		assessee_1_Statements := project(assessee_party.entity[1].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'assessee_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
		assessee_1_Disputes := if(assessee_party.entity[1].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'assessee_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		)));
		
		
		SELF.assessee_2_orig_name      := StringLib.StringCleanSpaces( assessee_party.orig_names[2].orig_name );    
		SELF.assessee_2_title          := assessee_party.entity[2].title;     
		SELF.assessee_2_first_name     := assessee_party.entity[2].fname;     
		SELF.assessee_2_middle_name    := assessee_party.entity[2].mname;     
		SELF.assessee_2_last_name      := assessee_party.entity[2].lname;      
		SELF.assessee_2_name_suffix    := assessee_party.entity[2].name_suffix;
		SELF.assessee_2_company_name   := assessee_party.entity[2].cname;     
		SELF.assessee_2_did            := assessee_party.entity[2].did;       
		SELF.assessee_2_bdid           := assessee_party.entity[2].bdid; 
		SELF.assessee_2_ultid					 := assessee_party.entity[2].ultid;
		SELF.assessee_2_orgid					 := assessee_party.entity[2].orgid;
		SELF.assessee_2_seleid				 := assessee_party.entity[2].seleid;
		SELF.assessee_2_proxid				 := assessee_party.entity[2].proxid;
		SELF.assessee_2_powid					 := assessee_party.entity[2].powid;
		SELF.assessee_2_empid					 := assessee_party.entity[2].empid;
		SELF.assessee_2_dotid					 := assessee_party.entity[2].dotid;
		SELF.assessee_2_ssn            := assessee_party.entity[2].app_ssn; 		
		assessee_2_Statements := project(assessee_party.entity[2].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'assessee_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno ));
		 
		assessee_2_Disputes := if(assessee_party.entity[2].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'assessee_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		)));
		
		// Borrower
		
		SELF.borrower_address1         := fn_DisplayAddr1(l.parties( LCase(party_type_name) = 'borrower' ));
		SELF.borrower_address2         := fn_DisplayAddr2(l.parties( LCase(party_type_name) = 'borrower' ));
		SELF.borrower_p_city_name      := borrower_party.p_city_name;    	
		SELF.borrower_v_city_name      := borrower_party.v_city_name;    	
		SELF.borrower_st               := borrower_party.st;             
		SELF.borrower_zip              := borrower_party.zip;            
		SELF.borrower_zip4             := borrower_party.zip4;           
		SELF.borrower_county_name      := borrower_party.county_name;    	
		SELF.borrower_geo_lat          := borrower_party.geo_lat;        
		SELF.borrower_geo_long         := borrower_party.geo_long;       
		SELF.borrower_msa              := fn_GetMsaPlusDesc(borrower_party.msa);     
		SELF.borrower_orig_address     := borrower_party.orig_addr;
		SELF.borrower_orig_unit        := borrower_party.orig_unit;
		SELF.borrower_orig_csz         := borrower_party.orig_csz;
		SELF.borrower_phone_number     := borrower_party.phone_number;   	
		SELF.borrower_vesting_desc     := l.deeds[1].borrower_vesting_desc;

		SELF.borrower_1_orig_name      := StringLib.StringCleanSpaces( borrower_party.orig_names[1].orig_name );    
		SELF.borrower_1_id_desc        := l.deeds[1].borrower1_id_desc;
		SELF.borrower_1_title          := borrower_party.entity[1].title;     
		SELF.borrower_1_first_name     := borrower_party.entity[1].fname;     
		SELF.borrower_1_middle_name    := borrower_party.entity[1].mname;     
		SELF.borrower_1_last_name      := borrower_party.entity[1].lname;      
		SELF.borrower_1_name_suffix    := borrower_party.entity[1].name_suffix;
		SELF.borrower_1_company_name   := borrower_party.entity[1].cname;     
		SELF.borrower_1_did            := borrower_party.entity[1].did;       
		SELF.borrower_1_bdid           := borrower_party.entity[1].bdid;
		SELF.borrower_1_ultid					 := borrower_party.entity[1].ultid;
		SELF.borrower_1_orgid					 := borrower_party.entity[1].orgid;
		SELF.borrower_1_seleid				 := borrower_party.entity[1].seleid;
		SELF.borrower_1_proxid				 := borrower_party.entity[1].proxid;
		SELF.borrower_1_powid					 := borrower_party.entity[1].powid;
		SELF.borrower_1_empid					 := borrower_party.entity[1].empid;
		SELF.borrower_1_dotid					 := borrower_party.entity[1].dotid;
		SELF.borrower_1_ssn            := borrower_party.entity[1].app_ssn;       
		borrower_1_Statements := project(borrower_party.entity[1].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'borrower_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
		borrower_1_Disputes := if(borrower_party.entity[1].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'borrower_1',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		)));
		
		SELF.borrower_2_orig_name      := StringLib.StringCleanSpaces( borrower_party.orig_names[2].orig_name );    
		SELF.borrower_2_id_desc        := l.deeds[1].borrower2_id_desc;
		SELF.borrower_2_title          := borrower_party.entity[2].title;     
		SELF.borrower_2_first_name     := borrower_party.entity[2].fname;     
		SELF.borrower_2_middle_name    := borrower_party.entity[2].mname;     
		SELF.borrower_2_last_name      := borrower_party.entity[2].lname;      
		SELF.borrower_2_name_suffix    := borrower_party.entity[2].name_suffix;
		SELF.borrower_2_company_name   := borrower_party.entity[2].cname;     
		SELF.borrower_2_did            := borrower_party.entity[2].did;       
		SELF.borrower_2_bdid           := borrower_party.entity[2].bdid;
		SELF.borrower_2_ultid					 := borrower_party.entity[2].ultid;
		SELF.borrower_2_orgid					 := borrower_party.entity[2].orgid;
		SELF.borrower_2_seleid				 := borrower_party.entity[2].seleid;
		SELF.borrower_2_proxid				 := borrower_party.entity[2].proxid;
		SELF.borrower_2_powid					 := borrower_party.entity[2].powid;
		SELF.borrower_2_empid					 := borrower_party.entity[2].empid;
		SELF.borrower_2_dotid					 := borrower_party.entity[2].dotid;
		SELF.borrower_2_ssn            := borrower_party.entity[2].app_ssn; 
		borrower_2_Statements := project(borrower_party.entity[2].statementids,
		FFD.InitializeConsumerStatementBatch
		(
			left,
			FFD.Constants.RecordType.RS ,
			'borrower_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno /*, did */
		));
		 
		borrower_2_Disputes := if(borrower_party.entity[2].isDisputed,row(FFD.InitializeConsumerStatementBatch
		(
			FFD.Constants.BlankStatementid,
			FFD.Constants.RecordType.DR ,
			'borrower_2',	
			FFD.Constants.DataGroups.PROPERTY_SEARCH, 
			c ,
			l.acctno
		)));
		
		SELF.StatementsAndDisputes := DeedDisputes + 
																	assessDisputes +
																	buyer_1_Disputes + 
																	buyer_2_Disputes + 
																	seller_1_Disputes +
																	seller_2_Disputes +
																	owner_1_Disputes +
																	owner_2_Disputes +
																	assessee_1_Disputes +
																	assessee_2_Disputes +
																	borrower_1_Disputes +
																	borrower_2_Disputes + 
																			DeedStatements + 
																			assessStatements +
																			buyer_1_Statements + 
																			buyer_2_Statements + 
																			seller_1_Statements +
																			seller_2_Statements +
																			owner_1_Statements +
																			owner_2_Statements +
																			assessee_1_Statements +
																			assessee_2_Statements +
																			borrower_1_Statements +
																			borrower_2_Statements;
		
		SELF := l;
		
	END;