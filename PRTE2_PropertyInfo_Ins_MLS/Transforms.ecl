/* ************************************************************************************************************************
Called to clean a sprayed file before further processing 
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
OLDER NOTES:
This is just to perfect the CSV data - so this should happen PRIOR to saving the CSV version of the base file (we spray/despray that)
INPUT: Alpha CSV LAYOUT directly from the sprayed file
OUTPUT: Alpha CSV LAYOUT to save as Thor base.
************************************************************************************************************************ */

IMPORT PRTE2_Common,std;

EXPORT Transforms := MODULE

			//*********************************************************************************************************
			// *************** WARNING - OLD TWO SOURCE LOGIC NOT VALID NOW WITH 6 SOURCES ***************************
			// Pick1(STRING s1,STRING s2) := IF(s1='',s2,s1);
			// appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
			// appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));
			// GETSRC(STRING S1) := IF(S1='D', 'FARES', 'OKCTY');
			// isBlank(STRING Val) := TRIM(Val)='' OR TRIM(Val)='0';
			// checkFixSrc(STRING Value, STRING VSrc, STRING oSRC) := IF(isBlank(Value), '', Pick1(oSRC, GETSRC(VSrc)));
			// checkFixSrcPct(udecimal5_2 Value, STRING VSrc, STRING oSRC) := IF(Value=0, '', Pick1(oSRC, GETSRC(VSrc)));
			// *************** WARNING - OLD TWO SOURCE LOGIC NOT VALID NOW WITH 6 SOURCES ***************************
			//*********************************************************************************************************

		EXPORT Layouts.AlphaPropertyCSVRec_MLS spreadsheet_clean(Layouts.AlphaPropertyCSVRec_MLS L) := TRANSFORM				
					// NOTE: 
					// ***************>> Nancy will edit these fields: property_street_address, v_city_name, st, zip
					// 		We then just need to update the other addresses in the record based on what she changes or adds.
					clean_address := PRTE2_Common.Clean_Address.cleanAddr1Addr2(l.property_street_address, l.property_city_state_zip);

					// Add an address error field that is easy for Nancy and data team to see.
					SELF.xAddrErr	:= IF(clean_address.err_stat[1]='E',clean_address.err_stat,'');

					// SELF.property_street_address := clean_address.addr1;	// I think we should just keep Nancy's values for the above incoming fields.
					SELF.property_city_state_zip := clean_address.addr2;
					SELF.fares_unformatted_apn := (STRING)HASH(L.property_street_address,clean_address.addr2,L.cust_name);
					SELF.apn_number := (STRING)HASH(L.property_street_address,clean_address.addr2,L.cust_name);

					// ------ Functions ----------------------------------------------------------------------------------------
					isBlank(STRING Val) := TRIM(Val)='' OR ( (INTEGER) TRIM(Val)=0 );
					checkFixSrc(STRING Value, STRING oSRC) := IF(isBlank(Value), '', oSRC);
					checkFixSrcPct(udecimal5_2 Value, STRING oSRC) := IF(Value=0, '', oSRC);
					// ---------------------------------------------------------------------------------------------------------
					
					// Do we need to use hasError logic like we do in the fn_spray_add process?
					SELF.prim_name  := clean_address.prim_name;
					SELF.predir     := clean_address.predir;
					SELF.prim_range := clean_address.prim_range;
					SELF.sec_range  := clean_address.sec_range;					
					SELF.unit_desig := clean_address.unit_desig;
					SELF.postdir    := clean_address.postdir;
					SELF.addr_suffix := clean_address.addr_suffix;
					SELF.p_city_name := clean_address.p_city_name;
					SELF.v_city_name := clean_address.v_city_name;
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

					// ******************************************************************************************************************
					// ***** Below section simply is there to remove any "src" field if the associated value is blank *******************
					// ***** As long as the associated value field isn't blank or zero then it just keeps whaever is there **************
					// ******************************************************************************************************************
					SELF.src_percent_improved := checkFixSrcPct(L.percent_improved,L.src_percent_improved);
					SELF.src_building_square_footage := checkFixSrc(L.building_square_footage,L.src_building_square_footage);
					SELF.src_air_conditioning_type := checkFixSrc(L.air_conditioning_type,L.src_air_conditioning_type);
					SELF.src_basement_finish := checkFixSrc(L.basement_finish,L.src_basement_finish);
					SELF.src_construction_type := checkFixSrc(L.construction_type,L.src_construction_type);
					SELF.src_exterior_wall := checkFixSrc(L.exterior_wall,L.src_exterior_wall);
					SELF.src_fireplace_ind := checkFixSrc(L.fireplace_ind,L.src_fireplace_ind);
					SELF.src_fireplace_type := checkFixSrc(L.fireplace_type,L.src_fireplace_type);
					SELF.src_flood_zone_panel := checkFixSrc(L.flood_zone_panel,L.src_flood_zone_panel);
					SELF.src_garage := checkFixSrc(L.garage,L.src_garage);
					SELF.src_first_floor_square_footage := checkFixSrc(L.first_floor_square_footage,L.src_first_floor_square_footage);
					SELF.src_heating := checkFixSrc(L.heating,L.src_heating);
					SELF.src_living_area_square_footage := checkFixSrc(L.living_area_square_footage,L.src_living_area_square_footage);
					SELF.src_no_of_baths := checkFixSrc(L.no_of_baths,L.src_no_of_baths);
					SELF.src_no_of_bedrooms := checkFixSrc(L.no_of_bedrooms,L.src_no_of_bedrooms);
					SELF.src_no_of_fireplaces := checkFixSrc(L.no_of_fireplaces,L.src_no_of_fireplaces);
					SELF.src_no_of_full_baths := checkFixSrc(L.no_of_full_baths,L.src_no_of_full_baths);
					SELF.src_no_of_half_baths := checkFixSrc(L.no_of_half_baths,L.src_no_of_half_baths);
					SELF.src_no_of_stories := checkFixSrc(L.no_of_stories,L.src_no_of_stories);
					SELF.src_parking_type := checkFixSrc(L.parking_type,L.src_parking_type);
					SELF.src_pool_indicator := checkFixSrc(L.pool_indicator,L.src_pool_indicator);
					SELF.src_pool_type := checkFixSrc(L.pool_type,L.src_pool_type);
					SELF.src_roof_cover := checkFixSrc(L.roof_cover,L.src_roof_cover);
					SELF.src_roof_type := checkFixSrc(L.roof_type,L.src_roof_type);
					SELF.src_year_built := checkFixSrc(L.year_built,L.src_year_built);
					SELF.src_foundation := checkFixSrc(L.foundation,L.src_foundation);
					SELF.src_basement_square_footage := checkFixSrc(L.basement_square_footage,L.src_basement_square_footage);
					SELF.src_effective_year_built := checkFixSrc(L.effective_year_built,L.src_effective_year_built);
					SELF.src_garage_square_footage := checkFixSrc(L.garage_square_footage,L.src_garage_square_footage);
					SELF.src_stories_type := checkFixSrc(L.stories_type,L.src_stories_type);
					SELF.src_apn_number := checkFixSrc(L.apn_number,L.src_apn_number);
					SELF.src_census_tract := checkFixSrc(L.census_tract,L.src_census_tract);
					SELF.src_range := checkFixSrc(L.range,L.src_range);
					SELF.src_zoning := checkFixSrc(L.zoning,L.src_zoning);
					SELF.src_block_number := checkFixSrc(L.block_number,L.src_block_number);
					SELF.src_county_name := checkFixSrc(L.county_name,L.src_county_name);
					SELF.src_fips_code := checkFixSrc(L.fips_code,L.src_fips_code);
					SELF.src_subdivision := checkFixSrc(L.subdivision,L.src_subdivision);
					SELF.src_municipality := checkFixSrc(L.municipality,L.src_municipality);
					SELF.src_township := checkFixSrc(L.township,L.src_township);
					SELF.src_homestead_exemption_ind := checkFixSrc(L.homestead_exemption_ind,L.src_homestead_exemption_ind);
					SELF.src_land_use_code := checkFixSrc(L.land_use_code,L.src_land_use_code);
					SELF.src_latitude := checkFixSrc(L.latitude,L.src_latitude);
					SELF.src_longitude := checkFixSrc(L.longitude,L.src_longitude);
					SELF.src_location_influence_code := checkFixSrc(L.location_influence_code,L.src_location_influence_code);
					SELF.src_acres := checkFixSrc(L.acres,L.src_acres);
					SELF.src_lot_depth_footage := checkFixSrc(L.lot_depth_footage,L.src_lot_depth_footage);
					SELF.src_lot_front_footage := checkFixSrc(L.lot_front_footage,L.src_lot_front_footage);
					SELF.src_lot_number := checkFixSrc(L.lot_number,L.src_lot_number);
					SELF.src_lot_size := checkFixSrc(L.lot_size,L.src_lot_size);
					SELF.src_property_type_code := checkFixSrc(L.property_type_code,L.src_property_type_code);
					SELF.src_structure_quality := checkFixSrc(L.structure_quality,L.src_structure_quality);
					SELF.src_water := checkFixSrc(L.water,L.src_water);
					SELF.src_sewer := checkFixSrc(L.sewer,L.src_sewer);
					SELF.src_assessed_land_value := checkFixSrc(L.assessed_land_value,L.src_assessed_land_value);
					SELF.src_assessed_year := checkFixSrc(L.assessed_year,L.src_assessed_year);
					SELF.src_tax_amount := checkFixSrc(L.tax_amount,L.src_tax_amount);
					SELF.src_tax_year := checkFixSrc(L.tax_year,L.src_tax_year);
					SELF.src_market_land_value := checkFixSrc(L.market_land_value,L.src_market_land_value);
					SELF.src_improvement_value := checkFixSrc(L.improvement_value,L.src_improvement_value);
					SELF.src_total_assessed_value := checkFixSrc(L.total_assessed_value,L.src_total_assessed_value);
					SELF.src_total_calculated_value := checkFixSrc(L.total_calculated_value,L.src_total_calculated_value);
					SELF.src_total_land_value := checkFixSrc(L.total_land_value,L.src_total_land_value);
					SELF.src_total_market_value := checkFixSrc(L.total_market_value,L.src_total_market_value);
					SELF.src_floor_type := checkFixSrc(L.floor_type,L.src_floor_type);
					SELF.src_frame_type := checkFixSrc(L.frame_type,L.src_frame_type);
					SELF.src_fuel_type := checkFixSrc(L.fuel_type,L.src_fuel_type);
					SELF.src_no_of_bath_fixtures := checkFixSrc(L.no_of_bath_fixtures,L.src_no_of_bath_fixtures);
					SELF.src_no_of_rooms := checkFixSrc(L.no_of_rooms,L.src_no_of_rooms);
					SELF.src_no_of_units := checkFixSrc(L.no_of_units,L.src_no_of_units);
					SELF.src_style_type := checkFixSrc(L.style_type,L.src_style_type);
					SELF.src_assessment_document_number := checkFixSrc(L.assessment_document_number,L.src_assessment_document_number);
					SELF.src_assessment_recording_date := checkFixSrc(L.assessment_recording_date,L.src_assessment_recording_date);
					SELF.src_deed_document_number := checkFixSrc(L.deed_document_number,L.src_deed_document_number);
					SELF.src_deed_recording_date := checkFixSrc(L.deed_recording_date,L.src_deed_recording_date);
					SELF.src_full_part_sale := checkFixSrc(L.full_part_sale,L.src_full_part_sale);
					SELF.src_sale_amount := checkFixSrc(L.sale_amount,L.src_sale_amount);
					SELF.src_sale_date := checkFixSrc(L.sale_date,L.src_sale_date);
					SELF.src_sale_type_code := checkFixSrc(L.sale_type_code,L.src_sale_type_code);
					SELF.src_mortgage_company_name := checkFixSrc(L.mortgage_company_name,L.src_mortgage_company_name);
					SELF.src_loan_amount := checkFixSrc(L.loan_amount,L.src_loan_amount);
					SELF.src_second_loan_amount := checkFixSrc(L.second_loan_amount,L.src_second_loan_amount);
					SELF.src_loan_type_code := checkFixSrc(L.loan_type_code,L.src_loan_type_code);
					SELF.src_interest_rate_type_code := checkFixSrc(L.interest_rate_type_code,L.src_interest_rate_type_code);
					// ******************************************************************************************************************
					// END: ********** WARNING - OLD TWO SOURCE LOGIC NOT VALID NOW WITH 6 SOURCES **************************************
					// ******************************************************************************************************************
				
					SELF := L;
					// SELF := [];
		END;

END;