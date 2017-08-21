import ut,strata,propertyFieldFillinByLA2;

EXPORT strata_LocalizedAvg := FUNCTION;

Slim_Layout := record
  unsigned8 seqno;
  string12 geolink;
  unsigned8 rawaid;
  unsigned8 cleanaid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string2 fips_county;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 standardized_land_use_code;
  string3 property_type_code;
  unsigned4 buildingage;
  string3 buildingage_ftype;
  unsigned4 assessedamount;
  string3 assessedamount_ftype;
  unsigned8 buildingarea;
  string3 buildingarea_ftype;
  real8 stories;
  string3 stories_ftype;
  unsigned8 rooms;
  string3 rooms_ftype;
  unsigned8 bedrooms;
  string3 bedrooms_ftype;
  real8 baths;
  string3 baths_ftype;
  unsigned4 fireplaces;
  string3 fireplaces_ftype;
  unsigned4 garage;
  string3 garage_ftype;
  unsigned4 construction_type;
  string3 construction_ftype;
  unsigned4 exterior_walls;
  string3 exterior_ftype;
  unsigned4 foundation;
  string3 foundation_ftype;
  unsigned4 roof_cover;
  string3 roof_cover_ftype;
  unsigned4 heating;
  string3 heating_ftype;
  unsigned4 fuel_type;
  string3 fuel_type_ftype;
  unsigned4 air_conditioning_type;
  string3 air_conditioning_ftype;
  unsigned4 floor_cover;
  string3 floor_cover_ftype;
  unsigned8 garage_sqft;
  string3 garage_sqft_ftype;
  unsigned8 basement_sqft;
  string3 basement_sqft_ftype;
  unsigned4 basement;
  string3 basement_ftype;
 END;

dsfile := dataset('~thor_data400::temp::propertyfieldfillinbyla2::outpropertyds', PropertyFieldFillInByLA2.layouts.update, thor);

infile := dedup(sort(distribute(dsFile, hash(RawAID)), RawAID, local), RawAID,local);

 
rPopulationStats_LA :=  record	
	infile.st;
	CountGroup    := count(group); 
	// has_seqno     						:= AVE(group,IF(stringlib.stringfilterout((string) infile.seqno, '0') <> '',100,0));
	// has_geolink								:= AVE(group,IF(stringlib.stringfilterout((string) infile.geolink, '0') <> '',100,0));
	// has_property_raw_aid     	:= AVE(group,IF(stringlib.stringfilterout((string) infile.RawAID, '0') <> '',100,0));
	// has_property_clean_aid		:= AVE(group,IF(stringlib.stringfilterout((string) infile.cleanaid, '0') <> '',100,0));
	// has_prim_range     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.prim_range, '0') <> '',100,0));
	// has_predir     						:= AVE(group,IF(stringlib.stringfilterout((string) infile.predir, '0') <> '',100,0));
	// has_prim_name     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.prim_name, '0') <> '',100,0));
	// has_addr_suffix     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.addr_suffix, '0') <> '',100,0));
	// has_postdir     					:= AVE(group,IF(stringlib.stringfilterout((string) infile.postdir, '0') <> '',100,0));
	// has_unit_desig     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.unit_desig, '0') <> '',100,0));
	// has_sec_range     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.sec_range, '0') <> '',100,0));
	// has_p_city_name     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.p_city_name, '0') <> '',100,0));
	// has_v_city_name     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.v_city_name, '0') <> '',100,0));
// has_st     								:= AVE(group,IF(stringlib.stringfilterout((string) infile.st, '0') <> '',100,0));
	// has_zip     							:= AVE(group,IF(stringlib.stringfilterout((string) infile.zip, '0') <> '',100,0));
	// has_zip4     							:= AVE(group,IF(stringlib.stringfilterout((string) infile.zip4, '0') <> '',100,0));
	// has_fips_county						:= AVE(group,IF(stringlib.stringfilterout((string) infile.fips_county, '0') <> '',100,0));
	// has_county     						:= AVE(group,IF(stringlib.stringfilterout((string) infile.county, '0') <> '',100,0));
	// has_geo_lat     					:= AVE(group,IF(stringlib.stringfilterout((string) infile.geo_lat, '0') <> '',100,0));
	// has_geo_long     					:= AVE(group,IF(stringlib.stringfilterout((string) infile.geo_long, '0') <> '',100,0));
	// has_msa     							:= AVE(group,IF(stringlib.stringfilterout((string) infile.msa, '0') <> '',100,0));
	// has_geo_blk     					:= AVE(group,IF(stringlib.stringfilterout((string) infile.geo_blk, '0') <> '',100,0));
	// has_geo_match     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.geo_match, '0') <> '',100,0));
	// has_standardized_land_use_code	:= AVE(group,IF(stringlib.stringfilterout((string) infile.standardized_land_use_code, '0') <> '',100,0));
	has_building_age     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.BuildingAge, '0') <> '' and infile.BuildingAge_ftype <> '',100,0));
	has_assessed_amount     	:= AVE(group,IF(stringlib.stringfilterout((string) infile.AssessedAmount, '0') <> '' and infile.AssessedAmount_ftype <> '',100,0));
	has_building_square_footage     := AVE(group,IF(stringlib.stringfilterout((string) infile.BuildingArea, '0') <> '' and infile.BuildingArea_ftype <> '',100,0));
	has_no_of_stories     		:= AVE(group,IF(stringlib.stringfilterout((string) infile.Stories, '0.00') <> '' and infile.Stories_ftype <> '',100,0));
	has_no_of_rooms     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.rooms, '0') <> '' and infile.Rooms_ftype <> '',100,0));
	has_no_of_bedrooms     		:= AVE(group,IF(stringlib.stringfilterout((string) infile.bedrooms, '0') <> '' and infile.Bedrooms_ftype <> '',100,0));
	has_no_of_baths     			:= AVE(group,IF(stringlib.stringfilterout((string) infile.baths, '0.00') <> '' and infile.Baths_ftype <> '',100,0));
	has_no_of_fireplaces     	:= AVE(group,IF(stringlib.stringfilterout((string) infile.fireplaces, '0') <> ''and infile.Fireplaces_ftype <> '',100,0));
	has_garage     						:= AVE(group,IF(stringlib.stringfilterout((string) infile.garage, '0') <> '' and infile.Garage_ftype <> '',100,0));
	has_construction_type     := AVE(group,IF(stringlib.stringfilterout((string) infile.construction_type, '0') <> '' and infile.Construction_ftype <> '',100,0));
	has_exterior_wall     		:= AVE(group,IF(stringlib.stringfilterout((string) infile.exterior_walls, '0') <> '' and infile.Exterior_ftype <> '',100,0));
	has_foundation     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.foundation, '0') <> '' and infile.Foundation_ftype <> '',100,0));
	has_roof_cover     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.roof_cover, '0') <> '' and infile.Roof_Cover_ftype <> '',100,0));
	has_heating     					:= AVE(group,IF(stringlib.stringfilterout((string) infile.heating, '0') <> '' and infile.Heating_ftype <> '',100,0));
	has_fuel_type     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.fuel_type, '0') <> '' and infile.Fuel_Type_ftype <> '',100,0));
	has_air_conditioning_type := AVE(group,IF(stringlib.stringfilterout((string) infile.air_conditioning_type, '0') <> '' and infile.Air_Conditioning_ftype <> '',100,0));
	has_floor_type     				:= AVE(group,IF(stringlib.stringfilterout((string) infile.floor_cover, '0') <> '' and infile.Floor_Cover_ftype <> '',100,0));
	has_garage_square_footage := AVE(group,IF(stringlib.stringfilterout((string) infile.garage_sqft, '0') <> '' and infile.Garage_sqft_ftype <> '',100,0));
	has_basement_square_footage     := AVE(group,IF(stringlib.stringfilterout((string) infile.basement_sqft, '0') <> '' and infile.Basement_sqft_ftype <> '',100,0));
	has_basement_finish     := AVE(group,IF(stringlib.stringfilterout((string) infile.basement, '0') <> '' and infile.Basement_ftype <> '',100,0));
	
// Future Phase
	// has_pool_type    	:= AVE(group,IF(stringlib.stringfilterout((string) in_file.pool_type, '0') <> '',100,0));
	// has_water     			:= AVE(group,IF(stringlib.stringfilterout((string) in_file.water, '0') <> '',100,0));
	// has_sewer     			:= AVE(group,IF(stringlib.stringfilterout((string) in_file.sewer, '0') <> '',100,0));
	// has_style_type     := AVE(group,IF(stringlib.stringfilterout((string) in_file.style_type, '0') <> '',100,0));
					
		end;

tbl_stats_3 := TABLE(infile, rPopulationStats_LA, st, few);	
LocalAverageDistAddr := output(count(infile));
out_tbl_stats_3 := output(sort(tbl_stats_3, st, skew(1.0)), all, named('base_LocalizedAverage_' + 'Field_Pops_by_State'));	
			
// out_files :=  out_tbl_stats_3;
														
		
		RETURN sequential(LocalAverageDistAddr,out_tbl_stats_3);	
	END;	




