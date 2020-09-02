/* ************************************************************************************************************************
PRTE2_PropertyInfo_Ins_MLS.Utilities_MLS.fn_add_Type_E

**********************************************************************************************
***** MLS CONVERSION NOTES:
Pass in "D" Records
Receive recordset with "E" records.
**********************************************************************************************
************************************************************************************************************************ */
IMPORT PRTE2_PropertyInfo_Ins_MLS, PropertyCharacteristics;

BaseLayout := PRTE2_PropertyInfo_Ins_MLS.Layouts.AlphaPropertyCSVRec_MLS;

cleanValue(STRING someValue) := PropertyCharacteristics.Functions.fn_remove_zeroes(someValue);
isEMPTY(STRING s1) := cleanValue(s1)='';
ReplaceIF(STRING s1, STRING s2) := IF(isEMPTY(s1), s1, s2);	

EXPORT fn_add_Type_E(DATASET(BaseLayout) CloneableDS) := FUNCTION
// finalSetE := CloneableDS;
	finalSetE := PROJECT(CloneableDS,
							TRANSFORM( {CloneableDS},
							E_SRC := 'MLS';
							SELF.vendor_source := 'E';
							SELF.src_building_square_footage := ReplaceIF(LEFT.src_building_square_footage ,E_SRC);
							SELF.src_air_conditioning_type := ReplaceIF(LEFT.src_air_conditioning_type,E_SRC);
							SELF.src_basement_finish := ReplaceIF(LEFT.src_basement_finish,E_SRC);
							SELF.src_construction_type := ReplaceIF(LEFT.src_construction_type,E_SRC);
							SELF.src_exterior_wall := ReplaceIF(LEFT.src_exterior_wall,E_SRC);
							SELF.src_fireplace_ind := ReplaceIF(LEFT.src_fireplace_ind,E_SRC);
							SELF.src_fireplace_type := ReplaceIF(LEFT.src_fireplace_type,E_SRC);
							SELF.src_flood_zone_panel := ReplaceIF(LEFT.src_flood_zone_panel,E_SRC);
							SELF.src_garage := ReplaceIF(LEFT.src_garage,E_SRC);
							SELF.src_first_floor_square_footage := ReplaceIF(LEFT.src_first_floor_square_footage,E_SRC);
							SELF.src_heating := ReplaceIF(LEFT.src_heating,E_SRC);
							SELF.src_living_area_square_footage := ReplaceIF(LEFT.src_living_area_square_footage,E_SRC);
							SELF.src_no_of_baths := ReplaceIF(LEFT.src_no_of_baths,E_SRC);
							SELF.src_no_of_bedrooms := ReplaceIF(LEFT.src_no_of_bedrooms,E_SRC);
							SELF.src_no_of_fireplaces := ReplaceIF(LEFT.src_no_of_fireplaces,E_SRC);
							SELF.src_no_of_full_baths := ReplaceIF(LEFT.src_no_of_full_baths,E_SRC);
							SELF.src_no_of_half_baths := ReplaceIF(LEFT.src_no_of_half_baths,E_SRC);
							SELF.src_no_of_stories := ReplaceIF(LEFT.src_no_of_stories,E_SRC);
							SELF.src_parking_type := ReplaceIF(LEFT.src_parking_type,E_SRC);
							SELF.src_pool_indicator := ReplaceIF(LEFT.src_pool_indicator,E_SRC);
							SELF.src_pool_type := ReplaceIF(LEFT.src_pool_type,E_SRC);
							SELF.src_roof_cover := ReplaceIF(LEFT.src_roof_cover,E_SRC);
							SELF.src_roof_type := ReplaceIF(LEFT.src_roof_type,E_SRC);
							SELF.src_year_built := ReplaceIF(LEFT.src_year_built,E_SRC);
							SELF.src_foundation := ReplaceIF(LEFT.src_foundation,E_SRC);
							SELF.src_basement_square_footage := ReplaceIF(LEFT.src_basement_square_footage,E_SRC);
							SELF.src_effective_year_built := ReplaceIF(LEFT.src_effective_year_built,E_SRC);
							SELF.src_garage_square_footage := ReplaceIF(LEFT.src_garage_square_footage,E_SRC);
							SELF.src_stories_type := ReplaceIF(LEFT.src_stories_type,E_SRC);
							SELF.src_apn_number := ReplaceIF(LEFT.src_apn_number,E_SRC);
							SELF.src_census_tract := ReplaceIF(LEFT.src_census_tract,E_SRC);
							SELF.src_range := ReplaceIF(LEFT.src_range,E_SRC);
							SELF.src_zoning := ReplaceIF(LEFT.src_zoning,E_SRC);
							SELF.src_block_number := ReplaceIF(LEFT.src_block_number,E_SRC);
							SELF.src_county_name := ReplaceIF(LEFT.src_county_name,E_SRC);
							SELF.src_fips_code := ReplaceIF(LEFT.src_fips_code,E_SRC);
							SELF.src_subdivision := ReplaceIF(LEFT.src_subdivision,E_SRC);
							SELF.src_municipality := ReplaceIF(LEFT.src_municipality,E_SRC);
							SELF.src_township := ReplaceIF(LEFT.src_township,E_SRC);
							SELF.src_homestead_exemption_ind := ReplaceIF(LEFT.src_homestead_exemption_ind,E_SRC);
							SELF.src_land_use_code := ReplaceIF(LEFT.src_land_use_code,E_SRC);
							SELF.src_latitude := ReplaceIF(LEFT.src_latitude,E_SRC);
							SELF.src_longitude := ReplaceIF(LEFT.src_longitude,E_SRC);
							SELF.src_location_influence_code := ReplaceIF(LEFT.src_location_influence_code,E_SRC);
							SELF.src_acres := ReplaceIF(LEFT.src_acres,E_SRC);
							SELF.src_lot_depth_footage := ReplaceIF(LEFT.src_lot_depth_footage,E_SRC);
							SELF.src_lot_front_footage := ReplaceIF(LEFT.src_lot_front_footage,E_SRC);
							SELF.src_lot_number := ReplaceIF(LEFT.src_lot_number,E_SRC);
							SELF.src_lot_size := ReplaceIF(LEFT.src_lot_size,E_SRC);
							SELF.src_property_type_code := ReplaceIF(LEFT.src_property_type_code,E_SRC);
							SELF.src_structure_quality := ReplaceIF(LEFT.src_structure_quality,E_SRC);
							SELF.src_water := ReplaceIF(LEFT.src_water,E_SRC);
							SELF.src_sewer := ReplaceIF(LEFT.src_sewer,E_SRC);
							SELF.src_assessed_land_value := ReplaceIF(LEFT.src_assessed_land_value,E_SRC);
							SELF.src_assessed_year := ReplaceIF(LEFT.src_assessed_year,E_SRC);
							SELF.src_tax_amount := ReplaceIF(LEFT.src_tax_amount,E_SRC);
							SELF.src_tax_year := ReplaceIF(LEFT.src_tax_year,E_SRC);
							SELF.src_market_land_value := ReplaceIF(LEFT.src_market_land_value,E_SRC);
							SELF.src_improvement_value := ReplaceIF(LEFT.src_improvement_value,E_SRC);
							SELF.src_percent_improved := ReplaceIF(LEFT.src_percent_improved,E_SRC);
							SELF.src_total_assessed_value := ReplaceIF(LEFT.src_total_assessed_value,E_SRC);
							SELF.src_total_calculated_value := ReplaceIF(LEFT.src_total_calculated_value,E_SRC);
							SELF.src_total_land_value := ReplaceIF(LEFT.src_total_land_value,E_SRC);
							SELF.src_total_market_value := ReplaceIF(LEFT.src_total_market_value,E_SRC);
							SELF.src_floor_type := ReplaceIF(LEFT.src_floor_type,E_SRC);
							SELF.src_frame_type := ReplaceIF(LEFT.src_frame_type,E_SRC);
							SELF.src_fuel_type := ReplaceIF(LEFT.src_fuel_type,E_SRC);
							SELF.src_no_of_bath_fixtures := ReplaceIF(LEFT.src_no_of_bath_fixtures,E_SRC);
							SELF.src_no_of_rooms := ReplaceIF(LEFT.src_no_of_rooms,E_SRC);
							SELF.src_no_of_units := ReplaceIF(LEFT.src_no_of_units,E_SRC);
							SELF.src_style_type := ReplaceIF(LEFT.src_style_type,E_SRC);
							SELF.src_assessment_document_number := ReplaceIF(LEFT.src_assessment_document_number,E_SRC);
							SELF.src_assessment_recording_date := ReplaceIF(LEFT.src_assessment_recording_date,E_SRC);
							SELF.src_deed_document_number := ReplaceIF(LEFT.src_deed_document_number,E_SRC);
							SELF.src_deed_recording_date := ReplaceIF(LEFT.src_deed_recording_date,E_SRC);
							SELF.src_full_part_sale := ReplaceIF(LEFT.src_full_part_sale,E_SRC);
							SELF.src_sale_amount := ReplaceIF(LEFT.src_sale_amount,E_SRC);
							SELF.src_sale_date := ReplaceIF(LEFT.src_sale_date,E_SRC);
							SELF.src_sale_type_code := ReplaceIF(LEFT.src_sale_type_code,E_SRC);
							SELF.src_mortgage_company_name := ReplaceIF(LEFT.src_mortgage_company_name,E_SRC);
							SELF.src_loan_amount := ReplaceIF(LEFT.src_loan_amount,E_SRC);
							SELF.src_second_loan_amount := ReplaceIF(LEFT.src_second_loan_amount,E_SRC);
							SELF.src_loan_type_code := ReplaceIF(LEFT.src_loan_type_code,E_SRC);
							SELF.src_interest_rate_type_code := ReplaceIF(LEFT.src_interest_rate_type_code,E_SRC);
							SELF := LEFT));

	RETURN finalSetE;
END;