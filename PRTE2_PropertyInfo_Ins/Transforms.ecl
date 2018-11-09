/* ************************************************************************************************************************
This is just to perfect the CSV data - so this can happen PRIOR to saving the CSV version of the base file (we spray/despray that)
INPUT: Alpha CSV LAYOUT directly from the sprayed file
OUTPUT: Alpha CSV LAYOUT
TEMP_ADDRESS_WORKAROUND TILL DATA3 IS DONE HERE
************************************************************************************************************************ */
IMPORT PRTE2_Common,std;

EXPORT Transforms := MODULE

			//---------------------------------------------------------------------
			Pick1(STRING s1,STRING s2) := IF(s1='',s2,s1);
			appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
			appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

			GETSRC(STRING S1) := IF(S1='D', 'FARES', 'OKCTY');
			isBlank(STRING Val) := TRIM(Val)='' OR TRIM(Val)='0';
			checkFixSrc(STRING Value, STRING VSrc, STRING oSRC) := IF(isBlank(Value), '', Pick1(oSRC, GETSRC(VSrc)));
			checkFixSrcPct(udecimal5_2 Value, STRING VSrc, STRING oSRC) := IF(Value=0, '', Pick1(oSRC, GETSRC(VSrc)));
			//---------------------------------------------------------------------

		EXPORT Layouts.AlphaPropertyCSVRec spreadsheet_clean(Layouts.AlphaPropertyCSVRec L) := TRANSFORM
		
//TODO?  Should we instead do the address cleaning from property_street_address and property_city_state_zip
//TODO - should add an address error fields for Nancy to see.
					// SELF.addr_error	:= IF(clean_address.errorCode[1]='E',clean_address.errorCode,'');
					
					// NOTE: 
					// ***************>> Nancy will edit these fields: property_street_address, property_city_state_zip
					// 		We then just need to update the other addresses in the record based on what she changes or adds.
					clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(l.property_street_address, l.property_city_state_zip);
					// SELF.property_street_address := clean_address.addr1;	// I think we should just keep Nancy's values for the above incoming fields.
					// SELF.property_city_state_zip := clean_address.addr2;
					// TEMP FIX:
					// hasProblem := STD.STR.Find(L.fares_unformatted_apn,' .') + STD.STR.Find(L.fares_unformatted_apn,'. ') >0;
					// apnTmp := appendIFDot4(ridString[1..3],cleanAddress.cart,cleanAddress.lot,cleanAddress.fips_county)+cleanAddress.geo_long[3..];
					// SELF.fares_unformatted_apn := IF(hasProblem,apnTmp,L.fares_unformatted_apn);
					// hasAPNN := L.apn_number <> '';
					// SELF.apn_number := IF(hasAPNN and hasProblem,apnTmp,L.apn_number);
					// ---------------------------------------------------------------------------------------------------------
					// SELF.property_city 	:= clean_address.v_city_name;
					// SELF.property_state := clean_address.st;					
					// SELF.property_zip 	:= clean_address.zip;
					
					// Do we need to use hasError logic like we do in the fn_spray_add process?
					SELF.prim_name  := clean_address.prim_name;
					SELF.predir     := clean_address.predir;
					SELF.prim_range := clean_address.prim_range;
					SELF.sec_range  := clean_address.sec_range;					
					SELF.unit_desig := clean_address.unit_desig;
					SELF.postdir    := clean_address.postdir;
					SELF.addr_suffix := clean_address.addr_suffix;
					SELF.st         := clean_address.st;
					self.zip        := clean_address.zip; 
					self.zip4       := clean_address.zip4;
					SELF.msa        := clean_address.msa;
					SELF.err_stat   := clean_address.err_stat;
					SELF.cart       := clean_address.cart;
					SELF.cr_sort_sz := clean_address.cr_sort_sz;
					SELF.lot        := clean_address.lot;
					SELF.lot_order  := clean_address.lot_order;
					SELF.dbpc       := clean_address.dbpc;
					SELF.chk_digit  := clean_address.chk_digit;
					SELF.rec_type   := clean_address.rec_type;
					SELF.county     := clean_address.fips_state+clean_address.fips_county;	// ??? This is what it used to do - [141-145]
					self.geo_lat    := clean_address.geo_lat;
					self.geo_long   := clean_address.geo_long;
					SELF.geo_blk    := clean_address.geo_blk;
					SELF.geo_match  := clean_address.geo_match;
					SELF.p_city_name := clean_address.p_city_name;
					SELF.v_city_name := clean_address.v_city_name;
					
					// ensure all sources are good based on what is in the value fields
					SELF.src_percent_improved := checkFixSrcPct(L.percent_improved,L.vendor_source,L.src_percent_improved);
					SELF.src_building_square_footage := checkFixSrc(L.building_square_footage,L.vendor_source,L.src_building_square_footage);
					SELF.src_air_conditioning_type := checkFixSrc(L.air_conditioning_type,L.vendor_source,L.src_air_conditioning_type);
					SELF.src_basement_finish := checkFixSrc(L.basement_finish,L.vendor_source,L.src_basement_finish);
					SELF.src_construction_type := checkFixSrc(L.construction_type,L.vendor_source,L.src_construction_type);
					SELF.src_exterior_wall := checkFixSrc(L.exterior_wall,L.vendor_source,L.src_exterior_wall);
					SELF.src_fireplace_ind := checkFixSrc(L.fireplace_ind,L.vendor_source,L.src_fireplace_ind);
					SELF.src_fireplace_type := checkFixSrc(L.fireplace_type,L.vendor_source,L.src_fireplace_type);
					SELF.src_flood_zone_panel := checkFixSrc(L.flood_zone_panel,L.vendor_source,L.src_flood_zone_panel);
					SELF.src_garage := checkFixSrc(L.garage,L.vendor_source,L.src_garage);
					SELF.src_first_floor_square_footage := checkFixSrc(L.first_floor_square_footage,L.vendor_source,L.src_first_floor_square_footage);
					SELF.src_heating := checkFixSrc(L.heating,L.vendor_source,L.src_heating);
					SELF.src_living_area_square_footage := checkFixSrc(L.living_area_square_footage,L.vendor_source,L.src_living_area_square_footage);
					SELF.src_no_of_baths := checkFixSrc(L.no_of_baths,L.vendor_source,L.src_no_of_baths);
					SELF.src_no_of_bedrooms := checkFixSrc(L.no_of_bedrooms,L.vendor_source,L.src_no_of_bedrooms);
					SELF.src_no_of_fireplaces := checkFixSrc(L.no_of_fireplaces,L.vendor_source,L.src_no_of_fireplaces);
					SELF.src_no_of_full_baths := checkFixSrc(L.no_of_full_baths,L.vendor_source,L.src_no_of_full_baths);
					SELF.src_no_of_half_baths := checkFixSrc(L.no_of_half_baths,L.vendor_source,L.src_no_of_half_baths);
					SELF.src_no_of_stories := checkFixSrc(L.no_of_stories,L.vendor_source,L.src_no_of_stories);
					SELF.src_parking_type := checkFixSrc(L.parking_type,L.vendor_source,L.src_parking_type);
					SELF.src_pool_indicator := checkFixSrc(L.pool_indicator,L.vendor_source,L.src_pool_indicator);
					SELF.src_pool_type := checkFixSrc(L.pool_type,L.vendor_source,L.src_pool_type);
					SELF.src_roof_cover := checkFixSrc(L.roof_cover,L.vendor_source,L.src_roof_cover);
					SELF.src_roof_type := checkFixSrc(L.roof_type,L.vendor_source,L.src_roof_type);
					SELF.src_year_built := checkFixSrc(L.year_built,L.vendor_source,L.src_year_built);
					SELF.src_foundation := checkFixSrc(L.foundation,L.vendor_source,L.src_foundation);
					SELF.src_basement_square_footage := checkFixSrc(L.basement_square_footage,L.vendor_source,L.src_basement_square_footage);
					SELF.src_effective_year_built := checkFixSrc(L.effective_year_built,L.vendor_source,L.src_effective_year_built);
					SELF.src_garage_square_footage := checkFixSrc(L.garage_square_footage,L.vendor_source,L.src_garage_square_footage);
					SELF.src_stories_type := checkFixSrc(L.stories_type,L.vendor_source,L.src_stories_type);
					SELF.src_apn_number := checkFixSrc(L.apn_number,L.vendor_source,L.src_apn_number);
					SELF.src_census_tract := checkFixSrc(L.census_tract,L.vendor_source,L.src_census_tract);
					SELF.src_range := checkFixSrc(L.range,L.vendor_source,L.src_range);
					SELF.src_zoning := checkFixSrc(L.zoning,L.vendor_source,L.src_zoning);
					SELF.src_block_number := checkFixSrc(L.block_number,L.vendor_source,L.src_block_number);
					SELF.src_county_name := checkFixSrc(L.county_name,L.vendor_source,L.src_county_name);
					SELF.src_fips_code := checkFixSrc(L.fips_code,L.vendor_source,L.src_fips_code);
					SELF.src_subdivision := checkFixSrc(L.subdivision,L.vendor_source,L.src_subdivision);
					SELF.src_municipality := checkFixSrc(L.municipality,L.vendor_source,L.src_municipality);
					SELF.src_township := checkFixSrc(L.township,L.vendor_source,L.src_township);
					SELF.src_homestead_exemption_ind := checkFixSrc(L.homestead_exemption_ind,L.vendor_source,L.src_homestead_exemption_ind);
					SELF.src_land_use_code := checkFixSrc(L.land_use_code,L.vendor_source,L.src_land_use_code);
					SELF.src_latitude := checkFixSrc(L.latitude,L.vendor_source,L.src_latitude);
					SELF.src_longitude := checkFixSrc(L.longitude,L.vendor_source,L.src_longitude);
					SELF.src_location_influence_code := checkFixSrc(L.location_influence_code,L.vendor_source,L.src_location_influence_code);
					SELF.src_acres := checkFixSrc(L.acres,L.vendor_source,L.src_acres);
					SELF.src_lot_depth_footage := checkFixSrc(L.lot_depth_footage,L.vendor_source,L.src_lot_depth_footage);
					SELF.src_lot_front_footage := checkFixSrc(L.lot_front_footage,L.vendor_source,L.src_lot_front_footage);
					SELF.src_lot_number := checkFixSrc(L.lot_number,L.vendor_source,L.src_lot_number);
					SELF.src_lot_size := checkFixSrc(L.lot_size,L.vendor_source,L.src_lot_size);
					SELF.src_property_type_code := checkFixSrc(L.property_type_code,L.vendor_source,L.src_property_type_code);
					SELF.src_structure_quality := checkFixSrc(L.structure_quality,L.vendor_source,L.src_structure_quality);
					SELF.src_water := checkFixSrc(L.water,L.vendor_source,L.src_water);
					SELF.src_sewer := checkFixSrc(L.sewer,L.vendor_source,L.src_sewer);
					SELF.src_assessed_land_value := checkFixSrc(L.assessed_land_value,L.vendor_source,L.src_assessed_land_value);
					SELF.src_assessed_year := checkFixSrc(L.assessed_year,L.vendor_source,L.src_assessed_year);
					SELF.src_tax_amount := checkFixSrc(L.tax_amount,L.vendor_source,L.src_tax_amount);
					SELF.src_tax_year := checkFixSrc(L.tax_year,L.vendor_source,L.src_tax_year);
					SELF.src_market_land_value := checkFixSrc(L.market_land_value,L.vendor_source,L.src_market_land_value);
					SELF.src_improvement_value := checkFixSrc(L.improvement_value,L.vendor_source,L.src_improvement_value);
					SELF.src_total_assessed_value := checkFixSrc(L.total_assessed_value,L.vendor_source,L.src_total_assessed_value);
					SELF.src_total_calculated_value := checkFixSrc(L.total_calculated_value,L.vendor_source,L.src_total_calculated_value);
					SELF.src_total_land_value := checkFixSrc(L.total_land_value,L.vendor_source,L.src_total_land_value);
					SELF.src_total_market_value := checkFixSrc(L.total_market_value,L.vendor_source,L.src_total_market_value);
					SELF.src_floor_type := checkFixSrc(L.floor_type,L.vendor_source,L.src_floor_type);
					SELF.src_frame_type := checkFixSrc(L.frame_type,L.vendor_source,L.src_frame_type);
					SELF.src_fuel_type := checkFixSrc(L.fuel_type,L.vendor_source,L.src_fuel_type);
					SELF.src_no_of_bath_fixtures := checkFixSrc(L.no_of_bath_fixtures,L.vendor_source,L.src_no_of_bath_fixtures);
					SELF.src_no_of_rooms := checkFixSrc(L.no_of_rooms,L.vendor_source,L.src_no_of_rooms);
					SELF.src_no_of_units := checkFixSrc(L.no_of_units,L.vendor_source,L.src_no_of_units);
					SELF.src_style_type := checkFixSrc(L.style_type,L.vendor_source,L.src_style_type);
					SELF.src_assessment_document_number := checkFixSrc(L.assessment_document_number,L.vendor_source,L.src_assessment_document_number);
					SELF.src_assessment_recording_date := checkFixSrc(L.assessment_recording_date,L.vendor_source,L.src_assessment_recording_date);
					SELF.src_deed_document_number := checkFixSrc(L.deed_document_number,L.vendor_source,L.src_deed_document_number);
					SELF.src_deed_recording_date := checkFixSrc(L.deed_recording_date,L.vendor_source,L.src_deed_recording_date);
					SELF.src_full_part_sale := checkFixSrc(L.full_part_sale,L.vendor_source,L.src_full_part_sale);
					SELF.src_sale_amount := checkFixSrc(L.sale_amount,L.vendor_source,L.src_sale_amount);
					SELF.src_sale_date := checkFixSrc(L.sale_date,L.vendor_source,L.src_sale_date);
					SELF.src_sale_type_code := checkFixSrc(L.sale_type_code,L.vendor_source,L.src_sale_type_code);
					SELF.src_mortgage_company_name := checkFixSrc(L.mortgage_company_name,L.vendor_source,L.src_mortgage_company_name);
					SELF.src_loan_amount := checkFixSrc(L.loan_amount,L.vendor_source,L.src_loan_amount);
					SELF.src_second_loan_amount := checkFixSrc(L.second_loan_amount,L.vendor_source,L.src_second_loan_amount);
					SELF.src_loan_type_code := checkFixSrc(L.loan_type_code,L.vendor_source,L.src_loan_type_code);
					SELF.src_interest_rate_type_code := checkFixSrc(L.interest_rate_type_code,L.vendor_source,L.src_interest_rate_type_code);
				
					SELF := L;
					// SELF := [];
		END;

END;