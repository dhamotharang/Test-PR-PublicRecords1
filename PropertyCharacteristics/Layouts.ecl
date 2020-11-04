 import	Address,AID;

export Layouts	:=
module

	export	Common	:=
	record
		string5			vendor_source;
		unsigned1		vendor_preference;
		string8			process_date;
		string8			tax_sortby_date;
		string8			deed_sortby_date;
		string100		property_street_address;
		string50		property_city_state_zip;
		AID.Common.xAID	property_raw_aid	:=	0;
		AID.Common.xAID	property_ace_aid	:=	0;
		Address.Layout_Clean182;
		
		string10		building_square_footage;
		string15		air_conditioning_type;
		string255		air_conditioning_type_desc;
		string15		basement_finish;
		string1500	basement_finish_desc;
		string15		construction_type;
		string255		construction_type_desc;
		string15		exterior_wall;
		string100		exterior_wall_desc;
		string1			fireplace_ind;
		string15		fireplace_type;
		string255		fireplace_type_desc;
		string11		flood_zone_panel;
		string15		garage;
		string255		garage_desc;
		string8			first_floor_square_footage;
		string15		heating;
		string250		heating_desc;
		string8			living_area_square_footage;
		string8			no_of_baths;
		string5			no_of_bedrooms;
		string3			no_of_fireplaces;
		string3			no_of_full_baths;
		string3			no_of_half_baths;
		string30		no_of_stories;
		string15		parking_type;
		string300		parking_type_desc;
		string1			pool_indicator;
		string15		pool_type;
		string255		pool_type_desc;
		string15		roof_cover;
		string150		roof_cover_desc;
		string15		roof_type;
		string150		roof_type_desc;
		string4			year_built;
		string15		foundation;
		string60		foundation_desc;
		string8			basement_square_footage;
		string4			effective_year_built;
		string8			garage_square_footage;
		string15		stories_type;
		string45		apn_number;
		string10		census_tract;
		string25		range;
		string25		zoning;
		string7			block_number;
		string30		county_name;
		string5			fips_code;
		string40		subdivision;
		string30		municipality;
		string30		township;
		string1			homestead_exemption_ind;
		string4			land_use_code;
		string11		latitude;
		string11		longitude;
		string5			location_influence_code;
		string255		location_influence_desc;
		string10		acres;
		string10		lot_depth_footage;
		string10		lot_front_footage;
		string7			lot_number;
		string20		lot_size;
		string3			property_type_code;
		string36		property_type_desc;
		string3			structure_quality;
		string10		structure_quality_desc;
		string15		water;
		string60		water_desc;
		string15		sewer;
		string60		sewer_desc;
		string11		assessed_land_value;
		string4			assessed_year;
		string13		tax_amount;
		string4			tax_year;
		string11		market_land_value;
		string11		improvement_value;
		udecimal5_2	percent_improved;
		string11		total_assessed_value;
		string11		total_calculated_value;
		string11		total_land_value;
		string11		total_market_value;
		string15		floor_type;
		string50		floor_type_desc;
		string15		frame_type;
		string15		frame_type_desc;
		string15		fuel_type;
		string50		fuel_type_desc;
		string5			no_of_bath_fixtures;
		string5			no_of_rooms;
		string5			no_of_units;
		string15		style_type;
		string500		style_type_desc;
		string20		assessment_document_number;
		string8			assessment_recording_date;
		string8			deed_recording_date;
		string20		deed_document_number;
		string3			full_part_sale;
		string11		sale_amount;
		string8			sale_date;
		string3			sale_type_code;
		string40		mortgage_company_name;
		string11		loan_amount;
		string11		second_loan_amount;
		string5			loan_type_code;
		string5			interest_rate_type_code;
		
		// Additional fields
		string1		current_record;
		string45	fares_unformatted_apn;
		
		// Insurbase codes
		dataset(PropertyCharacteristics.Layout_Codes.TradeMaterials)	insurbase_codes	{maxcount(PropertyCharacteristics.Constants.MAX_COUNT_PROP_CHAR)};
	end;

	export	TempBase	:=
	record
		unsigned4 		global_sid:=0;
		unsigned8 		record_sid:=0;
		unsigned6		property_rid;
		unsigned4		dt_vendor_first_reported;
		unsigned4		dt_vendor_last_reported;
		string8			tax_sortby_date;
		string8			deed_sortby_date;
		unsigned1		data_source;
		string1			vendor_source;
		string5			vendor;
		unsigned1		vendor_preference;
		string1			current_record;
		string45		fares_unformatted_apn;
		string100		property_street_address;
		string50		property_city_state_zip;
		AID.Common.xAID	property_raw_aid;
		AID.Common.xAID	property_ace_aid;
		Address.Layout_Clean182;
		
		string10		building_square_footage;
		string5			src_building_square_footage;
		string8			tax_dt_building_square_footage;
		
		string15		air_conditioning_type;
		string255		air_conditioning_type_desc;
		string5			src_air_conditioning_type;
		string8			tax_dt_air_conditioning_type;
		
		string15		basement_finish;
		string1500	basement_finish_desc;
		string5			src_basement_finish;
		string8			tax_dt_basement_finish;
		
		string15		construction_type;
		string255		construction_type_desc;
		string5			src_construction_type;
		string8			tax_dt_construction_type;
		
		string15		exterior_wall;
		string100		exterior_wall_desc;
		string5			src_exterior_wall;
		string8			tax_dt_exterior_wall;
		
		string1			fireplace_ind;
		string5			src_fireplace_ind;
		string8			tax_dt_fireplace_ind;
		
		string15		fireplace_type;
		string255		fireplace_type_desc;
		string5			src_fireplace_type;
		string8			tax_dt_fireplace_type;
		
		string11		flood_zone_panel;
		string5			src_flood_zone_panel;
		string8			tax_dt_flood_zone_panel;
		
		string15		garage;
		string255		garage_desc;
		string5			src_garage;
		string8			tax_dt_garage;
		
		string8			first_floor_square_footage;
		string5			src_first_floor_square_footage;
		string8			tax_dt_first_floor_square_footage;
		
		string15		heating;
		string255		heating_desc;
		string5			src_heating;
		string8			tax_dt_heating;
		
		string8			living_area_square_footage;
		string5			src_living_area_square_footage;
		string8			tax_dt_living_area_square_footage;
		
		string8			no_of_baths;
		string5			src_no_of_baths;
		string8			tax_dt_no_of_baths;
		
		string5			no_of_bedrooms;
		string5			src_no_of_bedrooms;
		string8			tax_dt_no_of_bedrooms;
		
		string3			no_of_fireplaces;
		string5			src_no_of_fireplaces;
		string8			tax_dt_no_of_fireplaces;
		
		string3			no_of_full_baths;
		string5			src_no_of_full_baths;
		string8			tax_dt_no_of_full_baths;
		
		string3			no_of_half_baths;
		string5			src_no_of_half_baths;
		string8			tax_dt_no_of_half_baths;
		
		string30		no_of_stories;
		string5			src_no_of_stories;
		string8			tax_dt_no_of_stories;
		
		string15		parking_type;
		string300		parking_type_desc;
		string5			src_parking_type;
		string8			tax_dt_parking_type;
		
		string1			pool_indicator;
		string5			src_pool_indicator;
		string8			tax_dt_pool_indicator;
		
		string15		pool_type;
		string255		pool_type_desc;
		string5			src_pool_type;
		string8			tax_dt_pool_type;
		
		string15		roof_cover;
		string150		roof_cover_desc;
		string5			src_roof_cover;
		string8			tax_dt_roof_cover;
		
		string15		roof_type;
		string150		roof_type_desc;
		string5			src_roof_type;
		string8			tax_dt_roof_type;
		
		string4			year_built;
		string5			src_year_built;
		string8			tax_dt_year_built;
		
		string15		foundation;
		string60		foundation_desc;
		string5			src_foundation;
		string8			tax_dt_foundation;
		
		string8			basement_square_footage;
		string5			src_basement_square_footage;
		string8			tax_dt_basement_square_footage;
		
		string4			effective_year_built;
		string5			src_effective_year_built;
		string8			tax_dt_effective_year_built;
		
		string8			garage_square_footage;
		string5			src_garage_square_footage;
		string8			tax_dt_garage_square_footage;
		
		string15		stories_type;
		string15		stories_type_desc;
		string5			src_stories_type;
		string8			tax_dt_stories_type;
		
		string45		apn_number;
		string5			src_apn_number;
		string8			tax_dt_apn_number;
		
		string10		census_tract;
		string5			src_census_tract;
		string8			tax_dt_census_tract;
		
		string25		range;
		string5			src_range;
		string8			tax_dt_range;
		
		string25		zoning;
		string5			src_zoning;
		string8			tax_dt_zoning;
		
		string7			block_number;
		string5			src_block_number;
		string8			tax_dt_block_number;
		
		string30		county_name;
		string5			src_county_name;
		string8			tax_dt_county_name;
		
		string5			fips_code;
		string5			src_fips_code;
		string8			tax_dt_fips_code;
		
		string40		subdivision;
		string5			src_subdivision;
		string8			tax_dt_subdivision;
		
		string30		municipality;
		string5			src_municipality;
		string8			tax_dt_municipality;
		
		string30		township;
		string5			src_township;
		string8			tax_dt_township;
		
		string1			homestead_exemption_ind;
		string5			src_homestead_exemption_ind;
		string8			tax_dt_homestead_exemption_ind;
		
		string4			land_use_code;
		string5			src_land_use_code;
		string8			tax_dt_land_use_code;
		
		string11		latitude;
		string5			src_latitude;
		string8			tax_dt_latitude;
		
		string11		longitude;
		string5			src_longitude;
		string8			tax_dt_longitude;
		
		string5			location_influence_code;
		string255		location_influence_desc;
		string5			src_location_influence_code;
		string8			tax_dt_location_influence_code;
		
		string10		acres;
		string5			src_acres;
		string8			tax_dt_acres;
		
		string10		lot_depth_footage;
		string5			src_lot_depth_footage;
		string8			tax_dt_lot_depth_footage;
		
		string10		lot_front_footage;
		string5			src_lot_front_footage;
		string8			tax_dt_lot_front_footage;
		
		string7			lot_number;
		string5			src_lot_number;
		string8			tax_dt_lot_number;
		
		string20		lot_size;
		string5			src_lot_size;
		string8			tax_dt_lot_size;
		
		string3			property_type_code;
		string36		property_type_desc;
		string5			src_property_type_code;
		string8			tax_dt_property_type_code;
		
		string3			structure_quality;
		string10		structure_quality_desc;
		string5			src_structure_quality;
		string8			tax_dt_structure_quality;
		
		string3			water;
		string60		water_desc;
		string5			src_water;
		string8			tax_dt_water;
		
		string3			sewer;
		string60		sewer_desc;
		string5			src_sewer;
		string8			tax_dt_sewer;
		
		string11		assessed_land_value;
		string5			src_assessed_land_value;
		string8			tax_dt_assessed_land_value;
		
		string4			assessed_year;
		string5			src_assessed_year;
		string8			tax_dt_assessed_year;
		
		string13		tax_amount;
		string5			src_tax_amount;
		string8			tax_dt_tax_amount;
		
		string4			tax_year;
		string5			src_tax_year;
		
		string11		market_land_value;
		string5			src_market_land_value;
		string8			tax_dt_market_land_value;
		
		string11		improvement_value;
		string5			src_improvement_value;
		string8			tax_dt_improvement_value;
		
		udecimal5_2	percent_improved;
		string5			src_percent_improved;
		string8			tax_dt_percent_improved;
		
		string11		total_assessed_value;
		string5			src_total_assessed_value;
		string8			tax_dt_total_assessed_value;
		
		string11		total_calculated_value;
		string5			src_total_calculated_value;
		string8			tax_dt_total_calculated_value;
		
		string11		total_land_value;
		string5			src_total_land_value;
		string8			tax_dt_total_land_value;
		
		string11		total_market_value;
		string5			src_total_market_value;
		string8			tax_dt_total_market_value;
		
		string15		floor_type;
		string50		floor_type_desc;
		string5			src_floor_type;
		string8			tax_dt_floor_type;
		
		string15		frame_type;
		string15		frame_type_desc;
		string5			src_frame_type;
		string8			tax_dt_frame_type;
		
		string15		fuel_type;
		string50		fuel_type_desc;
		string5			src_fuel_type;
		string8			tax_dt_fuel_type;
		
		string5			no_of_bath_fixtures;
		string5			src_no_of_bath_fixtures;
		string8			tax_dt_no_of_bath_fixtures;
		
		string5			no_of_rooms;
		string5			src_no_of_rooms;
		string8			tax_dt_no_of_rooms;
		
		string5			no_of_units;
		string5			src_no_of_units;
		string8			tax_dt_no_of_units;
		
		string15		style_type;
		string500		style_type_desc;
		string5			src_style_type;
		string8			tax_dt_style_type;
		
		string20		assessment_document_number;
		string5			src_assessment_document_number;
		string8			tax_dt_assessment_document_number;
		
		string8			assessment_recording_date;
		string5			src_assessment_recording_date;
		string8			tax_dt_assessment_recording_date;
		
		string20		deed_document_number;
		string5			src_deed_document_number;
		string8			rec_dt_deed_document_number;
		
		string8			deed_recording_date;
		string5			src_deed_recording_date;
		
		string3			full_part_sale;
		string5			src_full_part_sale;
		string8			rec_dt_full_part_sale;
		
		string11		sale_amount;
		string5			src_sale_amount;
		string8			rec_dt_sale_amount;
		
		string8			sale_date;
		string5			src_sale_date;
		string8			rec_dt_sale_date;
		
		string3			sale_type_code;
		string5			src_sale_type_code;
		string8			rec_dt_sale_type_code;
		
		string40		mortgage_company_name;
		string5			src_mortgage_company_name;
		string8			rec_dt_mortgage_company_name;
		
		string11		loan_amount;
		string5			src_loan_amount;
		string8			rec_dt_loan_amount;
		
		string11		second_loan_amount;
		string5			src_second_loan_amount;
		string8			rec_dt_second_loan_amount;
		
		string5			loan_type_code;
		string5			src_loan_type_code;
		string8			rec_dt_loan_type_code;
		
		string5			interest_rate_type_code;
		string5			src_interest_rate_type_code;
		string8			rec_dt_interest_rate_type_code;

		// Insurbase codes
		dataset(PropertyCharacteristics.Layout_Codes.TradeMaterials)	insurbase_codes	{maxcount(PropertyCharacteristics.Constants.MAX_COUNT_PROP_CHAR)};
		unsigned1																											cnt_insurbase_codes;
	end;
	
	export	rIBTemp_layout	:=
	record(PropertyCharacteristics.Layout_Codes.TradeMaterials)
		AID.Common.xAID	property_ace_aid;
		unsigned1				preference	:=	0;
		boolean					remove_rec	:=	false;
	end;
	
	export	TempRollup	:=
	record
		TempBase	and	not	insurbase_codes;
		dataset(rIBTemp_layout)	insurbase_codes;
	end;
	
	export	IBCodesRID	:=
	record(PropertyCharacteristics.Layout_Codes.TradeMaterials)
		unsigned6	property_rid;
	end;
	
	shared CharacteristicsOnly:=RECORD
		unsigned4		dt_vendor_first_reported;//first
		unsigned4		dt_vendor_last_reported;//last
		
		unsigned6		property_rid;
		string8			tax_sortby_date;//last
		string8			deed_sortby_date;//source
		
		string10		building_square_footage;
		string5			src_building_square_footage;
		string8			tax_dt_building_square_footage;
		
		string15		air_conditioning_type;
		string255		air_conditioning_type_desc;
		string5			src_air_conditioning_type;
		string8			tax_dt_air_conditioning_type;
		
		string15		basement_finish;
		string1500	basement_finish_desc;
		string5			src_basement_finish;
		string8			tax_dt_basement_finish;
		
		string15		construction_type;
		string255		construction_type_desc;
		string5			src_construction_type;
		string8			tax_dt_construction_type;
		
		string15		exterior_wall;
		string100		exterior_wall_desc;
		string5			src_exterior_wall;
		string8			tax_dt_exterior_wall;
		
		string1			fireplace_ind;
		string5			src_fireplace_ind;
		string8			tax_dt_fireplace_ind;
		
		string15		fireplace_type;
		string255		fireplace_type_desc;
		string5			src_fireplace_type;
		string8			tax_dt_fireplace_type;
		
		string11		flood_zone_panel;
		string5			src_flood_zone_panel;
		string8			tax_dt_flood_zone_panel;
		
		string15		garage;
		string255		garage_desc;
		string5			src_garage;
		string8			tax_dt_garage;
		
		string8			first_floor_square_footage;
		string5			src_first_floor_square_footage;
		string8			tax_dt_first_floor_square_footage;
		
		string15		heating;
		string255		heating_desc;
		string5			src_heating;
		string8			tax_dt_heating;
		
		string8			living_area_square_footage;
		string5			src_living_area_square_footage;
		string8			tax_dt_living_area_square_footage;
		
		string8			no_of_baths;
		string5			src_no_of_baths;
		string8			tax_dt_no_of_baths;
		
		string5			no_of_bedrooms;
		string5			src_no_of_bedrooms;
		string8			tax_dt_no_of_bedrooms;
		
		string3			no_of_fireplaces;
		string5			src_no_of_fireplaces;
		string8			tax_dt_no_of_fireplaces;
		
		string3			no_of_full_baths;
		string5			src_no_of_full_baths;
		string8			tax_dt_no_of_full_baths;
		
		string3			no_of_half_baths;
		string5			src_no_of_half_baths;
		string8			tax_dt_no_of_half_baths;
		
		string30		no_of_stories;
		string5			src_no_of_stories;
		string8			tax_dt_no_of_stories;
		
		string15		parking_type;
		string300		parking_type_desc;
		string5			src_parking_type;
		string8			tax_dt_parking_type;
		
		string1			pool_indicator;
		string5			src_pool_indicator;
		string8			tax_dt_pool_indicator;
		
		string15		pool_type;
		string255		pool_type_desc;
		string5			src_pool_type;
		string8			tax_dt_pool_type;
		
		string15		roof_cover;
		string150		roof_cover_desc;
		string5			src_roof_cover;
		string8			tax_dt_roof_cover;
		
		string15		roof_type;
		string150		roof_type_desc;
		string5			src_roof_type;
		string8			tax_dt_roof_type;
		
		string4			year_built;
		string5			src_year_built;
		string8			tax_dt_year_built;
		
		string15		foundation;
		string60		foundation_desc;
		string5			src_foundation;
		string8			tax_dt_foundation;
		
		string8			basement_square_footage;
		string5			src_basement_square_footage;
		string8			tax_dt_basement_square_footage;
		
		string4			effective_year_built;
		string5			src_effective_year_built;
		string8			tax_dt_effective_year_built;
		
		string8			garage_square_footage;
		string5			src_garage_square_footage;
		string8			tax_dt_garage_square_footage;
		
		string15		stories_type;
		string15		stories_type_desc;
		string5			src_stories_type;
		string8			tax_dt_stories_type;
		
		string45		apn_number;
		string5			src_apn_number;
		string8			tax_dt_apn_number;
		
		string10		census_tract;
		string5			src_census_tract;
		string8			tax_dt_census_tract;
		
		string25		range;
		string5			src_range;
		string8			tax_dt_range;
		
		string25		zoning;
		string5			src_zoning;
		string8			tax_dt_zoning;
		
		string7			block_number;
		string5			src_block_number;
		string8			tax_dt_block_number;
		
		string30		county_name;
		string5			src_county_name;
		string8			tax_dt_county_name;
		
		string5			fips_code;
		string5			src_fips_code;
		string8			tax_dt_fips_code;
		
		string40		subdivision;
		string5			src_subdivision;
		string8			tax_dt_subdivision;
		
		string30		municipality;
		string5			src_municipality;
		string8			tax_dt_municipality;
		
		string30		township;
		string5			src_township;
		string8			tax_dt_township;
		
		string1			homestead_exemption_ind;
		string5			src_homestead_exemption_ind;
		string8			tax_dt_homestead_exemption_ind;
		
		string4			land_use_code;
		string5			src_land_use_code;
		string8			tax_dt_land_use_code;
		
		string11		latitude;
		string5			src_latitude;
		string8			tax_dt_latitude;
		
		string11		longitude;
		string5			src_longitude;
		string8			tax_dt_longitude;
		
		string5			location_influence_code;
		string255		location_influence_desc;
		string5			src_location_influence_code;
		string8			tax_dt_location_influence_code;
		
		string10		acres;
		string5			src_acres;
		string8			tax_dt_acres;
		
		string10		lot_depth_footage;
		string5			src_lot_depth_footage;
		string8			tax_dt_lot_depth_footage;
		
		string10		lot_front_footage;
		string5			src_lot_front_footage;
		string8			tax_dt_lot_front_footage;
		
		string7			lot_number;
		string5			src_lot_number;
		string8			tax_dt_lot_number;
		
		string20		lot_size;
		string5			src_lot_size;
		string8			tax_dt_lot_size;
		
		string3			property_type_code;
		string36		property_type_desc;
		string5			src_property_type_code;
		string8			tax_dt_property_type_code;
		
		string3			structure_quality;
		string10		structure_quality_desc;
		string5			src_structure_quality;
		string8			tax_dt_structure_quality;
		
		string3			water;
		string60		water_desc;
		string5			src_water;
		string8			tax_dt_water;
		
		string3			sewer;
		string60		sewer_desc;
		string5			src_sewer;
		string8			tax_dt_sewer;
		
		string11		assessed_land_value;
		string5			src_assessed_land_value;
		string8			tax_dt_assessed_land_value;
		
		string4			assessed_year;
		string5			src_assessed_year;
		string8			tax_dt_assessed_year;
		
		string13		tax_amount;
		string5			src_tax_amount;
		string8			tax_dt_tax_amount;
		
		string4			tax_year;
		string5			src_tax_year;
		
		string11		market_land_value;
		string5			src_market_land_value;
		string8			tax_dt_market_land_value;
		
		string11		improvement_value;
		string5			src_improvement_value;
		string8			tax_dt_improvement_value;
		
		udecimal5_2	percent_improved;
		string5			src_percent_improved;
		string8			tax_dt_percent_improved;
		
		string11		total_assessed_value;
		string5			src_total_assessed_value;
		string8			tax_dt_total_assessed_value;
		
		string11		total_calculated_value;
		string5			src_total_calculated_value;
		string8			tax_dt_total_calculated_value;
		
		string11		total_land_value;
		string5			src_total_land_value;
		string8			tax_dt_total_land_value;
		
		string11		total_market_value;
		string5			src_total_market_value;
		string8			tax_dt_total_market_value;
		
		string15		floor_type;
		string50		floor_type_desc;
		string5			src_floor_type;
		string8			tax_dt_floor_type;
		
		string15		frame_type;
		string15		frame_type_desc;
		string5			src_frame_type;
		string8			tax_dt_frame_type;
		
		string15		fuel_type;
		string50		fuel_type_desc;
		string5			src_fuel_type;
		string8			tax_dt_fuel_type;
		
		string5			no_of_bath_fixtures;
		string5			src_no_of_bath_fixtures;
		string8			tax_dt_no_of_bath_fixtures;
		
		string5			no_of_rooms;
		string5			src_no_of_rooms;
		string8			tax_dt_no_of_rooms;
		
		string5			no_of_units;
		string5			src_no_of_units;
		string8			tax_dt_no_of_units;
		
		string15		style_type;
		string500		style_type_desc;
		string5			src_style_type;
		string8			tax_dt_style_type;
		
		string20		assessment_document_number;
		string5			src_assessment_document_number;
		string8			tax_dt_assessment_document_number;
		
		string8			assessment_recording_date;
		string5			src_assessment_recording_date;
		string8			tax_dt_assessment_recording_date;
		
		string20		deed_document_number;
		string5			src_deed_document_number;
		string8			rec_dt_deed_document_number;
		
		string8			deed_recording_date;
		string5			src_deed_recording_date;
		
		string3			full_part_sale;
		string5			src_full_part_sale;
		string8			rec_dt_full_part_sale;
		
		string11		sale_amount;
		string5			src_sale_amount;
		string8			rec_dt_sale_amount;
		
		string8			sale_date;
		string5			src_sale_date;
		string8			rec_dt_sale_date;
		
		string3			sale_type_code;
		string5			src_sale_type_code;
		string8			rec_dt_sale_type_code;
		
		string40		mortgage_company_name;
		string5			src_mortgage_company_name;
		string8			rec_dt_mortgage_company_name;
		
		string11		loan_amount;
		string5			src_loan_amount;
		string8			rec_dt_loan_amount;
		
		string11		second_loan_amount;
		string5			src_second_loan_amount;
		string8			rec_dt_second_loan_amount;
		
		string5			loan_type_code;
		string5			src_loan_type_code;
		string8			rec_dt_loan_type_code;
		
		string5			interest_rate_type_code;
		string5			src_interest_rate_type_code;
		string8			rec_dt_interest_rate_type_code;
	END;

	Export TempSourceCompare:=record
		//latest
		unsigned1		data_source;//blank
		string1			vendor_source;//F
		string5			vendor;//blank
		unsigned1		vendor_preference;//blank
		string1			current_record;//blank
		string45		fares_unformatted_apn;//corelogic
		string100		property_street_address;//left
		string50		property_city_state_zip;//left
		AID.Common.xAID	property_raw_aid;//left
		AID.Common.xAID	property_ace_aid;//blank
		Address.Layout_Clean182;
		CharacteristicsOnly CollAnalytics;
		CharacteristicsOnly CoreLogic;
		CharacteristicsOnly BlackKnight;
	end;

	export	Base	:=
	record
		TempBase	and	not	[	vendor,
												vendor_preference,
												data_source,
												current_record,
												property_ace_aid,
												air_conditioning_type_desc,
												basement_finish_desc,
												construction_type_desc,
												exterior_wall_desc,
												fireplace_type_desc,
												garage_desc,
												heating_desc,
												parking_type_desc,
												pool_type_desc,
												roof_cover_desc,
												roof_type_desc,
												foundation_desc,
												stories_type_desc,
												location_influence_desc,
												property_type_desc,
												structure_quality_desc,
												water_desc,
												sewer_desc,
												floor_type_desc,
												frame_type_desc,
												fuel_type_desc,
												style_type_desc,
												cnt_insurbase_codes
											];
	end;
	
end;