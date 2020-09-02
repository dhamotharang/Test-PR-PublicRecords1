/* **********************************************************************************************************
Basically 3 steps to fix the data we have had over the years to the new data.
1. All record types except F - all value/src attributes check value, if not blank, fill source, if blank, blank source.
2. MLS records only should have specific attributes, all others are blank
3. Rebuild F records from all the others again - that way we avoid MLS values for attributes that it s/n have.
********************************************************************************************************** */

IMPORT PRTE2_PropertyInfo_Ins_MLS,PRTE2_Common,PRTE2_PropertyInfo_Ins_PreMLS;

DS_Prop := SORT(PRTE2_PropertyInfo_Ins_MLS.Files.PII_ALPHA_BASE_SF_DS_Prod,property_rid);
Keep_asis := DS_Prop(vendor_source = 'F');
PropInfo := DS_Prop(vendor_source <> 'F');


NewProp := PROJECT(PropInfo,
                TRANSFORM({PropInfo},
                    // ------------------------------------------------
                    V_Src := LEFT.vendor_source;
                    tmpSrc := MAP(  V_Src='A' => 'FARES',
                                    V_Src='B' => 'OKCTY',     // OR DEFLT!!!  replaceIF will keep existing DEFLTs, all blanks will be OKCTY
                                    V_Src='C' => 'OKCTY',
                                    V_Src='D' => 'FARES',
                                    V_Src='E' => 'MLS',''); 
                                    // F records left out of this process use BWR_9_Refill_Best_Values_Sources to re-do F records from scratch
                                    
                    isEmpty(STRING s1) := TRIM(s1,left,right)='' OR ( s1='0') OR (s1='0.000000');  // Some had just '0' in them we should ignore
                    replaceIF(STRING S1) := IF(TRIM(S1,left,right)<>'',S1,tmpSrc);
                    // NOTE: This will ensure src is filled if there is a value but also if no value will ensure it is blank.
                    FillIF(STRING s1,STRING s2) := IF(isEmpty(s1),'',replaceIF(s2));
                    // ------------------------------------------------

                    SELF.src_building_square_footage := FillIF(LEFT.building_square_footage,LEFT.src_building_square_footage);
                    SELF.src_air_conditioning_type := FillIF(LEFT.air_conditioning_type,LEFT.src_air_conditioning_type);
                    SELF.src_basement_finish := FillIF(LEFT.basement_finish,LEFT.src_basement_finish);
                    SELF.src_construction_type := FillIF(LEFT.construction_type,LEFT.src_construction_type);
                    SELF.src_exterior_wall := FillIF(LEFT.exterior_wall,LEFT.src_exterior_wall);
                    SELF.src_fireplace_ind := FillIF(LEFT.fireplace_ind,LEFT.src_fireplace_ind);
                    SELF.src_fireplace_type := FillIF(LEFT.fireplace_type,LEFT.src_fireplace_type);
                    SELF.src_flood_zone_panel := FillIF(LEFT.flood_zone_panel,LEFT.src_flood_zone_panel);
                    SELF.src_garage := FillIF(LEFT.garage,LEFT.src_garage);
                    SELF.src_first_floor_square_footage := FillIF(LEFT.first_floor_square_footage,LEFT.src_first_floor_square_footage);
                    SELF.src_heating := FillIF(LEFT.heating,LEFT.src_heating);
                    SELF.src_living_area_square_footage := FillIF(LEFT.living_area_square_footage,LEFT.src_living_area_square_footage);
                    SELF.src_no_of_baths := FillIF(LEFT.no_of_baths,LEFT.src_no_of_baths);
                    SELF.src_no_of_bedrooms := FillIF(LEFT.no_of_bedrooms,LEFT.src_no_of_bedrooms);
                    SELF.src_no_of_fireplaces := FillIF(LEFT.no_of_fireplaces,LEFT.src_no_of_fireplaces);
                    SELF.src_no_of_full_baths := FillIF(LEFT.no_of_full_baths,LEFT.src_no_of_full_baths);
                    SELF.src_no_of_half_baths := FillIF(LEFT.no_of_half_baths,LEFT.src_no_of_half_baths);
                    SELF.src_no_of_stories := FillIF(LEFT.no_of_stories,LEFT.src_no_of_stories);
                    SELF.src_parking_type := FillIF(LEFT.parking_type,LEFT.src_parking_type);
                    SELF.src_pool_indicator := FillIF(LEFT.pool_indicator,LEFT.src_pool_indicator);
                    SELF.src_pool_type := FillIF(LEFT.pool_type,LEFT.src_pool_type);
                    SELF.src_roof_cover := FillIF(LEFT.roof_cover,LEFT.src_roof_cover);
                    SELF.src_roof_type := FillIF(LEFT.roof_type,LEFT.src_roof_type);
                    SELF.src_year_built := FillIF(LEFT.year_built,LEFT.src_year_built);
                    SELF.src_foundation := FillIF(LEFT.foundation,LEFT.src_foundation);
                    SELF.src_basement_square_footage := FillIF(LEFT.basement_square_footage,LEFT.src_basement_square_footage);
                    SELF.src_effective_year_built := FillIF(LEFT.effective_year_built,LEFT.src_effective_year_built);
                    SELF.src_garage_square_footage := FillIF(LEFT.garage_square_footage,LEFT.src_garage_square_footage);
                    SELF.src_stories_type := FillIF(LEFT.stories_type,LEFT.src_stories_type);
                    SELF.src_apn_number := FillIF(LEFT.apn_number,LEFT.src_apn_number);
                    SELF.src_census_tract := FillIF(LEFT.census_tract,LEFT.src_census_tract);
                    SELF.src_range := FillIF(LEFT.range,LEFT.src_range);
                    SELF.src_zoning := FillIF(LEFT.zoning,LEFT.src_zoning);
                    SELF.src_block_number := FillIF(LEFT.block_number,LEFT.src_block_number);
                    SELF.src_county_name := FillIF(LEFT.county_name,LEFT.src_county_name);
                    SELF.src_fips_code := FillIF(LEFT.fips_code,LEFT.src_fips_code);
                    SELF.src_subdivision := FillIF(LEFT.subdivision,LEFT.src_subdivision);
                    SELF.src_municipality := FillIF(LEFT.municipality,LEFT.src_municipality);
                    SELF.src_township := FillIF(LEFT.township,LEFT.src_township);
                    SELF.src_homestead_exemption_ind := FillIF(LEFT.homestead_exemption_ind,LEFT.src_homestead_exemption_ind);
                    SELF.src_land_use_code := FillIF(LEFT.land_use_code,LEFT.src_land_use_code);
                    SELF.src_latitude := FillIF(LEFT.latitude,LEFT.src_latitude);
                    SELF.src_longitude := FillIF(LEFT.longitude,LEFT.src_longitude);
                    SELF.src_location_influence_code := FillIF(LEFT.location_influence_code,LEFT.src_location_influence_code);
                    SELF.src_acres := FillIF(LEFT.acres,LEFT.src_acres);
                    SELF.src_lot_depth_footage := FillIF(LEFT.lot_depth_footage,LEFT.src_lot_depth_footage);
                    SELF.src_lot_front_footage := FillIF(LEFT.lot_front_footage,LEFT.src_lot_front_footage);
                    SELF.src_lot_number := FillIF(LEFT.lot_number,LEFT.src_lot_number);
                    SELF.src_lot_size := FillIF(LEFT.lot_size,LEFT.src_lot_size);
                    SELF.src_property_type_code := FillIF(LEFT.property_type_code,LEFT.src_property_type_code);
                    SELF.src_structure_quality := FillIF(LEFT.structure_quality,LEFT.src_structure_quality);
                    SELF.src_water := FillIF(LEFT.water,LEFT.src_water);
                    SELF.src_sewer := FillIF(LEFT.sewer,LEFT.src_sewer);
                    SELF.src_assessed_land_value := FillIF(LEFT.assessed_land_value,LEFT.src_assessed_land_value);
                    SELF.src_assessed_year := FillIF(LEFT.assessed_year,LEFT.src_assessed_year);
                    SELF.src_tax_amount := FillIF(LEFT.tax_amount,LEFT.src_tax_amount);
                    SELF.src_tax_year := FillIF(LEFT.tax_year,LEFT.src_tax_year);
                    SELF.src_market_land_value := FillIF(LEFT.market_land_value,LEFT.src_market_land_value);
                    SELF.src_total_assessed_value := FillIF(LEFT.total_assessed_value,LEFT.src_total_assessed_value);
                    SELF.src_total_calculated_value := FillIF(LEFT.total_calculated_value,LEFT.src_total_calculated_value);
                    SELF.src_total_land_value := FillIF(LEFT.total_land_value,LEFT.src_total_land_value);
                    SELF.src_total_market_value := FillIF(LEFT.total_market_value,LEFT.src_total_market_value);
                    SELF.src_floor_type := FillIF(LEFT.floor_type,LEFT.src_floor_type);
                    SELF.src_frame_type := FillIF(LEFT.frame_type,LEFT.src_frame_type);
                    SELF.src_fuel_type := FillIF(LEFT.fuel_type,LEFT.src_fuel_type);
                    SELF.src_no_of_bath_fixtures := FillIF(LEFT.no_of_bath_fixtures,LEFT.src_no_of_bath_fixtures);
                    SELF.src_no_of_rooms := FillIF(LEFT.no_of_rooms,LEFT.src_no_of_rooms);
                    SELF.src_no_of_units := FillIF(LEFT.no_of_units,LEFT.src_no_of_units);
                    SELF.src_style_type := FillIF(LEFT.style_type,LEFT.src_style_type);
                    SELF.src_assessment_document_number := FillIF(LEFT.assessment_document_number,LEFT.src_assessment_document_number);
                    SELF.src_assessment_recording_date := FillIF(LEFT.assessment_recording_date,LEFT.src_assessment_recording_date);
                    SELF.src_deed_document_number := FillIF(LEFT.deed_document_number,LEFT.src_deed_document_number);
                    SELF.src_deed_recording_date := FillIF(LEFT.deed_recording_date,LEFT.src_deed_recording_date);
                    SELF.src_full_part_sale := FillIF(LEFT.full_part_sale,LEFT.src_full_part_sale);
                    SELF.src_sale_amount := FillIF(LEFT.sale_amount,LEFT.src_sale_amount);
                    SELF.src_sale_date := FillIF(LEFT.sale_date,LEFT.src_sale_date);
                    SELF.src_sale_type_code := FillIF(LEFT.sale_type_code,LEFT.src_sale_type_code);
                    SELF.src_mortgage_company_name := FillIF(LEFT.mortgage_company_name,LEFT.src_mortgage_company_name);
                    SELF.src_loan_amount := FillIF(LEFT.loan_amount,LEFT.src_loan_amount);
                    SELF.src_second_loan_amount := FillIF(LEFT.second_loan_amount,LEFT.src_second_loan_amount);
                    SELF.src_loan_type_code := FillIF(LEFT.loan_type_code,LEFT.src_loan_type_code);
                    SELF.src_interest_rate_type_code := FillIF(LEFT.interest_rate_type_code,LEFT.src_interest_rate_type_code);

                    SELF.src_percent_improved := IF(LEFT.percent_improved<>0.0,replaceIF(LEFT.src_percent_improved),'');
                    SELF.src_improvement_value := IF( ( (INTEGER)LEFT.improvement_value=0),'',LEFT.src_improvement_value);

                    SELF := LEFT;
                ));

// -------------------------------------------------------------------------------------
EXPORT_DSa := Keep_asis+NewProp;
EXPORT_DS := SORT(EXPORT_DSa,fares_unformatted_apn,property_rid);
EXPORT_DS2 := SORT(DS_Prop,fares_unformatted_apn,property_rid);
OUTPUT('COUNTS:'+COUNT(DS_Prop)+COUNT(EXPORT_DS));
// -------------------------------------------------------------------------------------
dateString 		:= PRTE2_Common.Constants.TodayString;
desprayName 	:= 'PropertyInfo_1_FixBlankSrc_'+dateString+'.csv';
desprayName2 	:= 'PropertyInfo_1_PreFix_'+dateString+'.csv';
lzFilePathFile	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.SourcePathForPIICSV + desprayName;
lzFilePathFile2	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.SourcePathForPIICSV + desprayName2;
LandingZoneIP 	:= PRTE2_PropertyInfo_Ins_PreMLS.Constants.LandingZoneIP;
TempCSV			:= PRTE2_PropertyInfo_Ins_PreMLS.Files.Alpha_Spray_Name;
TempCSV2		:= PRTE2_PropertyInfo_Ins_PreMLS.Files.Alpha_Spray_Name+'_2';

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathFile);
PRTE2_Common.DesprayCSV(EXPORT_DS2, TempCSV2, LandingZoneIP, lzFilePathFile2);

Files := PRTE2_PropertyInfo_Ins_MLS.Files;
NewDataDS := DISTRIBUTE(EXPORT_DS,HASH(fares_unformatted_apn,property_rid));
buildPIIBase := PRTE2_Common.Promote_Supers.mac_SFBuildProcess(NewDataDS, Files.PII_ALPHA_BASE_SF);
SEQUENTIAL(buildPIIBase);