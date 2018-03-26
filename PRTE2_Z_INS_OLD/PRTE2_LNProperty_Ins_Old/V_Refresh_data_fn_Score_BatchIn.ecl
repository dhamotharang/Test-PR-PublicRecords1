/* I can use this function to generate a scored version of our batch_in spreadsheet.
Also the modified field names compared with the V_Refresh_data_fn_Score_Assess field names 
helped greatly with creating V_Refresh_Data_Transform_A_to_BatIn to pull 99% of the data we might need to update
*/

assessorKey_Renew_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.assessorKey_Renew_Layout;
deedsKey_Renew_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.deedsKey_Renew_Layout;
batch_in_Layout := PRTE2_LNProperty.Layouts.batch_in;


batch_in_Score_Layout := RECORD
	INTEGER CTscore := 0;
	INTEGER total_robustness_score	:= 0;
	INTEGER key_robustness_score := 0;
	batch_in_Layout;
END;

export V_Refresh_data_fn_Score_BatchIn (dataset(batch_in_Layout) in_data) := function

	
	testStrValue (String inStr) := function
		return if(length(Trim(inStr))>0,1,0);
	end;
	testIntValue (Integer inInt) := function
		return if(inInt>0,1,0);
	end;
	
	getKeyScore (batch_in_Layout l) := function
				hasNbrStories := testStrValue(l.assess_no_of_stories);
				hasNbrBaths := testStrValue(l.assess_no_of_baths);
				hasYearBuilt := testStrValue(l.assess_year_built);
				hasSalesDate := testStrValue(l.assess_sale_date);
				hasConstructionType := testStrValue(l.assess_type_construction_code);
				hasExteriorWalls := testStrValue(l.assess_exterior_walls_code);
				hasAirConditioningType := testStrValue(l.assess_air_conditioning_type_code);
				hasHeatingType := testStrValue(l.assess_heating_code);
				hasRoofCover := testStrValue(l.assess_roof_cover_code);

				result_cnt := Sum(
					hasNbrStories,
					hasNbrBaths,
					hasYearBuilt,
					hasSalesDate,
					hasConstructionType,
					hasExteriorWalls,
					hasAirConditioningType,
					hasHeatingType,
					hasRoofCover
				);

		return result_cnt;
	end;	

	getScore (batch_in_Layout l) := function
				hasNbrBaths := testStrValue(l.assess_no_of_baths);
				hasYearBuilt := testStrValue(l.assess_year_built);
				hasSalesDate := testStrValue(l.assess_sale_date);
				hasConstructionType := testStrValue(l.assess_type_construction_code);
				hasExteriorWalls := testStrValue(l.assess_exterior_walls_code);
				hasAirConditioningType := testStrValue(l.assess_air_conditioning_type_code);
				hasHeatingType := testStrValue(l.assess_heating_code);
				hasRoofCover := testStrValue(l.assess_roof_cover_code);
				hasCounty := testStrValue(l.property_county_name);
				hasCensusTract := testStrValue(l.assess_census_tract);
				hasNbrBedrooms := testStrValue(l.assess_no_of_bedrooms);
				hasFirePlace := testStrValue(l.assess_fireplace_indicator);
				hasNbrFirePlace := testStrValue(l.assess_fireplace_number);
				hasNbrUnits := testStrValue(l.assess_no_of_units);
				hasNbrRooms := testStrValue(l.assess_no_of_rooms);
				hasEffectiveYear := testStrValue(l.assess_effective_year_built);
				// hasLoanAmount := testStrValue(l.first_td_loan_amount);
				// hasLoanTypeCode := testStrValue(l.first_td_loan_type_code);
				// hasSecondLoanAmount := testStrValue(l.second_td_loan_amount);
				hasDeedRecordingDate := testStrValue(l.deed_recording_date);
				hasAssessmentRecordingDate := testStrValue(l.assess_recording_date);
				// hasDeedDocumentNbr := testStrValue(l.document_number); 
				hasAssessmentDocumentNbr := testStrValue(l.assess_recorder_document_number); 
				hasSalesAmt := testStrValue(l.deed_sales_price); 
				hasLegalDescription := testStrValue(l.assess_legal_brief_desc); 
				hasFIPSCode := testStrValue(l.assess_fips_code);
				// there is also a deed fips code for the few deed records we have.
				hasBlockNum := testStrValue(l.assess_legal_block);
				hasLotNum := testStrValue(l.assess_legal_lot_number);
				hasSubDivisionName := testStrValue(l.assess_legal_subdivision_name);
				hasTownShip := testStrValue(l.assess_legal_city_municipal_township);
				hasSection := testStrValue(l.assess_legal_section);
				hasZoningDesc := testStrValue(l.assess_zoning);
				hasLocationofInfluenceCode := testStrValue(l.assess_site_influence1_code);
				// hasLandUseCode := testStrValue(l.assess_standardized_land_use_code);
				// hasLatitude := testStrValue(l.geo_lat);
				// hasLongitude := testStrValue(l.geo_long);
				// hasLotSize := testStrValue(l.land_lot_size);
				hasLotFrontFtg := testStrValue(l.assess_land_dimensions);
				hasAcres := testStrValue(l.assess_land_acrs);
				hasTotAssessed := testStrValue(l.assess_assessed_total_value);
				hasTotCalculated := testStrValue(l.assess_assessed_total_value);
				hasTotMarketed := testStrValue(l.assess_market_total_value);
				hasTotLand := testStrValue(l.assess_assessed_land_value);
				hasMktLand := testStrValue(l.assess_market_land_value);
				hasAssessedLand := testStrValue(l.assess_assessed_land_value);
				hasImproved := testStrValue(l.assess_assessed_improvement_value);
				hasAssessedYear := testStrValue(l.assess_assessed_value_year);
				hasTaxCode := testStrValue(l.assess_tax_rate_code);
				hasTaxBillingYear := testStrValue(l.assess_tax_year);
				hasHomeSteadExemption := testStrValue(l.assess_homestead_homeowner_exempt);
				hasTaxAmount := testStrValue(l.assess_tax_amount);
				// hasPCTImproved := testIntValue(l.percent_improved);
				hasFoundationCode := testStrValue(l.assess_foundation_code);
				hasFireplaceType := testStrValue(l.assess_fireplace_indicator);
				hasFloorCover := testStrValue(l.assess_floor_cover_code);
				hasBasementType := testStrValue(l.assess_basement_code);
				hasGarageType := testStrValue(l.assess_garage_type_code);
				hasHeatingFuelType := testStrValue(l.assess_heating_fuel_type_code);
				hasParkingType := testStrValue(l.assess_parking_no_of_cars);
				hasPoolType := testStrValue(l.assess_pool_code);
				hasStoriesType := testStrValue(l.assess_no_of_stories);
				hasACInd := testStrValue(l.assess_air_conditioning_type_code);
				hasQAStructCode := testStrValue(l.assess_building_quality_code);
				// hasInterestRate := testStrValue(l.first_td_interest_rate);
				// hasIntRateTypeCode := testStrValue(l.type_financing);
				// hasSaleTypeCode := testStrValue(l.sales_price_code);
				// hasSaleFullPart := testStrValue(l.sales_price_code);
				// hasNbrFullBath := testStrValue(l.fares_no_of_full_baths);
				// hasNbrHalfBath := testStrValue(l.fares_no_of_half_baths);
				// hasNbrBathFixture :=  testStrValue(l.fares_no_of_bath_fixtures);
				// hasPoolInd := testStrValue(l.fares_pool_indicator);
				// hasBldgSqFeet := testStrValue(l.fares_building_square_feet);
				// hasGroundSqFt := testStrValue(l.fares_ground_floor_square_feet);
				// hasBasementSqFt := testStrValue(l.fares_basement_square_feet);
				// hasGarageSqFt := testStrValue(l.fares_garage_square_feet);
				// hasAssessmentAPNNbr := testStrValue(l.fares_unformatted_apn);
				// hasFrameType := testStrValue(l.fares_frame);
				// hasSewer := testStrValue(l.fares_sewer);
				// hasWaterCode := testStrValue(l.fares_water);

				result_cnt := Sum(
					// hasNbrStories,
					hasNbrBaths,
					hasYearBuilt,
					hasSalesDate,
					hasConstructionType,
					hasExteriorWalls,
					hasAirConditioningType,
					hasHeatingType,
					hasRoofCover,
					hasCounty,				
					hasCensusTract,				
					hasNbrBedrooms,				
					hasFirePlace,					
					hasNbrFirePlace,				
					hasNbrUnits,					
					hasNbrRooms,					
					hasEffectiveYear,				
					// hasMortgageCompName,				
					// hasLoanAmount,					
					// hasLoanTypeCode,				
					// hasSecondLoanAmount,				
					hasDeedRecordingDate,				
					hasAssessmentRecordingDate,				
					// hasDeedDocumentNbr,				
					hasAssessmentDocumentNbr,				
					hasSalesAmt,					
					hasLegalDescription,				
					hasFIPSCode,					
					hasBlockNum,					
					hasLotNum,				
					hasSubDivisionName,				
					hasTownShip,					
					hasSection,					
					hasZoningDesc,					
					hasLocationofInfluenceCode,				
					// hasLandUseCode,				
					// hasLatitude,					
					// hasLongitude,					
					// hasLotSize,					
					hasLotFrontFtg,				
					hasAcres,				
					hasTotAssessed,				
					hasTotCalculated,				
					hasTotMarketed,				
					hasTotLand,					
					hasMktLand,					
					hasAssessedLand,				
					hasImproved,					
					hasAssessedYear,				
					hasTaxCode,
					hasTaxBillingYear,				
					hasHomeSteadExemption,				
					hasTaxAmount,					
					// hasPCTImproved,
					hasFoundationCode,				
					hasFireplaceType,				
					hasFloorCover,					
					hasBasementType,				
					hasGarageType,					
					hasHeatingFuelType,				
					hasParkingType,				
					hasPoolType,					
					hasStoriesType,				
					hasACInd,				
					hasQAStructCode
					// hasInterestRate,				
					// hasIntRateTypeCode,
					// hasSaleTypeCode,				
					// hasSaleFullPart
					// hasNbrFullBath,				
					// hasNbrHalfBath,				
					// hasNbrBathFixture,				
					// hasPoolInd,					
					// hasBldgSqFeet,					
					// hasGroundSqFt,					
					// hasBasementSqFt,				
					// hasGarageSqFt,					
					// hasAssessmentAPNNbr,				
					// hasFrameType,					
					// hasSewer,				
					// hasWaterCode,					
				);
				
		return result_cnt;
	end;	

	batch_in_Score_Layout scoreRecords(batch_in_Layout l) := transform
			scoreVal := getScore(l);
			keyScoreVal := getKeyScore(l);
			self.total_robustness_score	:= scoreVal+keyScoreVal,
			self.key_robustness_score := keyScoreVal,
			self.CTScore := scoreVal;
			self := l;
	end;
	
	//Score the records
	scoredRecords := Project(in_data,scoreRecords(left));
	// return SORT(scoredRecords,key_robustness_score);
	return SORT(scoredRecords,-total_robustness_score);
	// RETURN scoredRecords;

end;