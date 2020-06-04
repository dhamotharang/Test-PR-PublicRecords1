﻿/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:   Need to add bugnum and custname
**********************************************************************************************
FEB 2020
* Convert to new layout with empty PII fields and cust_name, bug_num
************************************************************************************************************************ */

IMPORT PRTE2,PRTE_CSV,PRTE, ut, PropertyCharacteristics;

EXPORT Layouts := MODULE

	EXPORT Boca_Official_Layout := RECORD
		PropertyCharacteristics.Layouts.Base;
		// add bugnum/custname		-- NO!  This layout isn't a Boca Base file - this becomes the RID key layout!  Should not add fields!
	END;

	// --------------------------------------------------------------------------------------------------------------------
	EXPORT AlphaPropertyCSVRec_Core := RECORD
		unsigned4	dt_vendor_first_reported;
		unsigned4	dt_vendor_last_reported;
		string8		tax_sortby_date;
		string8		deed_sortby_date;
		string1		vendor_source;
		string45	fares_unformatted_apn;
		string100	property_street_address;
		string50	property_city_state_zip;
		unsigned8	property_raw_aid;
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		addr_suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip;
		string4		zip4;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dbpc;
		string1		chk_digit;
		string2		rec_type;
		string5		county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		string10	building_square_footage;
		string5		src_building_square_footage;
		string8		tax_dt_building_square_footage;
		string15	air_conditioning_type;
		string5		src_air_conditioning_type;
		string8		tax_dt_air_conditioning_type;
		string15	basement_finish;
		string5		src_basement_finish;
		string8		tax_dt_basement_finish;
		string15	construction_type;
		string5		src_construction_type;
		string8		tax_dt_construction_type;
		string15	exterior_wall;
		string5		src_exterior_wall;
		string8		tax_dt_exterior_wall;
		string1		fireplace_ind;
		string5		src_fireplace_ind;
		string8		tax_dt_fireplace_ind;
		string15	fireplace_type;
		string5		src_fireplace_type;
		string8		tax_dt_fireplace_type;
		string11	flood_zone_panel;
		string5		src_flood_zone_panel;
		string8		tax_dt_flood_zone_panel;
		string15	garage;
		string5		src_garage;
		string8		tax_dt_garage;
		string8		first_floor_square_footage;
		string5		src_first_floor_square_footage;
		string8		tax_dt_first_floor_square_footage;
		string15	heating;
		string5		src_heating;
		string8		tax_dt_heating;
		string8		living_area_square_footage;
		string5		src_living_area_square_footage;
		string8		tax_dt_living_area_square_footage;
		string8		no_of_baths;
		string5		src_no_of_baths;
		string8		tax_dt_no_of_baths;
		string5		no_of_bedrooms;
		string5		src_no_of_bedrooms;
		string8		tax_dt_no_of_bedrooms;
		string3		no_of_fireplaces;
		string5		src_no_of_fireplaces;
		string8		tax_dt_no_of_fireplaces;
		string3		no_of_full_baths;
		string5		src_no_of_full_baths;
		string8		tax_dt_no_of_full_baths;
		string3		no_of_half_baths;
		string5		src_no_of_half_baths;
		string8		tax_dt_no_of_half_baths;
		string30	no_of_stories;
		string5		src_no_of_stories;
		string8		tax_dt_no_of_stories;
		string15	parking_type;
		string5		src_parking_type;
		string8		tax_dt_parking_type;
		string1		pool_indicator;
		string5		src_pool_indicator;
		string8		tax_dt_pool_indicator;
		string15	pool_type;
		string5		src_pool_type;
		string8		tax_dt_pool_type;
		string15	roof_cover;
		string5		src_roof_cover;
		string8		tax_dt_roof_cover;
		string15	roof_type;
		string5		src_roof_type;
		string8		tax_dt_roof_type;		
		string4		year_built;
		string5		src_year_built;
		string8		tax_dt_year_built;
		string15	foundation;
		string5		src_foundation;
		string8		tax_dt_foundation;
		string8		basement_square_footage;
		string5		src_basement_square_footage;
		string8		tax_dt_basement_square_footage;
		string4		effective_year_built;
		string5		src_effective_year_built;
		string8		tax_dt_effective_year_built;
		string8		garage_square_footage;
		string5		src_garage_square_footage;
		string8		tax_dt_garage_square_footage;
		string15	stories_type;
		string5		src_stories_type;
		string8		tax_dt_stories_type;
		string45	apn_number;
		string5		src_apn_number;
		string8		tax_dt_apn_number;
		string10	census_tract;
		string5		src_census_tract;
		string8		tax_dt_census_tract;
		string25	range;
		string5		src_range;
		string8		tax_dt_range;
		string25	zoning;
		string5		src_zoning;
		string8		tax_dt_zoning;
		string7		block_number;
		string5		src_block_number;
		string8		tax_dt_block_number;
		string30	county_name;
		string5		src_county_name;
		string8		tax_dt_county_name;
		string5		fips_code;
		string5		src_fips_code;
		string8		tax_dt_fips_code;
		string40	subdivision;
		string5		src_subdivision;
		string8		tax_dt_subdivision;
		string30	municipality;
		string5		src_municipality;
		string8		tax_dt_municipality;
		string30	township;
		string5		src_township;
		string8		tax_dt_township;
		string1		homestead_exemption_ind;
		string5		src_homestead_exemption_ind;
		string8		tax_dt_homestead_exemption_ind;
		string4		land_use_code;
		string5		src_land_use_code;
		string8		tax_dt_land_use_code;
		string11	latitude;
		string5		src_latitude;
		string8		tax_dt_latitude;
		string11	longitude;
		string5		src_longitude;
		string8		tax_dt_longitude;
		string5		location_influence_code;
		string5		src_location_influence_code;
		string8		tax_dt_location_influence_code;
		string10	acres;
		string5		src_acres;
		string8		tax_dt_acres;
		string10	lot_depth_footage;
		string5		src_lot_depth_footage;
		string8		tax_dt_lot_depth_footage;
		string10	lot_front_footage;
		string5		src_lot_front_footage;
		string8		tax_dt_lot_front_footage;
		string7		lot_number;
		string5		src_lot_number;
		string8		tax_dt_lot_number;
		string20	lot_size;
		string5		src_lot_size;
		string8		tax_dt_lot_size;
		string3		property_type_code;
		string5		src_property_type_code;
		string8		tax_dt_property_type_code;
		string3		structure_quality;
		string5		src_structure_quality;
		string8		tax_dt_structure_quality;
		string3		water;
		string5		src_water;
		string8		tax_dt_water;
		string3		sewer;
		string5		src_sewer;
		string8		tax_dt_sewer;
		string11	assessed_land_value;
		string5		src_assessed_land_value;
		string8		tax_dt_assessed_land_value;
		string4		assessed_year;
		string5		src_assessed_year;
		string8		tax_dt_assessed_year;
		string13	tax_amount;
		string5		src_tax_amount;
		string8		tax_dt_tax_amount;
		string4		tax_year;
		string5		src_tax_year;
		string11	market_land_value;
		string5		src_market_land_value;
		string8		tax_dt_market_land_value;
		string11	improvement_value;
		string5		src_improvement_value;
		string8		tax_dt_improvement_value;
		udecimal5_2	percent_improved;
		string5		src_percent_improved;
		string8		tax_dt_percent_improved;
		string11	total_assessed_value;
		string5		src_total_assessed_value;
		string8		tax_dt_total_assessed_value;
		string11	total_calculated_value;
		string5		src_total_calculated_value;
		string8		tax_dt_total_calculated_value;
		string11	total_land_value;
		string5		src_total_land_value;
		string8		tax_dt_total_land_value;
		string11	total_market_value;
		string5		src_total_market_value;
		string8		tax_dt_total_market_value;
		string15	floor_type;
		string5		src_floor_type;
		string8		tax_dt_floor_type;
		string15	frame_type;
		string5		src_frame_type;
		string8		tax_dt_frame_type;
		string15	fuel_type;
		string5		src_fuel_type;
		string8		tax_dt_fuel_type;
		string5		no_of_bath_fixtures;
		string5		src_no_of_bath_fixtures;
		string8		tax_dt_no_of_bath_fixtures;
		string5		no_of_rooms;
		string5		src_no_of_rooms;
		string8		tax_dt_no_of_rooms;
		string5		no_of_units;
		string5		src_no_of_units;
		string8		tax_dt_no_of_units;
		string15	style_type;
		string5		src_style_type;
		string8		tax_dt_style_type;
		string20	assessment_document_number;
		string5		src_assessment_document_number;
		string8		tax_dt_assessment_document_number;
		string8		assessment_recording_date;
		string5		src_assessment_recording_date;
		string8		tax_dt_assessment_recording_date;
		string20	deed_document_number;
		string5		src_deed_document_number;
		string8		rec_dt_deed_document_number;
		string8		deed_recording_date;
		string5		src_deed_recording_date;
		string3		full_part_sale;
		string5		src_full_part_sale;
		string8		rec_dt_full_part_sale;
		string11	sale_amount;
		string5		src_sale_amount;
		string8		rec_dt_sale_amount;
		string8		sale_date;
		string5		src_sale_date;
		string8		rec_dt_sale_date;
		string3		sale_type_code;
		string5		src_sale_type_code;
		string8		rec_dt_sale_type_code;
		string40	mortgage_company_name;
		string5		src_mortgage_company_name;
		string8		rec_dt_mortgage_company_name;
		string11	loan_amount;
		string5		src_loan_amount;
		string8		rec_dt_loan_amount;
		string11	second_loan_amount;
		string5		src_second_loan_amount;
		string8		rec_dt_second_loan_amount;
		string5		loan_type_code;
		string5		src_loan_type_code;
		string8		rec_dt_loan_type_code;
		string5		interest_rate_type_code;
		string5		src_interest_rate_type_code;
		string8		rec_dt_interest_rate_type_code;
		string3		category;
		string3		material;
		real8			value;
		string1		quality;
		string1		condition;
		unsigned2	age;
		unsigned8	__internal_fpos__;	
	END;
	// --------------------------------------------------------------------------------------------------------------------

	// --------------------------------------------------------------------------------------------------------------------
	// Maria want's these to be added sometime - but to me (Bruce) looks like a very confusing thing to do.
	// Thinking about it for now ...  Records have NO CONCEPT of any person, so almost all of these really do not apply.
	// Also if in IHDR we have 2 or more people living at the address - which one do we pick to be here as the "person"?
	// add bugnum/custname
	EXPORT AlphaPeoplePII_Fields := RECORD
		unsigned6	property_rid;		// Unique key value
		STRING 		cust_name:='';
		STRING 		bug_num:='';	
		unsigned6	xLexID :=0;			// No person applied
		STRING 		xFName:='';			// No person applied
		STRING 		xMName:='';			// No person applied
		STRING 		xLName:='';			// No person applied
		STRING 		xSuffix:='';		// No person applied	
		STRING 		xDOB:='';			// No person applied
		STRING 		xSSN:='';			// No person applied
		string100	property_street_address;	// relocated 
		string25		v_city_name;					// relocated 
		string2		st;								// relocated 
		string5		zip;								// relocated 
		string4		zip4;								// relocated 
		STRING 		xDLNum:='';			// No person applied
		STRING 		xDLState:='';		// No person applied
		STRING 		xAddrErr:='';		// GIVE CT DATA TEAM SOME INSIGHT INTO BAD ADDRESSES
	END;
	// --------------------------------------------------------------------------------------------------------------------

	// --------------------------------------------------------------------------------------------------------------------
	EXPORT AlphaPropertyCSVRec_MLS := RECORD
		AlphaPeoplePII_Fields OR AlphaPropertyCSVRec_Core;
	END;
	// --------------------------------------------------------------------------------------------------------------------
	
	export Jims_Spreadsheet := RECORD, maxLength(32768)
		string  fname;
		string  mname;
		string  lname;
		string  i_address;
		string  apt;
		string  p_city_name;
		string  st;
		string  zip;
		string  coverage_A :='';
		INTEGER YearBuilt;
  END;
	// --------------------------------------------------------------------------------------------------------------------
	
	
END;	