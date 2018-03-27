/* I can use this function to generate a scored version of our assessorKey_Renew_Layout generated data
I will use this scored file to join a batch_in record to a V_Refresh_Data_Base_Files.RefreshAssessorDS record
with the highest score - I'll then pull over the fields into the spreadsheet using V_Refresh_Data_Transform_A_to_BatIn
*/

assessorKey_Renew_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.assessorKey_Renew_Layout;
deedsKey_Renew_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.deedsKey_Renew_Layout;

export V_Refresh_data_fn_Score_Assess (dataset(assessorKey_Renew_Layout) in_data) := function

	
	testStrValue (String inStr) := function
		return if(length(Trim(inStr))>0,1,0);
	end;
	testIntValue (Integer inInt) := function
		return if(inInt>0,1,0);
	end;
	
	getKeyScore (assessorKey_Renew_Layout l) := function
				hasNbrStories := testStrValue(l.no_of_stories);
				hasNbrBaths := testStrValue(l.no_of_baths);
				hasYearBuilt := testStrValue(l.year_built);
				hasSalesDate := testStrValue(l.sale_date);
				hasConstructionType := testStrValue(l.type_construction_code);
				hasExteriorWalls := testStrValue(l.exterior_walls_code);
				hasAirConditioningType := testStrValue(l.air_conditioning_code);
				hasHeatingType := testStrValue(l.heating_code);
				hasRoofCover := testStrValue(l.roof_cover_code);

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

	getScore (assessorKey_Renew_Layout l) := function
				hasNbrStories := testStrValue(l.no_of_stories);
				hasNbrBaths := testStrValue(l.no_of_baths);
				hasYearBuilt := testStrValue(l.year_built);
				hasSalesDate := testStrValue(l.sale_date);
				hasConstructionType := testStrValue(l.type_construction_code);
				hasExteriorWalls := testStrValue(l.exterior_walls_code);
				hasAirConditioningType := testStrValue(l.air_conditioning_code);
				hasHeatingType := testStrValue(l.heating_code);
				hasRoofCover := testStrValue(l.roof_cover_code);
				hasCounty := testStrValue(l.county_name);
				hasCensusTract := testStrValue(l.census_tract);
				hasNbrBedrooms := testStrValue(l.no_of_bedrooms);
				hasFirePlace := testStrValue(l.fireplace_indicator);
				hasNbrFirePlace := testStrValue(l.fireplace_number);
				hasNbrUnits := testStrValue(l.no_of_units);
				hasNbrRooms := testStrValue(l.no_of_rooms);
				hasEffectiveYear := testStrValue(l.effective_year_built);
				// hasLoanAmount := testStrValue(l.first_td_loan_amount);
				// hasLoanTypeCode := testStrValue(l.first_td_loan_type_code);
				// hasSecondLoanAmount := testStrValue(l.second_td_loan_amount);
				hasDeedRecordingDate := testStrValue(l.recording_date);
				hasAssessmentRecordingDate := testStrValue(l.recording_date);
				// hasDeedDocumentNbr := testStrValue(l.document_number); 
				hasAssessmentDocumentNbr := testStrValue(l.recorder_document_number); 
				hasSalesAmt := testStrValue(l.sales_price); 
				hasLegalDescription := testStrValue(l.legal_brief_description); 
				hasFIPSCode := testStrValue(l.fips_code);
				hasBlockNum := testStrValue(l.legal_block);
				hasLotNum := testStrValue(l.legal_lot_number);
				hasSubDivisionName := testStrValue(l.legal_subdivision_name);
				hasTownShip := testStrValue(l.legal_city_municipality_township);
				hasSection := testStrValue(l.legal_section);
				hasZoningDesc := testStrValue(l.zoning);
				hasLocationofInfluenceCode := testStrValue(l.site_influence1_code);
				hasLandUseCode := testStrValue(l.standardized_land_use_code);
				// hasLatitude := testStrValue(l.geo_lat);
				// hasLongitude := testStrValue(l.geo_long);
				// hasLotSize := testStrValue(l.land_lot_size);
				hasLotFrontFtg := testStrValue(l.land_dimensions);
				hasAcres := testStrValue(l.land_acres);
				hasTotAssessed := testStrValue(l.assessed_total_value);
				hasTotCalculated := testStrValue(l.assessed_total_value);
				hasTotMarketed := testStrValue(l.market_total_value);
				hasTotLand := testStrValue(l.assessed_land_value);
				hasMktLand := testStrValue(l.market_land_value);
				hasAssessedLand := testStrValue(l.assessed_land_value);
				hasImproved := testStrValue(l.assessed_improvement_value);
				hasAssessedYear := testStrValue(l.assessed_value_year);
				hasTaxCode := testStrValue(l.tax_rate_code_area);
				hasTaxBillingYear := testStrValue(l.tax_year);
				hasHomeSteadExemption := testStrValue(l.tax_exemption1_code);
				hasTaxAmount := testStrValue(l.tax_amount);
				// hasPCTImproved := testIntValue(l.percent_improved);
				hasFoundationCode := testStrValue(l.foundation_code);
				hasFireplaceType := testStrValue(l.fireplace_indicator);
				hasFloorCover := testStrValue(l.floor_cover_code);
				hasBasementType := testStrValue(l.basement_code);
				hasGarageType := testStrValue(l.garage_type_code);
				hasHeatingFuelType := testStrValue(l.heating_fuel_type_code);
				hasParkingType := testStrValue(l.parking_no_of_cars);
				hasPoolType := testStrValue(l.pool_code);
				hasStoriesType := testStrValue(l.no_of_stories);
				hasACInd := testStrValue(l.air_conditioning_code);
				hasQAStructCode := testStrValue(l.building_quality_code);
				// hasInterestRate := testStrValue(l.first_td_interest_rate);
				// hasIntRateTypeCode := testStrValue(l.type_financing);
				hasSaleTypeCode := testStrValue(l.sales_price_code);
				hasSaleFullPart := testStrValue(l.sales_price_code);
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
					hasNbrStories,
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
					hasLandUseCode,				
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
					hasQAStructCode,
					// hasInterestRate,				
					// hasIntRateTypeCode,
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

	assessorKey_Renew_Layout scoreRecords(assessorKey_Renew_Layout l) := transform
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