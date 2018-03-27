/*
We will probably adjust this somewhat as we go along...
This will replace fields that we think can be replaced
*/
IMPORT PRTE2_LNProperty.V_Refresh_Data_Base_Files;

Assess_Refresh_Base_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.assessorKey_Renew_Layout;

batchInLayout := V_Refresh_Data_Base_Files.EnhancedBatchIn_Layout;
EXPORT batchInLayout V_Refresh_Data_Transform_A_to_BatIn(batchInLayout L, Assess_Refresh_Base_Layout R) := TRANSFORM

		cleanUpStringDollars(STRING x) := FUNCTION
				y := (integer)regexreplace('[^0-9\\.]',x,'');
				RETURN IF(y=0, '', (STRING)y );
		END;
		cleanOrReplaceIfNewExists(STRING oldValue, STRING newValue) := IF( newValue<>'', TRIM(newValue), cleanUpStringDollars(TRIM(oldValue)) );
		replaceIfNew_Exists(STRING oldValue, STRING newValue) := IF( newValue<>'', TRIM(newValue), TRIM(oldValue) );


		SELF.CTscore := 99;		// just a flag
		SELF.total_robustness_score := R.total_robustness_score;
		SELF.key_robustness_score := R.key_robustness_score;
		// Aging related fields - but to do these we need to connect to the Roxie SF key to get all data and maybe sort by date.
		SELF.assess_assessed_value_year := replaceIfNew_Exists(l.assess_assessed_value_year,r.assessed_value_year);
		SELF.assess_effective_year_built := replaceIfNew_Exists(l.assess_effective_year_built,r.effective_year_built);
		SELF.assess_market_value_year := replaceIfNew_Exists(l.assess_market_value_year,r.market_value_year);
		SELF.assess_tax_year := replaceIfNew_Exists(l.assess_tax_year,r.tax_year);
		SELF.assess_year_built := replaceIfNew_Exists(l.assess_year_built,r.year_built);
		SELF.assess_recording_date := replaceIfNew_Exists(l.assess_recording_date,r.recording_date);
		SELF.assess_sale_date := replaceIfNew_Exists(l.assess_sale_date,r.sale_date);

		// other codes and generic fields that I don't think are recognizable PII
		SELF.assess_air_conditioning_type_code := replaceIfNew_Exists(l.assess_air_conditioning_type_code,r.air_conditioning_code);
		SELF.assess_basement_code := replaceIfNew_Exists(l.assess_basement_code,r.basement_code);
		SELF.assess_building_quality_code := replaceIfNew_Exists(l.assess_building_quality_code,r.building_quality_code);
		SELF.assess_building_class_code := replaceIfNew_Exists(l.assess_building_class_code,r.building_class_code);
		SELF.assess_census_tract := replaceIfNew_Exists(l.assess_census_tract,r.census_tract);
		SELF.assessee_county_name := replaceIfNew_Exists(l.assessee_county_name,r.county_name);
		SELF.assess_exterior_walls_code := replaceIfNew_Exists(l.assess_exterior_walls_code,r.exterior_walls_code);
		SELF.assess_fips_code := replaceIfNew_Exists(l.assess_fips_code,r.fips_code);
		SELF.assess_fireplace_indicator := replaceIfNew_Exists(l.assess_fireplace_indicator,r.fireplace_indicator);
		SELF.assess_fireplace_number := replaceIfNew_Exists(l.assess_fireplace_number,r.fireplace_number);
		SELF.assess_floor_cover_code := replaceIfNew_Exists(l.assess_floor_cover_code,r.floor_cover_code);
		SELF.assess_foundation_code := replaceIfNew_Exists(l.assess_foundation_code,r.foundation_code);
		SELF.assess_garage_type_code := replaceIfNew_Exists(l.assess_garage_type_code,r.garage_type_code);
		SELF.assess_heating_code := replaceIfNew_Exists(l.assess_heating_code,r.heating_code);
		SELF.assess_heating_fuel_type_code := replaceIfNew_Exists(l.assess_heating_fuel_type_code,r.heating_fuel_type_code);
		SELF.assess_homestead_homeowner_exempt := replaceIfNew_Exists(l.assess_homestead_homeowner_exempt,r.tax_exemption1_code);
		SELF.assess_assessed_land_value := cleanOrReplaceIfNewExists(l.assess_assessed_land_value,r.assessed_land_value);
		SELF.assess_land_acrs := replaceIfNew_Exists(l.assess_land_acrs,r.land_acres);
		SELF.assess_assessed_improvement_value := cleanOrReplaceIfNewExists(l.assess_assessed_improvement_value,r.assessed_improvement_value);
		SELF.assess_assessed_total_value := cleanOrReplaceIfNewExists(l.assess_assessed_total_value,r.assessed_total_value);
		SELF.assess_land_dimensions := replaceIfNew_Exists(l.assess_land_dimensions,r.land_dimensions);
		SELF.assess_county_land_use_code := replaceIfNew_Exists(l.assess_county_land_use_code,r.county_land_use_code);
		SELF.assess_county_land_use_desc := replaceIfNew_Exists(l.assess_county_land_use_desc,r.county_land_use_description);
		
		// not in the assessment key - go ahead and clean $$ up, but these are probably RESPONSE fields and not data fields.
		SELF.assess_calculated_land_value := cleanOrReplaceIfNewExists(l.assess_calculated_land_value,'');
		SELF.assess_calculated_improvement_value := cleanOrReplaceIfNewExists(l.assess_calculated_improvement_value,'');
		SELF.assess_calculated_total_value := cleanOrReplaceIfNewExists(l.assess_calculated_total_value,'');		

		// not in the assessment key - go ahead and clean $$ up, but these should be only in the Deed records.
		SELF.deed_sales_price := cleanOrReplaceIfNewExists(l.deed_sales_price,'');		
		SELF.deed_first_td_loan_amt := cleanOrReplaceIfNewExists(l.deed_first_td_loan_amt,'');	
		// NOTE: I'm trying this such that I throw in all this Assessor values even into the 257 deed records we have.
		// we may have to rethink this and remove the assessor fields from those 257 ??
		// might need to do something similar but only for the 257 deed records

		// legal* fields - might want but might need to scramble as PII?
		SELF.assess_legal_block := replaceIfNew_Exists(l.assess_legal_block,r.legal_block);
		SELF.assess_legal_brief_desc  := replaceIfNew_Exists(l.assess_legal_brief_desc,r.legal_brief_description);
		SELF.assess_legal_city_municipal_township := replaceIfNew_Exists(l.assess_legal_city_municipal_township,r.legal_city_municipality_township);
		SELF.assess_legal_lot_number := replaceIfNew_Exists(l.assess_legal_lot_number,r.legal_lot_number);
		SELF.assess_legal_section := replaceIfNew_Exists(l.assess_legal_section,r.legal_section);
		SELF.assess_legal_subdivision_name := replaceIfNew_Exists(l.assess_legal_subdivision_name,r.legal_subdivision_name);
		SELF.assess_market_land_value := cleanOrReplaceIfNewExists(l.assess_market_land_value,r.market_land_value);
		SELF.assess_market_total_value := cleanOrReplaceIfNewExists(l.assess_market_total_value,r.market_total_value);
		SELF.assess_market_improvement_value := cleanOrReplaceIfNewExists(l.assess_market_improvement_value,r.market_improvement_value);
		SELF.assess_no_of_baths := replaceIfNew_Exists(l.assess_no_of_baths,r.no_of_baths);
		SELF.assess_no_of_bedrooms := replaceIfNew_Exists(l.assess_no_of_bedrooms,r.no_of_bedrooms);
		SELF.assess_no_of_rooms := replaceIfNew_Exists(l.assess_no_of_rooms,r.no_of_rooms);
		SELF.assess_no_of_stories := replaceIfNew_Exists(l.assess_no_of_stories,r.no_of_stories);
		SELF.assess_no_of_units := replaceIfNew_Exists(l.assess_no_of_units,r.no_of_units);
		SELF.assess_parking_no_of_cars := replaceIfNew_Exists(l.assess_parking_no_of_cars,r.parking_no_of_cars);
		SELF.assess_pool_code := replaceIfNew_Exists(l.assess_pool_code,r.pool_code);
		SELF.assess_recorder_document_number  := replaceIfNew_Exists(l.assess_recorder_document_number,r.recorder_document_number);
		SELF.assess_roof_cover_code := replaceIfNew_Exists(l.assess_roof_cover_code,r.roof_cover_code);
		// r.sales_price
		SELF.assess_site_influence1_code := replaceIfNew_Exists(l.assess_site_influence1_code,r.site_influence1_code);
		// r.standardized_land_use_code
		SELF.assess_tax_amount := cleanOrReplaceIfNewExists(l.assess_tax_amount,r.tax_amount);
		SELF.assess_tax_rate_code := replaceIfNew_Exists(l.assess_tax_rate_code,r.tax_rate_code_area);
		SELF.assess_type_construction_code := replaceIfNew_Exists(l.assess_type_construction_code,r.type_construction_code);
		SELF.assess_zoning := replaceIfNew_Exists(l.assess_zoning,r.zoning);
		SELF.assess_document_type := replaceIfNew_Exists(l.assess_document_type,r.document_type);
		SELF.assess_sales_price  := cleanOrReplaceIfNewExists(l.assess_sales_price,r.sales_price);
		// SELF.assess_sales_price_desc  := replaceIfNew_Exists(l.assess_sales_price_desc,r.sales_price_desc);
		SELF.assess_prior_sales_price := cleanOrReplaceIfNewExists(l.assess_prior_sales_price,r.prior_sales_price);
		// SELF.assess_prior_sales_price_desc := replaceIfNew_Exists(l.assess_prior_sales_price,r.prior_sales_price_desc);
		
		SELF.assess_mortgage_loan_amount := cleanOrReplaceIfNewExists(l.assess_mortgage_loan_amount,r.mortgage_loan_amount);
		// this is in assessor key, but spreadsheet seems to only have a deed field for it.
		SELF.deed_timeshare_flag := replaceIfNew_Exists(l.deed_timeshare_flag,r.timeshare_code);
		SELF := L;
END;
		// These are DEED ONLY FIELDS.		
		// SELF.deed_recording_date := replaceIfNew_Exists(l.deed_recording_date,r.values2);
		// SELF.document_number  := replaceIfNew_Exists(l.document_number,r.values2);
		// SELF.first_td_loan_amount := replaceIfNew_Exists(l.first_td_loan_amount,r.values2);
		// SELF.first_td_loan_type_code := replaceIfNew_Exists(l.first_td_loan_type_code,r.values2);
		// SELF.property_county_name := replaceIfNew_Exists(l.property_county_name,r.values2);
		// SELF.second_td_loan_amount := replaceIfNew_Exists(l.second_td_loan_amount,r.values2);

				// hasLandUseCode := testStrValue(l.assess_standardized_land_use_code
				// hasLatitude := testStrValue(l.geo_lat
				// hasLongitude := testStrValue(l.geo_long
				// hasLotSize := testStrValue(l.land_lot_size
				// hasPCTImproved := testIntValue(l.percent_improved
				// hasInterestRate := testStrValue(l.first_td_interest_rate
				// hasIntRateTypeCode := testStrValue(l.type_financing
				// hasSaleTypeCode := testStrValue(l.sales_price_code
				// hasSaleFullPart := testStrValue(l.sales_price_code
				// hasNbrFullBath := testStrValue(l.fares_no_of_full_baths
				// hasNbrHalfBath := testStrValue(l.fares_no_of_half_baths
				// hasNbrBathFixture :=  testStrValue(l.fares_no_of_bath_fixtures
				// hasPoolInd := testStrValue(l.fares_pool_indicator
				// hasBldgSqFeet := testStrValue(l.fares_building_square_feet
				// hasGroundSqFt := testStrValue(l.fares_ground_floor_square_feet
				// hasBasementSqFt := testStrValue(l.fares_basement_square_feet
				// hasGarageSqFt := testStrValue(l.fares_garage_square_feet
				// hasAssessmentAPNNbr := testStrValue(l.fares_unformatted_apn
				// hasFrameType := testStrValue(l.fares_frame
				// hasSewer := testStrValue(l.fares_sewer
				// hasWaterCode := testStrValue(l.fares_water