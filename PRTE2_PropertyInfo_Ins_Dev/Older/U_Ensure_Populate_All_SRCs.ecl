/*2016-08-01T19:24:37Z (Bruce Petro)

*/
//---------------------------------------------------------------------
// PRTE2_PropertyInfo.BWR_Despray_Base
//  - despray the Property Info base file for editing.
//---------------------------------------------------------------------
// NOTE: The CSV name "PropertyInfo_V2" is to indicate we totally altered
//  the main layouts removed gateway and editable_spreadsheet layouts
//---------------------------------------------------------------------

IMPORT PRTE2_Common, ut;
IMPORT PRTE2_PropertyInfo as PII;
#workunit('name', 'Boca CT PropertyInfo Pop-All-Src');

dateString := ut.GetDate;
LandingZoneIP 				:= PII.Constants.LandingZoneIP;
TempCSV								:= PII.Files.PII_CSV_FILE + '::' +  WORKUNIT;
desprayName 					:= 'PropertyInfo_Pop_Src_Prod_'+dateString+'.csv';
lzFilePathGatewayFile	:= PII.Constants.SourcePathForPIICSV + desprayName;
ProcessDS1	:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;

//---------------------------------------------------------------------
GETSRC(STRING S1) := IF(S1='D', 'FARES', 'OKCTY');
ChooseWhich(STRING SRC, STRING VSrc) := IF(SRC='', GETSRC(VSrc), SRC);
checkFixSrc(STRING Value, STRING SRC, STRING VSrc) := IF(Value='', '', ChooseWhich(SRC, VSrc));
checkFixSrc52(udecimal5_2 value, STRING SRC, STRING VSrc) := IF(Value=0.00, '', ChooseWhich(SRC, VSrc));

//---------------------------------------------------------------------
ProcessDS1 trxCheckAll(ProcessDS1 L) := TRANSFORM
		SELF.src_building_square_footage := checkFixSrc(L.building_square_footage,L.src_building_square_footage,L.vendor_source);
		SELF.src_air_conditioning_type := checkFixSrc(L.air_conditioning_type,L.src_air_conditioning_type,L.vendor_source);
		SELF.src_basement_finish := checkFixSrc(L.basement_finish,L.src_basement_finish,L.vendor_source);
		SELF.src_construction_type := checkFixSrc(L.construction_type,L.src_construction_type,L.vendor_source);
		SELF.src_exterior_wall := checkFixSrc(L.exterior_wall,L.src_exterior_wall,L.vendor_source);
		SELF.src_fireplace_ind := checkFixSrc(L.fireplace_ind,L.src_fireplace_ind,L.vendor_source);
		SELF.src_fireplace_type := checkFixSrc(L.fireplace_type,L.src_fireplace_type,L.vendor_source);
		SELF.src_flood_zone_panel := checkFixSrc(L.flood_zone_panel,L.src_flood_zone_panel,L.vendor_source);
		SELF.src_garage := checkFixSrc(L.garage,L.src_garage,L.vendor_source);
		SELF.src_first_floor_square_footage := checkFixSrc(L.first_floor_square_footage,L.src_first_floor_square_footage,L.vendor_source);
		SELF.src_heating := checkFixSrc(L.heating,L.src_heating,L.vendor_source);
		SELF.src_living_area_square_footage := checkFixSrc(L.living_area_square_footage,L.src_living_area_square_footage,L.vendor_source);
		SELF.src_no_of_baths := checkFixSrc(L.no_of_baths,L.src_no_of_baths,L.vendor_source);
		SELF.src_no_of_bedrooms := checkFixSrc(L.no_of_bedrooms,L.src_no_of_bedrooms,L.vendor_source);
		SELF.src_no_of_fireplaces := checkFixSrc(L.no_of_fireplaces,L.src_no_of_fireplaces,L.vendor_source);
		SELF.src_no_of_full_baths := checkFixSrc(L.no_of_full_baths,L.src_no_of_full_baths,L.vendor_source);
		SELF.src_no_of_half_baths := checkFixSrc(L.no_of_half_baths,L.src_no_of_half_baths,L.vendor_source);
		SELF.src_no_of_stories := checkFixSrc(L.no_of_stories,L.src_no_of_stories,L.vendor_source);
		SELF.src_parking_type := checkFixSrc(L.parking_type,L.src_parking_type,L.vendor_source);
		SELF.src_pool_indicator := checkFixSrc(L.pool_indicator,L.src_pool_indicator,L.vendor_source);
		SELF.src_pool_type := checkFixSrc(L.pool_type,L.src_pool_type,L.vendor_source);
		SELF.src_roof_cover := checkFixSrc(L.roof_cover,L.src_roof_cover,L.vendor_source);
		SELF.src_roof_type := checkFixSrc(L.roof_type,L.src_roof_type,L.vendor_source);
		SELF.src_year_built := checkFixSrc(L.year_built,L.src_year_built,L.vendor_source);
		SELF.src_foundation := checkFixSrc(L.foundation,L.src_foundation,L.vendor_source);
		SELF.src_basement_square_footage := checkFixSrc(L.basement_square_footage,L.src_basement_square_footage,L.vendor_source);
		SELF.src_effective_year_built := checkFixSrc(L.effective_year_built,L.src_effective_year_built,L.vendor_source);
		SELF.src_garage_square_footage := checkFixSrc(L.garage_square_footage,L.src_garage_square_footage,L.vendor_source);
		SELF.src_stories_type := checkFixSrc(L.stories_type,L.src_stories_type,L.vendor_source);
		SELF.src_apn_number := checkFixSrc(L.apn_number,L.src_apn_number,L.vendor_source);
		SELF.src_census_tract := checkFixSrc(L.census_tract,L.src_census_tract,L.vendor_source);
		SELF.src_range := checkFixSrc(L.range,L.src_range,L.vendor_source);
		SELF.src_zoning := checkFixSrc(L.zoning,L.src_zoning,L.vendor_source);
		SELF.src_block_number := checkFixSrc(L.block_number,L.src_block_number,L.vendor_source);
		SELF.src_county_name := checkFixSrc(L.county_name,L.src_county_name,L.vendor_source);
		SELF.src_fips_code := checkFixSrc(L.fips_code,L.src_fips_code,L.vendor_source);
		SELF.src_subdivision := checkFixSrc(L.subdivision,L.src_subdivision,L.vendor_source);
		SELF.src_municipality := checkFixSrc(L.municipality,L.src_municipality,L.vendor_source);
		SELF.src_township := checkFixSrc(L.township,L.src_township,L.vendor_source);
		SELF.src_homestead_exemption_ind := checkFixSrc(L.homestead_exemption_ind,L.src_homestead_exemption_ind,L.vendor_source);
		SELF.src_land_use_code := checkFixSrc(L.land_use_code,L.src_land_use_code,L.vendor_source);
		SELF.src_latitude := checkFixSrc(L.latitude,L.src_latitude,L.vendor_source);
		SELF.src_longitude := checkFixSrc(L.longitude,L.src_longitude,L.vendor_source);
		SELF.src_location_influence_code := checkFixSrc(L.location_influence_code,L.src_location_influence_code,L.vendor_source);
		SELF.src_acres := checkFixSrc(L.acres,L.src_acres,L.vendor_source);
		SELF.src_lot_depth_footage := checkFixSrc(L.lot_depth_footage,L.src_lot_depth_footage,L.vendor_source);
		SELF.src_lot_front_footage := checkFixSrc(L.lot_front_footage,L.src_lot_front_footage,L.vendor_source);
		SELF.src_lot_number := checkFixSrc(L.lot_number,L.src_lot_number,L.vendor_source);
		SELF.src_lot_size := checkFixSrc(L.lot_size,L.src_lot_size,L.vendor_source);
		SELF.src_property_type_code := checkFixSrc(L.property_type_code,L.src_property_type_code,L.vendor_source);
		SELF.src_structure_quality := checkFixSrc(L.structure_quality,L.src_structure_quality,L.vendor_source);
		SELF.src_water := checkFixSrc(L.water,L.src_water,L.vendor_source);
		SELF.src_sewer := checkFixSrc(L.sewer,L.src_sewer,L.vendor_source);
		SELF.src_assessed_land_value := checkFixSrc(L.assessed_land_value,L.src_assessed_land_value,L.vendor_source);
		SELF.src_assessed_year := checkFixSrc(L.assessed_year,L.src_assessed_year,L.vendor_source);
		SELF.src_tax_amount := checkFixSrc(L.tax_amount,L.src_tax_amount,L.vendor_source);
		SELF.src_tax_year := checkFixSrc(L.tax_year,L.src_tax_year,L.vendor_source);
		SELF.src_market_land_value := checkFixSrc(L.market_land_value,L.src_market_land_value,L.vendor_source);
		SELF.src_improvement_value := checkFixSrc(L.improvement_value,L.src_improvement_value,L.vendor_source);
		SELF.src_percent_improved := checkFixSrc52(L.percent_improved,L.src_percent_improved,L.vendor_source);
		SELF.src_total_assessed_value := checkFixSrc(L.total_assessed_value,L.src_total_assessed_value,L.vendor_source);
		SELF.src_total_calculated_value := checkFixSrc(L.total_calculated_value,L.src_total_calculated_value,L.vendor_source);
		SELF.src_total_land_value := checkFixSrc(L.total_land_value,L.src_total_land_value,L.vendor_source);
		SELF.src_total_market_value := checkFixSrc(L.total_market_value,L.src_total_market_value,L.vendor_source);
		SELF.src_floor_type := checkFixSrc(L.floor_type,L.src_floor_type,L.vendor_source);
		SELF.src_frame_type := checkFixSrc(L.frame_type,L.src_frame_type,L.vendor_source);
		SELF.src_fuel_type := checkFixSrc(L.fuel_type,L.src_fuel_type,L.vendor_source);
		SELF.src_no_of_bath_fixtures := checkFixSrc(L.no_of_bath_fixtures,L.src_no_of_bath_fixtures,L.vendor_source);
		SELF.src_no_of_rooms := checkFixSrc(L.no_of_rooms,L.src_no_of_rooms,L.vendor_source);
		SELF.src_no_of_units := checkFixSrc(L.no_of_units,L.src_no_of_units,L.vendor_source);
		SELF.src_style_type := checkFixSrc(L.style_type,L.src_style_type,L.vendor_source);
		SELF.src_assessment_document_number := checkFixSrc(L.assessment_document_number,L.src_assessment_document_number,L.vendor_source);
		SELF.src_assessment_recording_date := checkFixSrc(L.assessment_recording_date,L.src_assessment_recording_date,L.vendor_source);
		SELF.src_deed_document_number := checkFixSrc(L.deed_document_number,L.src_deed_document_number,L.vendor_source);
		SELF.src_deed_recording_date := checkFixSrc(L.deed_recording_date,L.src_deed_recording_date,L.vendor_source);
		SELF.src_full_part_sale := checkFixSrc(L.full_part_sale,L.src_full_part_sale,L.vendor_source);
		SELF.src_sale_amount := checkFixSrc(L.sale_amount,L.src_sale_amount,L.vendor_source);
		SELF.src_sale_date := checkFixSrc(L.sale_date,L.src_sale_date,L.vendor_source);
		SELF.src_sale_type_code := checkFixSrc(L.sale_type_code,L.src_sale_type_code,L.vendor_source);
		SELF.src_mortgage_company_name := checkFixSrc(L.mortgage_company_name,L.src_mortgage_company_name,L.vendor_source);
		SELF.src_loan_amount := checkFixSrc(L.loan_amount,L.src_loan_amount,L.vendor_source);
		SELF.src_second_loan_amount := checkFixSrc(L.second_loan_amount,L.src_second_loan_amount,L.vendor_source);
		SELF.src_loan_type_code := checkFixSrc(L.loan_type_code,L.src_loan_type_code,L.vendor_source);
		SELF.src_interest_rate_type_code := checkFixSrc(L.interest_rate_type_code,L.src_interest_rate_type_code,L.vendor_source);
		SELF := L;
END;

//---------------------------------------------------------------------
ProcessedDS		:= PROJECT(ProcessDS1,trxCheckAll(LEFT));
EXPORT_DS			:= SORT(processedDS,property_rid);
PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

