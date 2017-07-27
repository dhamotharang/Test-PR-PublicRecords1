import STRATA;

export Out_Base_Stats_Population(string pversion) := function
	rPopulationStats_file_base
	 :=
	  record
		CountGroup                                     := count(group);
    PropertyCharacteristics.Files.Base.Property.vendor_source;
		property_rid_CountNonBlank		                  :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.property_rid<>0,1,0));
    dt_vendor_first_reported_CountNonBlank	        :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonBlank	          :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.dt_vendor_last_reported<>0,1,0));
    tax_sortby_date_CountNonBlank		                :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_sortby_date<>'',1,0));
    deed_sortby_date_CountNonBlank		              :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.deed_sortby_date<>'',1,0));
    fares_unformatted_apn_CountNonBlank	            :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.fares_unformatted_apn<>'',1,0));
    property_street_address_CountNonBlank	          :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.property_street_address<>'',1,0));
    property_city_state_zip_CountNonBlank	          :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.property_city_state_zip<>'',1,0));
    property_raw_aid_CountNonBlank		              :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.property_raw_aid<>0,1,0));
    prim_range_CountNonBlank		                    :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.prim_range<>'',1,0));
    predir_CountNonBlank			                      :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.predir<>'',1,0));
    prim_name_CountNonBlank			                    :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.prim_name<>'',1,0));
    addr_suffix_CountNonBlank		                    :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.addr_suffix<>'',1,0));
		postdir_CountNonBlank			                          :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.postdir<>'',1,0));
		unit_desig_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.unit_desig<>'',1,0));
		sec_range_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.sec_range<>'',1,0));
		p_city_name_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.p_city_name<>'',1,0));
		v_city_name_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.v_city_name<>'',1,0));
		st_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.st<>'',1,0));
		zip_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.zip<>'',1,0));
		zip4_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.zip4<>'',1,0));
		cart_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.cart<>'',1,0));
		cr_sort_sz_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.cr_sort_sz<>'',1,0));
		lot_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot<>'',1,0));
		lot_order_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot_order<>'',1,0));
		dbpc_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.dbpc<>'',1,0));
		chk_digit_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.chk_digit<>'',1,0));
		rec_type_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_type<>'',1,0));
		county_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.county<>'',1,0));
		geo_lat_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.geo_lat<>'',1,0));
		geo_long_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.geo_long<>'',1,0));
		msa_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.msa<>'',1,0));
		geo_blk_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.geo_blk<>'',1,0));
		geo_match_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.geo_match<>'',1,0));
		err_stat_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.err_stat<>'',1,0));
		
		bldg_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.building_square_footage<>'',1,0));
		src_bldg_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_building_square_footage<>'',1,0));
		tax_dt_bldg_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_building_square_footage<>'',1,0));

		air_conditioning_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.air_conditioning_type<>'',1,0));
		src_air_conditioning_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_air_conditioning_type <>'',1,0));
		tax_dt_air_conditioning_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_air_conditioning_type <>'',1,0));

		basement_finish_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.basement_finish <>'',1,0));
		src_basement_finish_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_basement_finish <>'',1,0));
		tax_dt_basement_finish_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_basement_finish <>'',1,0));

		construction_type_CountNonBlank	        :=	sum(group,if(PropertyCharacteristics.Files.Base.Property.construction_type <>'',1,0));
		src_construction_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_construction_type <>'',1,0));
		tax_dt_construction_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_construction_type <>'',1,0));

		exterior_wall_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.exterior_wall <>'',1,0));
		src_exterior_wall_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_exterior_wall <>'',1,0));
		tax_dt_exterior_wall_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_exterior_wall <>'',1,0));

		fireplace_ind_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.fireplace_ind <>'',1,0));
		src_fireplace_ind_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_fireplace_ind <>'',1,0));
		tax_dt_fireplace_ind_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_fireplace_ind <>'',1,0));

		fireplace_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.fireplace_type <>'',1,0));
		src_fireplace_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_fireplace_type <>'',1,0));
		tax_dt_fireplace_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_fireplace_type <>'',1,0));

		flood_zone_panel_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.flood_zone_panel <>'',1,0));
		src_flood_zone_panel_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_flood_zone_panel <>'',1,0));
		tax_dt_flood_zone_panel_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_flood_zone_panel <>'',1,0));

		garage_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.garage <>'',1,0));
		src_garage_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_garage <>'',1,0));
		tax_dt_garage_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_garage <>'',1,0));

		first_floor_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.first_floor_square_footage <>'',1,0));
		src_first_floor_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_first_floor_square_footage <>'',1,0));
		tax_dt_first_floor_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_first_floor_square_footage <>'',1,0));

		heating_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.heating <>'',1,0));
		src_heating_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_heating <>'',1,0));
		tax_dt_heating_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_heating <>'',1,0));

		living_area_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.living_area_square_footage <>'',1,0));
		src_living_area_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_living_area_square_footage <>'',1,0));
		tax_dt_living_area_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_living_area_square_footage <>'',1,0));

		no_of_baths_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_baths <>'',1,0));
		src_no_of_baths_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_baths <>'',1,0));
		tax_dt_no_of_baths_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_baths <>'',1,0));

		no_of_bedrooms_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_bedrooms <>'',1,0));
		src_no_of_bedrooms_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_bedrooms <>'',1,0));
		tax_dt_no_of_bedrooms_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_bedrooms <>'',1,0));

		no_of_fireplaces_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_fireplaces <>'',1,0));
		src_no_of_fireplaces_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_fireplaces <>'',1,0));
		tax_dt_no_of_fireplaces_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_fireplaces <>'',1,0));

		no_of_full_baths_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_full_baths <>'',1,0));
		src_no_of_full_baths_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_full_baths <>'',1,0));
		tax_dt_no_of_full_baths_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_full_baths <>'',1,0));

		no_of_half_baths_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_half_baths <>'',1,0));
		src_no_of_half_baths_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_half_baths <>'',1,0));
		tax_dt_no_of_half_baths_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_half_baths <>'',1,0));

		no_of_stories_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_stories <>'',1,0));
		src_no_of_stories_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_stories <>'',1,0));
		tax_dt_no_of_stories_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_stories <>'',1,0));

		parking_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.parking_type <>'',1,0));
		src_parking_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_parking_type <>'',1,0));
		tax_dt_parking_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_parking_type <>'',1,0));

		pool_indicator_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.pool_indicator <>'',1,0));
		src_pool_indicator_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_pool_indicator <>'',1,0));
		tax_dt_pool_indicator_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_pool_indicator <>'',1,0));

		pool_type_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.pool_type <>'',1,0));
		src_pool_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_pool_type <>'',1,0));
		tax_dt_pool_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_pool_type <>'',1,0));

		roof_cover_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.roof_cover <>'',1,0));
		src_roof_cover_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_roof_cover <>'',1,0));
		tax_dt_roof_cover_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_roof_cover <>'',1,0));

		year_built_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.year_built <>'',1,0));
		src_year_built_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_year_built <>'',1,0));
		tax_dt_year_built_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_year_built <>'',1,0));

		foundation_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.foundation <>'',1,0));
		src_foundation_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_foundation <>'',1,0));
		tax_dt_foundation_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_foundation <>'',1,0));

		basement_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.basement_square_footage <>'',1,0));
		src_basement_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_basement_square_footage <>'',1,0));
		tax_dt_basement_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_basement_square_footage <>'',1,0));

		effective_year_built_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.effective_year_built <>'',1,0));
		src_effective_year_built_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_effective_year_built <>'',1,0));
		tax_dt_effective_year_built_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_effective_year_built <>'',1,0));

		garage_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.garage_square_footage <>'',1,0));
		src_garage_sq_ft_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_garage_square_footage <>'',1,0));
		tax_dt_garage_sq_ft_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_garage_square_footage <>'',1,0));

		stories_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.stories_type <>'',1,0));
		src_stories_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_stories_type <>'',1,0));
		tax_dt_stories_type_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_stories_type <>'',1,0));

		apn_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.apn_number <>'',1,0));
		src_apn_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_apn_number <>'',1,0));
		tax_dt_apn_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_apn_number <>'',1,0));

		census_tract_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.census_tract <>'',1,0));
		src_census_tract_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_census_tract <>'',1,0));
		tax_dt_census_tract_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_census_tract <>'',1,0));

		range_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.range <>'',1,0));
		src_range_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_range <>'',1,0));
		tax_dt_range_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_range <>'',1,0));

		zoning_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.zoning <>'',1,0));
		src_zoning_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_zoning <>'',1,0));
		tax_dt_zoning_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_zoning <>'',1,0));

		block_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.block_number <>'',1,0));
		src_block_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_block_number <>'',1,0));
		tax_dt_block_number_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_block_number <>'',1,0));

		county_name_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.county_name <>'',1,0));
		src_county_name_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_county_name <>'',1,0));
		tax_dt_county_name_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_county_name <>'',1,0));

		fips_code_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.fips_code <>'',1,0));
		src_fips_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_fips_code <>'',1,0));
		tax_dt_fips_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_fips_code <>'',1,0));

		subdivision_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.subdivision <>'',1,0));
		src_subdivision_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_subdivision <>'',1,0));
		tax_dt_subdivision_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_subdivision <>'',1,0));

		municipality_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.municipality <>'',1,0));
		src_municipality_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_municipality <>'',1,0));
		tax_dt_municipality_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_municipality <>'',1,0));

		township_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.township <>'',1,0));
		src_township_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_township <>'',1,0));
		tax_dt_township_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_township <>'',1,0));

		homestead_exemption_ind_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.homestead_exemption_ind <>'',1,0));
		src_homestead_exemption_ind_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_homestead_exemption_ind <>'',1,0));
		tax_dt_homestead_exemption_ind_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_homestead_exemption_ind <>'',1,0));

		land_use_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.land_use_code <>'',1,0));
		src_land_use_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_land_use_code <>'',1,0));
		tax_dt_land_use_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_land_use_code <>'',1,0));

		latitude_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.latitude <>'',1,0));
		src_latitude_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_latitude <>'',1,0));
		tax_dt_latitude_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_latitude <>'',1,0));

		longitude_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.longitude <>'',1,0));
		src_longitude_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_longitude <>'',1,0));
		tax_dt_longitude_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_longitude <>'',1,0));

		location_influence_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.location_influence_code <>'',1,0));
		src_location_influence_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_location_influence_code <>'',1,0));
		tax_dt_location_influence_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_location_influence_code <>'',1,0));

		acres_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.acres <>'',1,0));
		src_acres_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_acres <>'',1,0));
		tax_dt_acres_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_acres <>'',1,0));

		lot_depth_footage_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot_depth_footage <>'',1,0));
		src_lot_depth_footage_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_lot_depth_footage <>'',1,0));
		tax_dt_lot_depth_footage_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_lot_depth_footage <>'',1,0));

		lot_front_footage_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot_front_footage <>'',1,0));
		src_lot_front_footage_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_lot_front_footage <>'',1,0));
		tax_dt_lot_front_footage_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_lot_front_footage <>'',1,0));

		lot_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot_number <>'',1,0));
		src_lot_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_lot_number <>'',1,0));
		tax_dt_lot_number_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_lot_number <>'',1,0));

		lot_size_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.lot_size <>'',1,0));
		src_lot_size_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_lot_size <>'',1,0));
		tax_dt_lot_size_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_lot_size <>'',1,0));

		property_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.property_type_code <>'',1,0));
		src_property_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_property_type_code <>'',1,0));
		tax_dt_property_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_property_type_code <>'',1,0));

		structure_quality_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.structure_quality <>'',1,0));
		src_structure_quality_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_structure_quality <>'',1,0));
		tax_dt_structure_quality_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_structure_quality <>'',1,0));

		water_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.water <>'',1,0));
		src_water_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_water <>'',1,0));
		tax_dt_water_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_water <>'',1,0));

		sewer_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.sewer <>'',1,0));
		src_sewer_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_sewer <>'',1,0));
		tax_dt_sewer_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_sewer <>'',1,0));

		assessed_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.assessed_land_value <>'',1,0));
		src_assessed_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_assessed_land_value <>'',1,0));
		tax_dt_assessed_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_assessed_land_value <>'',1,0));

		assessed_year_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.assessed_year <>'',1,0));
		src_assessed_year_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_assessed_year <>'',1,0));
		tax_dt_assessed_year_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_assessed_year <>'',1,0));
tax_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_amount <>'',1,0));
src_tax_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_tax_amount <>'',1,0));
tax_dt_tax_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_tax_amount <>'',1,0));
tax_year_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_year <>'',1,0));
src_tax_year_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_tax_year <>'',1,0));
market_land_value_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.market_land_value <>'',1,0));
src_market_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_market_land_value <>'',1,0));
tax_dt_market_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_market_land_value <>'',1,0));
improvement_value_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.improvement_value <>'',1,0));
src_improvement_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_improvement_value <>'',1,0));
tax_dt_improvement_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_improvement_value <>'',1,0));
percent_improved_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.percent_improved <>0,1,0));
src_percent_improved_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_percent_improved <>'',1,0));
tax_dt_percent_improved_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_percent_improved <>'',1,0));
total_assessed_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.total_assessed_value <>'',1,0));
src_total_assessed_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_total_assessed_value <>'',1,0));
tax_dt_total_assessed_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_total_assessed_value <>'',1,0));
total_calculated_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.total_calculated_value <>'',1,0));
src_total_calculated_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_total_calculated_value <>'',1,0));
tax_dt_total_calculated_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_total_calculated_value <>'',1,0));
total_land_value_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.total_land_value <>'',1,0));
src_total_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_total_land_value <>'',1,0));
tax_dt_total_land_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_total_land_value <>'',1,0));
total_market_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.total_market_value <>'',1,0));
src_total_market_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_total_market_value <>'',1,0));
tax_dt_total_market_value_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_total_market_value <>'',1,0));
floor_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.floor_type <>'',1,0));
src_floor_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_floor_type <>'',1,0));
tax_dt_floor_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_floor_type <>'',1,0));
frame_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.frame_type <>'',1,0));
src_frame_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_frame_type <>'',1,0));
tax_dt_frame_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_frame_type <>'',1,0));
fuel_type_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.fuel_type <>'',1,0));
src_fuel_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_fuel_type <>'',1,0));
tax_dt_fuel_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_fuel_type <>'',1,0));
no_of_bath_fixtures_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_bath_fixtures <>'',1,0));
src_no_of_bath_fixtures_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_bath_fixtures <>'',1,0));
tax_dt_no_of_bath_fixtures_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_bath_fixtures <>'',1,0));
no_of_rooms_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_rooms <>'',1,0));
src_no_of_rooms_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_rooms <>'',1,0));
tax_dt_no_of_rooms_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_rooms <>'',1,0));
no_of_units_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.no_of_units <>'',1,0));
src_no_of_units_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_no_of_units <>'',1,0));
tax_dt_no_of_units_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_no_of_units <>'',1,0));
style_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.style_type <>'',1,0));
src_style_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_style_type <>'',1,0));
tax_dt_style_type_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_style_type <>'',1,0));
assmnt_document_nbr_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.assessment_document_number <>'',1,0));
src_assmnt_document_nbr_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_assessment_document_number <>'',1,0));
tax_dt_assmnt_document_nbr_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_assessment_document_number <>'',1,0));
assmnt_recording_date_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.assessment_recording_date <>'',1,0));
src_assmnt_recording_date_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_assessment_recording_date <>'',1,0));
tax_dt_assessment_recording_date_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_assessment_recording_date <>'',1,0));
deed_document_nbr_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.deed_document_number <>'',1,0));
src_deed_document_nbr_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_deed_document_number <>'',1,0));
rec_dt_deed_document_nmbr_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_deed_document_number <>'',1,0));
deed_recording_date_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.deed_recording_date <>'',1,0));
src_deed_recording_date_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_deed_recording_date <>'',1,0));
full_part_sale_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.full_part_sale <>'',1,0));
src_full_part_sale_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_full_part_sale <>'',1,0));
rec_dt_full_part_sale_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_full_part_sale <>'',1,0));
sale_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.sale_amount <>'',1,0));
src_sale_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_sale_amount <>'',1,0));
rec_dt_sale_amount_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_sale_amount <>'',1,0));
sale_date_CountNonBlank			:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.sale_date <>'',1,0));
src_sale_date_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_sale_date <>'',1,0));
rec_dt_sale_date_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_sale_date <>'',1,0));
sale_type_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.sale_type_code <>'',1,0));
src_sale_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_sale_type_code <>'',1,0));
rec_dt_sale_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_sale_type_code <>'',1,0));
mortgage_company_name_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.mortgage_company_name <>'',1,0));
src_mortgage_company_name_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_mortgage_company_name <>'',1,0));
rec_dt_mortgage_company_name_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_mortgage_company_name <>'',1,0));
loan_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.loan_amount <>'',1,0));
src_loan_amount_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_loan_amount <>'',1,0));
rec_dt_loan_amount_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_loan_amount <>'',1,0));
second_loan_amount_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.second_loan_amount <>'',1,0));
src_second_loan_amount_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_second_loan_amount <>'',1,0));
rec_dt_second_loan_amount_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_second_loan_amount <>'',1,0));
loan_type_code_CountNonBlank		:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.loan_type_code <>'',1,0));
src_loan_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_loan_type_code <>'',1,0));
rec_dt_loan_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_loan_type_code <>'',1,0));
interest_rate_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.interest_rate_type_code <>'',1,0));
src_interest_rate_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.src_interest_rate_type_code <>'',1,0));
rec_dt_interest_rate_type_code_CountNonBlank	:=	sum(group,if(PropertyCharacteristics.Files.Base.Property.rec_dt_interest_rate_type_code <>'',1,0));

roof_type_code_CountNonBlank := sum(group,if(PropertyCharacteristics.Files.Base.Property.roof_type <>'',1,0));
src_roof_type_code_CountNonBlank := sum(group,if(PropertyCharacteristics.Files.Base.Property.src_roof_type <>'',1,0));
tax_dt_roof_type_code_CountNonBlank := sum(group,if(PropertyCharacteristics.Files.Base.Property.tax_dt_roof_type <>'',1,0));
end;

dPopulationStats_PropertyCharacteristics__property_base := table(PropertyCharacteristics.Files.Base.Property,
													rPopulationStats_file_base,
													 PropertyCharacteristics.Files.Base.Property.vendor_source,
													 few
													);

STRATA.createXMLStats(dPopulationStats_PropertyCharacteristics__property_base,
						  'PropertyCharacteristics',
						  'Information',
						  pversion,
						  '',
						  resultsOut,
						  'view',
						  'population'
						 );
		 
	PropertyInfo_base_stats := resultsOut;
	return PropertyInfo_base_stats;
end;