IMPORT PRTE2_PropertyInfo,PropertyCharacteristics;

// PROD_BASE_FILE := PropertyCharacteristics.Files.Property;

AddrKey := PropertyCharacteristics.Key_PropChar_Address;
RidKey 	:= PropertyCharacteristics.Key_PropChar_RID;

K1 := 'HILLVILLE';
K2 := '8948';
// Might want to protect that we don't return more than ONE property:
// * use more of the key values to lookup the property...
// * don't process if the FullList contains > 2 records
// -----------------------------------------------------------------------------------------------
RidList := AddrKey(AddrKey.prim_name=K1 AND AddrKey.prim_range=K2);
OUTPUT(RidList);

RidKey doJOIN (addrKey L, RidKey R) := TRANSFORM
	self := r;
	self := [];
END;
FullList := JOIN( RidList,RidKey, LEFT.property_rid = RIGHT.property_rid AND RIGHT.vendor_source IN ['A','B'], doJOIN(LEFT,RIGHT) );
AList := FullList(vendor_source='A')[1];	// example if we wanted the A record for this property
// -----------------------------------------------------------------------------------------------
OUTPUT(FullList);
OUTPUT(AList.air_conditioning_type,NAMED('air_conditioning_type'));
OUTPUT(AList.src_air_conditioning_type,NAMED('src_air_conditioning_type'));
OUTPUT(AList.tax_dt_air_conditioning_type,NAMED('tax_dt_air_conditioning_type'));

OUTPUT(AList.basement_finish,NAMED('basement_finish'));
OUTPUT(AList.src_basement_finish,NAMED('src_basement_finish'));
OUTPUT(AList.tax_dt_basement_finish,NAMED('tax_dt_basement_finish'));

OUTPUT(AList.construction_type,NAMED('construction_type'));
OUTPUT(AList.src_construction_type,NAMED('src_construction_type'));
OUTPUT(AList.tax_dt_construction_type,NAMED('tax_dt_construction_type'));

OUTPUT(AList.exterior_wall,NAMED('exterior_wall'));
OUTPUT(AList.src_exterior_wall,NAMED('src_exterior_wall'));
OUTPUT(AList.tax_dt_exterior_wall,NAMED('tax_dt_exterior_wall'));

OUTPUT(AList.fireplace_ind,NAMED('fireplace_ind'));
OUTPUT(AList.src_fireplace_ind,NAMED('src_fireplace_ind'));
OUTPUT(AList.tax_dt_fireplace_ind,NAMED('tax_dt_fireplace_ind'));

OUTPUT(AList.fireplace_type,NAMED('fireplace_type'));
OUTPUT(AList.src_fireplace_type,NAMED('src_fireplace_type'));
OUTPUT(AList.tax_dt_fireplace_type,NAMED('tax_dt_fireplace_type'));

OUTPUT(AList.flood_zone_panel,NAMED('flood_zone_panel'));
OUTPUT(AList.src_flood_zone_panel,NAMED('src_flood_zone_panel'));
OUTPUT(AList.tax_dt_flood_zone_panel,NAMED('tax_dt_flood_zone_panel'));

OUTPUT(AList.garage,NAMED('garage'));
OUTPUT(AList.src_garage,NAMED('src_garage'));
OUTPUT(AList.tax_dt_garage,NAMED('tax_dt_garage'));

OUTPUT(AList.first_floor_square_footage,NAMED('first_floor_square_footage'));
OUTPUT(AList.src_first_floor_square_footage,NAMED('src_first_floor_square_footage'));
OUTPUT(AList.tax_dt_first_floor_square_footage,NAMED('tax_dt_first_floor_square_footage'));

OUTPUT(AList.heating,NAMED('heating'));
OUTPUT(AList.src_heating,NAMED('src_heating'));
OUTPUT(AList.tax_dt_heating,NAMED('tax_dt_heating'));

OUTPUT(AList.living_area_square_footage,NAMED('living_area_square_footage'));
OUTPUT(AList.src_living_area_square_footage,NAMED('src_living_area_square_footage'));
OUTPUT(AList.tax_dt_living_area_square_footage,NAMED('tax_dt_living_area_square_footage'));

OUTPUT(AList.no_of_baths,NAMED('no_of_baths'));
OUTPUT(AList.src_no_of_baths,NAMED('src_no_of_baths'));
OUTPUT(AList.tax_dt_no_of_baths,NAMED('tax_dt_no_of_baths'));

OUTPUT(AList.no_of_bedrooms,NAMED('no_of_bedrooms'));
OUTPUT(AList.src_no_of_bedrooms,NAMED('src_no_of_bedrooms'));
OUTPUT(AList.tax_dt_no_of_bedrooms,NAMED('tax_dt_no_of_bedrooms'));

OUTPUT(AList.no_of_fireplaces,NAMED('no_of_fireplaces'));
OUTPUT(AList.src_no_of_fireplaces,NAMED('src_no_of_fireplaces'));
OUTPUT(AList.tax_dt_no_of_fireplaces,NAMED('tax_dt_no_of_fireplaces'));

OUTPUT(AList.no_of_full_baths,NAMED('no_of_full_baths'));
OUTPUT(AList.src_no_of_full_baths,NAMED('src_no_of_full_baths'));
OUTPUT(AList.tax_dt_no_of_full_baths,NAMED('tax_dt_no_of_full_baths'));

OUTPUT(AList.no_of_half_baths,NAMED('no_of_half_baths'));
OUTPUT(AList.src_no_of_half_baths,NAMED('src_no_of_half_baths'));
OUTPUT(AList.tax_dt_no_of_half_baths,NAMED('tax_dt_no_of_half_baths'));

OUTPUT(AList.no_of_stories,NAMED('no_of_stories'));
OUTPUT(AList.src_no_of_stories,NAMED('src_no_of_stories'));
OUTPUT(AList.tax_dt_no_of_stories,NAMED('tax_dt_no_of_stories'));

OUTPUT(AList.parking_type,NAMED('parking_type'));
OUTPUT(AList.src_parking_type,NAMED('src_parking_type'));
OUTPUT(AList.tax_dt_parking_type,NAMED('tax_dt_parking_type'));

OUTPUT(AList.pool_indicator,NAMED('pool_indicator'));
OUTPUT(AList.src_pool_indicator,NAMED('src_pool_indicator'));
OUTPUT(AList.tax_dt_pool_indicator,NAMED('tax_dt_pool_indicator'));

OUTPUT(AList.pool_type,NAMED('pool_type'));
OUTPUT(AList.src_pool_type,NAMED('src_pool_type'));
OUTPUT(AList.tax_dt_pool_type,NAMED('tax_dt_pool_type'));

OUTPUT(AList.roof_cover,NAMED('roof_cover'));
OUTPUT(AList.src_roof_cover,NAMED('src_roof_cover'));
OUTPUT(AList.tax_dt_roof_cover,NAMED('tax_dt_roof_cover'));

OUTPUT(AList.year_built,NAMED('year_built'));
OUTPUT(AList.src_year_built,NAMED('src_year_built'));
OUTPUT(AList.tax_dt_year_built,NAMED('tax_dt_year_built'));

OUTPUT(AList.foundation,NAMED('foundation'));
OUTPUT(AList.src_foundation,NAMED('src_foundation'));
OUTPUT(AList.tax_dt_foundation,NAMED('tax_dt_foundation'));

OUTPUT(AList.basement_square_footage,NAMED('basement_square_footage'));
OUTPUT(AList.src_basement_square_footage,NAMED('src_basement_square_footage'));
OUTPUT(AList.tax_dt_basement_square_footage,NAMED('tax_dt_basement_square_footage'));

OUTPUT(AList.effective_year_built,NAMED('effective_year_built'));
OUTPUT(AList.src_effective_year_built,NAMED('src_effective_year_built'));
OUTPUT(AList.tax_dt_effective_year_built,NAMED('tax_dt_effective_year_built'));

OUTPUT(AList.garage_square_footage,NAMED('garage_square_footage'));
OUTPUT(AList.src_garage_square_footage,NAMED('src_garage_square_footage'));
OUTPUT(AList.tax_dt_garage_square_footage,NAMED('tax_dt_garage_square_footage'));

OUTPUT(AList.stories_type,NAMED('stories_type'));
OUTPUT(AList.src_stories_type,NAMED('src_stories_type'));
OUTPUT(AList.tax_dt_stories_type,NAMED('tax_dt_stories_type'));

OUTPUT(AList.water,NAMED('water'));
OUTPUT(AList.src_water,NAMED('src_water'));
OUTPUT(AList.tax_dt_water,NAMED('tax_dt_water'));

OUTPUT(AList.sewer,NAMED('sewer'));
OUTPUT(AList.src_sewer,NAMED('src_sewer'));
OUTPUT(AList.tax_dt_sewer,NAMED('tax_dt_sewer'));

