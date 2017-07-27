export fn_robustness_scoring (dataset(layouts.combined.tmp) in_data) := function

	
	testStrValue (String inStr) := function
		return if(length(Trim(inStr))>consts.missing,consts.found,consts.missing);
	end;
	testIntValue (Integer inInt) := function
		return if(inInt>consts.missing,consts.found,consts.missing);
	end;
	
	getKeyScore (layouts.combined.tmp l) := function
				hasLivingAreaSqFt := if(testStrValue(l.deeds[1].fares_building_square_feet)>consts.missing or (testStrValue(l.assessments[1].building_area)>consts.missing and l.assessments[1].building_area_indicator = 'L'),consts.found,consts.missing);
				hasNbrStories := testStrValue(l.assessments[1].no_of_stories);
				hasNbrBaths := testStrValue(l.assessments[1].no_of_baths);
				hasYearBuilt := testStrValue(l.assessments[1].year_built);
				hasSalesDate := testStrValue(l.assessments[1].sale_date);
				hasConstructionType := testStrValue(l.assessments[1].type_construction_code);
				hasExteriorWalls := testStrValue(l.assessments[1].exterior_walls_code);
				hasAirConditioningType := testStrValue(l.assessments[1].air_conditioning_code);
				hasHeatingType := testStrValue(l.assessments[1].heating_code);
				hasRoofCover := testStrValue(l.assessments[1].roof_cover_code);

				result_cnt := Sum(
					hasLivingAreaSqFt,
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

	getScore (layouts.combined.tmp l) := function
				hasCounty := testStrValue(l.assessments[1].county_name);
				hasCensusTract := testStrValue(l.assessments[1].census_tract);
				hasNbrBedrooms := testStrValue(l.assessments[1].no_of_bedrooms);
				hasFirePlace := testStrValue(l.assessments[1].fireplace_indicator);
				hasNbrFirePlace := testStrValue(l.assessments[1].fireplace_number);
				hasNbrUnits := testStrValue(l.assessments[1].no_of_units);
				hasNbrRooms := testStrValue(l.assessments[1].no_of_rooms);
				hasEffectiveYear := testStrValue(l.assessments[1].effective_year_built);
				hasMortgageCompName := testStrValue(l.deeds[1].lender_name);
				hasLoanAmount := testStrValue(l.deeds[1].first_td_loan_amount);
				hasLoanTypeCode := testStrValue(l.deeds[1].first_td_loan_type_code);
				hasSecondLoanAmount := testStrValue(l.deeds[1].second_td_loan_amount);
				hasDeedRecordingDate := testStrValue(l.deeds[1].recording_date);
				hasAssessmentRecordingDate := testStrValue(l.assessments[1].recording_date);
				hasDeedDocumentNbr := testStrValue(l.deeds[1].document_number); 
				hasAssessmentDocumentNbr := testStrValue(l.assessments[1].recorder_document_number); 
				hasSalesAmt := testStrValue(l.deeds[1].sales_price); 
				hasLegalDescription := testStrValue(l.assessments[1].legal_brief_description); 
				hasFIPSCode := testStrValue(l.assessments[1].fips_code);
				hasBlockNum := testStrValue(l.assessments[1].legal_block);
				hasLotNum := testStrValue(l.assessments[1].legal_lot_number);
				hasSubDivisionName := testStrValue(l.assessments[1].legal_subdivision_name);
				hasTownShip := testStrValue(l.assessments[1].legal_city_municipality_township);
				hasSection := testStrValue(l.assessments[1].legal_section);
				hasZoningDesc := testStrValue(l.assessments[1].zoning);
				hasLocationofInfluenceCode := testStrValue(l.assessments[1].site_influence1_code);
				hasLandUseCode := testStrValue(l.assessments[1].standardized_land_use_code);
				hasLatitude := testStrValue(l.parties[1].geo_lat);
				hasLongitude := testStrValue(l.parties[1].geo_long);
				hasLotSize := testStrValue(l.deeds[1].land_lot_size);
				hasLotFrontFtg := testStrValue(l.assessments[1].land_dimensions);
				hasAcres := testStrValue(l.assessments[1].land_acres);
				hasTotAssessed := testStrValue(l.assessments[1].assessed_total_value);
				hasTotCalculated := testStrValue(l.assessments[1].assessed_total_value);
				hasTotMarketed := testStrValue(l.assessments[1].market_total_value);
				hasTotLand := testStrValue(l.assessments[1].assessed_land_value);
				hasMktLand := testStrValue(l.assessments[1].market_land_value);
				hasAssessedLand := testStrValue(l.assessments[1].assessed_land_value);
				hasImproved := testStrValue(l.assessments[1].assessed_improvement_value);
				hasAssessedYear := testStrValue(l.assessments[1].assessed_value_year);
				hasTaxCode := testStrValue(l.assessments[1].tax_rate_code_area);
				hasTaxBillingYear := testStrValue(l.assessments[1].tax_year);
				hasHomeSteadExemption := testStrValue(l.assessments[1].tax_exemption1_code);
				hasTaxAmount := testStrValue(l.assessments[1].tax_amount);
				hasPCTImproved := testIntValue(l.assessments[1].percent_improved);
				hasFoundationCode := testStrValue(l.assessments[1].foundation_code);
				hasFireplaceType := testStrValue(l.assessments[1].fireplace_indicator);
				hasFloorCover := testStrValue(l.assessments[1].floor_cover_code);
				hasBasementType := testStrValue(l.assessments[1].basement_code);
				hasGarageType := testStrValue(l.assessments[1].garage_type_code);
				hasHeatingFuelType := testStrValue(l.assessments[1].heating_fuel_type_code);
				hasParkingType := testStrValue(l.assessments[1].parking_no_of_cars);
				hasPoolType := testStrValue(l.assessments[1].pool_code);
				hasStoriesType := testStrValue(l.assessments[1].no_of_stories);
				hasACInd := testStrValue(l.assessments[1].air_conditioning_code);
				hasQAStructCode := testStrValue(l.assessments[1].building_quality_code);
				hasInterestRate := testStrValue(l.deeds[1].first_td_interest_rate);
				hasIntRateTypeCode := testStrValue(l.deeds[1].type_financing);
				hasSaleTypeCode := testStrValue(l.assessments[1].sales_price_code);
				hasSaleFullPart := testStrValue(l.assessments[1].sales_price_code);
				// hasNbrFullBath := testStrValue(l.assessments[1].fares_no_of_full_baths);
				// hasNbrHalfBath := testStrValue(l.assessments[1].fares_no_of_half_baths);
				// hasNbrBathFixture :=  testStrValue(l.assessments[1].fares_no_of_bath_fixtures);
				// hasPoolInd := testStrValue(l.assessments[1].fares_pool_indicator);
				// hasBldgSqFeet := testStrValue(l.deeds[1].fares_building_square_feet);
				// hasGroundSqFt := testStrValue(l.assessments[1].fares_ground_floor_square_feet);
				// hasBasementSqFt := testStrValue(l.assessments[1].fares_basement_square_feet);
				// hasGarageSqFt := testStrValue(l.assessments[1].fares_garage_square_feet);
				// hasAssessmentAPNNbr := testStrValue(l.assessments[1].fares_unformatted_apn);
				// hasFrameType := testStrValue(l.assessments[1].fares_frame);
				// hasSewer := testStrValue(l.assessments[1].fares_sewer);
				// hasWaterCode := testStrValue(l.assessments[1].fares_water);

				result_cnt := Sum(
					hasCounty,				
					hasCensusTract,				
					hasNbrBedrooms,				
					hasFirePlace,					
					hasNbrFirePlace,				
					hasNbrUnits,					
					hasNbrRooms,					
					hasEffectiveYear,				
					hasMortgageCompName,				
					hasLoanAmount,					
					hasLoanTypeCode,				
					hasSecondLoanAmount,				
					hasDeedRecordingDate,				
					hasAssessmentRecordingDate,				
					hasDeedDocumentNbr,				
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
					hasLandUseCode,				
					hasLatitude,					
					hasLongitude,					
					hasLotSize,					
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
					hasPCTImproved,
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
					hasQAStructCode,
					hasInterestRate,				
					hasIntRateTypeCode,
					hasSaleTypeCode,				
					hasSaleFullPart
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

	layouts.combined.tmp scoreRecords(layouts.combined.tmp l) := transform
			scoreVal := getScore(l);
			keyScoreVal := getKeyScore(l);
			self.total_robustness_score	:= scoreVal+keyScoreVal,
			self.key_robustness_score := keyScoreVal,
			self := l;
	end;
	
	//Score the records
	scoredRecord := Project(in_data,scoreRecords(left));
	return scoredRecord;
end;