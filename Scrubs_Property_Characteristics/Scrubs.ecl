IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_LN_PropertyV2_Assessor,Scrubs_Property_Characteristics; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 337;
  EXPORT NumRulesFromFieldType := 337;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 247;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Property_Characteristics)
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 tax_sortby_date_Invalid;
    UNSIGNED1 deed_sortby_date_Invalid;
    UNSIGNED1 fares_unformatted_apn_Invalid;
    UNSIGNED1 property_street_address_Invalid;
    UNSIGNED1 property_city_state_zip_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 building_square_footage_Invalid;
    UNSIGNED1 src_building_square_footage_Invalid;
    UNSIGNED1 tax_dt_building_square_footage_Invalid;
    UNSIGNED1 air_conditioning_type_Invalid;
    UNSIGNED1 src_air_conditioning_type_Invalid;
    UNSIGNED1 tax_dt_air_conditioning_type_Invalid;
    UNSIGNED1 basement_finish_Invalid;
    UNSIGNED1 src_basement_finish_Invalid;
    UNSIGNED1 tax_dt_basement_finish_Invalid;
    UNSIGNED1 construction_type_Invalid;
    UNSIGNED1 src_construction_type_Invalid;
    UNSIGNED1 tax_dt_construction_type_Invalid;
    UNSIGNED1 exterior_wall_Invalid;
    UNSIGNED1 src_exterior_wall_Invalid;
    UNSIGNED1 tax_dt_exterior_wall_Invalid;
    UNSIGNED1 fireplace_ind_Invalid;
    UNSIGNED1 src_fireplace_ind_Invalid;
    UNSIGNED1 tax_dt_fireplace_ind_Invalid;
    UNSIGNED1 fireplace_type_Invalid;
    UNSIGNED1 src_fireplace_type_Invalid;
    UNSIGNED1 tax_dt_fireplace_type_Invalid;
    UNSIGNED1 src_flood_zone_panel_Invalid;
    UNSIGNED1 tax_dt_flood_zone_panel_Invalid;
    UNSIGNED1 garage_Invalid;
    UNSIGNED1 src_garage_Invalid;
    UNSIGNED1 tax_dt_garage_Invalid;
    UNSIGNED1 first_floor_square_footage_Invalid;
    UNSIGNED1 src_first_floor_square_footage_Invalid;
    UNSIGNED1 tax_dt_first_floor_square_footage_Invalid;
    UNSIGNED1 heating_Invalid;
    UNSIGNED1 src_heating_Invalid;
    UNSIGNED1 tax_dt_heating_Invalid;
    UNSIGNED1 living_area_square_footage_Invalid;
    UNSIGNED1 src_living_area_square_footage_Invalid;
    UNSIGNED1 tax_dt_living_area_square_footage_Invalid;
    UNSIGNED1 no_of_baths_Invalid;
    UNSIGNED1 src_no_of_baths_Invalid;
    UNSIGNED1 tax_dt_no_of_baths_Invalid;
    UNSIGNED1 no_of_bedrooms_Invalid;
    UNSIGNED1 src_no_of_bedrooms_Invalid;
    UNSIGNED1 tax_dt_no_of_bedrooms_Invalid;
    UNSIGNED1 no_of_fireplaces_Invalid;
    UNSIGNED1 src_no_of_fireplaces_Invalid;
    UNSIGNED1 tax_dt_no_of_fireplaces_Invalid;
    UNSIGNED1 no_of_full_baths_Invalid;
    UNSIGNED1 src_no_of_full_baths_Invalid;
    UNSIGNED1 tax_dt_no_of_full_baths_Invalid;
    UNSIGNED1 no_of_half_baths_Invalid;
    UNSIGNED1 src_no_of_half_baths_Invalid;
    UNSIGNED1 tax_dt_no_of_half_baths_Invalid;
    UNSIGNED1 no_of_stories_Invalid;
    UNSIGNED1 src_no_of_stories_Invalid;
    UNSIGNED1 tax_dt_no_of_stories_Invalid;
    UNSIGNED1 parking_type_Invalid;
    UNSIGNED1 src_parking_type_Invalid;
    UNSIGNED1 tax_dt_parking_type_Invalid;
    UNSIGNED1 src_pool_indicator_Invalid;
    UNSIGNED1 tax_dt_pool_indicator_Invalid;
    UNSIGNED1 pool_type_Invalid;
    UNSIGNED1 src_pool_type_Invalid;
    UNSIGNED1 tax_dt_pool_type_Invalid;
    UNSIGNED1 roof_cover_Invalid;
    UNSIGNED1 src_roof_cover_Invalid;
    UNSIGNED1 tax_dt_roof_cover_Invalid;
    UNSIGNED1 year_built_Invalid;
    UNSIGNED1 src_year_built_Invalid;
    UNSIGNED1 tax_dt_year_built_Invalid;
    UNSIGNED1 foundation_Invalid;
    UNSIGNED1 src_foundation_Invalid;
    UNSIGNED1 tax_dt_foundation_Invalid;
    UNSIGNED1 basement_square_footage_Invalid;
    UNSIGNED1 src_basement_square_footage_Invalid;
    UNSIGNED1 tax_dt_basement_square_footage_Invalid;
    UNSIGNED1 effective_year_built_Invalid;
    UNSIGNED1 src_effective_year_built_Invalid;
    UNSIGNED1 tax_dt_effective_year_built_Invalid;
    UNSIGNED1 garage_square_footage_Invalid;
    UNSIGNED1 src_garage_square_footage_Invalid;
    UNSIGNED1 tax_dt_garage_square_footage_Invalid;
    UNSIGNED1 stories_type_Invalid;
    UNSIGNED1 src_stories_type_Invalid;
    UNSIGNED1 tax_dt_stories_type_Invalid;
    UNSIGNED1 apn_number_Invalid;
    UNSIGNED1 src_apn_number_Invalid;
    UNSIGNED1 tax_dt_apn_number_Invalid;
    UNSIGNED1 src_census_tract_Invalid;
    UNSIGNED1 tax_dt_census_tract_Invalid;
    UNSIGNED1 src_range_Invalid;
    UNSIGNED1 tax_dt_range_Invalid;
    UNSIGNED1 src_zoning_Invalid;
    UNSIGNED1 tax_dt_zoning_Invalid;
    UNSIGNED1 src_block_number_Invalid;
    UNSIGNED1 tax_dt_block_number_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 src_county_name_Invalid;
    UNSIGNED1 tax_dt_county_name_Invalid;
    UNSIGNED1 fips_code_Invalid;
    UNSIGNED1 src_fips_code_Invalid;
    UNSIGNED1 tax_dt_fips_code_Invalid;
    UNSIGNED1 src_subdivision_Invalid;
    UNSIGNED1 tax_dt_subdivision_Invalid;
    UNSIGNED1 src_municipality_Invalid;
    UNSIGNED1 tax_dt_municipality_Invalid;
    UNSIGNED1 src_township_Invalid;
    UNSIGNED1 tax_dt_township_Invalid;
    UNSIGNED1 src_homestead_exemption_ind_Invalid;
    UNSIGNED1 tax_dt_homestead_exemption_ind_Invalid;
    UNSIGNED1 land_use_code_Invalid;
    UNSIGNED1 src_land_use_code_Invalid;
    UNSIGNED1 tax_dt_land_use_code_Invalid;
    UNSIGNED1 src_latitude_Invalid;
    UNSIGNED1 tax_dt_latitude_Invalid;
    UNSIGNED1 src_longitude_Invalid;
    UNSIGNED1 tax_dt_longitude_Invalid;
    UNSIGNED1 location_influence_code_Invalid;
    UNSIGNED1 src_location_influence_code_Invalid;
    UNSIGNED1 tax_dt_location_influence_code_Invalid;
    UNSIGNED1 src_acres_Invalid;
    UNSIGNED1 tax_dt_acres_Invalid;
    UNSIGNED1 src_lot_depth_footage_Invalid;
    UNSIGNED1 tax_dt_lot_depth_footage_Invalid;
    UNSIGNED1 src_lot_front_footage_Invalid;
    UNSIGNED1 tax_dt_lot_front_footage_Invalid;
    UNSIGNED1 src_lot_number_Invalid;
    UNSIGNED1 tax_dt_lot_number_Invalid;
    UNSIGNED1 src_lot_size_Invalid;
    UNSIGNED1 tax_dt_lot_size_Invalid;
    UNSIGNED1 property_type_code_Invalid;
    UNSIGNED1 src_property_type_code_Invalid;
    UNSIGNED1 tax_dt_property_type_code_Invalid;
    UNSIGNED1 structure_quality_Invalid;
    UNSIGNED1 src_structure_quality_Invalid;
    UNSIGNED1 tax_dt_structure_quality_Invalid;
    UNSIGNED1 water_Invalid;
    UNSIGNED1 src_water_Invalid;
    UNSIGNED1 tax_dt_water_Invalid;
    UNSIGNED1 sewer_Invalid;
    UNSIGNED1 src_sewer_Invalid;
    UNSIGNED1 tax_dt_sewer_Invalid;
    UNSIGNED1 assessed_land_value_Invalid;
    UNSIGNED1 src_assessed_land_value_Invalid;
    UNSIGNED1 tax_dt_assessed_land_value_Invalid;
    UNSIGNED1 assessed_year_Invalid;
    UNSIGNED1 src_assessed_year_Invalid;
    UNSIGNED1 tax_dt_assessed_year_Invalid;
    UNSIGNED1 tax_amount_Invalid;
    UNSIGNED1 src_tax_amount_Invalid;
    UNSIGNED1 tax_dt_tax_amount_Invalid;
    UNSIGNED1 tax_year_Invalid;
    UNSIGNED1 src_tax_year_Invalid;
    UNSIGNED1 market_land_value_Invalid;
    UNSIGNED1 src_market_land_value_Invalid;
    UNSIGNED1 tax_dt_market_land_value_Invalid;
    UNSIGNED1 improvement_value_Invalid;
    UNSIGNED1 src_improvement_value_Invalid;
    UNSIGNED1 tax_dt_improvement_value_Invalid;
    UNSIGNED1 src_percent_improved_Invalid;
    UNSIGNED1 tax_dt_percent_improved_Invalid;
    UNSIGNED1 total_assessed_value_Invalid;
    UNSIGNED1 src_total_assessed_value_Invalid;
    UNSIGNED1 tax_dt_total_assessed_value_Invalid;
    UNSIGNED1 total_calculated_value_Invalid;
    UNSIGNED1 src_total_calculated_value_Invalid;
    UNSIGNED1 tax_dt_total_calculated_value_Invalid;
    UNSIGNED1 total_land_value_Invalid;
    UNSIGNED1 src_total_land_value_Invalid;
    UNSIGNED1 tax_dt_total_land_value_Invalid;
    UNSIGNED1 total_market_value_Invalid;
    UNSIGNED1 src_total_market_value_Invalid;
    UNSIGNED1 tax_dt_total_market_value_Invalid;
    UNSIGNED1 floor_type_Invalid;
    UNSIGNED1 src_floor_type_Invalid;
    UNSIGNED1 tax_dt_floor_type_Invalid;
    UNSIGNED1 frame_type_Invalid;
    UNSIGNED1 src_frame_type_Invalid;
    UNSIGNED1 tax_dt_frame_type_Invalid;
    UNSIGNED1 fuel_type_Invalid;
    UNSIGNED1 src_fuel_type_Invalid;
    UNSIGNED1 tax_dt_fuel_type_Invalid;
    UNSIGNED1 no_of_bath_fixtures_Invalid;
    UNSIGNED1 src_no_of_bath_fixtures_Invalid;
    UNSIGNED1 tax_dt_no_of_bath_fixtures_Invalid;
    UNSIGNED1 no_of_rooms_Invalid;
    UNSIGNED1 src_no_of_rooms_Invalid;
    UNSIGNED1 tax_dt_no_of_rooms_Invalid;
    UNSIGNED1 no_of_units_Invalid;
    UNSIGNED1 src_no_of_units_Invalid;
    UNSIGNED1 tax_dt_no_of_units_Invalid;
    UNSIGNED1 style_type_Invalid;
    UNSIGNED1 src_style_type_Invalid;
    UNSIGNED1 tax_dt_style_type_Invalid;
    UNSIGNED1 assessment_document_number_Invalid;
    UNSIGNED1 src_assessment_document_number_Invalid;
    UNSIGNED1 tax_dt_assessment_document_number_Invalid;
    UNSIGNED1 assessment_recording_date_Invalid;
    UNSIGNED1 src_assessment_recording_date_Invalid;
    UNSIGNED1 tax_dt_assessment_recording_date_Invalid;
    UNSIGNED1 deed_document_number_Invalid;
    UNSIGNED1 src_deed_document_number_Invalid;
    UNSIGNED1 rec_dt_deed_document_number_Invalid;
    UNSIGNED1 deed_recording_date_Invalid;
    UNSIGNED1 src_deed_recording_date_Invalid;
    UNSIGNED1 full_part_sale_Invalid;
    UNSIGNED1 src_full_part_sale_Invalid;
    UNSIGNED1 rec_dt_full_part_sale_Invalid;
    UNSIGNED1 sale_amount_Invalid;
    UNSIGNED1 src_sale_amount_Invalid;
    UNSIGNED1 rec_dt_sale_amount_Invalid;
    UNSIGNED1 sale_date_Invalid;
    UNSIGNED1 src_sale_date_Invalid;
    UNSIGNED1 rec_dt_sale_date_Invalid;
    UNSIGNED1 sale_type_code_Invalid;
    UNSIGNED1 src_sale_type_code_Invalid;
    UNSIGNED1 rec_dt_sale_type_code_Invalid;
    UNSIGNED1 mortgage_company_name_Invalid;
    UNSIGNED1 src_mortgage_company_name_Invalid;
    UNSIGNED1 rec_dt_mortgage_company_name_Invalid;
    UNSIGNED1 loan_amount_Invalid;
    UNSIGNED1 src_loan_amount_Invalid;
    UNSIGNED1 rec_dt_loan_amount_Invalid;
    UNSIGNED1 second_loan_amount_Invalid;
    UNSIGNED1 src_second_loan_amount_Invalid;
    UNSIGNED1 rec_dt_second_loan_amount_Invalid;
    UNSIGNED1 loan_type_code_Invalid;
    UNSIGNED1 src_loan_type_code_Invalid;
    UNSIGNED1 rec_dt_loan_type_code_Invalid;
    UNSIGNED1 interest_rate_type_code_Invalid;
    UNSIGNED1 src_interest_rate_type_code_Invalid;
    UNSIGNED1 rec_dt_interest_rate_type_code_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Property_Characteristics)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Property_Characteristics)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_vendor_first_reported:invalid_date:CUSTOM'
          ,'dt_vendor_last_reported:invalid_date:CUSTOM'
          ,'tax_sortby_date:invalid_date:CUSTOM'
          ,'deed_sortby_date:invalid_date:CUSTOM'
          ,'fares_unformatted_apn:invalid_apn:ALLOW'
          ,'property_street_address:invalid_address:ALLOW'
          ,'property_city_state_zip:invalid_csz:ALLOW'
          ,'prim_range:invalid_address:ALLOW'
          ,'predir:invalid_address:ALLOW'
          ,'prim_name:invalid_address:ALLOW'
          ,'addr_suffix:invalid_address:ALLOW'
          ,'postdir:invalid_address:ALLOW'
          ,'unit_desig:invalid_address:ALLOW'
          ,'sec_range:invalid_address:ALLOW'
          ,'p_city_name:invalid_csz:ALLOW'
          ,'v_city_name:invalid_csz:ALLOW'
          ,'zip:invalid_nums:ALLOW'
          ,'zip4:invalid_nums:ALLOW'
          ,'building_square_footage:invalid_nums:ALLOW'
          ,'src_building_square_footage:invalid_vendor_source:ENUM','src_building_square_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_building_square_footage:invalid_date:CUSTOM'
          ,'air_conditioning_type:invalid_air_conditioning_type_code:CUSTOM'
          ,'src_air_conditioning_type:invalid_vendor_source:ENUM','src_air_conditioning_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_air_conditioning_type:invalid_date:CUSTOM'
          ,'basement_finish:invalid_basement_finish_type_code:CUSTOM'
          ,'src_basement_finish:invalid_vendor_source:ENUM','src_basement_finish:invalid_vendor_source:LENGTHS'
          ,'tax_dt_basement_finish:invalid_date:CUSTOM'
          ,'construction_type:invalid_construction_type_code:CUSTOM'
          ,'src_construction_type:invalid_vendor_source:ENUM','src_construction_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_construction_type:invalid_date:CUSTOM'
          ,'exterior_wall:invalid_exterior_walls_code:CUSTOM'
          ,'src_exterior_wall:invalid_vendor_source:ENUM','src_exterior_wall:invalid_vendor_source:LENGTHS'
          ,'tax_dt_exterior_wall:invalid_date:CUSTOM'
          ,'fireplace_ind:invalid_fireplace_indicator:ENUM'
          ,'src_fireplace_ind:invalid_vendor_source:ENUM','src_fireplace_ind:invalid_vendor_source:LENGTHS'
          ,'tax_dt_fireplace_ind:invalid_date:CUSTOM'
          ,'fireplace_type:invalid_fireplace_type:CUSTOM'
          ,'src_fireplace_type:invalid_vendor_source:ENUM','src_fireplace_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_fireplace_type:invalid_date:CUSTOM'
          ,'src_flood_zone_panel:invalid_vendor_source:ENUM','src_flood_zone_panel:invalid_vendor_source:LENGTHS'
          ,'tax_dt_flood_zone_panel:invalid_date:CUSTOM'
          ,'garage:invalid_garage_type:CUSTOM'
          ,'src_garage:invalid_vendor_source:ENUM','src_garage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_garage:invalid_date:CUSTOM'
          ,'first_floor_square_footage:invalid_nums:ALLOW'
          ,'src_first_floor_square_footage:invalid_vendor_source:ENUM','src_first_floor_square_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_first_floor_square_footage:invalid_date:CUSTOM'
          ,'heating:invalid_heating_type:CUSTOM'
          ,'src_heating:invalid_vendor_source:ENUM','src_heating:invalid_vendor_source:LENGTHS'
          ,'tax_dt_heating:invalid_date:CUSTOM'
          ,'living_area_square_footage:invalid_nums:ALLOW'
          ,'src_living_area_square_footage:invalid_vendor_source:ENUM','src_living_area_square_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_living_area_square_footage:invalid_date:CUSTOM'
          ,'no_of_baths:invalid_nums:ALLOW'
          ,'src_no_of_baths:invalid_vendor_source:ENUM','src_no_of_baths:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_baths:invalid_date:CUSTOM'
          ,'no_of_bedrooms:invalid_nums:ALLOW'
          ,'src_no_of_bedrooms:invalid_vendor_source:ENUM','src_no_of_bedrooms:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_bedrooms:invalid_date:CUSTOM'
          ,'no_of_fireplaces:invalid_nums:ALLOW'
          ,'src_no_of_fireplaces:invalid_vendor_source:ENUM','src_no_of_fireplaces:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_fireplaces:invalid_date:CUSTOM'
          ,'no_of_full_baths:invalid_nums:ALLOW'
          ,'src_no_of_full_baths:invalid_vendor_source:ENUM','src_no_of_full_baths:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_full_baths:invalid_date:CUSTOM'
          ,'no_of_half_baths:invalid_nums:ALLOW'
          ,'src_no_of_half_baths:invalid_vendor_source:ENUM','src_no_of_half_baths:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_half_baths:invalid_date:CUSTOM'
          ,'no_of_stories:invalid_nums:ALLOW'
          ,'src_no_of_stories:invalid_vendor_source:ENUM','src_no_of_stories:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_stories:invalid_date:CUSTOM'
          ,'parking_type:invalid_parking_type:CUSTOM'
          ,'src_parking_type:invalid_vendor_source:ENUM','src_parking_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_parking_type:invalid_date:CUSTOM'
          ,'src_pool_indicator:invalid_vendor_source:ENUM','src_pool_indicator:invalid_vendor_source:LENGTHS'
          ,'tax_dt_pool_indicator:invalid_date:CUSTOM'
          ,'pool_type:invalid_pool_type:CUSTOM'
          ,'src_pool_type:invalid_vendor_source:ENUM','src_pool_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_pool_type:invalid_date:CUSTOM'
          ,'roof_cover:invalid_roof_type:CUSTOM'
          ,'src_roof_cover:invalid_vendor_source:ENUM','src_roof_cover:invalid_vendor_source:LENGTHS'
          ,'tax_dt_roof_cover:invalid_date:CUSTOM'
          ,'year_built:invalid_year:ALLOW','year_built:invalid_year:LENGTHS'
          ,'src_year_built:invalid_vendor_source:ENUM','src_year_built:invalid_vendor_source:LENGTHS'
          ,'tax_dt_year_built:invalid_date:CUSTOM'
          ,'foundation:invalid_foundation_type:CUSTOM'
          ,'src_foundation:invalid_vendor_source:ENUM','src_foundation:invalid_vendor_source:LENGTHS'
          ,'tax_dt_foundation:invalid_date:CUSTOM'
          ,'basement_square_footage:invalid_nums:ALLOW'
          ,'src_basement_square_footage:invalid_vendor_source:ENUM','src_basement_square_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_basement_square_footage:invalid_date:CUSTOM'
          ,'effective_year_built:invalid_year:ALLOW','effective_year_built:invalid_year:LENGTHS'
          ,'src_effective_year_built:invalid_vendor_source:ENUM','src_effective_year_built:invalid_vendor_source:LENGTHS'
          ,'tax_dt_effective_year_built:invalid_date:CUSTOM'
          ,'garage_square_footage:invalid_nums:ALLOW'
          ,'src_garage_square_footage:invalid_vendor_source:ENUM','src_garage_square_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_garage_square_footage:invalid_date:CUSTOM'
          ,'stories_type:invalid_stories_type:CUSTOM'
          ,'src_stories_type:invalid_vendor_source:ENUM','src_stories_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_stories_type:invalid_date:CUSTOM'
          ,'apn_number:invalid_apn:ALLOW'
          ,'src_apn_number:invalid_vendor_source:ENUM','src_apn_number:invalid_vendor_source:LENGTHS'
          ,'tax_dt_apn_number:invalid_date:CUSTOM'
          ,'src_census_tract:invalid_vendor_source:ENUM','src_census_tract:invalid_vendor_source:LENGTHS'
          ,'tax_dt_census_tract:invalid_date:CUSTOM'
          ,'src_range:invalid_vendor_source:ENUM','src_range:invalid_vendor_source:LENGTHS'
          ,'tax_dt_range:invalid_date:CUSTOM'
          ,'src_zoning:invalid_vendor_source:ENUM','src_zoning:invalid_vendor_source:LENGTHS'
          ,'tax_dt_zoning:invalid_date:CUSTOM'
          ,'src_block_number:invalid_vendor_source:ENUM','src_block_number:invalid_vendor_source:LENGTHS'
          ,'tax_dt_block_number:invalid_date:CUSTOM'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'src_county_name:invalid_vendor_source:ENUM','src_county_name:invalid_vendor_source:LENGTHS'
          ,'tax_dt_county_name:invalid_date:CUSTOM'
          ,'fips_code:invalid_fips:ALLOW','fips_code:invalid_fips:LENGTHS','fips_code:invalid_fips:WITHIN_FILE'
          ,'src_fips_code:invalid_vendor_source:ENUM','src_fips_code:invalid_vendor_source:LENGTHS'
          ,'tax_dt_fips_code:invalid_date:CUSTOM'
          ,'src_subdivision:invalid_vendor_source:ENUM','src_subdivision:invalid_vendor_source:LENGTHS'
          ,'tax_dt_subdivision:invalid_date:CUSTOM'
          ,'src_municipality:invalid_vendor_source:ENUM','src_municipality:invalid_vendor_source:LENGTHS'
          ,'tax_dt_municipality:invalid_date:CUSTOM'
          ,'src_township:invalid_vendor_source:ENUM','src_township:invalid_vendor_source:LENGTHS'
          ,'tax_dt_township:invalid_date:CUSTOM'
          ,'src_homestead_exemption_ind:invalid_vendor_source:ENUM','src_homestead_exemption_ind:invalid_vendor_source:LENGTHS'
          ,'tax_dt_homestead_exemption_ind:invalid_date:CUSTOM'
          ,'land_use_code:invalid_land_use:CUSTOM'
          ,'src_land_use_code:invalid_vendor_source:ENUM','src_land_use_code:invalid_vendor_source:LENGTHS'
          ,'tax_dt_land_use_code:invalid_date:CUSTOM'
          ,'src_latitude:invalid_vendor_source:ENUM','src_latitude:invalid_vendor_source:LENGTHS'
          ,'tax_dt_latitude:invalid_date:CUSTOM'
          ,'src_longitude:invalid_vendor_source:ENUM','src_longitude:invalid_vendor_source:LENGTHS'
          ,'tax_dt_longitude:invalid_date:CUSTOM'
          ,'location_influence_code:invalid_location_code:CUSTOM'
          ,'src_location_influence_code:invalid_vendor_source:ENUM','src_location_influence_code:invalid_vendor_source:LENGTHS'
          ,'tax_dt_location_influence_code:invalid_date:CUSTOM'
          ,'src_acres:invalid_vendor_source:ENUM','src_acres:invalid_vendor_source:LENGTHS'
          ,'tax_dt_acres:invalid_date:CUSTOM'
          ,'src_lot_depth_footage:invalid_vendor_source:ENUM','src_lot_depth_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_lot_depth_footage:invalid_date:CUSTOM'
          ,'src_lot_front_footage:invalid_vendor_source:ENUM','src_lot_front_footage:invalid_vendor_source:LENGTHS'
          ,'tax_dt_lot_front_footage:invalid_date:CUSTOM'
          ,'src_lot_number:invalid_vendor_source:ENUM','src_lot_number:invalid_vendor_source:LENGTHS'
          ,'tax_dt_lot_number:invalid_date:CUSTOM'
          ,'src_lot_size:invalid_vendor_source:ENUM','src_lot_size:invalid_vendor_source:LENGTHS'
          ,'tax_dt_lot_size:invalid_date:CUSTOM'
          ,'property_type_code:invalid_property_code:CUSTOM'
          ,'src_property_type_code:invalid_vendor_source:ENUM','src_property_type_code:invalid_vendor_source:LENGTHS'
          ,'tax_dt_property_type_code:invalid_date:CUSTOM'
          ,'structure_quality:invalid_structure_quality_code:CUSTOM'
          ,'src_structure_quality:invalid_vendor_source:ENUM','src_structure_quality:invalid_vendor_source:LENGTHS'
          ,'tax_dt_structure_quality:invalid_date:CUSTOM'
          ,'water:invalid_water_type:CUSTOM'
          ,'src_water:invalid_vendor_source:ENUM','src_water:invalid_vendor_source:LENGTHS'
          ,'tax_dt_water:invalid_date:CUSTOM'
          ,'sewer:invalid_sewer_type:CUSTOM'
          ,'src_sewer:invalid_vendor_source:ENUM','src_sewer:invalid_vendor_source:LENGTHS'
          ,'tax_dt_sewer:invalid_date:CUSTOM'
          ,'assessed_land_value:invalid_tax_amount:ALLOW'
          ,'src_assessed_land_value:invalid_vendor_source:ENUM','src_assessed_land_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_assessed_land_value:invalid_date:CUSTOM'
          ,'assessed_year:invalid_year:ALLOW','assessed_year:invalid_year:LENGTHS'
          ,'src_assessed_year:invalid_vendor_source:ENUM','src_assessed_year:invalid_vendor_source:LENGTHS'
          ,'tax_dt_assessed_year:invalid_date:CUSTOM'
          ,'tax_amount:invalid_tax_amount:ALLOW'
          ,'src_tax_amount:invalid_vendor_source:ENUM','src_tax_amount:invalid_vendor_source:LENGTHS'
          ,'tax_dt_tax_amount:invalid_date:CUSTOM'
          ,'tax_year:invalid_year:ALLOW','tax_year:invalid_year:LENGTHS'
          ,'src_tax_year:invalid_vendor_source:ENUM','src_tax_year:invalid_vendor_source:LENGTHS'
          ,'market_land_value:invalid_tax_amount:ALLOW'
          ,'src_market_land_value:invalid_vendor_source:ENUM','src_market_land_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_market_land_value:invalid_date:CUSTOM'
          ,'improvement_value:invalid_tax_amount:ALLOW'
          ,'src_improvement_value:invalid_vendor_source:ENUM','src_improvement_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_improvement_value:invalid_date:CUSTOM'
          ,'src_percent_improved:invalid_vendor_source:ENUM','src_percent_improved:invalid_vendor_source:LENGTHS'
          ,'tax_dt_percent_improved:invalid_date:CUSTOM'
          ,'total_assessed_value:invalid_tax_amount:ALLOW'
          ,'src_total_assessed_value:invalid_vendor_source:ENUM','src_total_assessed_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_total_assessed_value:invalid_date:CUSTOM'
          ,'total_calculated_value:invalid_tax_amount:ALLOW'
          ,'src_total_calculated_value:invalid_vendor_source:ENUM','src_total_calculated_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_total_calculated_value:invalid_date:CUSTOM'
          ,'total_land_value:invalid_tax_amount:ALLOW'
          ,'src_total_land_value:invalid_vendor_source:ENUM','src_total_land_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_total_land_value:invalid_date:CUSTOM'
          ,'total_market_value:invalid_tax_amount:ALLOW'
          ,'src_total_market_value:invalid_vendor_source:ENUM','src_total_market_value:invalid_vendor_source:LENGTHS'
          ,'tax_dt_total_market_value:invalid_date:CUSTOM'
          ,'floor_type:invalid_floor_cover_code:CUSTOM'
          ,'src_floor_type:invalid_vendor_source:ENUM','src_floor_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_floor_type:invalid_date:CUSTOM'
          ,'frame_type:invalid_frame_code:CUSTOM'
          ,'src_frame_type:invalid_vendor_source:ENUM','src_frame_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_frame_type:invalid_date:CUSTOM'
          ,'fuel_type:invalid_heating_fuel_type:CUSTOM'
          ,'src_fuel_type:invalid_vendor_source:ENUM','src_fuel_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_fuel_type:invalid_date:CUSTOM'
          ,'no_of_bath_fixtures:invalid_nums:ALLOW'
          ,'src_no_of_bath_fixtures:invalid_vendor_source:ENUM','src_no_of_bath_fixtures:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_bath_fixtures:invalid_date:CUSTOM'
          ,'no_of_rooms:invalid_nums:ALLOW'
          ,'src_no_of_rooms:invalid_vendor_source:ENUM','src_no_of_rooms:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_rooms:invalid_date:CUSTOM'
          ,'no_of_units:invalid_nums:ALLOW'
          ,'src_no_of_units:invalid_vendor_source:ENUM','src_no_of_units:invalid_vendor_source:LENGTHS'
          ,'tax_dt_no_of_units:invalid_date:CUSTOM'
          ,'style_type:invalid_style_type:CUSTOM'
          ,'src_style_type:invalid_vendor_source:ENUM','src_style_type:invalid_vendor_source:LENGTHS'
          ,'tax_dt_style_type:invalid_date:CUSTOM'
          ,'assessment_document_number:invalid_document_number:ALLOW'
          ,'src_assessment_document_number:invalid_vendor_source:ENUM','src_assessment_document_number:invalid_vendor_source:LENGTHS'
          ,'tax_dt_assessment_document_number:invalid_date:CUSTOM'
          ,'assessment_recording_date:invalid_date:CUSTOM'
          ,'src_assessment_recording_date:invalid_vendor_source:ENUM','src_assessment_recording_date:invalid_vendor_source:LENGTHS'
          ,'tax_dt_assessment_recording_date:invalid_date:CUSTOM'
          ,'deed_document_number:invalid_document_number:ALLOW'
          ,'src_deed_document_number:invalid_vendor_source:ENUM','src_deed_document_number:invalid_vendor_source:LENGTHS'
          ,'rec_dt_deed_document_number:invalid_date:CUSTOM'
          ,'deed_recording_date:invalid_date:CUSTOM'
          ,'src_deed_recording_date:invalid_vendor_source:ENUM','src_deed_recording_date:invalid_vendor_source:LENGTHS'
          ,'full_part_sale:invalid_sale_code:CUSTOM'
          ,'src_full_part_sale:invalid_vendor_source:ENUM','src_full_part_sale:invalid_vendor_source:LENGTHS'
          ,'rec_dt_full_part_sale:invalid_date:CUSTOM'
          ,'sale_amount:invalid_tax_amount:ALLOW'
          ,'src_sale_amount:invalid_vendor_source:ENUM','src_sale_amount:invalid_vendor_source:LENGTHS'
          ,'rec_dt_sale_amount:invalid_date:CUSTOM'
          ,'sale_date:invalid_date:CUSTOM'
          ,'src_sale_date:invalid_vendor_source:ENUM','src_sale_date:invalid_vendor_source:LENGTHS'
          ,'rec_dt_sale_date:invalid_date:CUSTOM'
          ,'sale_type_code:invalid_sale_tran_code:CUSTOM'
          ,'src_sale_type_code:invalid_vendor_source:ENUM','src_sale_type_code:invalid_vendor_source:LENGTHS'
          ,'rec_dt_sale_type_code:invalid_date:CUSTOM'
          ,'mortgage_company_name:invalid_alpha:ALLOW'
          ,'src_mortgage_company_name:invalid_vendor_source:ENUM','src_mortgage_company_name:invalid_vendor_source:LENGTHS'
          ,'rec_dt_mortgage_company_name:invalid_date:CUSTOM'
          ,'loan_amount:invalid_tax_amount:ALLOW'
          ,'src_loan_amount:invalid_vendor_source:ENUM','src_loan_amount:invalid_vendor_source:LENGTHS'
          ,'rec_dt_loan_amount:invalid_date:CUSTOM'
          ,'second_loan_amount:invalid_tax_amount:ALLOW'
          ,'src_second_loan_amount:invalid_vendor_source:ENUM','src_second_loan_amount:invalid_vendor_source:LENGTHS'
          ,'rec_dt_second_loan_amount:invalid_date:CUSTOM'
          ,'loan_type_code:invalid_mortgage_loan_type_code:CUSTOM'
          ,'src_loan_type_code:invalid_vendor_source:ENUM','src_loan_type_code:invalid_vendor_source:LENGTHS'
          ,'rec_dt_loan_type_code:invalid_date:CUSTOM'
          ,'interest_rate_type_code:invalid_financing_type_code:CUSTOM'
          ,'src_interest_rate_type_code:invalid_vendor_source:ENUM','src_interest_rate_type_code:invalid_vendor_source:LENGTHS'
          ,'rec_dt_interest_rate_type_code:invalid_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Fields.InvalidMessage_tax_sortby_date(1)
          ,Fields.InvalidMessage_deed_sortby_date(1)
          ,Fields.InvalidMessage_fares_unformatted_apn(1)
          ,Fields.InvalidMessage_property_street_address(1)
          ,Fields.InvalidMessage_property_city_state_zip(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_building_square_footage(1)
          ,Fields.InvalidMessage_src_building_square_footage(1),Fields.InvalidMessage_src_building_square_footage(2)
          ,Fields.InvalidMessage_tax_dt_building_square_footage(1)
          ,Fields.InvalidMessage_air_conditioning_type(1)
          ,Fields.InvalidMessage_src_air_conditioning_type(1),Fields.InvalidMessage_src_air_conditioning_type(2)
          ,Fields.InvalidMessage_tax_dt_air_conditioning_type(1)
          ,Fields.InvalidMessage_basement_finish(1)
          ,Fields.InvalidMessage_src_basement_finish(1),Fields.InvalidMessage_src_basement_finish(2)
          ,Fields.InvalidMessage_tax_dt_basement_finish(1)
          ,Fields.InvalidMessage_construction_type(1)
          ,Fields.InvalidMessage_src_construction_type(1),Fields.InvalidMessage_src_construction_type(2)
          ,Fields.InvalidMessage_tax_dt_construction_type(1)
          ,Fields.InvalidMessage_exterior_wall(1)
          ,Fields.InvalidMessage_src_exterior_wall(1),Fields.InvalidMessage_src_exterior_wall(2)
          ,Fields.InvalidMessage_tax_dt_exterior_wall(1)
          ,Fields.InvalidMessage_fireplace_ind(1)
          ,Fields.InvalidMessage_src_fireplace_ind(1),Fields.InvalidMessage_src_fireplace_ind(2)
          ,Fields.InvalidMessage_tax_dt_fireplace_ind(1)
          ,Fields.InvalidMessage_fireplace_type(1)
          ,Fields.InvalidMessage_src_fireplace_type(1),Fields.InvalidMessage_src_fireplace_type(2)
          ,Fields.InvalidMessage_tax_dt_fireplace_type(1)
          ,Fields.InvalidMessage_src_flood_zone_panel(1),Fields.InvalidMessage_src_flood_zone_panel(2)
          ,Fields.InvalidMessage_tax_dt_flood_zone_panel(1)
          ,Fields.InvalidMessage_garage(1)
          ,Fields.InvalidMessage_src_garage(1),Fields.InvalidMessage_src_garage(2)
          ,Fields.InvalidMessage_tax_dt_garage(1)
          ,Fields.InvalidMessage_first_floor_square_footage(1)
          ,Fields.InvalidMessage_src_first_floor_square_footage(1),Fields.InvalidMessage_src_first_floor_square_footage(2)
          ,Fields.InvalidMessage_tax_dt_first_floor_square_footage(1)
          ,Fields.InvalidMessage_heating(1)
          ,Fields.InvalidMessage_src_heating(1),Fields.InvalidMessage_src_heating(2)
          ,Fields.InvalidMessage_tax_dt_heating(1)
          ,Fields.InvalidMessage_living_area_square_footage(1)
          ,Fields.InvalidMessage_src_living_area_square_footage(1),Fields.InvalidMessage_src_living_area_square_footage(2)
          ,Fields.InvalidMessage_tax_dt_living_area_square_footage(1)
          ,Fields.InvalidMessage_no_of_baths(1)
          ,Fields.InvalidMessage_src_no_of_baths(1),Fields.InvalidMessage_src_no_of_baths(2)
          ,Fields.InvalidMessage_tax_dt_no_of_baths(1)
          ,Fields.InvalidMessage_no_of_bedrooms(1)
          ,Fields.InvalidMessage_src_no_of_bedrooms(1),Fields.InvalidMessage_src_no_of_bedrooms(2)
          ,Fields.InvalidMessage_tax_dt_no_of_bedrooms(1)
          ,Fields.InvalidMessage_no_of_fireplaces(1)
          ,Fields.InvalidMessage_src_no_of_fireplaces(1),Fields.InvalidMessage_src_no_of_fireplaces(2)
          ,Fields.InvalidMessage_tax_dt_no_of_fireplaces(1)
          ,Fields.InvalidMessage_no_of_full_baths(1)
          ,Fields.InvalidMessage_src_no_of_full_baths(1),Fields.InvalidMessage_src_no_of_full_baths(2)
          ,Fields.InvalidMessage_tax_dt_no_of_full_baths(1)
          ,Fields.InvalidMessage_no_of_half_baths(1)
          ,Fields.InvalidMessage_src_no_of_half_baths(1),Fields.InvalidMessage_src_no_of_half_baths(2)
          ,Fields.InvalidMessage_tax_dt_no_of_half_baths(1)
          ,Fields.InvalidMessage_no_of_stories(1)
          ,Fields.InvalidMessage_src_no_of_stories(1),Fields.InvalidMessage_src_no_of_stories(2)
          ,Fields.InvalidMessage_tax_dt_no_of_stories(1)
          ,Fields.InvalidMessage_parking_type(1)
          ,Fields.InvalidMessage_src_parking_type(1),Fields.InvalidMessage_src_parking_type(2)
          ,Fields.InvalidMessage_tax_dt_parking_type(1)
          ,Fields.InvalidMessage_src_pool_indicator(1),Fields.InvalidMessage_src_pool_indicator(2)
          ,Fields.InvalidMessage_tax_dt_pool_indicator(1)
          ,Fields.InvalidMessage_pool_type(1)
          ,Fields.InvalidMessage_src_pool_type(1),Fields.InvalidMessage_src_pool_type(2)
          ,Fields.InvalidMessage_tax_dt_pool_type(1)
          ,Fields.InvalidMessage_roof_cover(1)
          ,Fields.InvalidMessage_src_roof_cover(1),Fields.InvalidMessage_src_roof_cover(2)
          ,Fields.InvalidMessage_tax_dt_roof_cover(1)
          ,Fields.InvalidMessage_year_built(1),Fields.InvalidMessage_year_built(2)
          ,Fields.InvalidMessage_src_year_built(1),Fields.InvalidMessage_src_year_built(2)
          ,Fields.InvalidMessage_tax_dt_year_built(1)
          ,Fields.InvalidMessage_foundation(1)
          ,Fields.InvalidMessage_src_foundation(1),Fields.InvalidMessage_src_foundation(2)
          ,Fields.InvalidMessage_tax_dt_foundation(1)
          ,Fields.InvalidMessage_basement_square_footage(1)
          ,Fields.InvalidMessage_src_basement_square_footage(1),Fields.InvalidMessage_src_basement_square_footage(2)
          ,Fields.InvalidMessage_tax_dt_basement_square_footage(1)
          ,Fields.InvalidMessage_effective_year_built(1),Fields.InvalidMessage_effective_year_built(2)
          ,Fields.InvalidMessage_src_effective_year_built(1),Fields.InvalidMessage_src_effective_year_built(2)
          ,Fields.InvalidMessage_tax_dt_effective_year_built(1)
          ,Fields.InvalidMessage_garage_square_footage(1)
          ,Fields.InvalidMessage_src_garage_square_footage(1),Fields.InvalidMessage_src_garage_square_footage(2)
          ,Fields.InvalidMessage_tax_dt_garage_square_footage(1)
          ,Fields.InvalidMessage_stories_type(1)
          ,Fields.InvalidMessage_src_stories_type(1),Fields.InvalidMessage_src_stories_type(2)
          ,Fields.InvalidMessage_tax_dt_stories_type(1)
          ,Fields.InvalidMessage_apn_number(1)
          ,Fields.InvalidMessage_src_apn_number(1),Fields.InvalidMessage_src_apn_number(2)
          ,Fields.InvalidMessage_tax_dt_apn_number(1)
          ,Fields.InvalidMessage_src_census_tract(1),Fields.InvalidMessage_src_census_tract(2)
          ,Fields.InvalidMessage_tax_dt_census_tract(1)
          ,Fields.InvalidMessage_src_range(1),Fields.InvalidMessage_src_range(2)
          ,Fields.InvalidMessage_tax_dt_range(1)
          ,Fields.InvalidMessage_src_zoning(1),Fields.InvalidMessage_src_zoning(2)
          ,Fields.InvalidMessage_tax_dt_zoning(1)
          ,Fields.InvalidMessage_src_block_number(1),Fields.InvalidMessage_src_block_number(2)
          ,Fields.InvalidMessage_tax_dt_block_number(1)
          ,Fields.InvalidMessage_county_name(1),Fields.InvalidMessage_county_name(2)
          ,Fields.InvalidMessage_src_county_name(1),Fields.InvalidMessage_src_county_name(2)
          ,Fields.InvalidMessage_tax_dt_county_name(1)
          ,Fields.InvalidMessage_fips_code(1),Fields.InvalidMessage_fips_code(2),Fields.InvalidMessage_fips_code(3)
          ,Fields.InvalidMessage_src_fips_code(1),Fields.InvalidMessage_src_fips_code(2)
          ,Fields.InvalidMessage_tax_dt_fips_code(1)
          ,Fields.InvalidMessage_src_subdivision(1),Fields.InvalidMessage_src_subdivision(2)
          ,Fields.InvalidMessage_tax_dt_subdivision(1)
          ,Fields.InvalidMessage_src_municipality(1),Fields.InvalidMessage_src_municipality(2)
          ,Fields.InvalidMessage_tax_dt_municipality(1)
          ,Fields.InvalidMessage_src_township(1),Fields.InvalidMessage_src_township(2)
          ,Fields.InvalidMessage_tax_dt_township(1)
          ,Fields.InvalidMessage_src_homestead_exemption_ind(1),Fields.InvalidMessage_src_homestead_exemption_ind(2)
          ,Fields.InvalidMessage_tax_dt_homestead_exemption_ind(1)
          ,Fields.InvalidMessage_land_use_code(1)
          ,Fields.InvalidMessage_src_land_use_code(1),Fields.InvalidMessage_src_land_use_code(2)
          ,Fields.InvalidMessage_tax_dt_land_use_code(1)
          ,Fields.InvalidMessage_src_latitude(1),Fields.InvalidMessage_src_latitude(2)
          ,Fields.InvalidMessage_tax_dt_latitude(1)
          ,Fields.InvalidMessage_src_longitude(1),Fields.InvalidMessage_src_longitude(2)
          ,Fields.InvalidMessage_tax_dt_longitude(1)
          ,Fields.InvalidMessage_location_influence_code(1)
          ,Fields.InvalidMessage_src_location_influence_code(1),Fields.InvalidMessage_src_location_influence_code(2)
          ,Fields.InvalidMessage_tax_dt_location_influence_code(1)
          ,Fields.InvalidMessage_src_acres(1),Fields.InvalidMessage_src_acres(2)
          ,Fields.InvalidMessage_tax_dt_acres(1)
          ,Fields.InvalidMessage_src_lot_depth_footage(1),Fields.InvalidMessage_src_lot_depth_footage(2)
          ,Fields.InvalidMessage_tax_dt_lot_depth_footage(1)
          ,Fields.InvalidMessage_src_lot_front_footage(1),Fields.InvalidMessage_src_lot_front_footage(2)
          ,Fields.InvalidMessage_tax_dt_lot_front_footage(1)
          ,Fields.InvalidMessage_src_lot_number(1),Fields.InvalidMessage_src_lot_number(2)
          ,Fields.InvalidMessage_tax_dt_lot_number(1)
          ,Fields.InvalidMessage_src_lot_size(1),Fields.InvalidMessage_src_lot_size(2)
          ,Fields.InvalidMessage_tax_dt_lot_size(1)
          ,Fields.InvalidMessage_property_type_code(1)
          ,Fields.InvalidMessage_src_property_type_code(1),Fields.InvalidMessage_src_property_type_code(2)
          ,Fields.InvalidMessage_tax_dt_property_type_code(1)
          ,Fields.InvalidMessage_structure_quality(1)
          ,Fields.InvalidMessage_src_structure_quality(1),Fields.InvalidMessage_src_structure_quality(2)
          ,Fields.InvalidMessage_tax_dt_structure_quality(1)
          ,Fields.InvalidMessage_water(1)
          ,Fields.InvalidMessage_src_water(1),Fields.InvalidMessage_src_water(2)
          ,Fields.InvalidMessage_tax_dt_water(1)
          ,Fields.InvalidMessage_sewer(1)
          ,Fields.InvalidMessage_src_sewer(1),Fields.InvalidMessage_src_sewer(2)
          ,Fields.InvalidMessage_tax_dt_sewer(1)
          ,Fields.InvalidMessage_assessed_land_value(1)
          ,Fields.InvalidMessage_src_assessed_land_value(1),Fields.InvalidMessage_src_assessed_land_value(2)
          ,Fields.InvalidMessage_tax_dt_assessed_land_value(1)
          ,Fields.InvalidMessage_assessed_year(1),Fields.InvalidMessage_assessed_year(2)
          ,Fields.InvalidMessage_src_assessed_year(1),Fields.InvalidMessage_src_assessed_year(2)
          ,Fields.InvalidMessage_tax_dt_assessed_year(1)
          ,Fields.InvalidMessage_tax_amount(1)
          ,Fields.InvalidMessage_src_tax_amount(1),Fields.InvalidMessage_src_tax_amount(2)
          ,Fields.InvalidMessage_tax_dt_tax_amount(1)
          ,Fields.InvalidMessage_tax_year(1),Fields.InvalidMessage_tax_year(2)
          ,Fields.InvalidMessage_src_tax_year(1),Fields.InvalidMessage_src_tax_year(2)
          ,Fields.InvalidMessage_market_land_value(1)
          ,Fields.InvalidMessage_src_market_land_value(1),Fields.InvalidMessage_src_market_land_value(2)
          ,Fields.InvalidMessage_tax_dt_market_land_value(1)
          ,Fields.InvalidMessage_improvement_value(1)
          ,Fields.InvalidMessage_src_improvement_value(1),Fields.InvalidMessage_src_improvement_value(2)
          ,Fields.InvalidMessage_tax_dt_improvement_value(1)
          ,Fields.InvalidMessage_src_percent_improved(1),Fields.InvalidMessage_src_percent_improved(2)
          ,Fields.InvalidMessage_tax_dt_percent_improved(1)
          ,Fields.InvalidMessage_total_assessed_value(1)
          ,Fields.InvalidMessage_src_total_assessed_value(1),Fields.InvalidMessage_src_total_assessed_value(2)
          ,Fields.InvalidMessage_tax_dt_total_assessed_value(1)
          ,Fields.InvalidMessage_total_calculated_value(1)
          ,Fields.InvalidMessage_src_total_calculated_value(1),Fields.InvalidMessage_src_total_calculated_value(2)
          ,Fields.InvalidMessage_tax_dt_total_calculated_value(1)
          ,Fields.InvalidMessage_total_land_value(1)
          ,Fields.InvalidMessage_src_total_land_value(1),Fields.InvalidMessage_src_total_land_value(2)
          ,Fields.InvalidMessage_tax_dt_total_land_value(1)
          ,Fields.InvalidMessage_total_market_value(1)
          ,Fields.InvalidMessage_src_total_market_value(1),Fields.InvalidMessage_src_total_market_value(2)
          ,Fields.InvalidMessage_tax_dt_total_market_value(1)
          ,Fields.InvalidMessage_floor_type(1)
          ,Fields.InvalidMessage_src_floor_type(1),Fields.InvalidMessage_src_floor_type(2)
          ,Fields.InvalidMessage_tax_dt_floor_type(1)
          ,Fields.InvalidMessage_frame_type(1)
          ,Fields.InvalidMessage_src_frame_type(1),Fields.InvalidMessage_src_frame_type(2)
          ,Fields.InvalidMessage_tax_dt_frame_type(1)
          ,Fields.InvalidMessage_fuel_type(1)
          ,Fields.InvalidMessage_src_fuel_type(1),Fields.InvalidMessage_src_fuel_type(2)
          ,Fields.InvalidMessage_tax_dt_fuel_type(1)
          ,Fields.InvalidMessage_no_of_bath_fixtures(1)
          ,Fields.InvalidMessage_src_no_of_bath_fixtures(1),Fields.InvalidMessage_src_no_of_bath_fixtures(2)
          ,Fields.InvalidMessage_tax_dt_no_of_bath_fixtures(1)
          ,Fields.InvalidMessage_no_of_rooms(1)
          ,Fields.InvalidMessage_src_no_of_rooms(1),Fields.InvalidMessage_src_no_of_rooms(2)
          ,Fields.InvalidMessage_tax_dt_no_of_rooms(1)
          ,Fields.InvalidMessage_no_of_units(1)
          ,Fields.InvalidMessage_src_no_of_units(1),Fields.InvalidMessage_src_no_of_units(2)
          ,Fields.InvalidMessage_tax_dt_no_of_units(1)
          ,Fields.InvalidMessage_style_type(1)
          ,Fields.InvalidMessage_src_style_type(1),Fields.InvalidMessage_src_style_type(2)
          ,Fields.InvalidMessage_tax_dt_style_type(1)
          ,Fields.InvalidMessage_assessment_document_number(1)
          ,Fields.InvalidMessage_src_assessment_document_number(1),Fields.InvalidMessage_src_assessment_document_number(2)
          ,Fields.InvalidMessage_tax_dt_assessment_document_number(1)
          ,Fields.InvalidMessage_assessment_recording_date(1)
          ,Fields.InvalidMessage_src_assessment_recording_date(1),Fields.InvalidMessage_src_assessment_recording_date(2)
          ,Fields.InvalidMessage_tax_dt_assessment_recording_date(1)
          ,Fields.InvalidMessage_deed_document_number(1)
          ,Fields.InvalidMessage_src_deed_document_number(1),Fields.InvalidMessage_src_deed_document_number(2)
          ,Fields.InvalidMessage_rec_dt_deed_document_number(1)
          ,Fields.InvalidMessage_deed_recording_date(1)
          ,Fields.InvalidMessage_src_deed_recording_date(1),Fields.InvalidMessage_src_deed_recording_date(2)
          ,Fields.InvalidMessage_full_part_sale(1)
          ,Fields.InvalidMessage_src_full_part_sale(1),Fields.InvalidMessage_src_full_part_sale(2)
          ,Fields.InvalidMessage_rec_dt_full_part_sale(1)
          ,Fields.InvalidMessage_sale_amount(1)
          ,Fields.InvalidMessage_src_sale_amount(1),Fields.InvalidMessage_src_sale_amount(2)
          ,Fields.InvalidMessage_rec_dt_sale_amount(1)
          ,Fields.InvalidMessage_sale_date(1)
          ,Fields.InvalidMessage_src_sale_date(1),Fields.InvalidMessage_src_sale_date(2)
          ,Fields.InvalidMessage_rec_dt_sale_date(1)
          ,Fields.InvalidMessage_sale_type_code(1)
          ,Fields.InvalidMessage_src_sale_type_code(1),Fields.InvalidMessage_src_sale_type_code(2)
          ,Fields.InvalidMessage_rec_dt_sale_type_code(1)
          ,Fields.InvalidMessage_mortgage_company_name(1)
          ,Fields.InvalidMessage_src_mortgage_company_name(1),Fields.InvalidMessage_src_mortgage_company_name(2)
          ,Fields.InvalidMessage_rec_dt_mortgage_company_name(1)
          ,Fields.InvalidMessage_loan_amount(1)
          ,Fields.InvalidMessage_src_loan_amount(1),Fields.InvalidMessage_src_loan_amount(2)
          ,Fields.InvalidMessage_rec_dt_loan_amount(1)
          ,Fields.InvalidMessage_second_loan_amount(1)
          ,Fields.InvalidMessage_src_second_loan_amount(1),Fields.InvalidMessage_src_second_loan_amount(2)
          ,Fields.InvalidMessage_rec_dt_second_loan_amount(1)
          ,Fields.InvalidMessage_loan_type_code(1)
          ,Fields.InvalidMessage_src_loan_type_code(1),Fields.InvalidMessage_src_loan_type_code(2)
          ,Fields.InvalidMessage_rec_dt_loan_type_code(1)
          ,Fields.InvalidMessage_interest_rate_type_code(1)
          ,Fields.InvalidMessage_src_interest_rate_type_code(1),Fields.InvalidMessage_src_interest_rate_type_code(2)
          ,Fields.InvalidMessage_rec_dt_interest_rate_type_code(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Property_Characteristics) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.tax_sortby_date_Invalid := Fields.InValid_tax_sortby_date((SALT311.StrType)le.tax_sortby_date);
    SELF.deed_sortby_date_Invalid := Fields.InValid_deed_sortby_date((SALT311.StrType)le.deed_sortby_date);
    SELF.fares_unformatted_apn_Invalid := Fields.InValid_fares_unformatted_apn((SALT311.StrType)le.fares_unformatted_apn);
    SELF.property_street_address_Invalid := Fields.InValid_property_street_address((SALT311.StrType)le.property_street_address);
    SELF.property_city_state_zip_Invalid := Fields.InValid_property_city_state_zip((SALT311.StrType)le.property_city_state_zip);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.building_square_footage_Invalid := Fields.InValid_building_square_footage((SALT311.StrType)le.building_square_footage);
    SELF.src_building_square_footage_Invalid := Fields.InValid_src_building_square_footage((SALT311.StrType)le.src_building_square_footage);
    SELF.tax_dt_building_square_footage_Invalid := Fields.InValid_tax_dt_building_square_footage((SALT311.StrType)le.tax_dt_building_square_footage);
    SELF.air_conditioning_type_Invalid := Fields.InValid_air_conditioning_type((SALT311.StrType)le.air_conditioning_type);
    SELF.src_air_conditioning_type_Invalid := Fields.InValid_src_air_conditioning_type((SALT311.StrType)le.src_air_conditioning_type);
    SELF.tax_dt_air_conditioning_type_Invalid := Fields.InValid_tax_dt_air_conditioning_type((SALT311.StrType)le.tax_dt_air_conditioning_type);
    SELF.basement_finish_Invalid := Fields.InValid_basement_finish((SALT311.StrType)le.basement_finish);
    SELF.src_basement_finish_Invalid := Fields.InValid_src_basement_finish((SALT311.StrType)le.src_basement_finish);
    SELF.tax_dt_basement_finish_Invalid := Fields.InValid_tax_dt_basement_finish((SALT311.StrType)le.tax_dt_basement_finish);
    SELF.construction_type_Invalid := Fields.InValid_construction_type((SALT311.StrType)le.construction_type);
    SELF.src_construction_type_Invalid := Fields.InValid_src_construction_type((SALT311.StrType)le.src_construction_type);
    SELF.tax_dt_construction_type_Invalid := Fields.InValid_tax_dt_construction_type((SALT311.StrType)le.tax_dt_construction_type);
    SELF.exterior_wall_Invalid := Fields.InValid_exterior_wall((SALT311.StrType)le.exterior_wall);
    SELF.src_exterior_wall_Invalid := Fields.InValid_src_exterior_wall((SALT311.StrType)le.src_exterior_wall);
    SELF.tax_dt_exterior_wall_Invalid := Fields.InValid_tax_dt_exterior_wall((SALT311.StrType)le.tax_dt_exterior_wall);
    SELF.fireplace_ind_Invalid := Fields.InValid_fireplace_ind((SALT311.StrType)le.fireplace_ind);
    SELF.src_fireplace_ind_Invalid := Fields.InValid_src_fireplace_ind((SALT311.StrType)le.src_fireplace_ind);
    SELF.tax_dt_fireplace_ind_Invalid := Fields.InValid_tax_dt_fireplace_ind((SALT311.StrType)le.tax_dt_fireplace_ind);
    SELF.fireplace_type_Invalid := Fields.InValid_fireplace_type((SALT311.StrType)le.fireplace_type);
    SELF.src_fireplace_type_Invalid := Fields.InValid_src_fireplace_type((SALT311.StrType)le.src_fireplace_type);
    SELF.tax_dt_fireplace_type_Invalid := Fields.InValid_tax_dt_fireplace_type((SALT311.StrType)le.tax_dt_fireplace_type);
    SELF.src_flood_zone_panel_Invalid := Fields.InValid_src_flood_zone_panel((SALT311.StrType)le.src_flood_zone_panel);
    SELF.tax_dt_flood_zone_panel_Invalid := Fields.InValid_tax_dt_flood_zone_panel((SALT311.StrType)le.tax_dt_flood_zone_panel);
    SELF.garage_Invalid := Fields.InValid_garage((SALT311.StrType)le.garage);
    SELF.src_garage_Invalid := Fields.InValid_src_garage((SALT311.StrType)le.src_garage);
    SELF.tax_dt_garage_Invalid := Fields.InValid_tax_dt_garage((SALT311.StrType)le.tax_dt_garage);
    SELF.first_floor_square_footage_Invalid := Fields.InValid_first_floor_square_footage((SALT311.StrType)le.first_floor_square_footage);
    SELF.src_first_floor_square_footage_Invalid := Fields.InValid_src_first_floor_square_footage((SALT311.StrType)le.src_first_floor_square_footage);
    SELF.tax_dt_first_floor_square_footage_Invalid := Fields.InValid_tax_dt_first_floor_square_footage((SALT311.StrType)le.tax_dt_first_floor_square_footage);
    SELF.heating_Invalid := Fields.InValid_heating((SALT311.StrType)le.heating);
    SELF.src_heating_Invalid := Fields.InValid_src_heating((SALT311.StrType)le.src_heating);
    SELF.tax_dt_heating_Invalid := Fields.InValid_tax_dt_heating((SALT311.StrType)le.tax_dt_heating);
    SELF.living_area_square_footage_Invalid := Fields.InValid_living_area_square_footage((SALT311.StrType)le.living_area_square_footage);
    SELF.src_living_area_square_footage_Invalid := Fields.InValid_src_living_area_square_footage((SALT311.StrType)le.src_living_area_square_footage);
    SELF.tax_dt_living_area_square_footage_Invalid := Fields.InValid_tax_dt_living_area_square_footage((SALT311.StrType)le.tax_dt_living_area_square_footage);
    SELF.no_of_baths_Invalid := Fields.InValid_no_of_baths((SALT311.StrType)le.no_of_baths);
    SELF.src_no_of_baths_Invalid := Fields.InValid_src_no_of_baths((SALT311.StrType)le.src_no_of_baths);
    SELF.tax_dt_no_of_baths_Invalid := Fields.InValid_tax_dt_no_of_baths((SALT311.StrType)le.tax_dt_no_of_baths);
    SELF.no_of_bedrooms_Invalid := Fields.InValid_no_of_bedrooms((SALT311.StrType)le.no_of_bedrooms);
    SELF.src_no_of_bedrooms_Invalid := Fields.InValid_src_no_of_bedrooms((SALT311.StrType)le.src_no_of_bedrooms);
    SELF.tax_dt_no_of_bedrooms_Invalid := Fields.InValid_tax_dt_no_of_bedrooms((SALT311.StrType)le.tax_dt_no_of_bedrooms);
    SELF.no_of_fireplaces_Invalid := Fields.InValid_no_of_fireplaces((SALT311.StrType)le.no_of_fireplaces);
    SELF.src_no_of_fireplaces_Invalid := Fields.InValid_src_no_of_fireplaces((SALT311.StrType)le.src_no_of_fireplaces);
    SELF.tax_dt_no_of_fireplaces_Invalid := Fields.InValid_tax_dt_no_of_fireplaces((SALT311.StrType)le.tax_dt_no_of_fireplaces);
    SELF.no_of_full_baths_Invalid := Fields.InValid_no_of_full_baths((SALT311.StrType)le.no_of_full_baths);
    SELF.src_no_of_full_baths_Invalid := Fields.InValid_src_no_of_full_baths((SALT311.StrType)le.src_no_of_full_baths);
    SELF.tax_dt_no_of_full_baths_Invalid := Fields.InValid_tax_dt_no_of_full_baths((SALT311.StrType)le.tax_dt_no_of_full_baths);
    SELF.no_of_half_baths_Invalid := Fields.InValid_no_of_half_baths((SALT311.StrType)le.no_of_half_baths);
    SELF.src_no_of_half_baths_Invalid := Fields.InValid_src_no_of_half_baths((SALT311.StrType)le.src_no_of_half_baths);
    SELF.tax_dt_no_of_half_baths_Invalid := Fields.InValid_tax_dt_no_of_half_baths((SALT311.StrType)le.tax_dt_no_of_half_baths);
    SELF.no_of_stories_Invalid := Fields.InValid_no_of_stories((SALT311.StrType)le.no_of_stories);
    SELF.src_no_of_stories_Invalid := Fields.InValid_src_no_of_stories((SALT311.StrType)le.src_no_of_stories);
    SELF.tax_dt_no_of_stories_Invalid := Fields.InValid_tax_dt_no_of_stories((SALT311.StrType)le.tax_dt_no_of_stories);
    SELF.parking_type_Invalid := Fields.InValid_parking_type((SALT311.StrType)le.parking_type);
    SELF.src_parking_type_Invalid := Fields.InValid_src_parking_type((SALT311.StrType)le.src_parking_type);
    SELF.tax_dt_parking_type_Invalid := Fields.InValid_tax_dt_parking_type((SALT311.StrType)le.tax_dt_parking_type);
    SELF.src_pool_indicator_Invalid := Fields.InValid_src_pool_indicator((SALT311.StrType)le.src_pool_indicator);
    SELF.tax_dt_pool_indicator_Invalid := Fields.InValid_tax_dt_pool_indicator((SALT311.StrType)le.tax_dt_pool_indicator);
    SELF.pool_type_Invalid := Fields.InValid_pool_type((SALT311.StrType)le.pool_type);
    SELF.src_pool_type_Invalid := Fields.InValid_src_pool_type((SALT311.StrType)le.src_pool_type);
    SELF.tax_dt_pool_type_Invalid := Fields.InValid_tax_dt_pool_type((SALT311.StrType)le.tax_dt_pool_type);
    SELF.roof_cover_Invalid := Fields.InValid_roof_cover((SALT311.StrType)le.roof_cover);
    SELF.src_roof_cover_Invalid := Fields.InValid_src_roof_cover((SALT311.StrType)le.src_roof_cover);
    SELF.tax_dt_roof_cover_Invalid := Fields.InValid_tax_dt_roof_cover((SALT311.StrType)le.tax_dt_roof_cover);
    SELF.year_built_Invalid := Fields.InValid_year_built((SALT311.StrType)le.year_built);
    SELF.src_year_built_Invalid := Fields.InValid_src_year_built((SALT311.StrType)le.src_year_built);
    SELF.tax_dt_year_built_Invalid := Fields.InValid_tax_dt_year_built((SALT311.StrType)le.tax_dt_year_built);
    SELF.foundation_Invalid := Fields.InValid_foundation((SALT311.StrType)le.foundation);
    SELF.src_foundation_Invalid := Fields.InValid_src_foundation((SALT311.StrType)le.src_foundation);
    SELF.tax_dt_foundation_Invalid := Fields.InValid_tax_dt_foundation((SALT311.StrType)le.tax_dt_foundation);
    SELF.basement_square_footage_Invalid := Fields.InValid_basement_square_footage((SALT311.StrType)le.basement_square_footage);
    SELF.src_basement_square_footage_Invalid := Fields.InValid_src_basement_square_footage((SALT311.StrType)le.src_basement_square_footage);
    SELF.tax_dt_basement_square_footage_Invalid := Fields.InValid_tax_dt_basement_square_footage((SALT311.StrType)le.tax_dt_basement_square_footage);
    SELF.effective_year_built_Invalid := Fields.InValid_effective_year_built((SALT311.StrType)le.effective_year_built);
    SELF.src_effective_year_built_Invalid := Fields.InValid_src_effective_year_built((SALT311.StrType)le.src_effective_year_built);
    SELF.tax_dt_effective_year_built_Invalid := Fields.InValid_tax_dt_effective_year_built((SALT311.StrType)le.tax_dt_effective_year_built);
    SELF.garage_square_footage_Invalid := Fields.InValid_garage_square_footage((SALT311.StrType)le.garage_square_footage);
    SELF.src_garage_square_footage_Invalid := Fields.InValid_src_garage_square_footage((SALT311.StrType)le.src_garage_square_footage);
    SELF.tax_dt_garage_square_footage_Invalid := Fields.InValid_tax_dt_garage_square_footage((SALT311.StrType)le.tax_dt_garage_square_footage);
    SELF.stories_type_Invalid := Fields.InValid_stories_type((SALT311.StrType)le.stories_type);
    SELF.src_stories_type_Invalid := Fields.InValid_src_stories_type((SALT311.StrType)le.src_stories_type);
    SELF.tax_dt_stories_type_Invalid := Fields.InValid_tax_dt_stories_type((SALT311.StrType)le.tax_dt_stories_type);
    SELF.apn_number_Invalid := Fields.InValid_apn_number((SALT311.StrType)le.apn_number);
    SELF.src_apn_number_Invalid := Fields.InValid_src_apn_number((SALT311.StrType)le.src_apn_number);
    SELF.tax_dt_apn_number_Invalid := Fields.InValid_tax_dt_apn_number((SALT311.StrType)le.tax_dt_apn_number);
    SELF.src_census_tract_Invalid := Fields.InValid_src_census_tract((SALT311.StrType)le.src_census_tract);
    SELF.tax_dt_census_tract_Invalid := Fields.InValid_tax_dt_census_tract((SALT311.StrType)le.tax_dt_census_tract);
    SELF.src_range_Invalid := Fields.InValid_src_range((SALT311.StrType)le.src_range);
    SELF.tax_dt_range_Invalid := Fields.InValid_tax_dt_range((SALT311.StrType)le.tax_dt_range);
    SELF.src_zoning_Invalid := Fields.InValid_src_zoning((SALT311.StrType)le.src_zoning);
    SELF.tax_dt_zoning_Invalid := Fields.InValid_tax_dt_zoning((SALT311.StrType)le.tax_dt_zoning);
    SELF.src_block_number_Invalid := Fields.InValid_src_block_number((SALT311.StrType)le.src_block_number);
    SELF.tax_dt_block_number_Invalid := Fields.InValid_tax_dt_block_number((SALT311.StrType)le.tax_dt_block_number);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.src_county_name_Invalid := Fields.InValid_src_county_name((SALT311.StrType)le.src_county_name);
    SELF.tax_dt_county_name_Invalid := Fields.InValid_tax_dt_county_name((SALT311.StrType)le.tax_dt_county_name);
    SELF.fips_code_Invalid := Fields.InValid_fips_code((SALT311.StrType)le.fips_code);
    SELF.src_fips_code_Invalid := Fields.InValid_src_fips_code((SALT311.StrType)le.src_fips_code);
    SELF.tax_dt_fips_code_Invalid := Fields.InValid_tax_dt_fips_code((SALT311.StrType)le.tax_dt_fips_code);
    SELF.src_subdivision_Invalid := Fields.InValid_src_subdivision((SALT311.StrType)le.src_subdivision);
    SELF.tax_dt_subdivision_Invalid := Fields.InValid_tax_dt_subdivision((SALT311.StrType)le.tax_dt_subdivision);
    SELF.src_municipality_Invalid := Fields.InValid_src_municipality((SALT311.StrType)le.src_municipality);
    SELF.tax_dt_municipality_Invalid := Fields.InValid_tax_dt_municipality((SALT311.StrType)le.tax_dt_municipality);
    SELF.src_township_Invalid := Fields.InValid_src_township((SALT311.StrType)le.src_township);
    SELF.tax_dt_township_Invalid := Fields.InValid_tax_dt_township((SALT311.StrType)le.tax_dt_township);
    SELF.src_homestead_exemption_ind_Invalid := Fields.InValid_src_homestead_exemption_ind((SALT311.StrType)le.src_homestead_exemption_ind);
    SELF.tax_dt_homestead_exemption_ind_Invalid := Fields.InValid_tax_dt_homestead_exemption_ind((SALT311.StrType)le.tax_dt_homestead_exemption_ind);
    SELF.land_use_code_Invalid := Fields.InValid_land_use_code((SALT311.StrType)le.land_use_code);
    SELF.src_land_use_code_Invalid := Fields.InValid_src_land_use_code((SALT311.StrType)le.src_land_use_code);
    SELF.tax_dt_land_use_code_Invalid := Fields.InValid_tax_dt_land_use_code((SALT311.StrType)le.tax_dt_land_use_code);
    SELF.src_latitude_Invalid := Fields.InValid_src_latitude((SALT311.StrType)le.src_latitude);
    SELF.tax_dt_latitude_Invalid := Fields.InValid_tax_dt_latitude((SALT311.StrType)le.tax_dt_latitude);
    SELF.src_longitude_Invalid := Fields.InValid_src_longitude((SALT311.StrType)le.src_longitude);
    SELF.tax_dt_longitude_Invalid := Fields.InValid_tax_dt_longitude((SALT311.StrType)le.tax_dt_longitude);
    SELF.location_influence_code_Invalid := Fields.InValid_location_influence_code((SALT311.StrType)le.location_influence_code);
    SELF.src_location_influence_code_Invalid := Fields.InValid_src_location_influence_code((SALT311.StrType)le.src_location_influence_code);
    SELF.tax_dt_location_influence_code_Invalid := Fields.InValid_tax_dt_location_influence_code((SALT311.StrType)le.tax_dt_location_influence_code);
    SELF.src_acres_Invalid := Fields.InValid_src_acres((SALT311.StrType)le.src_acres);
    SELF.tax_dt_acres_Invalid := Fields.InValid_tax_dt_acres((SALT311.StrType)le.tax_dt_acres);
    SELF.src_lot_depth_footage_Invalid := Fields.InValid_src_lot_depth_footage((SALT311.StrType)le.src_lot_depth_footage);
    SELF.tax_dt_lot_depth_footage_Invalid := Fields.InValid_tax_dt_lot_depth_footage((SALT311.StrType)le.tax_dt_lot_depth_footage);
    SELF.src_lot_front_footage_Invalid := Fields.InValid_src_lot_front_footage((SALT311.StrType)le.src_lot_front_footage);
    SELF.tax_dt_lot_front_footage_Invalid := Fields.InValid_tax_dt_lot_front_footage((SALT311.StrType)le.tax_dt_lot_front_footage);
    SELF.src_lot_number_Invalid := Fields.InValid_src_lot_number((SALT311.StrType)le.src_lot_number);
    SELF.tax_dt_lot_number_Invalid := Fields.InValid_tax_dt_lot_number((SALT311.StrType)le.tax_dt_lot_number);
    SELF.src_lot_size_Invalid := Fields.InValid_src_lot_size((SALT311.StrType)le.src_lot_size);
    SELF.tax_dt_lot_size_Invalid := Fields.InValid_tax_dt_lot_size((SALT311.StrType)le.tax_dt_lot_size);
    SELF.property_type_code_Invalid := Fields.InValid_property_type_code((SALT311.StrType)le.property_type_code);
    SELF.src_property_type_code_Invalid := Fields.InValid_src_property_type_code((SALT311.StrType)le.src_property_type_code);
    SELF.tax_dt_property_type_code_Invalid := Fields.InValid_tax_dt_property_type_code((SALT311.StrType)le.tax_dt_property_type_code);
    SELF.structure_quality_Invalid := Fields.InValid_structure_quality((SALT311.StrType)le.structure_quality);
    SELF.src_structure_quality_Invalid := Fields.InValid_src_structure_quality((SALT311.StrType)le.src_structure_quality);
    SELF.tax_dt_structure_quality_Invalid := Fields.InValid_tax_dt_structure_quality((SALT311.StrType)le.tax_dt_structure_quality);
    SELF.water_Invalid := Fields.InValid_water((SALT311.StrType)le.water);
    SELF.src_water_Invalid := Fields.InValid_src_water((SALT311.StrType)le.src_water);
    SELF.tax_dt_water_Invalid := Fields.InValid_tax_dt_water((SALT311.StrType)le.tax_dt_water);
    SELF.sewer_Invalid := Fields.InValid_sewer((SALT311.StrType)le.sewer);
    SELF.src_sewer_Invalid := Fields.InValid_src_sewer((SALT311.StrType)le.src_sewer);
    SELF.tax_dt_sewer_Invalid := Fields.InValid_tax_dt_sewer((SALT311.StrType)le.tax_dt_sewer);
    SELF.assessed_land_value_Invalid := Fields.InValid_assessed_land_value((SALT311.StrType)le.assessed_land_value);
    SELF.src_assessed_land_value_Invalid := Fields.InValid_src_assessed_land_value((SALT311.StrType)le.src_assessed_land_value);
    SELF.tax_dt_assessed_land_value_Invalid := Fields.InValid_tax_dt_assessed_land_value((SALT311.StrType)le.tax_dt_assessed_land_value);
    SELF.assessed_year_Invalid := Fields.InValid_assessed_year((SALT311.StrType)le.assessed_year);
    SELF.src_assessed_year_Invalid := Fields.InValid_src_assessed_year((SALT311.StrType)le.src_assessed_year);
    SELF.tax_dt_assessed_year_Invalid := Fields.InValid_tax_dt_assessed_year((SALT311.StrType)le.tax_dt_assessed_year);
    SELF.tax_amount_Invalid := Fields.InValid_tax_amount((SALT311.StrType)le.tax_amount);
    SELF.src_tax_amount_Invalid := Fields.InValid_src_tax_amount((SALT311.StrType)le.src_tax_amount);
    SELF.tax_dt_tax_amount_Invalid := Fields.InValid_tax_dt_tax_amount((SALT311.StrType)le.tax_dt_tax_amount);
    SELF.tax_year_Invalid := Fields.InValid_tax_year((SALT311.StrType)le.tax_year);
    SELF.src_tax_year_Invalid := Fields.InValid_src_tax_year((SALT311.StrType)le.src_tax_year);
    SELF.market_land_value_Invalid := Fields.InValid_market_land_value((SALT311.StrType)le.market_land_value);
    SELF.src_market_land_value_Invalid := Fields.InValid_src_market_land_value((SALT311.StrType)le.src_market_land_value);
    SELF.tax_dt_market_land_value_Invalid := Fields.InValid_tax_dt_market_land_value((SALT311.StrType)le.tax_dt_market_land_value);
    SELF.improvement_value_Invalid := Fields.InValid_improvement_value((SALT311.StrType)le.improvement_value);
    SELF.src_improvement_value_Invalid := Fields.InValid_src_improvement_value((SALT311.StrType)le.src_improvement_value);
    SELF.tax_dt_improvement_value_Invalid := Fields.InValid_tax_dt_improvement_value((SALT311.StrType)le.tax_dt_improvement_value);
    SELF.src_percent_improved_Invalid := Fields.InValid_src_percent_improved((SALT311.StrType)le.src_percent_improved);
    SELF.tax_dt_percent_improved_Invalid := Fields.InValid_tax_dt_percent_improved((SALT311.StrType)le.tax_dt_percent_improved);
    SELF.total_assessed_value_Invalid := Fields.InValid_total_assessed_value((SALT311.StrType)le.total_assessed_value);
    SELF.src_total_assessed_value_Invalid := Fields.InValid_src_total_assessed_value((SALT311.StrType)le.src_total_assessed_value);
    SELF.tax_dt_total_assessed_value_Invalid := Fields.InValid_tax_dt_total_assessed_value((SALT311.StrType)le.tax_dt_total_assessed_value);
    SELF.total_calculated_value_Invalid := Fields.InValid_total_calculated_value((SALT311.StrType)le.total_calculated_value);
    SELF.src_total_calculated_value_Invalid := Fields.InValid_src_total_calculated_value((SALT311.StrType)le.src_total_calculated_value);
    SELF.tax_dt_total_calculated_value_Invalid := Fields.InValid_tax_dt_total_calculated_value((SALT311.StrType)le.tax_dt_total_calculated_value);
    SELF.total_land_value_Invalid := Fields.InValid_total_land_value((SALT311.StrType)le.total_land_value);
    SELF.src_total_land_value_Invalid := Fields.InValid_src_total_land_value((SALT311.StrType)le.src_total_land_value);
    SELF.tax_dt_total_land_value_Invalid := Fields.InValid_tax_dt_total_land_value((SALT311.StrType)le.tax_dt_total_land_value);
    SELF.total_market_value_Invalid := Fields.InValid_total_market_value((SALT311.StrType)le.total_market_value);
    SELF.src_total_market_value_Invalid := Fields.InValid_src_total_market_value((SALT311.StrType)le.src_total_market_value);
    SELF.tax_dt_total_market_value_Invalid := Fields.InValid_tax_dt_total_market_value((SALT311.StrType)le.tax_dt_total_market_value);
    SELF.floor_type_Invalid := Fields.InValid_floor_type((SALT311.StrType)le.floor_type);
    SELF.src_floor_type_Invalid := Fields.InValid_src_floor_type((SALT311.StrType)le.src_floor_type);
    SELF.tax_dt_floor_type_Invalid := Fields.InValid_tax_dt_floor_type((SALT311.StrType)le.tax_dt_floor_type);
    SELF.frame_type_Invalid := Fields.InValid_frame_type((SALT311.StrType)le.frame_type);
    SELF.src_frame_type_Invalid := Fields.InValid_src_frame_type((SALT311.StrType)le.src_frame_type);
    SELF.tax_dt_frame_type_Invalid := Fields.InValid_tax_dt_frame_type((SALT311.StrType)le.tax_dt_frame_type);
    SELF.fuel_type_Invalid := Fields.InValid_fuel_type((SALT311.StrType)le.fuel_type);
    SELF.src_fuel_type_Invalid := Fields.InValid_src_fuel_type((SALT311.StrType)le.src_fuel_type);
    SELF.tax_dt_fuel_type_Invalid := Fields.InValid_tax_dt_fuel_type((SALT311.StrType)le.tax_dt_fuel_type);
    SELF.no_of_bath_fixtures_Invalid := Fields.InValid_no_of_bath_fixtures((SALT311.StrType)le.no_of_bath_fixtures);
    SELF.src_no_of_bath_fixtures_Invalid := Fields.InValid_src_no_of_bath_fixtures((SALT311.StrType)le.src_no_of_bath_fixtures);
    SELF.tax_dt_no_of_bath_fixtures_Invalid := Fields.InValid_tax_dt_no_of_bath_fixtures((SALT311.StrType)le.tax_dt_no_of_bath_fixtures);
    SELF.no_of_rooms_Invalid := Fields.InValid_no_of_rooms((SALT311.StrType)le.no_of_rooms);
    SELF.src_no_of_rooms_Invalid := Fields.InValid_src_no_of_rooms((SALT311.StrType)le.src_no_of_rooms);
    SELF.tax_dt_no_of_rooms_Invalid := Fields.InValid_tax_dt_no_of_rooms((SALT311.StrType)le.tax_dt_no_of_rooms);
    SELF.no_of_units_Invalid := Fields.InValid_no_of_units((SALT311.StrType)le.no_of_units);
    SELF.src_no_of_units_Invalid := Fields.InValid_src_no_of_units((SALT311.StrType)le.src_no_of_units);
    SELF.tax_dt_no_of_units_Invalid := Fields.InValid_tax_dt_no_of_units((SALT311.StrType)le.tax_dt_no_of_units);
    SELF.style_type_Invalid := Fields.InValid_style_type((SALT311.StrType)le.style_type);
    SELF.src_style_type_Invalid := Fields.InValid_src_style_type((SALT311.StrType)le.src_style_type);
    SELF.tax_dt_style_type_Invalid := Fields.InValid_tax_dt_style_type((SALT311.StrType)le.tax_dt_style_type);
    SELF.assessment_document_number_Invalid := Fields.InValid_assessment_document_number((SALT311.StrType)le.assessment_document_number);
    SELF.src_assessment_document_number_Invalid := Fields.InValid_src_assessment_document_number((SALT311.StrType)le.src_assessment_document_number);
    SELF.tax_dt_assessment_document_number_Invalid := Fields.InValid_tax_dt_assessment_document_number((SALT311.StrType)le.tax_dt_assessment_document_number);
    SELF.assessment_recording_date_Invalid := Fields.InValid_assessment_recording_date((SALT311.StrType)le.assessment_recording_date);
    SELF.src_assessment_recording_date_Invalid := Fields.InValid_src_assessment_recording_date((SALT311.StrType)le.src_assessment_recording_date);
    SELF.tax_dt_assessment_recording_date_Invalid := Fields.InValid_tax_dt_assessment_recording_date((SALT311.StrType)le.tax_dt_assessment_recording_date);
    SELF.deed_document_number_Invalid := Fields.InValid_deed_document_number((SALT311.StrType)le.deed_document_number);
    SELF.src_deed_document_number_Invalid := Fields.InValid_src_deed_document_number((SALT311.StrType)le.src_deed_document_number);
    SELF.rec_dt_deed_document_number_Invalid := Fields.InValid_rec_dt_deed_document_number((SALT311.StrType)le.rec_dt_deed_document_number);
    SELF.deed_recording_date_Invalid := Fields.InValid_deed_recording_date((SALT311.StrType)le.deed_recording_date);
    SELF.src_deed_recording_date_Invalid := Fields.InValid_src_deed_recording_date((SALT311.StrType)le.src_deed_recording_date);
    SELF.full_part_sale_Invalid := Fields.InValid_full_part_sale((SALT311.StrType)le.full_part_sale);
    SELF.src_full_part_sale_Invalid := Fields.InValid_src_full_part_sale((SALT311.StrType)le.src_full_part_sale);
    SELF.rec_dt_full_part_sale_Invalid := Fields.InValid_rec_dt_full_part_sale((SALT311.StrType)le.rec_dt_full_part_sale);
    SELF.sale_amount_Invalid := Fields.InValid_sale_amount((SALT311.StrType)le.sale_amount);
    SELF.src_sale_amount_Invalid := Fields.InValid_src_sale_amount((SALT311.StrType)le.src_sale_amount);
    SELF.rec_dt_sale_amount_Invalid := Fields.InValid_rec_dt_sale_amount((SALT311.StrType)le.rec_dt_sale_amount);
    SELF.sale_date_Invalid := Fields.InValid_sale_date((SALT311.StrType)le.sale_date);
    SELF.src_sale_date_Invalid := Fields.InValid_src_sale_date((SALT311.StrType)le.src_sale_date);
    SELF.rec_dt_sale_date_Invalid := Fields.InValid_rec_dt_sale_date((SALT311.StrType)le.rec_dt_sale_date);
    SELF.sale_type_code_Invalid := Fields.InValid_sale_type_code((SALT311.StrType)le.sale_type_code);
    SELF.src_sale_type_code_Invalid := Fields.InValid_src_sale_type_code((SALT311.StrType)le.src_sale_type_code);
    SELF.rec_dt_sale_type_code_Invalid := Fields.InValid_rec_dt_sale_type_code((SALT311.StrType)le.rec_dt_sale_type_code);
    SELF.mortgage_company_name_Invalid := Fields.InValid_mortgage_company_name((SALT311.StrType)le.mortgage_company_name);
    SELF.src_mortgage_company_name_Invalid := Fields.InValid_src_mortgage_company_name((SALT311.StrType)le.src_mortgage_company_name);
    SELF.rec_dt_mortgage_company_name_Invalid := Fields.InValid_rec_dt_mortgage_company_name((SALT311.StrType)le.rec_dt_mortgage_company_name);
    SELF.loan_amount_Invalid := Fields.InValid_loan_amount((SALT311.StrType)le.loan_amount);
    SELF.src_loan_amount_Invalid := Fields.InValid_src_loan_amount((SALT311.StrType)le.src_loan_amount);
    SELF.rec_dt_loan_amount_Invalid := Fields.InValid_rec_dt_loan_amount((SALT311.StrType)le.rec_dt_loan_amount);
    SELF.second_loan_amount_Invalid := Fields.InValid_second_loan_amount((SALT311.StrType)le.second_loan_amount);
    SELF.src_second_loan_amount_Invalid := Fields.InValid_src_second_loan_amount((SALT311.StrType)le.src_second_loan_amount);
    SELF.rec_dt_second_loan_amount_Invalid := Fields.InValid_rec_dt_second_loan_amount((SALT311.StrType)le.rec_dt_second_loan_amount);
    SELF.loan_type_code_Invalid := Fields.InValid_loan_type_code((SALT311.StrType)le.loan_type_code);
    SELF.src_loan_type_code_Invalid := Fields.InValid_src_loan_type_code((SALT311.StrType)le.src_loan_type_code);
    SELF.rec_dt_loan_type_code_Invalid := Fields.InValid_rec_dt_loan_type_code((SALT311.StrType)le.rec_dt_loan_type_code);
    SELF.interest_rate_type_code_Invalid := Fields.InValid_interest_rate_type_code((SALT311.StrType)le.interest_rate_type_code);
    SELF.src_interest_rate_type_code_Invalid := Fields.InValid_src_interest_rate_type_code((SALT311.StrType)le.src_interest_rate_type_code);
    SELF.rec_dt_interest_rate_type_code_Invalid := Fields.InValid_rec_dt_interest_rate_type_code((SALT311.StrType)le.rec_dt_interest_rate_type_code);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_Property_Characteristics::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Scrubs_Property_Characteristics.Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.fips_code=RIGHT.fips_code AND LEFT.fips_code_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_code_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_code_Invalid>0=>LEFT.fips_code_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile1;
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Property_Characteristics);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_vendor_first_reported_Invalid << 0 ) + ( le.dt_vendor_last_reported_Invalid << 1 ) + ( le.tax_sortby_date_Invalid << 2 ) + ( le.deed_sortby_date_Invalid << 3 ) + ( le.fares_unformatted_apn_Invalid << 4 ) + ( le.property_street_address_Invalid << 5 ) + ( le.property_city_state_zip_Invalid << 6 ) + ( le.prim_range_Invalid << 7 ) + ( le.predir_Invalid << 8 ) + ( le.prim_name_Invalid << 9 ) + ( le.addr_suffix_Invalid << 10 ) + ( le.postdir_Invalid << 11 ) + ( le.unit_desig_Invalid << 12 ) + ( le.sec_range_Invalid << 13 ) + ( le.p_city_name_Invalid << 14 ) + ( le.v_city_name_Invalid << 15 ) + ( le.zip_Invalid << 16 ) + ( le.zip4_Invalid << 17 ) + ( le.building_square_footage_Invalid << 18 ) + ( le.src_building_square_footage_Invalid << 19 ) + ( le.tax_dt_building_square_footage_Invalid << 21 ) + ( le.air_conditioning_type_Invalid << 22 ) + ( le.src_air_conditioning_type_Invalid << 23 ) + ( le.tax_dt_air_conditioning_type_Invalid << 25 ) + ( le.basement_finish_Invalid << 26 ) + ( le.src_basement_finish_Invalid << 27 ) + ( le.tax_dt_basement_finish_Invalid << 29 ) + ( le.construction_type_Invalid << 30 ) + ( le.src_construction_type_Invalid << 31 ) + ( le.tax_dt_construction_type_Invalid << 33 ) + ( le.exterior_wall_Invalid << 34 ) + ( le.src_exterior_wall_Invalid << 35 ) + ( le.tax_dt_exterior_wall_Invalid << 37 ) + ( le.fireplace_ind_Invalid << 38 ) + ( le.src_fireplace_ind_Invalid << 39 ) + ( le.tax_dt_fireplace_ind_Invalid << 41 ) + ( le.fireplace_type_Invalid << 42 ) + ( le.src_fireplace_type_Invalid << 43 ) + ( le.tax_dt_fireplace_type_Invalid << 45 ) + ( le.src_flood_zone_panel_Invalid << 46 ) + ( le.tax_dt_flood_zone_panel_Invalid << 48 ) + ( le.garage_Invalid << 49 ) + ( le.src_garage_Invalid << 50 ) + ( le.tax_dt_garage_Invalid << 52 ) + ( le.first_floor_square_footage_Invalid << 53 ) + ( le.src_first_floor_square_footage_Invalid << 54 ) + ( le.tax_dt_first_floor_square_footage_Invalid << 56 ) + ( le.heating_Invalid << 57 ) + ( le.src_heating_Invalid << 58 ) + ( le.tax_dt_heating_Invalid << 60 ) + ( le.living_area_square_footage_Invalid << 61 ) + ( le.src_living_area_square_footage_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.tax_dt_living_area_square_footage_Invalid << 0 ) + ( le.no_of_baths_Invalid << 1 ) + ( le.src_no_of_baths_Invalid << 2 ) + ( le.tax_dt_no_of_baths_Invalid << 4 ) + ( le.no_of_bedrooms_Invalid << 5 ) + ( le.src_no_of_bedrooms_Invalid << 6 ) + ( le.tax_dt_no_of_bedrooms_Invalid << 8 ) + ( le.no_of_fireplaces_Invalid << 9 ) + ( le.src_no_of_fireplaces_Invalid << 10 ) + ( le.tax_dt_no_of_fireplaces_Invalid << 12 ) + ( le.no_of_full_baths_Invalid << 13 ) + ( le.src_no_of_full_baths_Invalid << 14 ) + ( le.tax_dt_no_of_full_baths_Invalid << 16 ) + ( le.no_of_half_baths_Invalid << 17 ) + ( le.src_no_of_half_baths_Invalid << 18 ) + ( le.tax_dt_no_of_half_baths_Invalid << 20 ) + ( le.no_of_stories_Invalid << 21 ) + ( le.src_no_of_stories_Invalid << 22 ) + ( le.tax_dt_no_of_stories_Invalid << 24 ) + ( le.parking_type_Invalid << 25 ) + ( le.src_parking_type_Invalid << 26 ) + ( le.tax_dt_parking_type_Invalid << 28 ) + ( le.src_pool_indicator_Invalid << 29 ) + ( le.tax_dt_pool_indicator_Invalid << 31 ) + ( le.pool_type_Invalid << 32 ) + ( le.src_pool_type_Invalid << 33 ) + ( le.tax_dt_pool_type_Invalid << 35 ) + ( le.roof_cover_Invalid << 36 ) + ( le.src_roof_cover_Invalid << 37 ) + ( le.tax_dt_roof_cover_Invalid << 39 ) + ( le.year_built_Invalid << 40 ) + ( le.src_year_built_Invalid << 42 ) + ( le.tax_dt_year_built_Invalid << 44 ) + ( le.foundation_Invalid << 45 ) + ( le.src_foundation_Invalid << 46 ) + ( le.tax_dt_foundation_Invalid << 48 ) + ( le.basement_square_footage_Invalid << 49 ) + ( le.src_basement_square_footage_Invalid << 50 ) + ( le.tax_dt_basement_square_footage_Invalid << 52 ) + ( le.effective_year_built_Invalid << 53 ) + ( le.src_effective_year_built_Invalid << 55 ) + ( le.tax_dt_effective_year_built_Invalid << 57 ) + ( le.garage_square_footage_Invalid << 58 ) + ( le.src_garage_square_footage_Invalid << 59 ) + ( le.tax_dt_garage_square_footage_Invalid << 61 ) + ( le.stories_type_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.src_stories_type_Invalid << 0 ) + ( le.tax_dt_stories_type_Invalid << 2 ) + ( le.apn_number_Invalid << 3 ) + ( le.src_apn_number_Invalid << 4 ) + ( le.tax_dt_apn_number_Invalid << 6 ) + ( le.src_census_tract_Invalid << 7 ) + ( le.tax_dt_census_tract_Invalid << 9 ) + ( le.src_range_Invalid << 10 ) + ( le.tax_dt_range_Invalid << 12 ) + ( le.src_zoning_Invalid << 13 ) + ( le.tax_dt_zoning_Invalid << 15 ) + ( le.src_block_number_Invalid << 16 ) + ( le.tax_dt_block_number_Invalid << 18 ) + ( le.county_name_Invalid << 19 ) + ( le.src_county_name_Invalid << 21 ) + ( le.tax_dt_county_name_Invalid << 23 ) + ( le.fips_code_Invalid << 24 ) + ( le.src_fips_code_Invalid << 26 ) + ( le.tax_dt_fips_code_Invalid << 28 ) + ( le.src_subdivision_Invalid << 29 ) + ( le.tax_dt_subdivision_Invalid << 31 ) + ( le.src_municipality_Invalid << 32 ) + ( le.tax_dt_municipality_Invalid << 34 ) + ( le.src_township_Invalid << 35 ) + ( le.tax_dt_township_Invalid << 37 ) + ( le.src_homestead_exemption_ind_Invalid << 38 ) + ( le.tax_dt_homestead_exemption_ind_Invalid << 40 ) + ( le.land_use_code_Invalid << 41 ) + ( le.src_land_use_code_Invalid << 42 ) + ( le.tax_dt_land_use_code_Invalid << 44 ) + ( le.src_latitude_Invalid << 45 ) + ( le.tax_dt_latitude_Invalid << 47 ) + ( le.src_longitude_Invalid << 48 ) + ( le.tax_dt_longitude_Invalid << 50 ) + ( le.location_influence_code_Invalid << 51 ) + ( le.src_location_influence_code_Invalid << 52 ) + ( le.tax_dt_location_influence_code_Invalid << 54 ) + ( le.src_acres_Invalid << 55 ) + ( le.tax_dt_acres_Invalid << 57 ) + ( le.src_lot_depth_footage_Invalid << 58 ) + ( le.tax_dt_lot_depth_footage_Invalid << 60 ) + ( le.src_lot_front_footage_Invalid << 61 ) + ( le.tax_dt_lot_front_footage_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.src_lot_number_Invalid << 0 ) + ( le.tax_dt_lot_number_Invalid << 2 ) + ( le.src_lot_size_Invalid << 3 ) + ( le.tax_dt_lot_size_Invalid << 5 ) + ( le.property_type_code_Invalid << 6 ) + ( le.src_property_type_code_Invalid << 7 ) + ( le.tax_dt_property_type_code_Invalid << 9 ) + ( le.structure_quality_Invalid << 10 ) + ( le.src_structure_quality_Invalid << 11 ) + ( le.tax_dt_structure_quality_Invalid << 13 ) + ( le.water_Invalid << 14 ) + ( le.src_water_Invalid << 15 ) + ( le.tax_dt_water_Invalid << 17 ) + ( le.sewer_Invalid << 18 ) + ( le.src_sewer_Invalid << 19 ) + ( le.tax_dt_sewer_Invalid << 21 ) + ( le.assessed_land_value_Invalid << 22 ) + ( le.src_assessed_land_value_Invalid << 23 ) + ( le.tax_dt_assessed_land_value_Invalid << 25 ) + ( le.assessed_year_Invalid << 26 ) + ( le.src_assessed_year_Invalid << 28 ) + ( le.tax_dt_assessed_year_Invalid << 30 ) + ( le.tax_amount_Invalid << 31 ) + ( le.src_tax_amount_Invalid << 32 ) + ( le.tax_dt_tax_amount_Invalid << 34 ) + ( le.tax_year_Invalid << 35 ) + ( le.src_tax_year_Invalid << 37 ) + ( le.market_land_value_Invalid << 39 ) + ( le.src_market_land_value_Invalid << 40 ) + ( le.tax_dt_market_land_value_Invalid << 42 ) + ( le.improvement_value_Invalid << 43 ) + ( le.src_improvement_value_Invalid << 44 ) + ( le.tax_dt_improvement_value_Invalid << 46 ) + ( le.src_percent_improved_Invalid << 47 ) + ( le.tax_dt_percent_improved_Invalid << 49 ) + ( le.total_assessed_value_Invalid << 50 ) + ( le.src_total_assessed_value_Invalid << 51 ) + ( le.tax_dt_total_assessed_value_Invalid << 53 ) + ( le.total_calculated_value_Invalid << 54 ) + ( le.src_total_calculated_value_Invalid << 55 ) + ( le.tax_dt_total_calculated_value_Invalid << 57 ) + ( le.total_land_value_Invalid << 58 ) + ( le.src_total_land_value_Invalid << 59 ) + ( le.tax_dt_total_land_value_Invalid << 61 ) + ( le.total_market_value_Invalid << 62 );
    SELF.ScrubsBits5 := ( le.src_total_market_value_Invalid << 0 ) + ( le.tax_dt_total_market_value_Invalid << 2 ) + ( le.floor_type_Invalid << 3 ) + ( le.src_floor_type_Invalid << 4 ) + ( le.tax_dt_floor_type_Invalid << 6 ) + ( le.frame_type_Invalid << 7 ) + ( le.src_frame_type_Invalid << 8 ) + ( le.tax_dt_frame_type_Invalid << 10 ) + ( le.fuel_type_Invalid << 11 ) + ( le.src_fuel_type_Invalid << 12 ) + ( le.tax_dt_fuel_type_Invalid << 14 ) + ( le.no_of_bath_fixtures_Invalid << 15 ) + ( le.src_no_of_bath_fixtures_Invalid << 16 ) + ( le.tax_dt_no_of_bath_fixtures_Invalid << 18 ) + ( le.no_of_rooms_Invalid << 19 ) + ( le.src_no_of_rooms_Invalid << 20 ) + ( le.tax_dt_no_of_rooms_Invalid << 22 ) + ( le.no_of_units_Invalid << 23 ) + ( le.src_no_of_units_Invalid << 24 ) + ( le.tax_dt_no_of_units_Invalid << 26 ) + ( le.style_type_Invalid << 27 ) + ( le.src_style_type_Invalid << 28 ) + ( le.tax_dt_style_type_Invalid << 30 ) + ( le.assessment_document_number_Invalid << 31 ) + ( le.src_assessment_document_number_Invalid << 32 ) + ( le.tax_dt_assessment_document_number_Invalid << 34 ) + ( le.assessment_recording_date_Invalid << 35 ) + ( le.src_assessment_recording_date_Invalid << 36 ) + ( le.tax_dt_assessment_recording_date_Invalid << 38 ) + ( le.deed_document_number_Invalid << 39 ) + ( le.src_deed_document_number_Invalid << 40 ) + ( le.rec_dt_deed_document_number_Invalid << 42 ) + ( le.deed_recording_date_Invalid << 43 ) + ( le.src_deed_recording_date_Invalid << 44 ) + ( le.full_part_sale_Invalid << 46 ) + ( le.src_full_part_sale_Invalid << 47 ) + ( le.rec_dt_full_part_sale_Invalid << 49 ) + ( le.sale_amount_Invalid << 50 ) + ( le.src_sale_amount_Invalid << 51 ) + ( le.rec_dt_sale_amount_Invalid << 53 ) + ( le.sale_date_Invalid << 54 ) + ( le.src_sale_date_Invalid << 55 ) + ( le.rec_dt_sale_date_Invalid << 57 ) + ( le.sale_type_code_Invalid << 58 ) + ( le.src_sale_type_code_Invalid << 59 ) + ( le.rec_dt_sale_type_code_Invalid << 61 ) + ( le.mortgage_company_name_Invalid << 62 );
    SELF.ScrubsBits6 := ( le.src_mortgage_company_name_Invalid << 0 ) + ( le.rec_dt_mortgage_company_name_Invalid << 2 ) + ( le.loan_amount_Invalid << 3 ) + ( le.src_loan_amount_Invalid << 4 ) + ( le.rec_dt_loan_amount_Invalid << 6 ) + ( le.second_loan_amount_Invalid << 7 ) + ( le.src_second_loan_amount_Invalid << 8 ) + ( le.rec_dt_second_loan_amount_Invalid << 10 ) + ( le.loan_type_code_Invalid << 11 ) + ( le.src_loan_type_code_Invalid << 12 ) + ( le.rec_dt_loan_type_code_Invalid << 14 ) + ( le.interest_rate_type_code_Invalid << 15 ) + ( le.src_interest_rate_type_code_Invalid << 16 ) + ( le.rec_dt_interest_rate_type_code_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0 OR (mask&le.ScrubsBits3)>0 OR (mask&le.ScrubsBits4)>0 OR (mask&le.ScrubsBits5)>0 OR (mask&le.ScrubsBits6)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND le.ScrubsBits3=0 AND le.ScrubsBits4=0 AND le.ScrubsBits5=0 AND le.ScrubsBits6=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Property_Characteristics);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.tax_sortby_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.deed_sortby_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fares_unformatted_apn_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.property_street_address_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.property_city_state_zip_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.building_square_footage_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.src_building_square_footage_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.tax_dt_building_square_footage_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.air_conditioning_type_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.src_air_conditioning_type_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.tax_dt_air_conditioning_type_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.basement_finish_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.src_basement_finish_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.tax_dt_basement_finish_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.construction_type_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.src_construction_type_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.tax_dt_construction_type_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.exterior_wall_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.src_exterior_wall_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.tax_dt_exterior_wall_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.fireplace_ind_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.src_fireplace_ind_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.tax_dt_fireplace_ind_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.fireplace_type_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.src_fireplace_type_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.tax_dt_fireplace_type_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.src_flood_zone_panel_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.tax_dt_flood_zone_panel_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.garage_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.src_garage_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.tax_dt_garage_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.first_floor_square_footage_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.src_first_floor_square_footage_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.tax_dt_first_floor_square_footage_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.heating_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.src_heating_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.tax_dt_heating_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.living_area_square_footage_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.src_living_area_square_footage_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.tax_dt_living_area_square_footage_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.no_of_baths_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.src_no_of_baths_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.tax_dt_no_of_baths_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.no_of_bedrooms_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.src_no_of_bedrooms_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.tax_dt_no_of_bedrooms_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.no_of_fireplaces_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.src_no_of_fireplaces_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.tax_dt_no_of_fireplaces_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.no_of_full_baths_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.src_no_of_full_baths_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.tax_dt_no_of_full_baths_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.no_of_half_baths_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.src_no_of_half_baths_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.tax_dt_no_of_half_baths_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.no_of_stories_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.src_no_of_stories_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.tax_dt_no_of_stories_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.parking_type_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.src_parking_type_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.tax_dt_parking_type_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.src_pool_indicator_Invalid := (le.ScrubsBits2 >> 29) & 3;
    SELF.tax_dt_pool_indicator_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.pool_type_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.src_pool_type_Invalid := (le.ScrubsBits2 >> 33) & 3;
    SELF.tax_dt_pool_type_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.roof_cover_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.src_roof_cover_Invalid := (le.ScrubsBits2 >> 37) & 3;
    SELF.tax_dt_roof_cover_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.year_built_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.src_year_built_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.tax_dt_year_built_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.foundation_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.src_foundation_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.tax_dt_foundation_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.basement_square_footage_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.src_basement_square_footage_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.tax_dt_basement_square_footage_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.effective_year_built_Invalid := (le.ScrubsBits2 >> 53) & 3;
    SELF.src_effective_year_built_Invalid := (le.ScrubsBits2 >> 55) & 3;
    SELF.tax_dt_effective_year_built_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.garage_square_footage_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.src_garage_square_footage_Invalid := (le.ScrubsBits2 >> 59) & 3;
    SELF.tax_dt_garage_square_footage_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.stories_type_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.src_stories_type_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.tax_dt_stories_type_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.apn_number_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.src_apn_number_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.tax_dt_apn_number_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.src_census_tract_Invalid := (le.ScrubsBits3 >> 7) & 3;
    SELF.tax_dt_census_tract_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.src_range_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.tax_dt_range_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.src_zoning_Invalid := (le.ScrubsBits3 >> 13) & 3;
    SELF.tax_dt_zoning_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.src_block_number_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.tax_dt_block_number_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits3 >> 19) & 3;
    SELF.src_county_name_Invalid := (le.ScrubsBits3 >> 21) & 3;
    SELF.tax_dt_county_name_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.fips_code_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.src_fips_code_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.tax_dt_fips_code_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.src_subdivision_Invalid := (le.ScrubsBits3 >> 29) & 3;
    SELF.tax_dt_subdivision_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.src_municipality_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.tax_dt_municipality_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.src_township_Invalid := (le.ScrubsBits3 >> 35) & 3;
    SELF.tax_dt_township_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.src_homestead_exemption_ind_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.tax_dt_homestead_exemption_ind_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.land_use_code_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.src_land_use_code_Invalid := (le.ScrubsBits3 >> 42) & 3;
    SELF.tax_dt_land_use_code_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.src_latitude_Invalid := (le.ScrubsBits3 >> 45) & 3;
    SELF.tax_dt_latitude_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.src_longitude_Invalid := (le.ScrubsBits3 >> 48) & 3;
    SELF.tax_dt_longitude_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.location_influence_code_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.src_location_influence_code_Invalid := (le.ScrubsBits3 >> 52) & 3;
    SELF.tax_dt_location_influence_code_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.src_acres_Invalid := (le.ScrubsBits3 >> 55) & 3;
    SELF.tax_dt_acres_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.src_lot_depth_footage_Invalid := (le.ScrubsBits3 >> 58) & 3;
    SELF.tax_dt_lot_depth_footage_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.src_lot_front_footage_Invalid := (le.ScrubsBits3 >> 61) & 3;
    SELF.tax_dt_lot_front_footage_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.src_lot_number_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.tax_dt_lot_number_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.src_lot_size_Invalid := (le.ScrubsBits4 >> 3) & 3;
    SELF.tax_dt_lot_size_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.property_type_code_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.src_property_type_code_Invalid := (le.ScrubsBits4 >> 7) & 3;
    SELF.tax_dt_property_type_code_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF.structure_quality_Invalid := (le.ScrubsBits4 >> 10) & 1;
    SELF.src_structure_quality_Invalid := (le.ScrubsBits4 >> 11) & 3;
    SELF.tax_dt_structure_quality_Invalid := (le.ScrubsBits4 >> 13) & 1;
    SELF.water_Invalid := (le.ScrubsBits4 >> 14) & 1;
    SELF.src_water_Invalid := (le.ScrubsBits4 >> 15) & 3;
    SELF.tax_dt_water_Invalid := (le.ScrubsBits4 >> 17) & 1;
    SELF.sewer_Invalid := (le.ScrubsBits4 >> 18) & 1;
    SELF.src_sewer_Invalid := (le.ScrubsBits4 >> 19) & 3;
    SELF.tax_dt_sewer_Invalid := (le.ScrubsBits4 >> 21) & 1;
    SELF.assessed_land_value_Invalid := (le.ScrubsBits4 >> 22) & 1;
    SELF.src_assessed_land_value_Invalid := (le.ScrubsBits4 >> 23) & 3;
    SELF.tax_dt_assessed_land_value_Invalid := (le.ScrubsBits4 >> 25) & 1;
    SELF.assessed_year_Invalid := (le.ScrubsBits4 >> 26) & 3;
    SELF.src_assessed_year_Invalid := (le.ScrubsBits4 >> 28) & 3;
    SELF.tax_dt_assessed_year_Invalid := (le.ScrubsBits4 >> 30) & 1;
    SELF.tax_amount_Invalid := (le.ScrubsBits4 >> 31) & 1;
    SELF.src_tax_amount_Invalid := (le.ScrubsBits4 >> 32) & 3;
    SELF.tax_dt_tax_amount_Invalid := (le.ScrubsBits4 >> 34) & 1;
    SELF.tax_year_Invalid := (le.ScrubsBits4 >> 35) & 3;
    SELF.src_tax_year_Invalid := (le.ScrubsBits4 >> 37) & 3;
    SELF.market_land_value_Invalid := (le.ScrubsBits4 >> 39) & 1;
    SELF.src_market_land_value_Invalid := (le.ScrubsBits4 >> 40) & 3;
    SELF.tax_dt_market_land_value_Invalid := (le.ScrubsBits4 >> 42) & 1;
    SELF.improvement_value_Invalid := (le.ScrubsBits4 >> 43) & 1;
    SELF.src_improvement_value_Invalid := (le.ScrubsBits4 >> 44) & 3;
    SELF.tax_dt_improvement_value_Invalid := (le.ScrubsBits4 >> 46) & 1;
    SELF.src_percent_improved_Invalid := (le.ScrubsBits4 >> 47) & 3;
    SELF.tax_dt_percent_improved_Invalid := (le.ScrubsBits4 >> 49) & 1;
    SELF.total_assessed_value_Invalid := (le.ScrubsBits4 >> 50) & 1;
    SELF.src_total_assessed_value_Invalid := (le.ScrubsBits4 >> 51) & 3;
    SELF.tax_dt_total_assessed_value_Invalid := (le.ScrubsBits4 >> 53) & 1;
    SELF.total_calculated_value_Invalid := (le.ScrubsBits4 >> 54) & 1;
    SELF.src_total_calculated_value_Invalid := (le.ScrubsBits4 >> 55) & 3;
    SELF.tax_dt_total_calculated_value_Invalid := (le.ScrubsBits4 >> 57) & 1;
    SELF.total_land_value_Invalid := (le.ScrubsBits4 >> 58) & 1;
    SELF.src_total_land_value_Invalid := (le.ScrubsBits4 >> 59) & 3;
    SELF.tax_dt_total_land_value_Invalid := (le.ScrubsBits4 >> 61) & 1;
    SELF.total_market_value_Invalid := (le.ScrubsBits4 >> 62) & 1;
    SELF.src_total_market_value_Invalid := (le.ScrubsBits5 >> 0) & 3;
    SELF.tax_dt_total_market_value_Invalid := (le.ScrubsBits5 >> 2) & 1;
    SELF.floor_type_Invalid := (le.ScrubsBits5 >> 3) & 1;
    SELF.src_floor_type_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.tax_dt_floor_type_Invalid := (le.ScrubsBits5 >> 6) & 1;
    SELF.frame_type_Invalid := (le.ScrubsBits5 >> 7) & 1;
    SELF.src_frame_type_Invalid := (le.ScrubsBits5 >> 8) & 3;
    SELF.tax_dt_frame_type_Invalid := (le.ScrubsBits5 >> 10) & 1;
    SELF.fuel_type_Invalid := (le.ScrubsBits5 >> 11) & 1;
    SELF.src_fuel_type_Invalid := (le.ScrubsBits5 >> 12) & 3;
    SELF.tax_dt_fuel_type_Invalid := (le.ScrubsBits5 >> 14) & 1;
    SELF.no_of_bath_fixtures_Invalid := (le.ScrubsBits5 >> 15) & 1;
    SELF.src_no_of_bath_fixtures_Invalid := (le.ScrubsBits5 >> 16) & 3;
    SELF.tax_dt_no_of_bath_fixtures_Invalid := (le.ScrubsBits5 >> 18) & 1;
    SELF.no_of_rooms_Invalid := (le.ScrubsBits5 >> 19) & 1;
    SELF.src_no_of_rooms_Invalid := (le.ScrubsBits5 >> 20) & 3;
    SELF.tax_dt_no_of_rooms_Invalid := (le.ScrubsBits5 >> 22) & 1;
    SELF.no_of_units_Invalid := (le.ScrubsBits5 >> 23) & 1;
    SELF.src_no_of_units_Invalid := (le.ScrubsBits5 >> 24) & 3;
    SELF.tax_dt_no_of_units_Invalid := (le.ScrubsBits5 >> 26) & 1;
    SELF.style_type_Invalid := (le.ScrubsBits5 >> 27) & 1;
    SELF.src_style_type_Invalid := (le.ScrubsBits5 >> 28) & 3;
    SELF.tax_dt_style_type_Invalid := (le.ScrubsBits5 >> 30) & 1;
    SELF.assessment_document_number_Invalid := (le.ScrubsBits5 >> 31) & 1;
    SELF.src_assessment_document_number_Invalid := (le.ScrubsBits5 >> 32) & 3;
    SELF.tax_dt_assessment_document_number_Invalid := (le.ScrubsBits5 >> 34) & 1;
    SELF.assessment_recording_date_Invalid := (le.ScrubsBits5 >> 35) & 1;
    SELF.src_assessment_recording_date_Invalid := (le.ScrubsBits5 >> 36) & 3;
    SELF.tax_dt_assessment_recording_date_Invalid := (le.ScrubsBits5 >> 38) & 1;
    SELF.deed_document_number_Invalid := (le.ScrubsBits5 >> 39) & 1;
    SELF.src_deed_document_number_Invalid := (le.ScrubsBits5 >> 40) & 3;
    SELF.rec_dt_deed_document_number_Invalid := (le.ScrubsBits5 >> 42) & 1;
    SELF.deed_recording_date_Invalid := (le.ScrubsBits5 >> 43) & 1;
    SELF.src_deed_recording_date_Invalid := (le.ScrubsBits5 >> 44) & 3;
    SELF.full_part_sale_Invalid := (le.ScrubsBits5 >> 46) & 1;
    SELF.src_full_part_sale_Invalid := (le.ScrubsBits5 >> 47) & 3;
    SELF.rec_dt_full_part_sale_Invalid := (le.ScrubsBits5 >> 49) & 1;
    SELF.sale_amount_Invalid := (le.ScrubsBits5 >> 50) & 1;
    SELF.src_sale_amount_Invalid := (le.ScrubsBits5 >> 51) & 3;
    SELF.rec_dt_sale_amount_Invalid := (le.ScrubsBits5 >> 53) & 1;
    SELF.sale_date_Invalid := (le.ScrubsBits5 >> 54) & 1;
    SELF.src_sale_date_Invalid := (le.ScrubsBits5 >> 55) & 3;
    SELF.rec_dt_sale_date_Invalid := (le.ScrubsBits5 >> 57) & 1;
    SELF.sale_type_code_Invalid := (le.ScrubsBits5 >> 58) & 1;
    SELF.src_sale_type_code_Invalid := (le.ScrubsBits5 >> 59) & 3;
    SELF.rec_dt_sale_type_code_Invalid := (le.ScrubsBits5 >> 61) & 1;
    SELF.mortgage_company_name_Invalid := (le.ScrubsBits5 >> 62) & 1;
    SELF.src_mortgage_company_name_Invalid := (le.ScrubsBits6 >> 0) & 3;
    SELF.rec_dt_mortgage_company_name_Invalid := (le.ScrubsBits6 >> 2) & 1;
    SELF.loan_amount_Invalid := (le.ScrubsBits6 >> 3) & 1;
    SELF.src_loan_amount_Invalid := (le.ScrubsBits6 >> 4) & 3;
    SELF.rec_dt_loan_amount_Invalid := (le.ScrubsBits6 >> 6) & 1;
    SELF.second_loan_amount_Invalid := (le.ScrubsBits6 >> 7) & 1;
    SELF.src_second_loan_amount_Invalid := (le.ScrubsBits6 >> 8) & 3;
    SELF.rec_dt_second_loan_amount_Invalid := (le.ScrubsBits6 >> 10) & 1;
    SELF.loan_type_code_Invalid := (le.ScrubsBits6 >> 11) & 1;
    SELF.src_loan_type_code_Invalid := (le.ScrubsBits6 >> 12) & 3;
    SELF.rec_dt_loan_type_code_Invalid := (le.ScrubsBits6 >> 14) & 1;
    SELF.interest_rate_type_code_Invalid := (le.ScrubsBits6 >> 15) & 1;
    SELF.src_interest_rate_type_code_Invalid := (le.ScrubsBits6 >> 16) & 3;
    SELF.rec_dt_interest_rate_type_code_Invalid := (le.ScrubsBits6 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.vendor_source) vendor_source := IF(Glob, '', h.vendor_source);
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    tax_sortby_date_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_sortby_date_Invalid=1);
    deed_sortby_date_CUSTOM_ErrorCount := COUNT(GROUP,h.deed_sortby_date_Invalid=1);
    fares_unformatted_apn_ALLOW_ErrorCount := COUNT(GROUP,h.fares_unformatted_apn_Invalid=1);
    property_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.property_street_address_Invalid=1);
    property_city_state_zip_ALLOW_ErrorCount := COUNT(GROUP,h.property_city_state_zip_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    building_square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.building_square_footage_Invalid=1);
    src_building_square_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_building_square_footage_Invalid=1);
    src_building_square_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_building_square_footage_Invalid=2);
    src_building_square_footage_Total_ErrorCount := COUNT(GROUP,h.src_building_square_footage_Invalid>0);
    tax_dt_building_square_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_building_square_footage_Invalid=1);
    air_conditioning_type_CUSTOM_ErrorCount := COUNT(GROUP,h.air_conditioning_type_Invalid=1);
    src_air_conditioning_type_ENUM_ErrorCount := COUNT(GROUP,h.src_air_conditioning_type_Invalid=1);
    src_air_conditioning_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_air_conditioning_type_Invalid=2);
    src_air_conditioning_type_Total_ErrorCount := COUNT(GROUP,h.src_air_conditioning_type_Invalid>0);
    tax_dt_air_conditioning_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_air_conditioning_type_Invalid=1);
    basement_finish_CUSTOM_ErrorCount := COUNT(GROUP,h.basement_finish_Invalid=1);
    src_basement_finish_ENUM_ErrorCount := COUNT(GROUP,h.src_basement_finish_Invalid=1);
    src_basement_finish_LENGTHS_ErrorCount := COUNT(GROUP,h.src_basement_finish_Invalid=2);
    src_basement_finish_Total_ErrorCount := COUNT(GROUP,h.src_basement_finish_Invalid>0);
    tax_dt_basement_finish_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_basement_finish_Invalid=1);
    construction_type_CUSTOM_ErrorCount := COUNT(GROUP,h.construction_type_Invalid=1);
    src_construction_type_ENUM_ErrorCount := COUNT(GROUP,h.src_construction_type_Invalid=1);
    src_construction_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_construction_type_Invalid=2);
    src_construction_type_Total_ErrorCount := COUNT(GROUP,h.src_construction_type_Invalid>0);
    tax_dt_construction_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_construction_type_Invalid=1);
    exterior_wall_CUSTOM_ErrorCount := COUNT(GROUP,h.exterior_wall_Invalid=1);
    src_exterior_wall_ENUM_ErrorCount := COUNT(GROUP,h.src_exterior_wall_Invalid=1);
    src_exterior_wall_LENGTHS_ErrorCount := COUNT(GROUP,h.src_exterior_wall_Invalid=2);
    src_exterior_wall_Total_ErrorCount := COUNT(GROUP,h.src_exterior_wall_Invalid>0);
    tax_dt_exterior_wall_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_exterior_wall_Invalid=1);
    fireplace_ind_ENUM_ErrorCount := COUNT(GROUP,h.fireplace_ind_Invalid=1);
    src_fireplace_ind_ENUM_ErrorCount := COUNT(GROUP,h.src_fireplace_ind_Invalid=1);
    src_fireplace_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.src_fireplace_ind_Invalid=2);
    src_fireplace_ind_Total_ErrorCount := COUNT(GROUP,h.src_fireplace_ind_Invalid>0);
    tax_dt_fireplace_ind_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_fireplace_ind_Invalid=1);
    fireplace_type_CUSTOM_ErrorCount := COUNT(GROUP,h.fireplace_type_Invalid=1);
    src_fireplace_type_ENUM_ErrorCount := COUNT(GROUP,h.src_fireplace_type_Invalid=1);
    src_fireplace_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_fireplace_type_Invalid=2);
    src_fireplace_type_Total_ErrorCount := COUNT(GROUP,h.src_fireplace_type_Invalid>0);
    tax_dt_fireplace_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_fireplace_type_Invalid=1);
    src_flood_zone_panel_ENUM_ErrorCount := COUNT(GROUP,h.src_flood_zone_panel_Invalid=1);
    src_flood_zone_panel_LENGTHS_ErrorCount := COUNT(GROUP,h.src_flood_zone_panel_Invalid=2);
    src_flood_zone_panel_Total_ErrorCount := COUNT(GROUP,h.src_flood_zone_panel_Invalid>0);
    tax_dt_flood_zone_panel_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_flood_zone_panel_Invalid=1);
    garage_CUSTOM_ErrorCount := COUNT(GROUP,h.garage_Invalid=1);
    src_garage_ENUM_ErrorCount := COUNT(GROUP,h.src_garage_Invalid=1);
    src_garage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_garage_Invalid=2);
    src_garage_Total_ErrorCount := COUNT(GROUP,h.src_garage_Invalid>0);
    tax_dt_garage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_garage_Invalid=1);
    first_floor_square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.first_floor_square_footage_Invalid=1);
    src_first_floor_square_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_first_floor_square_footage_Invalid=1);
    src_first_floor_square_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_first_floor_square_footage_Invalid=2);
    src_first_floor_square_footage_Total_ErrorCount := COUNT(GROUP,h.src_first_floor_square_footage_Invalid>0);
    tax_dt_first_floor_square_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_first_floor_square_footage_Invalid=1);
    heating_CUSTOM_ErrorCount := COUNT(GROUP,h.heating_Invalid=1);
    src_heating_ENUM_ErrorCount := COUNT(GROUP,h.src_heating_Invalid=1);
    src_heating_LENGTHS_ErrorCount := COUNT(GROUP,h.src_heating_Invalid=2);
    src_heating_Total_ErrorCount := COUNT(GROUP,h.src_heating_Invalid>0);
    tax_dt_heating_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_heating_Invalid=1);
    living_area_square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.living_area_square_footage_Invalid=1);
    src_living_area_square_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_living_area_square_footage_Invalid=1);
    src_living_area_square_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_living_area_square_footage_Invalid=2);
    src_living_area_square_footage_Total_ErrorCount := COUNT(GROUP,h.src_living_area_square_footage_Invalid>0);
    tax_dt_living_area_square_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_living_area_square_footage_Invalid=1);
    no_of_baths_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_baths_Invalid=1);
    src_no_of_baths_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_baths_Invalid=1);
    src_no_of_baths_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_baths_Invalid=2);
    src_no_of_baths_Total_ErrorCount := COUNT(GROUP,h.src_no_of_baths_Invalid>0);
    tax_dt_no_of_baths_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_baths_Invalid=1);
    no_of_bedrooms_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_bedrooms_Invalid=1);
    src_no_of_bedrooms_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_bedrooms_Invalid=1);
    src_no_of_bedrooms_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_bedrooms_Invalid=2);
    src_no_of_bedrooms_Total_ErrorCount := COUNT(GROUP,h.src_no_of_bedrooms_Invalid>0);
    tax_dt_no_of_bedrooms_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_bedrooms_Invalid=1);
    no_of_fireplaces_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_fireplaces_Invalid=1);
    src_no_of_fireplaces_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_fireplaces_Invalid=1);
    src_no_of_fireplaces_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_fireplaces_Invalid=2);
    src_no_of_fireplaces_Total_ErrorCount := COUNT(GROUP,h.src_no_of_fireplaces_Invalid>0);
    tax_dt_no_of_fireplaces_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_fireplaces_Invalid=1);
    no_of_full_baths_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_full_baths_Invalid=1);
    src_no_of_full_baths_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_full_baths_Invalid=1);
    src_no_of_full_baths_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_full_baths_Invalid=2);
    src_no_of_full_baths_Total_ErrorCount := COUNT(GROUP,h.src_no_of_full_baths_Invalid>0);
    tax_dt_no_of_full_baths_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_full_baths_Invalid=1);
    no_of_half_baths_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_half_baths_Invalid=1);
    src_no_of_half_baths_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_half_baths_Invalid=1);
    src_no_of_half_baths_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_half_baths_Invalid=2);
    src_no_of_half_baths_Total_ErrorCount := COUNT(GROUP,h.src_no_of_half_baths_Invalid>0);
    tax_dt_no_of_half_baths_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_half_baths_Invalid=1);
    no_of_stories_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_stories_Invalid=1);
    src_no_of_stories_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_stories_Invalid=1);
    src_no_of_stories_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_stories_Invalid=2);
    src_no_of_stories_Total_ErrorCount := COUNT(GROUP,h.src_no_of_stories_Invalid>0);
    tax_dt_no_of_stories_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_stories_Invalid=1);
    parking_type_CUSTOM_ErrorCount := COUNT(GROUP,h.parking_type_Invalid=1);
    src_parking_type_ENUM_ErrorCount := COUNT(GROUP,h.src_parking_type_Invalid=1);
    src_parking_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_parking_type_Invalid=2);
    src_parking_type_Total_ErrorCount := COUNT(GROUP,h.src_parking_type_Invalid>0);
    tax_dt_parking_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_parking_type_Invalid=1);
    src_pool_indicator_ENUM_ErrorCount := COUNT(GROUP,h.src_pool_indicator_Invalid=1);
    src_pool_indicator_LENGTHS_ErrorCount := COUNT(GROUP,h.src_pool_indicator_Invalid=2);
    src_pool_indicator_Total_ErrorCount := COUNT(GROUP,h.src_pool_indicator_Invalid>0);
    tax_dt_pool_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_pool_indicator_Invalid=1);
    pool_type_CUSTOM_ErrorCount := COUNT(GROUP,h.pool_type_Invalid=1);
    src_pool_type_ENUM_ErrorCount := COUNT(GROUP,h.src_pool_type_Invalid=1);
    src_pool_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_pool_type_Invalid=2);
    src_pool_type_Total_ErrorCount := COUNT(GROUP,h.src_pool_type_Invalid>0);
    tax_dt_pool_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_pool_type_Invalid=1);
    roof_cover_CUSTOM_ErrorCount := COUNT(GROUP,h.roof_cover_Invalid=1);
    src_roof_cover_ENUM_ErrorCount := COUNT(GROUP,h.src_roof_cover_Invalid=1);
    src_roof_cover_LENGTHS_ErrorCount := COUNT(GROUP,h.src_roof_cover_Invalid=2);
    src_roof_cover_Total_ErrorCount := COUNT(GROUP,h.src_roof_cover_Invalid>0);
    tax_dt_roof_cover_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_roof_cover_Invalid=1);
    year_built_ALLOW_ErrorCount := COUNT(GROUP,h.year_built_Invalid=1);
    year_built_LENGTHS_ErrorCount := COUNT(GROUP,h.year_built_Invalid=2);
    year_built_Total_ErrorCount := COUNT(GROUP,h.year_built_Invalid>0);
    src_year_built_ENUM_ErrorCount := COUNT(GROUP,h.src_year_built_Invalid=1);
    src_year_built_LENGTHS_ErrorCount := COUNT(GROUP,h.src_year_built_Invalid=2);
    src_year_built_Total_ErrorCount := COUNT(GROUP,h.src_year_built_Invalid>0);
    tax_dt_year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_year_built_Invalid=1);
    foundation_CUSTOM_ErrorCount := COUNT(GROUP,h.foundation_Invalid=1);
    src_foundation_ENUM_ErrorCount := COUNT(GROUP,h.src_foundation_Invalid=1);
    src_foundation_LENGTHS_ErrorCount := COUNT(GROUP,h.src_foundation_Invalid=2);
    src_foundation_Total_ErrorCount := COUNT(GROUP,h.src_foundation_Invalid>0);
    tax_dt_foundation_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_foundation_Invalid=1);
    basement_square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.basement_square_footage_Invalid=1);
    src_basement_square_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_basement_square_footage_Invalid=1);
    src_basement_square_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_basement_square_footage_Invalid=2);
    src_basement_square_footage_Total_ErrorCount := COUNT(GROUP,h.src_basement_square_footage_Invalid>0);
    tax_dt_basement_square_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_basement_square_footage_Invalid=1);
    effective_year_built_ALLOW_ErrorCount := COUNT(GROUP,h.effective_year_built_Invalid=1);
    effective_year_built_LENGTHS_ErrorCount := COUNT(GROUP,h.effective_year_built_Invalid=2);
    effective_year_built_Total_ErrorCount := COUNT(GROUP,h.effective_year_built_Invalid>0);
    src_effective_year_built_ENUM_ErrorCount := COUNT(GROUP,h.src_effective_year_built_Invalid=1);
    src_effective_year_built_LENGTHS_ErrorCount := COUNT(GROUP,h.src_effective_year_built_Invalid=2);
    src_effective_year_built_Total_ErrorCount := COUNT(GROUP,h.src_effective_year_built_Invalid>0);
    tax_dt_effective_year_built_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_effective_year_built_Invalid=1);
    garage_square_footage_ALLOW_ErrorCount := COUNT(GROUP,h.garage_square_footage_Invalid=1);
    src_garage_square_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_garage_square_footage_Invalid=1);
    src_garage_square_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_garage_square_footage_Invalid=2);
    src_garage_square_footage_Total_ErrorCount := COUNT(GROUP,h.src_garage_square_footage_Invalid>0);
    tax_dt_garage_square_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_garage_square_footage_Invalid=1);
    stories_type_CUSTOM_ErrorCount := COUNT(GROUP,h.stories_type_Invalid=1);
    src_stories_type_ENUM_ErrorCount := COUNT(GROUP,h.src_stories_type_Invalid=1);
    src_stories_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_stories_type_Invalid=2);
    src_stories_type_Total_ErrorCount := COUNT(GROUP,h.src_stories_type_Invalid>0);
    tax_dt_stories_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_stories_type_Invalid=1);
    apn_number_ALLOW_ErrorCount := COUNT(GROUP,h.apn_number_Invalid=1);
    src_apn_number_ENUM_ErrorCount := COUNT(GROUP,h.src_apn_number_Invalid=1);
    src_apn_number_LENGTHS_ErrorCount := COUNT(GROUP,h.src_apn_number_Invalid=2);
    src_apn_number_Total_ErrorCount := COUNT(GROUP,h.src_apn_number_Invalid>0);
    tax_dt_apn_number_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_apn_number_Invalid=1);
    src_census_tract_ENUM_ErrorCount := COUNT(GROUP,h.src_census_tract_Invalid=1);
    src_census_tract_LENGTHS_ErrorCount := COUNT(GROUP,h.src_census_tract_Invalid=2);
    src_census_tract_Total_ErrorCount := COUNT(GROUP,h.src_census_tract_Invalid>0);
    tax_dt_census_tract_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_census_tract_Invalid=1);
    src_range_ENUM_ErrorCount := COUNT(GROUP,h.src_range_Invalid=1);
    src_range_LENGTHS_ErrorCount := COUNT(GROUP,h.src_range_Invalid=2);
    src_range_Total_ErrorCount := COUNT(GROUP,h.src_range_Invalid>0);
    tax_dt_range_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_range_Invalid=1);
    src_zoning_ENUM_ErrorCount := COUNT(GROUP,h.src_zoning_Invalid=1);
    src_zoning_LENGTHS_ErrorCount := COUNT(GROUP,h.src_zoning_Invalid=2);
    src_zoning_Total_ErrorCount := COUNT(GROUP,h.src_zoning_Invalid>0);
    tax_dt_zoning_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_zoning_Invalid=1);
    src_block_number_ENUM_ErrorCount := COUNT(GROUP,h.src_block_number_Invalid=1);
    src_block_number_LENGTHS_ErrorCount := COUNT(GROUP,h.src_block_number_Invalid=2);
    src_block_number_Total_ErrorCount := COUNT(GROUP,h.src_block_number_Invalid>0);
    tax_dt_block_number_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_block_number_Invalid=1);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    src_county_name_ENUM_ErrorCount := COUNT(GROUP,h.src_county_name_Invalid=1);
    src_county_name_LENGTHS_ErrorCount := COUNT(GROUP,h.src_county_name_Invalid=2);
    src_county_name_Total_ErrorCount := COUNT(GROUP,h.src_county_name_Invalid>0);
    tax_dt_county_name_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_county_name_Invalid=1);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    fips_code_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=2);
    fips_code_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=3);
    fips_code_Total_ErrorCount := COUNT(GROUP,h.fips_code_Invalid>0);
    src_fips_code_ENUM_ErrorCount := COUNT(GROUP,h.src_fips_code_Invalid=1);
    src_fips_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_fips_code_Invalid=2);
    src_fips_code_Total_ErrorCount := COUNT(GROUP,h.src_fips_code_Invalid>0);
    tax_dt_fips_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_fips_code_Invalid=1);
    src_subdivision_ENUM_ErrorCount := COUNT(GROUP,h.src_subdivision_Invalid=1);
    src_subdivision_LENGTHS_ErrorCount := COUNT(GROUP,h.src_subdivision_Invalid=2);
    src_subdivision_Total_ErrorCount := COUNT(GROUP,h.src_subdivision_Invalid>0);
    tax_dt_subdivision_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_subdivision_Invalid=1);
    src_municipality_ENUM_ErrorCount := COUNT(GROUP,h.src_municipality_Invalid=1);
    src_municipality_LENGTHS_ErrorCount := COUNT(GROUP,h.src_municipality_Invalid=2);
    src_municipality_Total_ErrorCount := COUNT(GROUP,h.src_municipality_Invalid>0);
    tax_dt_municipality_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_municipality_Invalid=1);
    src_township_ENUM_ErrorCount := COUNT(GROUP,h.src_township_Invalid=1);
    src_township_LENGTHS_ErrorCount := COUNT(GROUP,h.src_township_Invalid=2);
    src_township_Total_ErrorCount := COUNT(GROUP,h.src_township_Invalid>0);
    tax_dt_township_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_township_Invalid=1);
    src_homestead_exemption_ind_ENUM_ErrorCount := COUNT(GROUP,h.src_homestead_exemption_ind_Invalid=1);
    src_homestead_exemption_ind_LENGTHS_ErrorCount := COUNT(GROUP,h.src_homestead_exemption_ind_Invalid=2);
    src_homestead_exemption_ind_Total_ErrorCount := COUNT(GROUP,h.src_homestead_exemption_ind_Invalid>0);
    tax_dt_homestead_exemption_ind_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_homestead_exemption_ind_Invalid=1);
    land_use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.land_use_code_Invalid=1);
    src_land_use_code_ENUM_ErrorCount := COUNT(GROUP,h.src_land_use_code_Invalid=1);
    src_land_use_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_land_use_code_Invalid=2);
    src_land_use_code_Total_ErrorCount := COUNT(GROUP,h.src_land_use_code_Invalid>0);
    tax_dt_land_use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_land_use_code_Invalid=1);
    src_latitude_ENUM_ErrorCount := COUNT(GROUP,h.src_latitude_Invalid=1);
    src_latitude_LENGTHS_ErrorCount := COUNT(GROUP,h.src_latitude_Invalid=2);
    src_latitude_Total_ErrorCount := COUNT(GROUP,h.src_latitude_Invalid>0);
    tax_dt_latitude_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_latitude_Invalid=1);
    src_longitude_ENUM_ErrorCount := COUNT(GROUP,h.src_longitude_Invalid=1);
    src_longitude_LENGTHS_ErrorCount := COUNT(GROUP,h.src_longitude_Invalid=2);
    src_longitude_Total_ErrorCount := COUNT(GROUP,h.src_longitude_Invalid>0);
    tax_dt_longitude_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_longitude_Invalid=1);
    location_influence_code_CUSTOM_ErrorCount := COUNT(GROUP,h.location_influence_code_Invalid=1);
    src_location_influence_code_ENUM_ErrorCount := COUNT(GROUP,h.src_location_influence_code_Invalid=1);
    src_location_influence_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_location_influence_code_Invalid=2);
    src_location_influence_code_Total_ErrorCount := COUNT(GROUP,h.src_location_influence_code_Invalid>0);
    tax_dt_location_influence_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_location_influence_code_Invalid=1);
    src_acres_ENUM_ErrorCount := COUNT(GROUP,h.src_acres_Invalid=1);
    src_acres_LENGTHS_ErrorCount := COUNT(GROUP,h.src_acres_Invalid=2);
    src_acres_Total_ErrorCount := COUNT(GROUP,h.src_acres_Invalid>0);
    tax_dt_acres_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_acres_Invalid=1);
    src_lot_depth_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_lot_depth_footage_Invalid=1);
    src_lot_depth_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_lot_depth_footage_Invalid=2);
    src_lot_depth_footage_Total_ErrorCount := COUNT(GROUP,h.src_lot_depth_footage_Invalid>0);
    tax_dt_lot_depth_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_lot_depth_footage_Invalid=1);
    src_lot_front_footage_ENUM_ErrorCount := COUNT(GROUP,h.src_lot_front_footage_Invalid=1);
    src_lot_front_footage_LENGTHS_ErrorCount := COUNT(GROUP,h.src_lot_front_footage_Invalid=2);
    src_lot_front_footage_Total_ErrorCount := COUNT(GROUP,h.src_lot_front_footage_Invalid>0);
    tax_dt_lot_front_footage_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_lot_front_footage_Invalid=1);
    src_lot_number_ENUM_ErrorCount := COUNT(GROUP,h.src_lot_number_Invalid=1);
    src_lot_number_LENGTHS_ErrorCount := COUNT(GROUP,h.src_lot_number_Invalid=2);
    src_lot_number_Total_ErrorCount := COUNT(GROUP,h.src_lot_number_Invalid>0);
    tax_dt_lot_number_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_lot_number_Invalid=1);
    src_lot_size_ENUM_ErrorCount := COUNT(GROUP,h.src_lot_size_Invalid=1);
    src_lot_size_LENGTHS_ErrorCount := COUNT(GROUP,h.src_lot_size_Invalid=2);
    src_lot_size_Total_ErrorCount := COUNT(GROUP,h.src_lot_size_Invalid>0);
    tax_dt_lot_size_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_lot_size_Invalid=1);
    property_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.property_type_code_Invalid=1);
    src_property_type_code_ENUM_ErrorCount := COUNT(GROUP,h.src_property_type_code_Invalid=1);
    src_property_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_property_type_code_Invalid=2);
    src_property_type_code_Total_ErrorCount := COUNT(GROUP,h.src_property_type_code_Invalid>0);
    tax_dt_property_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_property_type_code_Invalid=1);
    structure_quality_CUSTOM_ErrorCount := COUNT(GROUP,h.structure_quality_Invalid=1);
    src_structure_quality_ENUM_ErrorCount := COUNT(GROUP,h.src_structure_quality_Invalid=1);
    src_structure_quality_LENGTHS_ErrorCount := COUNT(GROUP,h.src_structure_quality_Invalid=2);
    src_structure_quality_Total_ErrorCount := COUNT(GROUP,h.src_structure_quality_Invalid>0);
    tax_dt_structure_quality_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_structure_quality_Invalid=1);
    water_CUSTOM_ErrorCount := COUNT(GROUP,h.water_Invalid=1);
    src_water_ENUM_ErrorCount := COUNT(GROUP,h.src_water_Invalid=1);
    src_water_LENGTHS_ErrorCount := COUNT(GROUP,h.src_water_Invalid=2);
    src_water_Total_ErrorCount := COUNT(GROUP,h.src_water_Invalid>0);
    tax_dt_water_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_water_Invalid=1);
    sewer_CUSTOM_ErrorCount := COUNT(GROUP,h.sewer_Invalid=1);
    src_sewer_ENUM_ErrorCount := COUNT(GROUP,h.src_sewer_Invalid=1);
    src_sewer_LENGTHS_ErrorCount := COUNT(GROUP,h.src_sewer_Invalid=2);
    src_sewer_Total_ErrorCount := COUNT(GROUP,h.src_sewer_Invalid>0);
    tax_dt_sewer_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_sewer_Invalid=1);
    assessed_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_land_value_Invalid=1);
    src_assessed_land_value_ENUM_ErrorCount := COUNT(GROUP,h.src_assessed_land_value_Invalid=1);
    src_assessed_land_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_assessed_land_value_Invalid=2);
    src_assessed_land_value_Total_ErrorCount := COUNT(GROUP,h.src_assessed_land_value_Invalid>0);
    tax_dt_assessed_land_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_assessed_land_value_Invalid=1);
    assessed_year_ALLOW_ErrorCount := COUNT(GROUP,h.assessed_year_Invalid=1);
    assessed_year_LENGTHS_ErrorCount := COUNT(GROUP,h.assessed_year_Invalid=2);
    assessed_year_Total_ErrorCount := COUNT(GROUP,h.assessed_year_Invalid>0);
    src_assessed_year_ENUM_ErrorCount := COUNT(GROUP,h.src_assessed_year_Invalid=1);
    src_assessed_year_LENGTHS_ErrorCount := COUNT(GROUP,h.src_assessed_year_Invalid=2);
    src_assessed_year_Total_ErrorCount := COUNT(GROUP,h.src_assessed_year_Invalid>0);
    tax_dt_assessed_year_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_assessed_year_Invalid=1);
    tax_amount_ALLOW_ErrorCount := COUNT(GROUP,h.tax_amount_Invalid=1);
    src_tax_amount_ENUM_ErrorCount := COUNT(GROUP,h.src_tax_amount_Invalid=1);
    src_tax_amount_LENGTHS_ErrorCount := COUNT(GROUP,h.src_tax_amount_Invalid=2);
    src_tax_amount_Total_ErrorCount := COUNT(GROUP,h.src_tax_amount_Invalid>0);
    tax_dt_tax_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_tax_amount_Invalid=1);
    tax_year_ALLOW_ErrorCount := COUNT(GROUP,h.tax_year_Invalid=1);
    tax_year_LENGTHS_ErrorCount := COUNT(GROUP,h.tax_year_Invalid=2);
    tax_year_Total_ErrorCount := COUNT(GROUP,h.tax_year_Invalid>0);
    src_tax_year_ENUM_ErrorCount := COUNT(GROUP,h.src_tax_year_Invalid=1);
    src_tax_year_LENGTHS_ErrorCount := COUNT(GROUP,h.src_tax_year_Invalid=2);
    src_tax_year_Total_ErrorCount := COUNT(GROUP,h.src_tax_year_Invalid>0);
    market_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.market_land_value_Invalid=1);
    src_market_land_value_ENUM_ErrorCount := COUNT(GROUP,h.src_market_land_value_Invalid=1);
    src_market_land_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_market_land_value_Invalid=2);
    src_market_land_value_Total_ErrorCount := COUNT(GROUP,h.src_market_land_value_Invalid>0);
    tax_dt_market_land_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_market_land_value_Invalid=1);
    improvement_value_ALLOW_ErrorCount := COUNT(GROUP,h.improvement_value_Invalid=1);
    src_improvement_value_ENUM_ErrorCount := COUNT(GROUP,h.src_improvement_value_Invalid=1);
    src_improvement_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_improvement_value_Invalid=2);
    src_improvement_value_Total_ErrorCount := COUNT(GROUP,h.src_improvement_value_Invalid>0);
    tax_dt_improvement_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_improvement_value_Invalid=1);
    src_percent_improved_ENUM_ErrorCount := COUNT(GROUP,h.src_percent_improved_Invalid=1);
    src_percent_improved_LENGTHS_ErrorCount := COUNT(GROUP,h.src_percent_improved_Invalid=2);
    src_percent_improved_Total_ErrorCount := COUNT(GROUP,h.src_percent_improved_Invalid>0);
    tax_dt_percent_improved_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_percent_improved_Invalid=1);
    total_assessed_value_ALLOW_ErrorCount := COUNT(GROUP,h.total_assessed_value_Invalid=1);
    src_total_assessed_value_ENUM_ErrorCount := COUNT(GROUP,h.src_total_assessed_value_Invalid=1);
    src_total_assessed_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_total_assessed_value_Invalid=2);
    src_total_assessed_value_Total_ErrorCount := COUNT(GROUP,h.src_total_assessed_value_Invalid>0);
    tax_dt_total_assessed_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_total_assessed_value_Invalid=1);
    total_calculated_value_ALLOW_ErrorCount := COUNT(GROUP,h.total_calculated_value_Invalid=1);
    src_total_calculated_value_ENUM_ErrorCount := COUNT(GROUP,h.src_total_calculated_value_Invalid=1);
    src_total_calculated_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_total_calculated_value_Invalid=2);
    src_total_calculated_value_Total_ErrorCount := COUNT(GROUP,h.src_total_calculated_value_Invalid>0);
    tax_dt_total_calculated_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_total_calculated_value_Invalid=1);
    total_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.total_land_value_Invalid=1);
    src_total_land_value_ENUM_ErrorCount := COUNT(GROUP,h.src_total_land_value_Invalid=1);
    src_total_land_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_total_land_value_Invalid=2);
    src_total_land_value_Total_ErrorCount := COUNT(GROUP,h.src_total_land_value_Invalid>0);
    tax_dt_total_land_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_total_land_value_Invalid=1);
    total_market_value_ALLOW_ErrorCount := COUNT(GROUP,h.total_market_value_Invalid=1);
    src_total_market_value_ENUM_ErrorCount := COUNT(GROUP,h.src_total_market_value_Invalid=1);
    src_total_market_value_LENGTHS_ErrorCount := COUNT(GROUP,h.src_total_market_value_Invalid=2);
    src_total_market_value_Total_ErrorCount := COUNT(GROUP,h.src_total_market_value_Invalid>0);
    tax_dt_total_market_value_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_total_market_value_Invalid=1);
    floor_type_CUSTOM_ErrorCount := COUNT(GROUP,h.floor_type_Invalid=1);
    src_floor_type_ENUM_ErrorCount := COUNT(GROUP,h.src_floor_type_Invalid=1);
    src_floor_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_floor_type_Invalid=2);
    src_floor_type_Total_ErrorCount := COUNT(GROUP,h.src_floor_type_Invalid>0);
    tax_dt_floor_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_floor_type_Invalid=1);
    frame_type_CUSTOM_ErrorCount := COUNT(GROUP,h.frame_type_Invalid=1);
    src_frame_type_ENUM_ErrorCount := COUNT(GROUP,h.src_frame_type_Invalid=1);
    src_frame_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_frame_type_Invalid=2);
    src_frame_type_Total_ErrorCount := COUNT(GROUP,h.src_frame_type_Invalid>0);
    tax_dt_frame_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_frame_type_Invalid=1);
    fuel_type_CUSTOM_ErrorCount := COUNT(GROUP,h.fuel_type_Invalid=1);
    src_fuel_type_ENUM_ErrorCount := COUNT(GROUP,h.src_fuel_type_Invalid=1);
    src_fuel_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_fuel_type_Invalid=2);
    src_fuel_type_Total_ErrorCount := COUNT(GROUP,h.src_fuel_type_Invalid>0);
    tax_dt_fuel_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_fuel_type_Invalid=1);
    no_of_bath_fixtures_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_bath_fixtures_Invalid=1);
    src_no_of_bath_fixtures_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_bath_fixtures_Invalid=1);
    src_no_of_bath_fixtures_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_bath_fixtures_Invalid=2);
    src_no_of_bath_fixtures_Total_ErrorCount := COUNT(GROUP,h.src_no_of_bath_fixtures_Invalid>0);
    tax_dt_no_of_bath_fixtures_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_bath_fixtures_Invalid=1);
    no_of_rooms_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_rooms_Invalid=1);
    src_no_of_rooms_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_rooms_Invalid=1);
    src_no_of_rooms_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_rooms_Invalid=2);
    src_no_of_rooms_Total_ErrorCount := COUNT(GROUP,h.src_no_of_rooms_Invalid>0);
    tax_dt_no_of_rooms_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_rooms_Invalid=1);
    no_of_units_ALLOW_ErrorCount := COUNT(GROUP,h.no_of_units_Invalid=1);
    src_no_of_units_ENUM_ErrorCount := COUNT(GROUP,h.src_no_of_units_Invalid=1);
    src_no_of_units_LENGTHS_ErrorCount := COUNT(GROUP,h.src_no_of_units_Invalid=2);
    src_no_of_units_Total_ErrorCount := COUNT(GROUP,h.src_no_of_units_Invalid>0);
    tax_dt_no_of_units_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_no_of_units_Invalid=1);
    style_type_CUSTOM_ErrorCount := COUNT(GROUP,h.style_type_Invalid=1);
    src_style_type_ENUM_ErrorCount := COUNT(GROUP,h.src_style_type_Invalid=1);
    src_style_type_LENGTHS_ErrorCount := COUNT(GROUP,h.src_style_type_Invalid=2);
    src_style_type_Total_ErrorCount := COUNT(GROUP,h.src_style_type_Invalid>0);
    tax_dt_style_type_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_style_type_Invalid=1);
    assessment_document_number_ALLOW_ErrorCount := COUNT(GROUP,h.assessment_document_number_Invalid=1);
    src_assessment_document_number_ENUM_ErrorCount := COUNT(GROUP,h.src_assessment_document_number_Invalid=1);
    src_assessment_document_number_LENGTHS_ErrorCount := COUNT(GROUP,h.src_assessment_document_number_Invalid=2);
    src_assessment_document_number_Total_ErrorCount := COUNT(GROUP,h.src_assessment_document_number_Invalid>0);
    tax_dt_assessment_document_number_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_assessment_document_number_Invalid=1);
    assessment_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.assessment_recording_date_Invalid=1);
    src_assessment_recording_date_ENUM_ErrorCount := COUNT(GROUP,h.src_assessment_recording_date_Invalid=1);
    src_assessment_recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.src_assessment_recording_date_Invalid=2);
    src_assessment_recording_date_Total_ErrorCount := COUNT(GROUP,h.src_assessment_recording_date_Invalid>0);
    tax_dt_assessment_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.tax_dt_assessment_recording_date_Invalid=1);
    deed_document_number_ALLOW_ErrorCount := COUNT(GROUP,h.deed_document_number_Invalid=1);
    src_deed_document_number_ENUM_ErrorCount := COUNT(GROUP,h.src_deed_document_number_Invalid=1);
    src_deed_document_number_LENGTHS_ErrorCount := COUNT(GROUP,h.src_deed_document_number_Invalid=2);
    src_deed_document_number_Total_ErrorCount := COUNT(GROUP,h.src_deed_document_number_Invalid>0);
    rec_dt_deed_document_number_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_deed_document_number_Invalid=1);
    deed_recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.deed_recording_date_Invalid=1);
    src_deed_recording_date_ENUM_ErrorCount := COUNT(GROUP,h.src_deed_recording_date_Invalid=1);
    src_deed_recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.src_deed_recording_date_Invalid=2);
    src_deed_recording_date_Total_ErrorCount := COUNT(GROUP,h.src_deed_recording_date_Invalid>0);
    full_part_sale_CUSTOM_ErrorCount := COUNT(GROUP,h.full_part_sale_Invalid=1);
    src_full_part_sale_ENUM_ErrorCount := COUNT(GROUP,h.src_full_part_sale_Invalid=1);
    src_full_part_sale_LENGTHS_ErrorCount := COUNT(GROUP,h.src_full_part_sale_Invalid=2);
    src_full_part_sale_Total_ErrorCount := COUNT(GROUP,h.src_full_part_sale_Invalid>0);
    rec_dt_full_part_sale_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_full_part_sale_Invalid=1);
    sale_amount_ALLOW_ErrorCount := COUNT(GROUP,h.sale_amount_Invalid=1);
    src_sale_amount_ENUM_ErrorCount := COUNT(GROUP,h.src_sale_amount_Invalid=1);
    src_sale_amount_LENGTHS_ErrorCount := COUNT(GROUP,h.src_sale_amount_Invalid=2);
    src_sale_amount_Total_ErrorCount := COUNT(GROUP,h.src_sale_amount_Invalid>0);
    rec_dt_sale_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_sale_amount_Invalid=1);
    sale_date_CUSTOM_ErrorCount := COUNT(GROUP,h.sale_date_Invalid=1);
    src_sale_date_ENUM_ErrorCount := COUNT(GROUP,h.src_sale_date_Invalid=1);
    src_sale_date_LENGTHS_ErrorCount := COUNT(GROUP,h.src_sale_date_Invalid=2);
    src_sale_date_Total_ErrorCount := COUNT(GROUP,h.src_sale_date_Invalid>0);
    rec_dt_sale_date_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_sale_date_Invalid=1);
    sale_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sale_type_code_Invalid=1);
    src_sale_type_code_ENUM_ErrorCount := COUNT(GROUP,h.src_sale_type_code_Invalid=1);
    src_sale_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_sale_type_code_Invalid=2);
    src_sale_type_code_Total_ErrorCount := COUNT(GROUP,h.src_sale_type_code_Invalid>0);
    rec_dt_sale_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_sale_type_code_Invalid=1);
    mortgage_company_name_ALLOW_ErrorCount := COUNT(GROUP,h.mortgage_company_name_Invalid=1);
    src_mortgage_company_name_ENUM_ErrorCount := COUNT(GROUP,h.src_mortgage_company_name_Invalid=1);
    src_mortgage_company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.src_mortgage_company_name_Invalid=2);
    src_mortgage_company_name_Total_ErrorCount := COUNT(GROUP,h.src_mortgage_company_name_Invalid>0);
    rec_dt_mortgage_company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_mortgage_company_name_Invalid=1);
    loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.loan_amount_Invalid=1);
    src_loan_amount_ENUM_ErrorCount := COUNT(GROUP,h.src_loan_amount_Invalid=1);
    src_loan_amount_LENGTHS_ErrorCount := COUNT(GROUP,h.src_loan_amount_Invalid=2);
    src_loan_amount_Total_ErrorCount := COUNT(GROUP,h.src_loan_amount_Invalid>0);
    rec_dt_loan_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_loan_amount_Invalid=1);
    second_loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.second_loan_amount_Invalid=1);
    src_second_loan_amount_ENUM_ErrorCount := COUNT(GROUP,h.src_second_loan_amount_Invalid=1);
    src_second_loan_amount_LENGTHS_ErrorCount := COUNT(GROUP,h.src_second_loan_amount_Invalid=2);
    src_second_loan_amount_Total_ErrorCount := COUNT(GROUP,h.src_second_loan_amount_Invalid>0);
    rec_dt_second_loan_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_second_loan_amount_Invalid=1);
    loan_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.loan_type_code_Invalid=1);
    src_loan_type_code_ENUM_ErrorCount := COUNT(GROUP,h.src_loan_type_code_Invalid=1);
    src_loan_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_loan_type_code_Invalid=2);
    src_loan_type_code_Total_ErrorCount := COUNT(GROUP,h.src_loan_type_code_Invalid>0);
    rec_dt_loan_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_loan_type_code_Invalid=1);
    interest_rate_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.interest_rate_type_code_Invalid=1);
    src_interest_rate_type_code_ENUM_ErrorCount := COUNT(GROUP,h.src_interest_rate_type_code_Invalid=1);
    src_interest_rate_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.src_interest_rate_type_code_Invalid=2);
    src_interest_rate_type_code_Total_ErrorCount := COUNT(GROUP,h.src_interest_rate_type_code_Invalid>0);
    rec_dt_interest_rate_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_dt_interest_rate_type_code_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.tax_sortby_date_Invalid > 0 OR h.deed_sortby_date_Invalid > 0 OR h.fares_unformatted_apn_Invalid > 0 OR h.property_street_address_Invalid > 0 OR h.property_city_state_zip_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.building_square_footage_Invalid > 0 OR h.src_building_square_footage_Invalid > 0 OR h.tax_dt_building_square_footage_Invalid > 0 OR h.air_conditioning_type_Invalid > 0 OR h.src_air_conditioning_type_Invalid > 0 OR h.tax_dt_air_conditioning_type_Invalid > 0 OR h.basement_finish_Invalid > 0 OR h.src_basement_finish_Invalid > 0 OR h.tax_dt_basement_finish_Invalid > 0 OR h.construction_type_Invalid > 0 OR h.src_construction_type_Invalid > 0 OR h.tax_dt_construction_type_Invalid > 0 OR h.exterior_wall_Invalid > 0 OR h.src_exterior_wall_Invalid > 0 OR h.tax_dt_exterior_wall_Invalid > 0 OR h.fireplace_ind_Invalid > 0 OR h.src_fireplace_ind_Invalid > 0 OR h.tax_dt_fireplace_ind_Invalid > 0 OR h.fireplace_type_Invalid > 0 OR h.src_fireplace_type_Invalid > 0 OR h.tax_dt_fireplace_type_Invalid > 0 OR h.src_flood_zone_panel_Invalid > 0 OR h.tax_dt_flood_zone_panel_Invalid > 0 OR h.garage_Invalid > 0 OR h.src_garage_Invalid > 0 OR h.tax_dt_garage_Invalid > 0 OR h.first_floor_square_footage_Invalid > 0 OR h.src_first_floor_square_footage_Invalid > 0 OR h.tax_dt_first_floor_square_footage_Invalid > 0 OR h.heating_Invalid > 0 OR h.src_heating_Invalid > 0 OR h.tax_dt_heating_Invalid > 0 OR h.living_area_square_footage_Invalid > 0 OR h.src_living_area_square_footage_Invalid > 0 OR h.tax_dt_living_area_square_footage_Invalid > 0 OR h.no_of_baths_Invalid > 0 OR h.src_no_of_baths_Invalid > 0 OR h.tax_dt_no_of_baths_Invalid > 0 OR h.no_of_bedrooms_Invalid > 0 OR h.src_no_of_bedrooms_Invalid > 0 OR h.tax_dt_no_of_bedrooms_Invalid > 0 OR h.no_of_fireplaces_Invalid > 0 OR h.src_no_of_fireplaces_Invalid > 0 OR h.tax_dt_no_of_fireplaces_Invalid > 0 OR h.no_of_full_baths_Invalid > 0 OR h.src_no_of_full_baths_Invalid > 0 OR h.tax_dt_no_of_full_baths_Invalid > 0 OR h.no_of_half_baths_Invalid > 0 OR h.src_no_of_half_baths_Invalid > 0 OR h.tax_dt_no_of_half_baths_Invalid > 0 OR h.no_of_stories_Invalid > 0 OR h.src_no_of_stories_Invalid > 0 OR h.tax_dt_no_of_stories_Invalid > 0 OR h.parking_type_Invalid > 0 OR h.src_parking_type_Invalid > 0 OR h.tax_dt_parking_type_Invalid > 0 OR h.src_pool_indicator_Invalid > 0 OR h.tax_dt_pool_indicator_Invalid > 0 OR h.pool_type_Invalid > 0 OR h.src_pool_type_Invalid > 0 OR h.tax_dt_pool_type_Invalid > 0 OR h.roof_cover_Invalid > 0 OR h.src_roof_cover_Invalid > 0 OR h.tax_dt_roof_cover_Invalid > 0 OR h.year_built_Invalid > 0 OR h.src_year_built_Invalid > 0 OR h.tax_dt_year_built_Invalid > 0 OR h.foundation_Invalid > 0 OR h.src_foundation_Invalid > 0 OR h.tax_dt_foundation_Invalid > 0 OR h.basement_square_footage_Invalid > 0 OR h.src_basement_square_footage_Invalid > 0 OR h.tax_dt_basement_square_footage_Invalid > 0 OR h.effective_year_built_Invalid > 0 OR h.src_effective_year_built_Invalid > 0 OR h.tax_dt_effective_year_built_Invalid > 0 OR h.garage_square_footage_Invalid > 0 OR h.src_garage_square_footage_Invalid > 0 OR h.tax_dt_garage_square_footage_Invalid > 0 OR h.stories_type_Invalid > 0 OR h.src_stories_type_Invalid > 0 OR h.tax_dt_stories_type_Invalid > 0 OR h.apn_number_Invalid > 0 OR h.src_apn_number_Invalid > 0 OR h.tax_dt_apn_number_Invalid > 0 OR h.src_census_tract_Invalid > 0 OR h.tax_dt_census_tract_Invalid > 0 OR h.src_range_Invalid > 0 OR h.tax_dt_range_Invalid > 0 OR h.src_zoning_Invalid > 0 OR h.tax_dt_zoning_Invalid > 0 OR h.src_block_number_Invalid > 0 OR h.tax_dt_block_number_Invalid > 0 OR h.county_name_Invalid > 0 OR h.src_county_name_Invalid > 0 OR h.tax_dt_county_name_Invalid > 0 OR h.fips_code_Invalid > 0 OR h.src_fips_code_Invalid > 0 OR h.tax_dt_fips_code_Invalid > 0 OR h.src_subdivision_Invalid > 0 OR h.tax_dt_subdivision_Invalid > 0 OR h.src_municipality_Invalid > 0 OR h.tax_dt_municipality_Invalid > 0 OR h.src_township_Invalid > 0 OR h.tax_dt_township_Invalid > 0 OR h.src_homestead_exemption_ind_Invalid > 0 OR h.tax_dt_homestead_exemption_ind_Invalid > 0 OR h.land_use_code_Invalid > 0 OR h.src_land_use_code_Invalid > 0 OR h.tax_dt_land_use_code_Invalid > 0 OR h.src_latitude_Invalid > 0 OR h.tax_dt_latitude_Invalid > 0 OR h.src_longitude_Invalid > 0 OR h.tax_dt_longitude_Invalid > 0 OR h.location_influence_code_Invalid > 0 OR h.src_location_influence_code_Invalid > 0 OR h.tax_dt_location_influence_code_Invalid > 0 OR h.src_acres_Invalid > 0 OR h.tax_dt_acres_Invalid > 0 OR h.src_lot_depth_footage_Invalid > 0 OR h.tax_dt_lot_depth_footage_Invalid > 0 OR h.src_lot_front_footage_Invalid > 0 OR h.tax_dt_lot_front_footage_Invalid > 0 OR h.src_lot_number_Invalid > 0 OR h.tax_dt_lot_number_Invalid > 0 OR h.src_lot_size_Invalid > 0 OR h.tax_dt_lot_size_Invalid > 0 OR h.property_type_code_Invalid > 0 OR h.src_property_type_code_Invalid > 0 OR h.tax_dt_property_type_code_Invalid > 0 OR h.structure_quality_Invalid > 0 OR h.src_structure_quality_Invalid > 0 OR h.tax_dt_structure_quality_Invalid > 0 OR h.water_Invalid > 0 OR h.src_water_Invalid > 0 OR h.tax_dt_water_Invalid > 0 OR h.sewer_Invalid > 0 OR h.src_sewer_Invalid > 0 OR h.tax_dt_sewer_Invalid > 0 OR h.assessed_land_value_Invalid > 0 OR h.src_assessed_land_value_Invalid > 0 OR h.tax_dt_assessed_land_value_Invalid > 0 OR h.assessed_year_Invalid > 0 OR h.src_assessed_year_Invalid > 0 OR h.tax_dt_assessed_year_Invalid > 0 OR h.tax_amount_Invalid > 0 OR h.src_tax_amount_Invalid > 0 OR h.tax_dt_tax_amount_Invalid > 0 OR h.tax_year_Invalid > 0 OR h.src_tax_year_Invalid > 0 OR h.market_land_value_Invalid > 0 OR h.src_market_land_value_Invalid > 0 OR h.tax_dt_market_land_value_Invalid > 0 OR h.improvement_value_Invalid > 0 OR h.src_improvement_value_Invalid > 0 OR h.tax_dt_improvement_value_Invalid > 0 OR h.src_percent_improved_Invalid > 0 OR h.tax_dt_percent_improved_Invalid > 0 OR h.total_assessed_value_Invalid > 0 OR h.src_total_assessed_value_Invalid > 0 OR h.tax_dt_total_assessed_value_Invalid > 0 OR h.total_calculated_value_Invalid > 0 OR h.src_total_calculated_value_Invalid > 0 OR h.tax_dt_total_calculated_value_Invalid > 0 OR h.total_land_value_Invalid > 0 OR h.src_total_land_value_Invalid > 0 OR h.tax_dt_total_land_value_Invalid > 0 OR h.total_market_value_Invalid > 0 OR h.src_total_market_value_Invalid > 0 OR h.tax_dt_total_market_value_Invalid > 0 OR h.floor_type_Invalid > 0 OR h.src_floor_type_Invalid > 0 OR h.tax_dt_floor_type_Invalid > 0 OR h.frame_type_Invalid > 0 OR h.src_frame_type_Invalid > 0 OR h.tax_dt_frame_type_Invalid > 0 OR h.fuel_type_Invalid > 0 OR h.src_fuel_type_Invalid > 0 OR h.tax_dt_fuel_type_Invalid > 0 OR h.no_of_bath_fixtures_Invalid > 0 OR h.src_no_of_bath_fixtures_Invalid > 0 OR h.tax_dt_no_of_bath_fixtures_Invalid > 0 OR h.no_of_rooms_Invalid > 0 OR h.src_no_of_rooms_Invalid > 0 OR h.tax_dt_no_of_rooms_Invalid > 0 OR h.no_of_units_Invalid > 0 OR h.src_no_of_units_Invalid > 0 OR h.tax_dt_no_of_units_Invalid > 0 OR h.style_type_Invalid > 0 OR h.src_style_type_Invalid > 0 OR h.tax_dt_style_type_Invalid > 0 OR h.assessment_document_number_Invalid > 0 OR h.src_assessment_document_number_Invalid > 0 OR h.tax_dt_assessment_document_number_Invalid > 0 OR h.assessment_recording_date_Invalid > 0 OR h.src_assessment_recording_date_Invalid > 0 OR h.tax_dt_assessment_recording_date_Invalid > 0 OR h.deed_document_number_Invalid > 0 OR h.src_deed_document_number_Invalid > 0 OR h.rec_dt_deed_document_number_Invalid > 0 OR h.deed_recording_date_Invalid > 0 OR h.src_deed_recording_date_Invalid > 0 OR h.full_part_sale_Invalid > 0 OR h.src_full_part_sale_Invalid > 0 OR h.rec_dt_full_part_sale_Invalid > 0 OR h.sale_amount_Invalid > 0 OR h.src_sale_amount_Invalid > 0 OR h.rec_dt_sale_amount_Invalid > 0 OR h.sale_date_Invalid > 0 OR h.src_sale_date_Invalid > 0 OR h.rec_dt_sale_date_Invalid > 0 OR h.sale_type_code_Invalid > 0 OR h.src_sale_type_code_Invalid > 0 OR h.rec_dt_sale_type_code_Invalid > 0 OR h.mortgage_company_name_Invalid > 0 OR h.src_mortgage_company_name_Invalid > 0 OR h.rec_dt_mortgage_company_name_Invalid > 0 OR h.loan_amount_Invalid > 0 OR h.src_loan_amount_Invalid > 0 OR h.rec_dt_loan_amount_Invalid > 0 OR h.second_loan_amount_Invalid > 0 OR h.src_second_loan_amount_Invalid > 0 OR h.rec_dt_second_loan_amount_Invalid > 0 OR h.loan_type_code_Invalid > 0 OR h.src_loan_type_code_Invalid > 0 OR h.rec_dt_loan_type_code_Invalid > 0 OR h.interest_rate_type_code_Invalid > 0 OR h.src_interest_rate_type_code_Invalid > 0 OR h.rec_dt_interest_rate_type_code_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor_source,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_sortby_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_sortby_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fares_unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_building_square_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_building_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.air_conditioning_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_air_conditioning_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_air_conditioning_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_finish_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_basement_finish_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_basement_finish_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.construction_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_construction_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_construction_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exterior_wall_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_exterior_wall_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_exterior_wall_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_ind_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fireplace_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fireplace_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_flood_zone_panel_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_flood_zone_panel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.garage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_garage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_garage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_floor_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_first_floor_square_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_first_floor_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_heating_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_heating_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.living_area_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_living_area_square_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_living_area_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_baths_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_bedrooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bedrooms_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_bedrooms_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_fireplaces_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_fireplaces_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_fireplaces_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_full_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_full_baths_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_full_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_half_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_half_baths_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_half_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_stories_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_stories_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parking_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_parking_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_parking_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_pool_indicator_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_pool_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pool_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_pool_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_pool_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.roof_cover_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_roof_cover_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_roof_cover_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_built_Total_ErrorCount > 0, 1, 0) + IF(le.src_year_built_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.foundation_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_foundation_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_foundation_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_basement_square_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_basement_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.effective_year_built_Total_ErrorCount > 0, 1, 0) + IF(le.src_effective_year_built_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_effective_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.garage_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_garage_square_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_garage_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.stories_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_stories_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_stories_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apn_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_apn_number_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_apn_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_census_tract_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_census_tract_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_range_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_zoning_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_zoning_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_block_number_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_block_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_name_Total_ErrorCount > 0, 1, 0) + IF(le.src_county_name_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_code_Total_ErrorCount > 0, 1, 0) + IF(le.src_fips_code_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fips_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_subdivision_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_subdivision_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_municipality_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_municipality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_township_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_township_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_homestead_exemption_ind_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_homestead_exemption_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_land_use_code_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_latitude_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_latitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_longitude_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_longitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_influence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_location_influence_code_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_location_influence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_acres_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_acres_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_depth_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_depth_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_front_footage_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_front_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_number_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_size_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_size_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.property_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_property_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_property_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.structure_quality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_structure_quality_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_structure_quality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.water_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_water_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_water_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sewer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sewer_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_sewer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_assessed_land_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessed_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_year_Total_ErrorCount > 0, 1, 0) + IF(le.src_assessed_year_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessed_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_tax_amount_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_tax_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_year_Total_ErrorCount > 0, 1, 0) + IF(le.src_tax_year_Total_ErrorCount > 0, 1, 0) + IF(le.market_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_market_land_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_market_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_improvement_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_improvement_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_percent_improved_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_percent_improved_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_assessed_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_assessed_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_assessed_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_calculated_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_calculated_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_calculated_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_land_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_market_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_market_value_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_market_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.floor_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_floor_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_floor_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frame_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_frame_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_frame_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fuel_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_fuel_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fuel_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_bath_fixtures_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bath_fixtures_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_bath_fixtures_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_rooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_rooms_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_rooms_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_units_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_units_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.style_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_style_type_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_style_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessment_document_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_assessment_document_number_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessment_document_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessment_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_assessment_recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessment_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_document_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_deed_document_number_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_deed_document_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_deed_recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.full_part_sale_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_full_part_sale_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_full_part_sale_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_sale_amount_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sale_date_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sale_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_mortgage_company_name_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_mortgage_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_loan_amount_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_loan_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_second_loan_amount_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_second_loan_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_loan_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.interest_rate_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_interest_rate_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.rec_dt_interest_rate_type_code_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_sortby_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_sortby_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fares_unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_city_state_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.building_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_building_square_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_building_square_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_building_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.air_conditioning_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_air_conditioning_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_air_conditioning_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_air_conditioning_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_finish_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_basement_finish_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_basement_finish_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_basement_finish_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.construction_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_construction_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_construction_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_construction_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exterior_wall_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_exterior_wall_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_exterior_wall_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_exterior_wall_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fireplace_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fireplace_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fireplace_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fireplace_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_flood_zone_panel_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_flood_zone_panel_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_flood_zone_panel_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.garage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_garage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_garage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_garage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_floor_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_first_floor_square_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_first_floor_square_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_first_floor_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.heating_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_heating_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_heating_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_heating_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.living_area_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_living_area_square_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_living_area_square_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_living_area_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_baths_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_baths_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_bedrooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bedrooms_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bedrooms_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_bedrooms_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_fireplaces_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_fireplaces_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_fireplaces_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_fireplaces_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_full_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_full_baths_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_full_baths_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_full_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_half_baths_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_half_baths_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_half_baths_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_half_baths_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_stories_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_stories_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_stories_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_stories_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.parking_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_parking_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_parking_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_parking_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_pool_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_pool_indicator_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_pool_indicator_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pool_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_pool_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_pool_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_pool_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.roof_cover_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_roof_cover_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_roof_cover_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_roof_cover_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.year_built_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_built_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_year_built_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_year_built_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.foundation_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_foundation_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_foundation_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_foundation_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.basement_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_basement_square_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_basement_square_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_basement_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.effective_year_built_ALLOW_ErrorCount > 0, 1, 0) + IF(le.effective_year_built_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_effective_year_built_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_effective_year_built_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_effective_year_built_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.garage_square_footage_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_garage_square_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_garage_square_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_garage_square_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.stories_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_stories_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_stories_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_stories_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apn_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_apn_number_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_apn_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_apn_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_census_tract_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_census_tract_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_census_tract_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_range_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_zoning_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_zoning_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_zoning_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_block_number_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_block_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_block_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.src_county_name_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_county_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_code_WITHIN_FILE_ErrorCount > 0, 1, 0) + IF(le.src_fips_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fips_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fips_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_subdivision_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_subdivision_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_subdivision_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_municipality_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_municipality_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_municipality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_township_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_township_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_township_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_homestead_exemption_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_homestead_exemption_ind_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_homestead_exemption_ind_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_land_use_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_land_use_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_land_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_latitude_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_latitude_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_latitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_longitude_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_longitude_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_longitude_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.location_influence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_location_influence_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_location_influence_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_location_influence_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_acres_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_acres_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_acres_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_depth_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_lot_depth_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_depth_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_front_footage_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_lot_front_footage_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_front_footage_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_number_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_lot_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_lot_size_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_lot_size_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_lot_size_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.property_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_property_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_property_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_property_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.structure_quality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_structure_quality_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_structure_quality_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_structure_quality_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.water_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_water_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_water_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_water_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sewer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sewer_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_sewer_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_sewer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_assessed_land_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_assessed_land_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessed_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessed_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.assessed_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_assessed_year_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_assessed_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessed_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_tax_amount_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_tax_amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_tax_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.tax_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tax_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.src_tax_year_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_tax_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.market_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_market_land_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_market_land_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_market_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.improvement_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_improvement_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_improvement_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_improvement_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_percent_improved_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_percent_improved_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_percent_improved_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_assessed_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_assessed_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_total_assessed_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_assessed_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_calculated_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_calculated_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_total_calculated_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_calculated_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_land_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_land_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_total_land_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_land_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_market_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_total_market_value_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_total_market_value_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_total_market_value_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.floor_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_floor_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_floor_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_floor_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.frame_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_frame_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_frame_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_frame_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fuel_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_fuel_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_fuel_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_fuel_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_bath_fixtures_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bath_fixtures_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_bath_fixtures_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_bath_fixtures_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_rooms_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_rooms_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_rooms_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_rooms_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.no_of_units_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_no_of_units_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_no_of_units_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_no_of_units_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.style_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_style_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_style_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_style_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessment_document_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_assessment_document_number_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_assessment_document_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessment_document_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.assessment_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_assessment_recording_date_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_assessment_recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.tax_dt_assessment_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_document_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_deed_document_number_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_deed_document_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_deed_document_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deed_recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_deed_recording_date_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_deed_recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.full_part_sale_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_full_part_sale_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_full_part_sale_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_full_part_sale_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_sale_amount_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_sale_amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sale_date_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_sale_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sale_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_sale_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_sale_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_sale_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mortgage_company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_mortgage_company_name_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_mortgage_company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_mortgage_company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_loan_amount_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_loan_amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_loan_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.src_second_loan_amount_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_second_loan_amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_second_loan_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_loan_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_loan_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.interest_rate_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.src_interest_rate_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.src_interest_rate_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rec_dt_interest_rate_type_code_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor_source;
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.tax_sortby_date_Invalid,le.deed_sortby_date_Invalid,le.fares_unformatted_apn_Invalid,le.property_street_address_Invalid,le.property_city_state_zip_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.zip_Invalid,le.zip4_Invalid,le.building_square_footage_Invalid,le.src_building_square_footage_Invalid,le.tax_dt_building_square_footage_Invalid,le.air_conditioning_type_Invalid,le.src_air_conditioning_type_Invalid,le.tax_dt_air_conditioning_type_Invalid,le.basement_finish_Invalid,le.src_basement_finish_Invalid,le.tax_dt_basement_finish_Invalid,le.construction_type_Invalid,le.src_construction_type_Invalid,le.tax_dt_construction_type_Invalid,le.exterior_wall_Invalid,le.src_exterior_wall_Invalid,le.tax_dt_exterior_wall_Invalid,le.fireplace_ind_Invalid,le.src_fireplace_ind_Invalid,le.tax_dt_fireplace_ind_Invalid,le.fireplace_type_Invalid,le.src_fireplace_type_Invalid,le.tax_dt_fireplace_type_Invalid,le.src_flood_zone_panel_Invalid,le.tax_dt_flood_zone_panel_Invalid,le.garage_Invalid,le.src_garage_Invalid,le.tax_dt_garage_Invalid,le.first_floor_square_footage_Invalid,le.src_first_floor_square_footage_Invalid,le.tax_dt_first_floor_square_footage_Invalid,le.heating_Invalid,le.src_heating_Invalid,le.tax_dt_heating_Invalid,le.living_area_square_footage_Invalid,le.src_living_area_square_footage_Invalid,le.tax_dt_living_area_square_footage_Invalid,le.no_of_baths_Invalid,le.src_no_of_baths_Invalid,le.tax_dt_no_of_baths_Invalid,le.no_of_bedrooms_Invalid,le.src_no_of_bedrooms_Invalid,le.tax_dt_no_of_bedrooms_Invalid,le.no_of_fireplaces_Invalid,le.src_no_of_fireplaces_Invalid,le.tax_dt_no_of_fireplaces_Invalid,le.no_of_full_baths_Invalid,le.src_no_of_full_baths_Invalid,le.tax_dt_no_of_full_baths_Invalid,le.no_of_half_baths_Invalid,le.src_no_of_half_baths_Invalid,le.tax_dt_no_of_half_baths_Invalid,le.no_of_stories_Invalid,le.src_no_of_stories_Invalid,le.tax_dt_no_of_stories_Invalid,le.parking_type_Invalid,le.src_parking_type_Invalid,le.tax_dt_parking_type_Invalid,le.src_pool_indicator_Invalid,le.tax_dt_pool_indicator_Invalid,le.pool_type_Invalid,le.src_pool_type_Invalid,le.tax_dt_pool_type_Invalid,le.roof_cover_Invalid,le.src_roof_cover_Invalid,le.tax_dt_roof_cover_Invalid,le.year_built_Invalid,le.src_year_built_Invalid,le.tax_dt_year_built_Invalid,le.foundation_Invalid,le.src_foundation_Invalid,le.tax_dt_foundation_Invalid,le.basement_square_footage_Invalid,le.src_basement_square_footage_Invalid,le.tax_dt_basement_square_footage_Invalid,le.effective_year_built_Invalid,le.src_effective_year_built_Invalid,le.tax_dt_effective_year_built_Invalid,le.garage_square_footage_Invalid,le.src_garage_square_footage_Invalid,le.tax_dt_garage_square_footage_Invalid,le.stories_type_Invalid,le.src_stories_type_Invalid,le.tax_dt_stories_type_Invalid,le.apn_number_Invalid,le.src_apn_number_Invalid,le.tax_dt_apn_number_Invalid,le.src_census_tract_Invalid,le.tax_dt_census_tract_Invalid,le.src_range_Invalid,le.tax_dt_range_Invalid,le.src_zoning_Invalid,le.tax_dt_zoning_Invalid,le.src_block_number_Invalid,le.tax_dt_block_number_Invalid,le.county_name_Invalid,le.src_county_name_Invalid,le.tax_dt_county_name_Invalid,le.fips_code_Invalid,le.src_fips_code_Invalid,le.tax_dt_fips_code_Invalid,le.src_subdivision_Invalid,le.tax_dt_subdivision_Invalid,le.src_municipality_Invalid,le.tax_dt_municipality_Invalid,le.src_township_Invalid,le.tax_dt_township_Invalid,le.src_homestead_exemption_ind_Invalid,le.tax_dt_homestead_exemption_ind_Invalid,le.land_use_code_Invalid,le.src_land_use_code_Invalid,le.tax_dt_land_use_code_Invalid,le.src_latitude_Invalid,le.tax_dt_latitude_Invalid,le.src_longitude_Invalid,le.tax_dt_longitude_Invalid,le.location_influence_code_Invalid,le.src_location_influence_code_Invalid,le.tax_dt_location_influence_code_Invalid,le.src_acres_Invalid,le.tax_dt_acres_Invalid,le.src_lot_depth_footage_Invalid,le.tax_dt_lot_depth_footage_Invalid,le.src_lot_front_footage_Invalid,le.tax_dt_lot_front_footage_Invalid,le.src_lot_number_Invalid,le.tax_dt_lot_number_Invalid,le.src_lot_size_Invalid,le.tax_dt_lot_size_Invalid,le.property_type_code_Invalid,le.src_property_type_code_Invalid,le.tax_dt_property_type_code_Invalid,le.structure_quality_Invalid,le.src_structure_quality_Invalid,le.tax_dt_structure_quality_Invalid,le.water_Invalid,le.src_water_Invalid,le.tax_dt_water_Invalid,le.sewer_Invalid,le.src_sewer_Invalid,le.tax_dt_sewer_Invalid,le.assessed_land_value_Invalid,le.src_assessed_land_value_Invalid,le.tax_dt_assessed_land_value_Invalid,le.assessed_year_Invalid,le.src_assessed_year_Invalid,le.tax_dt_assessed_year_Invalid,le.tax_amount_Invalid,le.src_tax_amount_Invalid,le.tax_dt_tax_amount_Invalid,le.tax_year_Invalid,le.src_tax_year_Invalid,le.market_land_value_Invalid,le.src_market_land_value_Invalid,le.tax_dt_market_land_value_Invalid,le.improvement_value_Invalid,le.src_improvement_value_Invalid,le.tax_dt_improvement_value_Invalid,le.src_percent_improved_Invalid,le.tax_dt_percent_improved_Invalid,le.total_assessed_value_Invalid,le.src_total_assessed_value_Invalid,le.tax_dt_total_assessed_value_Invalid,le.total_calculated_value_Invalid,le.src_total_calculated_value_Invalid,le.tax_dt_total_calculated_value_Invalid,le.total_land_value_Invalid,le.src_total_land_value_Invalid,le.tax_dt_total_land_value_Invalid,le.total_market_value_Invalid,le.src_total_market_value_Invalid,le.tax_dt_total_market_value_Invalid,le.floor_type_Invalid,le.src_floor_type_Invalid,le.tax_dt_floor_type_Invalid,le.frame_type_Invalid,le.src_frame_type_Invalid,le.tax_dt_frame_type_Invalid,le.fuel_type_Invalid,le.src_fuel_type_Invalid,le.tax_dt_fuel_type_Invalid,le.no_of_bath_fixtures_Invalid,le.src_no_of_bath_fixtures_Invalid,le.tax_dt_no_of_bath_fixtures_Invalid,le.no_of_rooms_Invalid,le.src_no_of_rooms_Invalid,le.tax_dt_no_of_rooms_Invalid,le.no_of_units_Invalid,le.src_no_of_units_Invalid,le.tax_dt_no_of_units_Invalid,le.style_type_Invalid,le.src_style_type_Invalid,le.tax_dt_style_type_Invalid,le.assessment_document_number_Invalid,le.src_assessment_document_number_Invalid,le.tax_dt_assessment_document_number_Invalid,le.assessment_recording_date_Invalid,le.src_assessment_recording_date_Invalid,le.tax_dt_assessment_recording_date_Invalid,le.deed_document_number_Invalid,le.src_deed_document_number_Invalid,le.rec_dt_deed_document_number_Invalid,le.deed_recording_date_Invalid,le.src_deed_recording_date_Invalid,le.full_part_sale_Invalid,le.src_full_part_sale_Invalid,le.rec_dt_full_part_sale_Invalid,le.sale_amount_Invalid,le.src_sale_amount_Invalid,le.rec_dt_sale_amount_Invalid,le.sale_date_Invalid,le.src_sale_date_Invalid,le.rec_dt_sale_date_Invalid,le.sale_type_code_Invalid,le.src_sale_type_code_Invalid,le.rec_dt_sale_type_code_Invalid,le.mortgage_company_name_Invalid,le.src_mortgage_company_name_Invalid,le.rec_dt_mortgage_company_name_Invalid,le.loan_amount_Invalid,le.src_loan_amount_Invalid,le.rec_dt_loan_amount_Invalid,le.second_loan_amount_Invalid,le.src_second_loan_amount_Invalid,le.rec_dt_second_loan_amount_Invalid,le.loan_type_code_Invalid,le.src_loan_type_code_Invalid,le.rec_dt_loan_type_code_Invalid,le.interest_rate_type_code_Invalid,le.src_interest_rate_type_code_Invalid,le.rec_dt_interest_rate_type_code_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_tax_sortby_date(le.tax_sortby_date_Invalid),Fields.InvalidMessage_deed_sortby_date(le.deed_sortby_date_Invalid),Fields.InvalidMessage_fares_unformatted_apn(le.fares_unformatted_apn_Invalid),Fields.InvalidMessage_property_street_address(le.property_street_address_Invalid),Fields.InvalidMessage_property_city_state_zip(le.property_city_state_zip_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_building_square_footage(le.building_square_footage_Invalid),Fields.InvalidMessage_src_building_square_footage(le.src_building_square_footage_Invalid),Fields.InvalidMessage_tax_dt_building_square_footage(le.tax_dt_building_square_footage_Invalid),Fields.InvalidMessage_air_conditioning_type(le.air_conditioning_type_Invalid),Fields.InvalidMessage_src_air_conditioning_type(le.src_air_conditioning_type_Invalid),Fields.InvalidMessage_tax_dt_air_conditioning_type(le.tax_dt_air_conditioning_type_Invalid),Fields.InvalidMessage_basement_finish(le.basement_finish_Invalid),Fields.InvalidMessage_src_basement_finish(le.src_basement_finish_Invalid),Fields.InvalidMessage_tax_dt_basement_finish(le.tax_dt_basement_finish_Invalid),Fields.InvalidMessage_construction_type(le.construction_type_Invalid),Fields.InvalidMessage_src_construction_type(le.src_construction_type_Invalid),Fields.InvalidMessage_tax_dt_construction_type(le.tax_dt_construction_type_Invalid),Fields.InvalidMessage_exterior_wall(le.exterior_wall_Invalid),Fields.InvalidMessage_src_exterior_wall(le.src_exterior_wall_Invalid),Fields.InvalidMessage_tax_dt_exterior_wall(le.tax_dt_exterior_wall_Invalid),Fields.InvalidMessage_fireplace_ind(le.fireplace_ind_Invalid),Fields.InvalidMessage_src_fireplace_ind(le.src_fireplace_ind_Invalid),Fields.InvalidMessage_tax_dt_fireplace_ind(le.tax_dt_fireplace_ind_Invalid),Fields.InvalidMessage_fireplace_type(le.fireplace_type_Invalid),Fields.InvalidMessage_src_fireplace_type(le.src_fireplace_type_Invalid),Fields.InvalidMessage_tax_dt_fireplace_type(le.tax_dt_fireplace_type_Invalid),Fields.InvalidMessage_src_flood_zone_panel(le.src_flood_zone_panel_Invalid),Fields.InvalidMessage_tax_dt_flood_zone_panel(le.tax_dt_flood_zone_panel_Invalid),Fields.InvalidMessage_garage(le.garage_Invalid),Fields.InvalidMessage_src_garage(le.src_garage_Invalid),Fields.InvalidMessage_tax_dt_garage(le.tax_dt_garage_Invalid),Fields.InvalidMessage_first_floor_square_footage(le.first_floor_square_footage_Invalid),Fields.InvalidMessage_src_first_floor_square_footage(le.src_first_floor_square_footage_Invalid),Fields.InvalidMessage_tax_dt_first_floor_square_footage(le.tax_dt_first_floor_square_footage_Invalid),Fields.InvalidMessage_heating(le.heating_Invalid),Fields.InvalidMessage_src_heating(le.src_heating_Invalid),Fields.InvalidMessage_tax_dt_heating(le.tax_dt_heating_Invalid),Fields.InvalidMessage_living_area_square_footage(le.living_area_square_footage_Invalid),Fields.InvalidMessage_src_living_area_square_footage(le.src_living_area_square_footage_Invalid),Fields.InvalidMessage_tax_dt_living_area_square_footage(le.tax_dt_living_area_square_footage_Invalid),Fields.InvalidMessage_no_of_baths(le.no_of_baths_Invalid),Fields.InvalidMessage_src_no_of_baths(le.src_no_of_baths_Invalid),Fields.InvalidMessage_tax_dt_no_of_baths(le.tax_dt_no_of_baths_Invalid),Fields.InvalidMessage_no_of_bedrooms(le.no_of_bedrooms_Invalid),Fields.InvalidMessage_src_no_of_bedrooms(le.src_no_of_bedrooms_Invalid),Fields.InvalidMessage_tax_dt_no_of_bedrooms(le.tax_dt_no_of_bedrooms_Invalid),Fields.InvalidMessage_no_of_fireplaces(le.no_of_fireplaces_Invalid),Fields.InvalidMessage_src_no_of_fireplaces(le.src_no_of_fireplaces_Invalid),Fields.InvalidMessage_tax_dt_no_of_fireplaces(le.tax_dt_no_of_fireplaces_Invalid),Fields.InvalidMessage_no_of_full_baths(le.no_of_full_baths_Invalid),Fields.InvalidMessage_src_no_of_full_baths(le.src_no_of_full_baths_Invalid),Fields.InvalidMessage_tax_dt_no_of_full_baths(le.tax_dt_no_of_full_baths_Invalid),Fields.InvalidMessage_no_of_half_baths(le.no_of_half_baths_Invalid),Fields.InvalidMessage_src_no_of_half_baths(le.src_no_of_half_baths_Invalid),Fields.InvalidMessage_tax_dt_no_of_half_baths(le.tax_dt_no_of_half_baths_Invalid),Fields.InvalidMessage_no_of_stories(le.no_of_stories_Invalid),Fields.InvalidMessage_src_no_of_stories(le.src_no_of_stories_Invalid),Fields.InvalidMessage_tax_dt_no_of_stories(le.tax_dt_no_of_stories_Invalid),Fields.InvalidMessage_parking_type(le.parking_type_Invalid),Fields.InvalidMessage_src_parking_type(le.src_parking_type_Invalid),Fields.InvalidMessage_tax_dt_parking_type(le.tax_dt_parking_type_Invalid),Fields.InvalidMessage_src_pool_indicator(le.src_pool_indicator_Invalid),Fields.InvalidMessage_tax_dt_pool_indicator(le.tax_dt_pool_indicator_Invalid),Fields.InvalidMessage_pool_type(le.pool_type_Invalid),Fields.InvalidMessage_src_pool_type(le.src_pool_type_Invalid),Fields.InvalidMessage_tax_dt_pool_type(le.tax_dt_pool_type_Invalid),Fields.InvalidMessage_roof_cover(le.roof_cover_Invalid),Fields.InvalidMessage_src_roof_cover(le.src_roof_cover_Invalid),Fields.InvalidMessage_tax_dt_roof_cover(le.tax_dt_roof_cover_Invalid),Fields.InvalidMessage_year_built(le.year_built_Invalid),Fields.InvalidMessage_src_year_built(le.src_year_built_Invalid),Fields.InvalidMessage_tax_dt_year_built(le.tax_dt_year_built_Invalid),Fields.InvalidMessage_foundation(le.foundation_Invalid),Fields.InvalidMessage_src_foundation(le.src_foundation_Invalid),Fields.InvalidMessage_tax_dt_foundation(le.tax_dt_foundation_Invalid),Fields.InvalidMessage_basement_square_footage(le.basement_square_footage_Invalid),Fields.InvalidMessage_src_basement_square_footage(le.src_basement_square_footage_Invalid),Fields.InvalidMessage_tax_dt_basement_square_footage(le.tax_dt_basement_square_footage_Invalid),Fields.InvalidMessage_effective_year_built(le.effective_year_built_Invalid),Fields.InvalidMessage_src_effective_year_built(le.src_effective_year_built_Invalid),Fields.InvalidMessage_tax_dt_effective_year_built(le.tax_dt_effective_year_built_Invalid),Fields.InvalidMessage_garage_square_footage(le.garage_square_footage_Invalid),Fields.InvalidMessage_src_garage_square_footage(le.src_garage_square_footage_Invalid),Fields.InvalidMessage_tax_dt_garage_square_footage(le.tax_dt_garage_square_footage_Invalid),Fields.InvalidMessage_stories_type(le.stories_type_Invalid),Fields.InvalidMessage_src_stories_type(le.src_stories_type_Invalid),Fields.InvalidMessage_tax_dt_stories_type(le.tax_dt_stories_type_Invalid),Fields.InvalidMessage_apn_number(le.apn_number_Invalid),Fields.InvalidMessage_src_apn_number(le.src_apn_number_Invalid),Fields.InvalidMessage_tax_dt_apn_number(le.tax_dt_apn_number_Invalid),Fields.InvalidMessage_src_census_tract(le.src_census_tract_Invalid),Fields.InvalidMessage_tax_dt_census_tract(le.tax_dt_census_tract_Invalid),Fields.InvalidMessage_src_range(le.src_range_Invalid),Fields.InvalidMessage_tax_dt_range(le.tax_dt_range_Invalid),Fields.InvalidMessage_src_zoning(le.src_zoning_Invalid),Fields.InvalidMessage_tax_dt_zoning(le.tax_dt_zoning_Invalid),Fields.InvalidMessage_src_block_number(le.src_block_number_Invalid),Fields.InvalidMessage_tax_dt_block_number(le.tax_dt_block_number_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_src_county_name(le.src_county_name_Invalid),Fields.InvalidMessage_tax_dt_county_name(le.tax_dt_county_name_Invalid),Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Fields.InvalidMessage_src_fips_code(le.src_fips_code_Invalid),Fields.InvalidMessage_tax_dt_fips_code(le.tax_dt_fips_code_Invalid),Fields.InvalidMessage_src_subdivision(le.src_subdivision_Invalid),Fields.InvalidMessage_tax_dt_subdivision(le.tax_dt_subdivision_Invalid),Fields.InvalidMessage_src_municipality(le.src_municipality_Invalid),Fields.InvalidMessage_tax_dt_municipality(le.tax_dt_municipality_Invalid),Fields.InvalidMessage_src_township(le.src_township_Invalid),Fields.InvalidMessage_tax_dt_township(le.tax_dt_township_Invalid),Fields.InvalidMessage_src_homestead_exemption_ind(le.src_homestead_exemption_ind_Invalid),Fields.InvalidMessage_tax_dt_homestead_exemption_ind(le.tax_dt_homestead_exemption_ind_Invalid),Fields.InvalidMessage_land_use_code(le.land_use_code_Invalid),Fields.InvalidMessage_src_land_use_code(le.src_land_use_code_Invalid),Fields.InvalidMessage_tax_dt_land_use_code(le.tax_dt_land_use_code_Invalid),Fields.InvalidMessage_src_latitude(le.src_latitude_Invalid),Fields.InvalidMessage_tax_dt_latitude(le.tax_dt_latitude_Invalid),Fields.InvalidMessage_src_longitude(le.src_longitude_Invalid),Fields.InvalidMessage_tax_dt_longitude(le.tax_dt_longitude_Invalid),Fields.InvalidMessage_location_influence_code(le.location_influence_code_Invalid),Fields.InvalidMessage_src_location_influence_code(le.src_location_influence_code_Invalid),Fields.InvalidMessage_tax_dt_location_influence_code(le.tax_dt_location_influence_code_Invalid),Fields.InvalidMessage_src_acres(le.src_acres_Invalid),Fields.InvalidMessage_tax_dt_acres(le.tax_dt_acres_Invalid),Fields.InvalidMessage_src_lot_depth_footage(le.src_lot_depth_footage_Invalid),Fields.InvalidMessage_tax_dt_lot_depth_footage(le.tax_dt_lot_depth_footage_Invalid),Fields.InvalidMessage_src_lot_front_footage(le.src_lot_front_footage_Invalid),Fields.InvalidMessage_tax_dt_lot_front_footage(le.tax_dt_lot_front_footage_Invalid),Fields.InvalidMessage_src_lot_number(le.src_lot_number_Invalid),Fields.InvalidMessage_tax_dt_lot_number(le.tax_dt_lot_number_Invalid),Fields.InvalidMessage_src_lot_size(le.src_lot_size_Invalid),Fields.InvalidMessage_tax_dt_lot_size(le.tax_dt_lot_size_Invalid),Fields.InvalidMessage_property_type_code(le.property_type_code_Invalid),Fields.InvalidMessage_src_property_type_code(le.src_property_type_code_Invalid),Fields.InvalidMessage_tax_dt_property_type_code(le.tax_dt_property_type_code_Invalid),Fields.InvalidMessage_structure_quality(le.structure_quality_Invalid),Fields.InvalidMessage_src_structure_quality(le.src_structure_quality_Invalid),Fields.InvalidMessage_tax_dt_structure_quality(le.tax_dt_structure_quality_Invalid),Fields.InvalidMessage_water(le.water_Invalid),Fields.InvalidMessage_src_water(le.src_water_Invalid),Fields.InvalidMessage_tax_dt_water(le.tax_dt_water_Invalid),Fields.InvalidMessage_sewer(le.sewer_Invalid),Fields.InvalidMessage_src_sewer(le.src_sewer_Invalid),Fields.InvalidMessage_tax_dt_sewer(le.tax_dt_sewer_Invalid),Fields.InvalidMessage_assessed_land_value(le.assessed_land_value_Invalid),Fields.InvalidMessage_src_assessed_land_value(le.src_assessed_land_value_Invalid),Fields.InvalidMessage_tax_dt_assessed_land_value(le.tax_dt_assessed_land_value_Invalid),Fields.InvalidMessage_assessed_year(le.assessed_year_Invalid),Fields.InvalidMessage_src_assessed_year(le.src_assessed_year_Invalid),Fields.InvalidMessage_tax_dt_assessed_year(le.tax_dt_assessed_year_Invalid),Fields.InvalidMessage_tax_amount(le.tax_amount_Invalid),Fields.InvalidMessage_src_tax_amount(le.src_tax_amount_Invalid),Fields.InvalidMessage_tax_dt_tax_amount(le.tax_dt_tax_amount_Invalid),Fields.InvalidMessage_tax_year(le.tax_year_Invalid),Fields.InvalidMessage_src_tax_year(le.src_tax_year_Invalid),Fields.InvalidMessage_market_land_value(le.market_land_value_Invalid),Fields.InvalidMessage_src_market_land_value(le.src_market_land_value_Invalid),Fields.InvalidMessage_tax_dt_market_land_value(le.tax_dt_market_land_value_Invalid),Fields.InvalidMessage_improvement_value(le.improvement_value_Invalid),Fields.InvalidMessage_src_improvement_value(le.src_improvement_value_Invalid),Fields.InvalidMessage_tax_dt_improvement_value(le.tax_dt_improvement_value_Invalid),Fields.InvalidMessage_src_percent_improved(le.src_percent_improved_Invalid),Fields.InvalidMessage_tax_dt_percent_improved(le.tax_dt_percent_improved_Invalid),Fields.InvalidMessage_total_assessed_value(le.total_assessed_value_Invalid),Fields.InvalidMessage_src_total_assessed_value(le.src_total_assessed_value_Invalid),Fields.InvalidMessage_tax_dt_total_assessed_value(le.tax_dt_total_assessed_value_Invalid),Fields.InvalidMessage_total_calculated_value(le.total_calculated_value_Invalid),Fields.InvalidMessage_src_total_calculated_value(le.src_total_calculated_value_Invalid),Fields.InvalidMessage_tax_dt_total_calculated_value(le.tax_dt_total_calculated_value_Invalid),Fields.InvalidMessage_total_land_value(le.total_land_value_Invalid),Fields.InvalidMessage_src_total_land_value(le.src_total_land_value_Invalid),Fields.InvalidMessage_tax_dt_total_land_value(le.tax_dt_total_land_value_Invalid),Fields.InvalidMessage_total_market_value(le.total_market_value_Invalid),Fields.InvalidMessage_src_total_market_value(le.src_total_market_value_Invalid),Fields.InvalidMessage_tax_dt_total_market_value(le.tax_dt_total_market_value_Invalid),Fields.InvalidMessage_floor_type(le.floor_type_Invalid),Fields.InvalidMessage_src_floor_type(le.src_floor_type_Invalid),Fields.InvalidMessage_tax_dt_floor_type(le.tax_dt_floor_type_Invalid),Fields.InvalidMessage_frame_type(le.frame_type_Invalid),Fields.InvalidMessage_src_frame_type(le.src_frame_type_Invalid),Fields.InvalidMessage_tax_dt_frame_type(le.tax_dt_frame_type_Invalid),Fields.InvalidMessage_fuel_type(le.fuel_type_Invalid),Fields.InvalidMessage_src_fuel_type(le.src_fuel_type_Invalid),Fields.InvalidMessage_tax_dt_fuel_type(le.tax_dt_fuel_type_Invalid),Fields.InvalidMessage_no_of_bath_fixtures(le.no_of_bath_fixtures_Invalid),Fields.InvalidMessage_src_no_of_bath_fixtures(le.src_no_of_bath_fixtures_Invalid),Fields.InvalidMessage_tax_dt_no_of_bath_fixtures(le.tax_dt_no_of_bath_fixtures_Invalid),Fields.InvalidMessage_no_of_rooms(le.no_of_rooms_Invalid),Fields.InvalidMessage_src_no_of_rooms(le.src_no_of_rooms_Invalid),Fields.InvalidMessage_tax_dt_no_of_rooms(le.tax_dt_no_of_rooms_Invalid),Fields.InvalidMessage_no_of_units(le.no_of_units_Invalid),Fields.InvalidMessage_src_no_of_units(le.src_no_of_units_Invalid),Fields.InvalidMessage_tax_dt_no_of_units(le.tax_dt_no_of_units_Invalid),Fields.InvalidMessage_style_type(le.style_type_Invalid),Fields.InvalidMessage_src_style_type(le.src_style_type_Invalid),Fields.InvalidMessage_tax_dt_style_type(le.tax_dt_style_type_Invalid),Fields.InvalidMessage_assessment_document_number(le.assessment_document_number_Invalid),Fields.InvalidMessage_src_assessment_document_number(le.src_assessment_document_number_Invalid),Fields.InvalidMessage_tax_dt_assessment_document_number(le.tax_dt_assessment_document_number_Invalid),Fields.InvalidMessage_assessment_recording_date(le.assessment_recording_date_Invalid),Fields.InvalidMessage_src_assessment_recording_date(le.src_assessment_recording_date_Invalid),Fields.InvalidMessage_tax_dt_assessment_recording_date(le.tax_dt_assessment_recording_date_Invalid),Fields.InvalidMessage_deed_document_number(le.deed_document_number_Invalid),Fields.InvalidMessage_src_deed_document_number(le.src_deed_document_number_Invalid),Fields.InvalidMessage_rec_dt_deed_document_number(le.rec_dt_deed_document_number_Invalid),Fields.InvalidMessage_deed_recording_date(le.deed_recording_date_Invalid),Fields.InvalidMessage_src_deed_recording_date(le.src_deed_recording_date_Invalid),Fields.InvalidMessage_full_part_sale(le.full_part_sale_Invalid),Fields.InvalidMessage_src_full_part_sale(le.src_full_part_sale_Invalid),Fields.InvalidMessage_rec_dt_full_part_sale(le.rec_dt_full_part_sale_Invalid),Fields.InvalidMessage_sale_amount(le.sale_amount_Invalid),Fields.InvalidMessage_src_sale_amount(le.src_sale_amount_Invalid),Fields.InvalidMessage_rec_dt_sale_amount(le.rec_dt_sale_amount_Invalid),Fields.InvalidMessage_sale_date(le.sale_date_Invalid),Fields.InvalidMessage_src_sale_date(le.src_sale_date_Invalid),Fields.InvalidMessage_rec_dt_sale_date(le.rec_dt_sale_date_Invalid),Fields.InvalidMessage_sale_type_code(le.sale_type_code_Invalid),Fields.InvalidMessage_src_sale_type_code(le.src_sale_type_code_Invalid),Fields.InvalidMessage_rec_dt_sale_type_code(le.rec_dt_sale_type_code_Invalid),Fields.InvalidMessage_mortgage_company_name(le.mortgage_company_name_Invalid),Fields.InvalidMessage_src_mortgage_company_name(le.src_mortgage_company_name_Invalid),Fields.InvalidMessage_rec_dt_mortgage_company_name(le.rec_dt_mortgage_company_name_Invalid),Fields.InvalidMessage_loan_amount(le.loan_amount_Invalid),Fields.InvalidMessage_src_loan_amount(le.src_loan_amount_Invalid),Fields.InvalidMessage_rec_dt_loan_amount(le.rec_dt_loan_amount_Invalid),Fields.InvalidMessage_second_loan_amount(le.second_loan_amount_Invalid),Fields.InvalidMessage_src_second_loan_amount(le.src_second_loan_amount_Invalid),Fields.InvalidMessage_rec_dt_second_loan_amount(le.rec_dt_second_loan_amount_Invalid),Fields.InvalidMessage_loan_type_code(le.loan_type_code_Invalid),Fields.InvalidMessage_src_loan_type_code(le.src_loan_type_code_Invalid),Fields.InvalidMessage_rec_dt_loan_type_code(le.rec_dt_loan_type_code_Invalid),Fields.InvalidMessage_interest_rate_type_code(le.interest_rate_type_code_Invalid),Fields.InvalidMessage_src_interest_rate_type_code(le.src_interest_rate_type_code_Invalid),Fields.InvalidMessage_rec_dt_interest_rate_type_code(le.rec_dt_interest_rate_type_code_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_sortby_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deed_sortby_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fares_unformatted_apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_city_state_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.building_square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_building_square_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_building_square_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.air_conditioning_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_air_conditioning_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_air_conditioning_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.basement_finish_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_basement_finish_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_basement_finish_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.construction_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_construction_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_construction_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.exterior_wall_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_exterior_wall_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_exterior_wall_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fireplace_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.src_fireplace_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_fireplace_ind_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fireplace_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_fireplace_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_fireplace_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_flood_zone_panel_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_flood_zone_panel_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.garage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_garage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_garage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_floor_square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_first_floor_square_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_first_floor_square_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.heating_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_heating_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_heating_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.living_area_square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_living_area_square_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_living_area_square_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_baths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_baths_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_baths_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_bedrooms_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_bedrooms_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_bedrooms_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_fireplaces_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_fireplaces_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_fireplaces_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_full_baths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_full_baths_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_full_baths_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_half_baths_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_half_baths_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_half_baths_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_stories_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_stories_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_stories_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.parking_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_parking_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_parking_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_pool_indicator_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_pool_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pool_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_pool_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_pool_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.roof_cover_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_roof_cover_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_roof_cover_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_built_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_year_built_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.foundation_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_foundation_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_foundation_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.basement_square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_basement_square_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_basement_square_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.effective_year_built_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_effective_year_built_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_effective_year_built_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.garage_square_footage_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_garage_square_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_garage_square_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.stories_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_stories_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_stories_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.apn_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_apn_number_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_apn_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_census_tract_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_census_tract_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_range_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_zoning_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_zoning_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_block_number_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_block_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.src_county_name_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_county_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','LENGTHS','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.src_fips_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_fips_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_subdivision_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_subdivision_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_municipality_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_municipality_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_township_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_township_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_homestead_exemption_ind_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_homestead_exemption_ind_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.land_use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_land_use_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_land_use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_latitude_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_latitude_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_longitude_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_longitude_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.location_influence_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_location_influence_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_location_influence_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_acres_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_acres_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_lot_depth_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_lot_depth_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_lot_front_footage_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_lot_front_footage_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_lot_number_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_lot_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_lot_size_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_lot_size_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.property_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_property_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_property_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.structure_quality_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_structure_quality_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_structure_quality_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.water_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_water_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_water_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sewer_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_sewer_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_sewer_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessed_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_assessed_land_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_assessed_land_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessed_year_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_assessed_year_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_assessed_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_tax_amount_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_tax_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.tax_year_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.src_tax_year_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.market_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_market_land_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_market_land_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.improvement_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_improvement_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_improvement_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_percent_improved_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_percent_improved_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_assessed_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_total_assessed_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_total_assessed_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_calculated_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_total_calculated_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_total_calculated_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_total_land_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_total_land_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_market_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_total_market_value_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_total_market_value_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.floor_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_floor_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_floor_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.frame_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_frame_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_frame_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fuel_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_fuel_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_fuel_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_bath_fixtures_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_bath_fixtures_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_bath_fixtures_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_rooms_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_rooms_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_rooms_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.no_of_units_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_no_of_units_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_no_of_units_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.style_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_style_type_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_style_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessment_document_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_assessment_document_number_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_assessment_document_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.assessment_recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_assessment_recording_date_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.tax_dt_assessment_recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deed_document_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_deed_document_number_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_deed_document_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deed_recording_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_deed_recording_date_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.full_part_sale_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_full_part_sale_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_full_part_sale_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sale_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_sale_amount_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_sale_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sale_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_sale_date_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_sale_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sale_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_sale_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_sale_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mortgage_company_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_mortgage_company_name_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_mortgage_company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_loan_amount_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_loan_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.src_second_loan_amount_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_second_loan_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_loan_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.interest_rate_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.src_interest_rate_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rec_dt_interest_rate_type_code_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_vendor_first_reported','dt_vendor_last_reported','tax_sortby_date','deed_sortby_date','fares_unformatted_apn','property_street_address','property_city_state_zip','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','zip','zip4','building_square_footage','src_building_square_footage','tax_dt_building_square_footage','air_conditioning_type','src_air_conditioning_type','tax_dt_air_conditioning_type','basement_finish','src_basement_finish','tax_dt_basement_finish','construction_type','src_construction_type','tax_dt_construction_type','exterior_wall','src_exterior_wall','tax_dt_exterior_wall','fireplace_ind','src_fireplace_ind','tax_dt_fireplace_ind','fireplace_type','src_fireplace_type','tax_dt_fireplace_type','src_flood_zone_panel','tax_dt_flood_zone_panel','garage','src_garage','tax_dt_garage','first_floor_square_footage','src_first_floor_square_footage','tax_dt_first_floor_square_footage','heating','src_heating','tax_dt_heating','living_area_square_footage','src_living_area_square_footage','tax_dt_living_area_square_footage','no_of_baths','src_no_of_baths','tax_dt_no_of_baths','no_of_bedrooms','src_no_of_bedrooms','tax_dt_no_of_bedrooms','no_of_fireplaces','src_no_of_fireplaces','tax_dt_no_of_fireplaces','no_of_full_baths','src_no_of_full_baths','tax_dt_no_of_full_baths','no_of_half_baths','src_no_of_half_baths','tax_dt_no_of_half_baths','no_of_stories','src_no_of_stories','tax_dt_no_of_stories','parking_type','src_parking_type','tax_dt_parking_type','src_pool_indicator','tax_dt_pool_indicator','pool_type','src_pool_type','tax_dt_pool_type','roof_cover','src_roof_cover','tax_dt_roof_cover','year_built','src_year_built','tax_dt_year_built','foundation','src_foundation','tax_dt_foundation','basement_square_footage','src_basement_square_footage','tax_dt_basement_square_footage','effective_year_built','src_effective_year_built','tax_dt_effective_year_built','garage_square_footage','src_garage_square_footage','tax_dt_garage_square_footage','stories_type','src_stories_type','tax_dt_stories_type','apn_number','src_apn_number','tax_dt_apn_number','src_census_tract','tax_dt_census_tract','src_range','tax_dt_range','src_zoning','tax_dt_zoning','src_block_number','tax_dt_block_number','county_name','src_county_name','tax_dt_county_name','fips_code','src_fips_code','tax_dt_fips_code','src_subdivision','tax_dt_subdivision','src_municipality','tax_dt_municipality','src_township','tax_dt_township','src_homestead_exemption_ind','tax_dt_homestead_exemption_ind','land_use_code','src_land_use_code','tax_dt_land_use_code','src_latitude','tax_dt_latitude','src_longitude','tax_dt_longitude','location_influence_code','src_location_influence_code','tax_dt_location_influence_code','src_acres','tax_dt_acres','src_lot_depth_footage','tax_dt_lot_depth_footage','src_lot_front_footage','tax_dt_lot_front_footage','src_lot_number','tax_dt_lot_number','src_lot_size','tax_dt_lot_size','property_type_code','src_property_type_code','tax_dt_property_type_code','structure_quality','src_structure_quality','tax_dt_structure_quality','water','src_water','tax_dt_water','sewer','src_sewer','tax_dt_sewer','assessed_land_value','src_assessed_land_value','tax_dt_assessed_land_value','assessed_year','src_assessed_year','tax_dt_assessed_year','tax_amount','src_tax_amount','tax_dt_tax_amount','tax_year','src_tax_year','market_land_value','src_market_land_value','tax_dt_market_land_value','improvement_value','src_improvement_value','tax_dt_improvement_value','src_percent_improved','tax_dt_percent_improved','total_assessed_value','src_total_assessed_value','tax_dt_total_assessed_value','total_calculated_value','src_total_calculated_value','tax_dt_total_calculated_value','total_land_value','src_total_land_value','tax_dt_total_land_value','total_market_value','src_total_market_value','tax_dt_total_market_value','floor_type','src_floor_type','tax_dt_floor_type','frame_type','src_frame_type','tax_dt_frame_type','fuel_type','src_fuel_type','tax_dt_fuel_type','no_of_bath_fixtures','src_no_of_bath_fixtures','tax_dt_no_of_bath_fixtures','no_of_rooms','src_no_of_rooms','tax_dt_no_of_rooms','no_of_units','src_no_of_units','tax_dt_no_of_units','style_type','src_style_type','tax_dt_style_type','assessment_document_number','src_assessment_document_number','tax_dt_assessment_document_number','assessment_recording_date','src_assessment_recording_date','tax_dt_assessment_recording_date','deed_document_number','src_deed_document_number','rec_dt_deed_document_number','deed_recording_date','src_deed_recording_date','full_part_sale','src_full_part_sale','rec_dt_full_part_sale','sale_amount','src_sale_amount','rec_dt_sale_amount','sale_date','src_sale_date','rec_dt_sale_date','sale_type_code','src_sale_type_code','rec_dt_sale_type_code','mortgage_company_name','src_mortgage_company_name','rec_dt_mortgage_company_name','loan_amount','src_loan_amount','rec_dt_loan_amount','second_loan_amount','src_second_loan_amount','rec_dt_second_loan_amount','loan_type_code','src_loan_type_code','rec_dt_loan_type_code','interest_rate_type_code','src_interest_rate_type_code','rec_dt_interest_rate_type_code','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_apn','invalid_address','invalid_csz','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','invalid_nums','invalid_nums','invalid_nums','invalid_vendor_source','invalid_date','invalid_air_conditioning_type_code','invalid_vendor_source','invalid_date','invalid_basement_finish_type_code','invalid_vendor_source','invalid_date','invalid_construction_type_code','invalid_vendor_source','invalid_date','invalid_exterior_walls_code','invalid_vendor_source','invalid_date','invalid_fireplace_indicator','invalid_vendor_source','invalid_date','invalid_fireplace_type','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_garage_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_heating_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_parking_type','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_pool_type','invalid_vendor_source','invalid_date','invalid_roof_type','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_foundation_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_stories_type','invalid_vendor_source','invalid_date','invalid_apn','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_county_name','invalid_vendor_source','invalid_date','invalid_fips','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_land_use','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_location_code','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_property_code','invalid_vendor_source','invalid_date','invalid_structure_quality_code','invalid_vendor_source','invalid_date','invalid_water_type','invalid_vendor_source','invalid_date','invalid_sewer_type','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_floor_cover_code','invalid_vendor_source','invalid_date','invalid_frame_code','invalid_vendor_source','invalid_date','invalid_heating_fuel_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_style_type','invalid_vendor_source','invalid_date','invalid_document_number','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_date','invalid_document_number','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_sale_code','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_date','invalid_sale_tran_code','invalid_vendor_source','invalid_date','invalid_alpha','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_mortgage_loan_type_code','invalid_vendor_source','invalid_date','invalid_financing_type_code','invalid_vendor_source','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.tax_sortby_date,(SALT311.StrType)le.deed_sortby_date,(SALT311.StrType)le.fares_unformatted_apn,(SALT311.StrType)le.property_street_address,(SALT311.StrType)le.property_city_state_zip,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.building_square_footage,(SALT311.StrType)le.src_building_square_footage,(SALT311.StrType)le.tax_dt_building_square_footage,(SALT311.StrType)le.air_conditioning_type,(SALT311.StrType)le.src_air_conditioning_type,(SALT311.StrType)le.tax_dt_air_conditioning_type,(SALT311.StrType)le.basement_finish,(SALT311.StrType)le.src_basement_finish,(SALT311.StrType)le.tax_dt_basement_finish,(SALT311.StrType)le.construction_type,(SALT311.StrType)le.src_construction_type,(SALT311.StrType)le.tax_dt_construction_type,(SALT311.StrType)le.exterior_wall,(SALT311.StrType)le.src_exterior_wall,(SALT311.StrType)le.tax_dt_exterior_wall,(SALT311.StrType)le.fireplace_ind,(SALT311.StrType)le.src_fireplace_ind,(SALT311.StrType)le.tax_dt_fireplace_ind,(SALT311.StrType)le.fireplace_type,(SALT311.StrType)le.src_fireplace_type,(SALT311.StrType)le.tax_dt_fireplace_type,(SALT311.StrType)le.src_flood_zone_panel,(SALT311.StrType)le.tax_dt_flood_zone_panel,(SALT311.StrType)le.garage,(SALT311.StrType)le.src_garage,(SALT311.StrType)le.tax_dt_garage,(SALT311.StrType)le.first_floor_square_footage,(SALT311.StrType)le.src_first_floor_square_footage,(SALT311.StrType)le.tax_dt_first_floor_square_footage,(SALT311.StrType)le.heating,(SALT311.StrType)le.src_heating,(SALT311.StrType)le.tax_dt_heating,(SALT311.StrType)le.living_area_square_footage,(SALT311.StrType)le.src_living_area_square_footage,(SALT311.StrType)le.tax_dt_living_area_square_footage,(SALT311.StrType)le.no_of_baths,(SALT311.StrType)le.src_no_of_baths,(SALT311.StrType)le.tax_dt_no_of_baths,(SALT311.StrType)le.no_of_bedrooms,(SALT311.StrType)le.src_no_of_bedrooms,(SALT311.StrType)le.tax_dt_no_of_bedrooms,(SALT311.StrType)le.no_of_fireplaces,(SALT311.StrType)le.src_no_of_fireplaces,(SALT311.StrType)le.tax_dt_no_of_fireplaces,(SALT311.StrType)le.no_of_full_baths,(SALT311.StrType)le.src_no_of_full_baths,(SALT311.StrType)le.tax_dt_no_of_full_baths,(SALT311.StrType)le.no_of_half_baths,(SALT311.StrType)le.src_no_of_half_baths,(SALT311.StrType)le.tax_dt_no_of_half_baths,(SALT311.StrType)le.no_of_stories,(SALT311.StrType)le.src_no_of_stories,(SALT311.StrType)le.tax_dt_no_of_stories,(SALT311.StrType)le.parking_type,(SALT311.StrType)le.src_parking_type,(SALT311.StrType)le.tax_dt_parking_type,(SALT311.StrType)le.src_pool_indicator,(SALT311.StrType)le.tax_dt_pool_indicator,(SALT311.StrType)le.pool_type,(SALT311.StrType)le.src_pool_type,(SALT311.StrType)le.tax_dt_pool_type,(SALT311.StrType)le.roof_cover,(SALT311.StrType)le.src_roof_cover,(SALT311.StrType)le.tax_dt_roof_cover,(SALT311.StrType)le.year_built,(SALT311.StrType)le.src_year_built,(SALT311.StrType)le.tax_dt_year_built,(SALT311.StrType)le.foundation,(SALT311.StrType)le.src_foundation,(SALT311.StrType)le.tax_dt_foundation,(SALT311.StrType)le.basement_square_footage,(SALT311.StrType)le.src_basement_square_footage,(SALT311.StrType)le.tax_dt_basement_square_footage,(SALT311.StrType)le.effective_year_built,(SALT311.StrType)le.src_effective_year_built,(SALT311.StrType)le.tax_dt_effective_year_built,(SALT311.StrType)le.garage_square_footage,(SALT311.StrType)le.src_garage_square_footage,(SALT311.StrType)le.tax_dt_garage_square_footage,(SALT311.StrType)le.stories_type,(SALT311.StrType)le.src_stories_type,(SALT311.StrType)le.tax_dt_stories_type,(SALT311.StrType)le.apn_number,(SALT311.StrType)le.src_apn_number,(SALT311.StrType)le.tax_dt_apn_number,(SALT311.StrType)le.src_census_tract,(SALT311.StrType)le.tax_dt_census_tract,(SALT311.StrType)le.src_range,(SALT311.StrType)le.tax_dt_range,(SALT311.StrType)le.src_zoning,(SALT311.StrType)le.tax_dt_zoning,(SALT311.StrType)le.src_block_number,(SALT311.StrType)le.tax_dt_block_number,(SALT311.StrType)le.county_name,(SALT311.StrType)le.src_county_name,(SALT311.StrType)le.tax_dt_county_name,(SALT311.StrType)le.fips_code,(SALT311.StrType)le.src_fips_code,(SALT311.StrType)le.tax_dt_fips_code,(SALT311.StrType)le.src_subdivision,(SALT311.StrType)le.tax_dt_subdivision,(SALT311.StrType)le.src_municipality,(SALT311.StrType)le.tax_dt_municipality,(SALT311.StrType)le.src_township,(SALT311.StrType)le.tax_dt_township,(SALT311.StrType)le.src_homestead_exemption_ind,(SALT311.StrType)le.tax_dt_homestead_exemption_ind,(SALT311.StrType)le.land_use_code,(SALT311.StrType)le.src_land_use_code,(SALT311.StrType)le.tax_dt_land_use_code,(SALT311.StrType)le.src_latitude,(SALT311.StrType)le.tax_dt_latitude,(SALT311.StrType)le.src_longitude,(SALT311.StrType)le.tax_dt_longitude,(SALT311.StrType)le.location_influence_code,(SALT311.StrType)le.src_location_influence_code,(SALT311.StrType)le.tax_dt_location_influence_code,(SALT311.StrType)le.src_acres,(SALT311.StrType)le.tax_dt_acres,(SALT311.StrType)le.src_lot_depth_footage,(SALT311.StrType)le.tax_dt_lot_depth_footage,(SALT311.StrType)le.src_lot_front_footage,(SALT311.StrType)le.tax_dt_lot_front_footage,(SALT311.StrType)le.src_lot_number,(SALT311.StrType)le.tax_dt_lot_number,(SALT311.StrType)le.src_lot_size,(SALT311.StrType)le.tax_dt_lot_size,(SALT311.StrType)le.property_type_code,(SALT311.StrType)le.src_property_type_code,(SALT311.StrType)le.tax_dt_property_type_code,(SALT311.StrType)le.structure_quality,(SALT311.StrType)le.src_structure_quality,(SALT311.StrType)le.tax_dt_structure_quality,(SALT311.StrType)le.water,(SALT311.StrType)le.src_water,(SALT311.StrType)le.tax_dt_water,(SALT311.StrType)le.sewer,(SALT311.StrType)le.src_sewer,(SALT311.StrType)le.tax_dt_sewer,(SALT311.StrType)le.assessed_land_value,(SALT311.StrType)le.src_assessed_land_value,(SALT311.StrType)le.tax_dt_assessed_land_value,(SALT311.StrType)le.assessed_year,(SALT311.StrType)le.src_assessed_year,(SALT311.StrType)le.tax_dt_assessed_year,(SALT311.StrType)le.tax_amount,(SALT311.StrType)le.src_tax_amount,(SALT311.StrType)le.tax_dt_tax_amount,(SALT311.StrType)le.tax_year,(SALT311.StrType)le.src_tax_year,(SALT311.StrType)le.market_land_value,(SALT311.StrType)le.src_market_land_value,(SALT311.StrType)le.tax_dt_market_land_value,(SALT311.StrType)le.improvement_value,(SALT311.StrType)le.src_improvement_value,(SALT311.StrType)le.tax_dt_improvement_value,(SALT311.StrType)le.src_percent_improved,(SALT311.StrType)le.tax_dt_percent_improved,(SALT311.StrType)le.total_assessed_value,(SALT311.StrType)le.src_total_assessed_value,(SALT311.StrType)le.tax_dt_total_assessed_value,(SALT311.StrType)le.total_calculated_value,(SALT311.StrType)le.src_total_calculated_value,(SALT311.StrType)le.tax_dt_total_calculated_value,(SALT311.StrType)le.total_land_value,(SALT311.StrType)le.src_total_land_value,(SALT311.StrType)le.tax_dt_total_land_value,(SALT311.StrType)le.total_market_value,(SALT311.StrType)le.src_total_market_value,(SALT311.StrType)le.tax_dt_total_market_value,(SALT311.StrType)le.floor_type,(SALT311.StrType)le.src_floor_type,(SALT311.StrType)le.tax_dt_floor_type,(SALT311.StrType)le.frame_type,(SALT311.StrType)le.src_frame_type,(SALT311.StrType)le.tax_dt_frame_type,(SALT311.StrType)le.fuel_type,(SALT311.StrType)le.src_fuel_type,(SALT311.StrType)le.tax_dt_fuel_type,(SALT311.StrType)le.no_of_bath_fixtures,(SALT311.StrType)le.src_no_of_bath_fixtures,(SALT311.StrType)le.tax_dt_no_of_bath_fixtures,(SALT311.StrType)le.no_of_rooms,(SALT311.StrType)le.src_no_of_rooms,(SALT311.StrType)le.tax_dt_no_of_rooms,(SALT311.StrType)le.no_of_units,(SALT311.StrType)le.src_no_of_units,(SALT311.StrType)le.tax_dt_no_of_units,(SALT311.StrType)le.style_type,(SALT311.StrType)le.src_style_type,(SALT311.StrType)le.tax_dt_style_type,(SALT311.StrType)le.assessment_document_number,(SALT311.StrType)le.src_assessment_document_number,(SALT311.StrType)le.tax_dt_assessment_document_number,(SALT311.StrType)le.assessment_recording_date,(SALT311.StrType)le.src_assessment_recording_date,(SALT311.StrType)le.tax_dt_assessment_recording_date,(SALT311.StrType)le.deed_document_number,(SALT311.StrType)le.src_deed_document_number,(SALT311.StrType)le.rec_dt_deed_document_number,(SALT311.StrType)le.deed_recording_date,(SALT311.StrType)le.src_deed_recording_date,(SALT311.StrType)le.full_part_sale,(SALT311.StrType)le.src_full_part_sale,(SALT311.StrType)le.rec_dt_full_part_sale,(SALT311.StrType)le.sale_amount,(SALT311.StrType)le.src_sale_amount,(SALT311.StrType)le.rec_dt_sale_amount,(SALT311.StrType)le.sale_date,(SALT311.StrType)le.src_sale_date,(SALT311.StrType)le.rec_dt_sale_date,(SALT311.StrType)le.sale_type_code,(SALT311.StrType)le.src_sale_type_code,(SALT311.StrType)le.rec_dt_sale_type_code,(SALT311.StrType)le.mortgage_company_name,(SALT311.StrType)le.src_mortgage_company_name,(SALT311.StrType)le.rec_dt_mortgage_company_name,(SALT311.StrType)le.loan_amount,(SALT311.StrType)le.src_loan_amount,(SALT311.StrType)le.rec_dt_loan_amount,(SALT311.StrType)le.second_loan_amount,(SALT311.StrType)le.src_second_loan_amount,(SALT311.StrType)le.rec_dt_second_loan_amount,(SALT311.StrType)le.loan_type_code,(SALT311.StrType)le.src_loan_type_code,(SALT311.StrType)le.rec_dt_loan_type_code,(SALT311.StrType)le.interest_rate_type_code,(SALT311.StrType)le.src_interest_rate_type_code,(SALT311.StrType)le.rec_dt_interest_rate_type_code,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,247,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Property_Characteristics) prevDS = DATASET([], Layout_Property_Characteristics)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor_source;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.tax_sortby_date_CUSTOM_ErrorCount
          ,le.deed_sortby_date_CUSTOM_ErrorCount
          ,le.fares_unformatted_apn_ALLOW_ErrorCount
          ,le.property_street_address_ALLOW_ErrorCount
          ,le.property_city_state_zip_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.building_square_footage_ALLOW_ErrorCount
          ,le.src_building_square_footage_ENUM_ErrorCount,le.src_building_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_building_square_footage_CUSTOM_ErrorCount
          ,le.air_conditioning_type_CUSTOM_ErrorCount
          ,le.src_air_conditioning_type_ENUM_ErrorCount,le.src_air_conditioning_type_LENGTHS_ErrorCount
          ,le.tax_dt_air_conditioning_type_CUSTOM_ErrorCount
          ,le.basement_finish_CUSTOM_ErrorCount
          ,le.src_basement_finish_ENUM_ErrorCount,le.src_basement_finish_LENGTHS_ErrorCount
          ,le.tax_dt_basement_finish_CUSTOM_ErrorCount
          ,le.construction_type_CUSTOM_ErrorCount
          ,le.src_construction_type_ENUM_ErrorCount,le.src_construction_type_LENGTHS_ErrorCount
          ,le.tax_dt_construction_type_CUSTOM_ErrorCount
          ,le.exterior_wall_CUSTOM_ErrorCount
          ,le.src_exterior_wall_ENUM_ErrorCount,le.src_exterior_wall_LENGTHS_ErrorCount
          ,le.tax_dt_exterior_wall_CUSTOM_ErrorCount
          ,le.fireplace_ind_ENUM_ErrorCount
          ,le.src_fireplace_ind_ENUM_ErrorCount,le.src_fireplace_ind_LENGTHS_ErrorCount
          ,le.tax_dt_fireplace_ind_CUSTOM_ErrorCount
          ,le.fireplace_type_CUSTOM_ErrorCount
          ,le.src_fireplace_type_ENUM_ErrorCount,le.src_fireplace_type_LENGTHS_ErrorCount
          ,le.tax_dt_fireplace_type_CUSTOM_ErrorCount
          ,le.src_flood_zone_panel_ENUM_ErrorCount,le.src_flood_zone_panel_LENGTHS_ErrorCount
          ,le.tax_dt_flood_zone_panel_CUSTOM_ErrorCount
          ,le.garage_CUSTOM_ErrorCount
          ,le.src_garage_ENUM_ErrorCount,le.src_garage_LENGTHS_ErrorCount
          ,le.tax_dt_garage_CUSTOM_ErrorCount
          ,le.first_floor_square_footage_ALLOW_ErrorCount
          ,le.src_first_floor_square_footage_ENUM_ErrorCount,le.src_first_floor_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_first_floor_square_footage_CUSTOM_ErrorCount
          ,le.heating_CUSTOM_ErrorCount
          ,le.src_heating_ENUM_ErrorCount,le.src_heating_LENGTHS_ErrorCount
          ,le.tax_dt_heating_CUSTOM_ErrorCount
          ,le.living_area_square_footage_ALLOW_ErrorCount
          ,le.src_living_area_square_footage_ENUM_ErrorCount,le.src_living_area_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_living_area_square_footage_CUSTOM_ErrorCount
          ,le.no_of_baths_ALLOW_ErrorCount
          ,le.src_no_of_baths_ENUM_ErrorCount,le.src_no_of_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_baths_CUSTOM_ErrorCount
          ,le.no_of_bedrooms_ALLOW_ErrorCount
          ,le.src_no_of_bedrooms_ENUM_ErrorCount,le.src_no_of_bedrooms_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_bedrooms_CUSTOM_ErrorCount
          ,le.no_of_fireplaces_ALLOW_ErrorCount
          ,le.src_no_of_fireplaces_ENUM_ErrorCount,le.src_no_of_fireplaces_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_fireplaces_CUSTOM_ErrorCount
          ,le.no_of_full_baths_ALLOW_ErrorCount
          ,le.src_no_of_full_baths_ENUM_ErrorCount,le.src_no_of_full_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_full_baths_CUSTOM_ErrorCount
          ,le.no_of_half_baths_ALLOW_ErrorCount
          ,le.src_no_of_half_baths_ENUM_ErrorCount,le.src_no_of_half_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_half_baths_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount
          ,le.src_no_of_stories_ENUM_ErrorCount,le.src_no_of_stories_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_stories_CUSTOM_ErrorCount
          ,le.parking_type_CUSTOM_ErrorCount
          ,le.src_parking_type_ENUM_ErrorCount,le.src_parking_type_LENGTHS_ErrorCount
          ,le.tax_dt_parking_type_CUSTOM_ErrorCount
          ,le.src_pool_indicator_ENUM_ErrorCount,le.src_pool_indicator_LENGTHS_ErrorCount
          ,le.tax_dt_pool_indicator_CUSTOM_ErrorCount
          ,le.pool_type_CUSTOM_ErrorCount
          ,le.src_pool_type_ENUM_ErrorCount,le.src_pool_type_LENGTHS_ErrorCount
          ,le.tax_dt_pool_type_CUSTOM_ErrorCount
          ,le.roof_cover_CUSTOM_ErrorCount
          ,le.src_roof_cover_ENUM_ErrorCount,le.src_roof_cover_LENGTHS_ErrorCount
          ,le.tax_dt_roof_cover_CUSTOM_ErrorCount
          ,le.year_built_ALLOW_ErrorCount,le.year_built_LENGTHS_ErrorCount
          ,le.src_year_built_ENUM_ErrorCount,le.src_year_built_LENGTHS_ErrorCount
          ,le.tax_dt_year_built_CUSTOM_ErrorCount
          ,le.foundation_CUSTOM_ErrorCount
          ,le.src_foundation_ENUM_ErrorCount,le.src_foundation_LENGTHS_ErrorCount
          ,le.tax_dt_foundation_CUSTOM_ErrorCount
          ,le.basement_square_footage_ALLOW_ErrorCount
          ,le.src_basement_square_footage_ENUM_ErrorCount,le.src_basement_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_basement_square_footage_CUSTOM_ErrorCount
          ,le.effective_year_built_ALLOW_ErrorCount,le.effective_year_built_LENGTHS_ErrorCount
          ,le.src_effective_year_built_ENUM_ErrorCount,le.src_effective_year_built_LENGTHS_ErrorCount
          ,le.tax_dt_effective_year_built_CUSTOM_ErrorCount
          ,le.garage_square_footage_ALLOW_ErrorCount
          ,le.src_garage_square_footage_ENUM_ErrorCount,le.src_garage_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_garage_square_footage_CUSTOM_ErrorCount
          ,le.stories_type_CUSTOM_ErrorCount
          ,le.src_stories_type_ENUM_ErrorCount,le.src_stories_type_LENGTHS_ErrorCount
          ,le.tax_dt_stories_type_CUSTOM_ErrorCount
          ,le.apn_number_ALLOW_ErrorCount
          ,le.src_apn_number_ENUM_ErrorCount,le.src_apn_number_LENGTHS_ErrorCount
          ,le.tax_dt_apn_number_CUSTOM_ErrorCount
          ,le.src_census_tract_ENUM_ErrorCount,le.src_census_tract_LENGTHS_ErrorCount
          ,le.tax_dt_census_tract_CUSTOM_ErrorCount
          ,le.src_range_ENUM_ErrorCount,le.src_range_LENGTHS_ErrorCount
          ,le.tax_dt_range_CUSTOM_ErrorCount
          ,le.src_zoning_ENUM_ErrorCount,le.src_zoning_LENGTHS_ErrorCount
          ,le.tax_dt_zoning_CUSTOM_ErrorCount
          ,le.src_block_number_ENUM_ErrorCount,le.src_block_number_LENGTHS_ErrorCount
          ,le.tax_dt_block_number_CUSTOM_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.src_county_name_ENUM_ErrorCount,le.src_county_name_LENGTHS_ErrorCount
          ,le.tax_dt_county_name_CUSTOM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.src_fips_code_ENUM_ErrorCount,le.src_fips_code_LENGTHS_ErrorCount
          ,le.tax_dt_fips_code_CUSTOM_ErrorCount
          ,le.src_subdivision_ENUM_ErrorCount,le.src_subdivision_LENGTHS_ErrorCount
          ,le.tax_dt_subdivision_CUSTOM_ErrorCount
          ,le.src_municipality_ENUM_ErrorCount,le.src_municipality_LENGTHS_ErrorCount
          ,le.tax_dt_municipality_CUSTOM_ErrorCount
          ,le.src_township_ENUM_ErrorCount,le.src_township_LENGTHS_ErrorCount
          ,le.tax_dt_township_CUSTOM_ErrorCount
          ,le.src_homestead_exemption_ind_ENUM_ErrorCount,le.src_homestead_exemption_ind_LENGTHS_ErrorCount
          ,le.tax_dt_homestead_exemption_ind_CUSTOM_ErrorCount
          ,le.land_use_code_CUSTOM_ErrorCount
          ,le.src_land_use_code_ENUM_ErrorCount,le.src_land_use_code_LENGTHS_ErrorCount
          ,le.tax_dt_land_use_code_CUSTOM_ErrorCount
          ,le.src_latitude_ENUM_ErrorCount,le.src_latitude_LENGTHS_ErrorCount
          ,le.tax_dt_latitude_CUSTOM_ErrorCount
          ,le.src_longitude_ENUM_ErrorCount,le.src_longitude_LENGTHS_ErrorCount
          ,le.tax_dt_longitude_CUSTOM_ErrorCount
          ,le.location_influence_code_CUSTOM_ErrorCount
          ,le.src_location_influence_code_ENUM_ErrorCount,le.src_location_influence_code_LENGTHS_ErrorCount
          ,le.tax_dt_location_influence_code_CUSTOM_ErrorCount
          ,le.src_acres_ENUM_ErrorCount,le.src_acres_LENGTHS_ErrorCount
          ,le.tax_dt_acres_CUSTOM_ErrorCount
          ,le.src_lot_depth_footage_ENUM_ErrorCount,le.src_lot_depth_footage_LENGTHS_ErrorCount
          ,le.tax_dt_lot_depth_footage_CUSTOM_ErrorCount
          ,le.src_lot_front_footage_ENUM_ErrorCount,le.src_lot_front_footage_LENGTHS_ErrorCount
          ,le.tax_dt_lot_front_footage_CUSTOM_ErrorCount
          ,le.src_lot_number_ENUM_ErrorCount,le.src_lot_number_LENGTHS_ErrorCount
          ,le.tax_dt_lot_number_CUSTOM_ErrorCount
          ,le.src_lot_size_ENUM_ErrorCount,le.src_lot_size_LENGTHS_ErrorCount
          ,le.tax_dt_lot_size_CUSTOM_ErrorCount
          ,le.property_type_code_CUSTOM_ErrorCount
          ,le.src_property_type_code_ENUM_ErrorCount,le.src_property_type_code_LENGTHS_ErrorCount
          ,le.tax_dt_property_type_code_CUSTOM_ErrorCount
          ,le.structure_quality_CUSTOM_ErrorCount
          ,le.src_structure_quality_ENUM_ErrorCount,le.src_structure_quality_LENGTHS_ErrorCount
          ,le.tax_dt_structure_quality_CUSTOM_ErrorCount
          ,le.water_CUSTOM_ErrorCount
          ,le.src_water_ENUM_ErrorCount,le.src_water_LENGTHS_ErrorCount
          ,le.tax_dt_water_CUSTOM_ErrorCount
          ,le.sewer_CUSTOM_ErrorCount
          ,le.src_sewer_ENUM_ErrorCount,le.src_sewer_LENGTHS_ErrorCount
          ,le.tax_dt_sewer_CUSTOM_ErrorCount
          ,le.assessed_land_value_ALLOW_ErrorCount
          ,le.src_assessed_land_value_ENUM_ErrorCount,le.src_assessed_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_assessed_land_value_CUSTOM_ErrorCount
          ,le.assessed_year_ALLOW_ErrorCount,le.assessed_year_LENGTHS_ErrorCount
          ,le.src_assessed_year_ENUM_ErrorCount,le.src_assessed_year_LENGTHS_ErrorCount
          ,le.tax_dt_assessed_year_CUSTOM_ErrorCount
          ,le.tax_amount_ALLOW_ErrorCount
          ,le.src_tax_amount_ENUM_ErrorCount,le.src_tax_amount_LENGTHS_ErrorCount
          ,le.tax_dt_tax_amount_CUSTOM_ErrorCount
          ,le.tax_year_ALLOW_ErrorCount,le.tax_year_LENGTHS_ErrorCount
          ,le.src_tax_year_ENUM_ErrorCount,le.src_tax_year_LENGTHS_ErrorCount
          ,le.market_land_value_ALLOW_ErrorCount
          ,le.src_market_land_value_ENUM_ErrorCount,le.src_market_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_market_land_value_CUSTOM_ErrorCount
          ,le.improvement_value_ALLOW_ErrorCount
          ,le.src_improvement_value_ENUM_ErrorCount,le.src_improvement_value_LENGTHS_ErrorCount
          ,le.tax_dt_improvement_value_CUSTOM_ErrorCount
          ,le.src_percent_improved_ENUM_ErrorCount,le.src_percent_improved_LENGTHS_ErrorCount
          ,le.tax_dt_percent_improved_CUSTOM_ErrorCount
          ,le.total_assessed_value_ALLOW_ErrorCount
          ,le.src_total_assessed_value_ENUM_ErrorCount,le.src_total_assessed_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_assessed_value_CUSTOM_ErrorCount
          ,le.total_calculated_value_ALLOW_ErrorCount
          ,le.src_total_calculated_value_ENUM_ErrorCount,le.src_total_calculated_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_calculated_value_CUSTOM_ErrorCount
          ,le.total_land_value_ALLOW_ErrorCount
          ,le.src_total_land_value_ENUM_ErrorCount,le.src_total_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_land_value_CUSTOM_ErrorCount
          ,le.total_market_value_ALLOW_ErrorCount
          ,le.src_total_market_value_ENUM_ErrorCount,le.src_total_market_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_market_value_CUSTOM_ErrorCount
          ,le.floor_type_CUSTOM_ErrorCount
          ,le.src_floor_type_ENUM_ErrorCount,le.src_floor_type_LENGTHS_ErrorCount
          ,le.tax_dt_floor_type_CUSTOM_ErrorCount
          ,le.frame_type_CUSTOM_ErrorCount
          ,le.src_frame_type_ENUM_ErrorCount,le.src_frame_type_LENGTHS_ErrorCount
          ,le.tax_dt_frame_type_CUSTOM_ErrorCount
          ,le.fuel_type_CUSTOM_ErrorCount
          ,le.src_fuel_type_ENUM_ErrorCount,le.src_fuel_type_LENGTHS_ErrorCount
          ,le.tax_dt_fuel_type_CUSTOM_ErrorCount
          ,le.no_of_bath_fixtures_ALLOW_ErrorCount
          ,le.src_no_of_bath_fixtures_ENUM_ErrorCount,le.src_no_of_bath_fixtures_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_bath_fixtures_CUSTOM_ErrorCount
          ,le.no_of_rooms_ALLOW_ErrorCount
          ,le.src_no_of_rooms_ENUM_ErrorCount,le.src_no_of_rooms_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_rooms_CUSTOM_ErrorCount
          ,le.no_of_units_ALLOW_ErrorCount
          ,le.src_no_of_units_ENUM_ErrorCount,le.src_no_of_units_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_units_CUSTOM_ErrorCount
          ,le.style_type_CUSTOM_ErrorCount
          ,le.src_style_type_ENUM_ErrorCount,le.src_style_type_LENGTHS_ErrorCount
          ,le.tax_dt_style_type_CUSTOM_ErrorCount
          ,le.assessment_document_number_ALLOW_ErrorCount
          ,le.src_assessment_document_number_ENUM_ErrorCount,le.src_assessment_document_number_LENGTHS_ErrorCount
          ,le.tax_dt_assessment_document_number_CUSTOM_ErrorCount
          ,le.assessment_recording_date_CUSTOM_ErrorCount
          ,le.src_assessment_recording_date_ENUM_ErrorCount,le.src_assessment_recording_date_LENGTHS_ErrorCount
          ,le.tax_dt_assessment_recording_date_CUSTOM_ErrorCount
          ,le.deed_document_number_ALLOW_ErrorCount
          ,le.src_deed_document_number_ENUM_ErrorCount,le.src_deed_document_number_LENGTHS_ErrorCount
          ,le.rec_dt_deed_document_number_CUSTOM_ErrorCount
          ,le.deed_recording_date_CUSTOM_ErrorCount
          ,le.src_deed_recording_date_ENUM_ErrorCount,le.src_deed_recording_date_LENGTHS_ErrorCount
          ,le.full_part_sale_CUSTOM_ErrorCount
          ,le.src_full_part_sale_ENUM_ErrorCount,le.src_full_part_sale_LENGTHS_ErrorCount
          ,le.rec_dt_full_part_sale_CUSTOM_ErrorCount
          ,le.sale_amount_ALLOW_ErrorCount
          ,le.src_sale_amount_ENUM_ErrorCount,le.src_sale_amount_LENGTHS_ErrorCount
          ,le.rec_dt_sale_amount_CUSTOM_ErrorCount
          ,le.sale_date_CUSTOM_ErrorCount
          ,le.src_sale_date_ENUM_ErrorCount,le.src_sale_date_LENGTHS_ErrorCount
          ,le.rec_dt_sale_date_CUSTOM_ErrorCount
          ,le.sale_type_code_CUSTOM_ErrorCount
          ,le.src_sale_type_code_ENUM_ErrorCount,le.src_sale_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_sale_type_code_CUSTOM_ErrorCount
          ,le.mortgage_company_name_ALLOW_ErrorCount
          ,le.src_mortgage_company_name_ENUM_ErrorCount,le.src_mortgage_company_name_LENGTHS_ErrorCount
          ,le.rec_dt_mortgage_company_name_CUSTOM_ErrorCount
          ,le.loan_amount_ALLOW_ErrorCount
          ,le.src_loan_amount_ENUM_ErrorCount,le.src_loan_amount_LENGTHS_ErrorCount
          ,le.rec_dt_loan_amount_CUSTOM_ErrorCount
          ,le.second_loan_amount_ALLOW_ErrorCount
          ,le.src_second_loan_amount_ENUM_ErrorCount,le.src_second_loan_amount_LENGTHS_ErrorCount
          ,le.rec_dt_second_loan_amount_CUSTOM_ErrorCount
          ,le.loan_type_code_CUSTOM_ErrorCount
          ,le.src_loan_type_code_ENUM_ErrorCount,le.src_loan_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_loan_type_code_CUSTOM_ErrorCount
          ,le.interest_rate_type_code_CUSTOM_ErrorCount
          ,le.src_interest_rate_type_code_ENUM_ErrorCount,le.src_interest_rate_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_interest_rate_type_code_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.tax_sortby_date_CUSTOM_ErrorCount
          ,le.deed_sortby_date_CUSTOM_ErrorCount
          ,le.fares_unformatted_apn_ALLOW_ErrorCount
          ,le.property_street_address_ALLOW_ErrorCount
          ,le.property_city_state_zip_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.building_square_footage_ALLOW_ErrorCount
          ,le.src_building_square_footage_ENUM_ErrorCount,le.src_building_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_building_square_footage_CUSTOM_ErrorCount
          ,le.air_conditioning_type_CUSTOM_ErrorCount
          ,le.src_air_conditioning_type_ENUM_ErrorCount,le.src_air_conditioning_type_LENGTHS_ErrorCount
          ,le.tax_dt_air_conditioning_type_CUSTOM_ErrorCount
          ,le.basement_finish_CUSTOM_ErrorCount
          ,le.src_basement_finish_ENUM_ErrorCount,le.src_basement_finish_LENGTHS_ErrorCount
          ,le.tax_dt_basement_finish_CUSTOM_ErrorCount
          ,le.construction_type_CUSTOM_ErrorCount
          ,le.src_construction_type_ENUM_ErrorCount,le.src_construction_type_LENGTHS_ErrorCount
          ,le.tax_dt_construction_type_CUSTOM_ErrorCount
          ,le.exterior_wall_CUSTOM_ErrorCount
          ,le.src_exterior_wall_ENUM_ErrorCount,le.src_exterior_wall_LENGTHS_ErrorCount
          ,le.tax_dt_exterior_wall_CUSTOM_ErrorCount
          ,le.fireplace_ind_ENUM_ErrorCount
          ,le.src_fireplace_ind_ENUM_ErrorCount,le.src_fireplace_ind_LENGTHS_ErrorCount
          ,le.tax_dt_fireplace_ind_CUSTOM_ErrorCount
          ,le.fireplace_type_CUSTOM_ErrorCount
          ,le.src_fireplace_type_ENUM_ErrorCount,le.src_fireplace_type_LENGTHS_ErrorCount
          ,le.tax_dt_fireplace_type_CUSTOM_ErrorCount
          ,le.src_flood_zone_panel_ENUM_ErrorCount,le.src_flood_zone_panel_LENGTHS_ErrorCount
          ,le.tax_dt_flood_zone_panel_CUSTOM_ErrorCount
          ,le.garage_CUSTOM_ErrorCount
          ,le.src_garage_ENUM_ErrorCount,le.src_garage_LENGTHS_ErrorCount
          ,le.tax_dt_garage_CUSTOM_ErrorCount
          ,le.first_floor_square_footage_ALLOW_ErrorCount
          ,le.src_first_floor_square_footage_ENUM_ErrorCount,le.src_first_floor_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_first_floor_square_footage_CUSTOM_ErrorCount
          ,le.heating_CUSTOM_ErrorCount
          ,le.src_heating_ENUM_ErrorCount,le.src_heating_LENGTHS_ErrorCount
          ,le.tax_dt_heating_CUSTOM_ErrorCount
          ,le.living_area_square_footage_ALLOW_ErrorCount
          ,le.src_living_area_square_footage_ENUM_ErrorCount,le.src_living_area_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_living_area_square_footage_CUSTOM_ErrorCount
          ,le.no_of_baths_ALLOW_ErrorCount
          ,le.src_no_of_baths_ENUM_ErrorCount,le.src_no_of_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_baths_CUSTOM_ErrorCount
          ,le.no_of_bedrooms_ALLOW_ErrorCount
          ,le.src_no_of_bedrooms_ENUM_ErrorCount,le.src_no_of_bedrooms_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_bedrooms_CUSTOM_ErrorCount
          ,le.no_of_fireplaces_ALLOW_ErrorCount
          ,le.src_no_of_fireplaces_ENUM_ErrorCount,le.src_no_of_fireplaces_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_fireplaces_CUSTOM_ErrorCount
          ,le.no_of_full_baths_ALLOW_ErrorCount
          ,le.src_no_of_full_baths_ENUM_ErrorCount,le.src_no_of_full_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_full_baths_CUSTOM_ErrorCount
          ,le.no_of_half_baths_ALLOW_ErrorCount
          ,le.src_no_of_half_baths_ENUM_ErrorCount,le.src_no_of_half_baths_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_half_baths_CUSTOM_ErrorCount
          ,le.no_of_stories_ALLOW_ErrorCount
          ,le.src_no_of_stories_ENUM_ErrorCount,le.src_no_of_stories_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_stories_CUSTOM_ErrorCount
          ,le.parking_type_CUSTOM_ErrorCount
          ,le.src_parking_type_ENUM_ErrorCount,le.src_parking_type_LENGTHS_ErrorCount
          ,le.tax_dt_parking_type_CUSTOM_ErrorCount
          ,le.src_pool_indicator_ENUM_ErrorCount,le.src_pool_indicator_LENGTHS_ErrorCount
          ,le.tax_dt_pool_indicator_CUSTOM_ErrorCount
          ,le.pool_type_CUSTOM_ErrorCount
          ,le.src_pool_type_ENUM_ErrorCount,le.src_pool_type_LENGTHS_ErrorCount
          ,le.tax_dt_pool_type_CUSTOM_ErrorCount
          ,le.roof_cover_CUSTOM_ErrorCount
          ,le.src_roof_cover_ENUM_ErrorCount,le.src_roof_cover_LENGTHS_ErrorCount
          ,le.tax_dt_roof_cover_CUSTOM_ErrorCount
          ,le.year_built_ALLOW_ErrorCount,le.year_built_LENGTHS_ErrorCount
          ,le.src_year_built_ENUM_ErrorCount,le.src_year_built_LENGTHS_ErrorCount
          ,le.tax_dt_year_built_CUSTOM_ErrorCount
          ,le.foundation_CUSTOM_ErrorCount
          ,le.src_foundation_ENUM_ErrorCount,le.src_foundation_LENGTHS_ErrorCount
          ,le.tax_dt_foundation_CUSTOM_ErrorCount
          ,le.basement_square_footage_ALLOW_ErrorCount
          ,le.src_basement_square_footage_ENUM_ErrorCount,le.src_basement_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_basement_square_footage_CUSTOM_ErrorCount
          ,le.effective_year_built_ALLOW_ErrorCount,le.effective_year_built_LENGTHS_ErrorCount
          ,le.src_effective_year_built_ENUM_ErrorCount,le.src_effective_year_built_LENGTHS_ErrorCount
          ,le.tax_dt_effective_year_built_CUSTOM_ErrorCount
          ,le.garage_square_footage_ALLOW_ErrorCount
          ,le.src_garage_square_footage_ENUM_ErrorCount,le.src_garage_square_footage_LENGTHS_ErrorCount
          ,le.tax_dt_garage_square_footage_CUSTOM_ErrorCount
          ,le.stories_type_CUSTOM_ErrorCount
          ,le.src_stories_type_ENUM_ErrorCount,le.src_stories_type_LENGTHS_ErrorCount
          ,le.tax_dt_stories_type_CUSTOM_ErrorCount
          ,le.apn_number_ALLOW_ErrorCount
          ,le.src_apn_number_ENUM_ErrorCount,le.src_apn_number_LENGTHS_ErrorCount
          ,le.tax_dt_apn_number_CUSTOM_ErrorCount
          ,le.src_census_tract_ENUM_ErrorCount,le.src_census_tract_LENGTHS_ErrorCount
          ,le.tax_dt_census_tract_CUSTOM_ErrorCount
          ,le.src_range_ENUM_ErrorCount,le.src_range_LENGTHS_ErrorCount
          ,le.tax_dt_range_CUSTOM_ErrorCount
          ,le.src_zoning_ENUM_ErrorCount,le.src_zoning_LENGTHS_ErrorCount
          ,le.tax_dt_zoning_CUSTOM_ErrorCount
          ,le.src_block_number_ENUM_ErrorCount,le.src_block_number_LENGTHS_ErrorCount
          ,le.tax_dt_block_number_CUSTOM_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.src_county_name_ENUM_ErrorCount,le.src_county_name_LENGTHS_ErrorCount
          ,le.tax_dt_county_name_CUSTOM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.src_fips_code_ENUM_ErrorCount,le.src_fips_code_LENGTHS_ErrorCount
          ,le.tax_dt_fips_code_CUSTOM_ErrorCount
          ,le.src_subdivision_ENUM_ErrorCount,le.src_subdivision_LENGTHS_ErrorCount
          ,le.tax_dt_subdivision_CUSTOM_ErrorCount
          ,le.src_municipality_ENUM_ErrorCount,le.src_municipality_LENGTHS_ErrorCount
          ,le.tax_dt_municipality_CUSTOM_ErrorCount
          ,le.src_township_ENUM_ErrorCount,le.src_township_LENGTHS_ErrorCount
          ,le.tax_dt_township_CUSTOM_ErrorCount
          ,le.src_homestead_exemption_ind_ENUM_ErrorCount,le.src_homestead_exemption_ind_LENGTHS_ErrorCount
          ,le.tax_dt_homestead_exemption_ind_CUSTOM_ErrorCount
          ,le.land_use_code_CUSTOM_ErrorCount
          ,le.src_land_use_code_ENUM_ErrorCount,le.src_land_use_code_LENGTHS_ErrorCount
          ,le.tax_dt_land_use_code_CUSTOM_ErrorCount
          ,le.src_latitude_ENUM_ErrorCount,le.src_latitude_LENGTHS_ErrorCount
          ,le.tax_dt_latitude_CUSTOM_ErrorCount
          ,le.src_longitude_ENUM_ErrorCount,le.src_longitude_LENGTHS_ErrorCount
          ,le.tax_dt_longitude_CUSTOM_ErrorCount
          ,le.location_influence_code_CUSTOM_ErrorCount
          ,le.src_location_influence_code_ENUM_ErrorCount,le.src_location_influence_code_LENGTHS_ErrorCount
          ,le.tax_dt_location_influence_code_CUSTOM_ErrorCount
          ,le.src_acres_ENUM_ErrorCount,le.src_acres_LENGTHS_ErrorCount
          ,le.tax_dt_acres_CUSTOM_ErrorCount
          ,le.src_lot_depth_footage_ENUM_ErrorCount,le.src_lot_depth_footage_LENGTHS_ErrorCount
          ,le.tax_dt_lot_depth_footage_CUSTOM_ErrorCount
          ,le.src_lot_front_footage_ENUM_ErrorCount,le.src_lot_front_footage_LENGTHS_ErrorCount
          ,le.tax_dt_lot_front_footage_CUSTOM_ErrorCount
          ,le.src_lot_number_ENUM_ErrorCount,le.src_lot_number_LENGTHS_ErrorCount
          ,le.tax_dt_lot_number_CUSTOM_ErrorCount
          ,le.src_lot_size_ENUM_ErrorCount,le.src_lot_size_LENGTHS_ErrorCount
          ,le.tax_dt_lot_size_CUSTOM_ErrorCount
          ,le.property_type_code_CUSTOM_ErrorCount
          ,le.src_property_type_code_ENUM_ErrorCount,le.src_property_type_code_LENGTHS_ErrorCount
          ,le.tax_dt_property_type_code_CUSTOM_ErrorCount
          ,le.structure_quality_CUSTOM_ErrorCount
          ,le.src_structure_quality_ENUM_ErrorCount,le.src_structure_quality_LENGTHS_ErrorCount
          ,le.tax_dt_structure_quality_CUSTOM_ErrorCount
          ,le.water_CUSTOM_ErrorCount
          ,le.src_water_ENUM_ErrorCount,le.src_water_LENGTHS_ErrorCount
          ,le.tax_dt_water_CUSTOM_ErrorCount
          ,le.sewer_CUSTOM_ErrorCount
          ,le.src_sewer_ENUM_ErrorCount,le.src_sewer_LENGTHS_ErrorCount
          ,le.tax_dt_sewer_CUSTOM_ErrorCount
          ,le.assessed_land_value_ALLOW_ErrorCount
          ,le.src_assessed_land_value_ENUM_ErrorCount,le.src_assessed_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_assessed_land_value_CUSTOM_ErrorCount
          ,le.assessed_year_ALLOW_ErrorCount,le.assessed_year_LENGTHS_ErrorCount
          ,le.src_assessed_year_ENUM_ErrorCount,le.src_assessed_year_LENGTHS_ErrorCount
          ,le.tax_dt_assessed_year_CUSTOM_ErrorCount
          ,le.tax_amount_ALLOW_ErrorCount
          ,le.src_tax_amount_ENUM_ErrorCount,le.src_tax_amount_LENGTHS_ErrorCount
          ,le.tax_dt_tax_amount_CUSTOM_ErrorCount
          ,le.tax_year_ALLOW_ErrorCount,le.tax_year_LENGTHS_ErrorCount
          ,le.src_tax_year_ENUM_ErrorCount,le.src_tax_year_LENGTHS_ErrorCount
          ,le.market_land_value_ALLOW_ErrorCount
          ,le.src_market_land_value_ENUM_ErrorCount,le.src_market_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_market_land_value_CUSTOM_ErrorCount
          ,le.improvement_value_ALLOW_ErrorCount
          ,le.src_improvement_value_ENUM_ErrorCount,le.src_improvement_value_LENGTHS_ErrorCount
          ,le.tax_dt_improvement_value_CUSTOM_ErrorCount
          ,le.src_percent_improved_ENUM_ErrorCount,le.src_percent_improved_LENGTHS_ErrorCount
          ,le.tax_dt_percent_improved_CUSTOM_ErrorCount
          ,le.total_assessed_value_ALLOW_ErrorCount
          ,le.src_total_assessed_value_ENUM_ErrorCount,le.src_total_assessed_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_assessed_value_CUSTOM_ErrorCount
          ,le.total_calculated_value_ALLOW_ErrorCount
          ,le.src_total_calculated_value_ENUM_ErrorCount,le.src_total_calculated_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_calculated_value_CUSTOM_ErrorCount
          ,le.total_land_value_ALLOW_ErrorCount
          ,le.src_total_land_value_ENUM_ErrorCount,le.src_total_land_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_land_value_CUSTOM_ErrorCount
          ,le.total_market_value_ALLOW_ErrorCount
          ,le.src_total_market_value_ENUM_ErrorCount,le.src_total_market_value_LENGTHS_ErrorCount
          ,le.tax_dt_total_market_value_CUSTOM_ErrorCount
          ,le.floor_type_CUSTOM_ErrorCount
          ,le.src_floor_type_ENUM_ErrorCount,le.src_floor_type_LENGTHS_ErrorCount
          ,le.tax_dt_floor_type_CUSTOM_ErrorCount
          ,le.frame_type_CUSTOM_ErrorCount
          ,le.src_frame_type_ENUM_ErrorCount,le.src_frame_type_LENGTHS_ErrorCount
          ,le.tax_dt_frame_type_CUSTOM_ErrorCount
          ,le.fuel_type_CUSTOM_ErrorCount
          ,le.src_fuel_type_ENUM_ErrorCount,le.src_fuel_type_LENGTHS_ErrorCount
          ,le.tax_dt_fuel_type_CUSTOM_ErrorCount
          ,le.no_of_bath_fixtures_ALLOW_ErrorCount
          ,le.src_no_of_bath_fixtures_ENUM_ErrorCount,le.src_no_of_bath_fixtures_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_bath_fixtures_CUSTOM_ErrorCount
          ,le.no_of_rooms_ALLOW_ErrorCount
          ,le.src_no_of_rooms_ENUM_ErrorCount,le.src_no_of_rooms_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_rooms_CUSTOM_ErrorCount
          ,le.no_of_units_ALLOW_ErrorCount
          ,le.src_no_of_units_ENUM_ErrorCount,le.src_no_of_units_LENGTHS_ErrorCount
          ,le.tax_dt_no_of_units_CUSTOM_ErrorCount
          ,le.style_type_CUSTOM_ErrorCount
          ,le.src_style_type_ENUM_ErrorCount,le.src_style_type_LENGTHS_ErrorCount
          ,le.tax_dt_style_type_CUSTOM_ErrorCount
          ,le.assessment_document_number_ALLOW_ErrorCount
          ,le.src_assessment_document_number_ENUM_ErrorCount,le.src_assessment_document_number_LENGTHS_ErrorCount
          ,le.tax_dt_assessment_document_number_CUSTOM_ErrorCount
          ,le.assessment_recording_date_CUSTOM_ErrorCount
          ,le.src_assessment_recording_date_ENUM_ErrorCount,le.src_assessment_recording_date_LENGTHS_ErrorCount
          ,le.tax_dt_assessment_recording_date_CUSTOM_ErrorCount
          ,le.deed_document_number_ALLOW_ErrorCount
          ,le.src_deed_document_number_ENUM_ErrorCount,le.src_deed_document_number_LENGTHS_ErrorCount
          ,le.rec_dt_deed_document_number_CUSTOM_ErrorCount
          ,le.deed_recording_date_CUSTOM_ErrorCount
          ,le.src_deed_recording_date_ENUM_ErrorCount,le.src_deed_recording_date_LENGTHS_ErrorCount
          ,le.full_part_sale_CUSTOM_ErrorCount
          ,le.src_full_part_sale_ENUM_ErrorCount,le.src_full_part_sale_LENGTHS_ErrorCount
          ,le.rec_dt_full_part_sale_CUSTOM_ErrorCount
          ,le.sale_amount_ALLOW_ErrorCount
          ,le.src_sale_amount_ENUM_ErrorCount,le.src_sale_amount_LENGTHS_ErrorCount
          ,le.rec_dt_sale_amount_CUSTOM_ErrorCount
          ,le.sale_date_CUSTOM_ErrorCount
          ,le.src_sale_date_ENUM_ErrorCount,le.src_sale_date_LENGTHS_ErrorCount
          ,le.rec_dt_sale_date_CUSTOM_ErrorCount
          ,le.sale_type_code_CUSTOM_ErrorCount
          ,le.src_sale_type_code_ENUM_ErrorCount,le.src_sale_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_sale_type_code_CUSTOM_ErrorCount
          ,le.mortgage_company_name_ALLOW_ErrorCount
          ,le.src_mortgage_company_name_ENUM_ErrorCount,le.src_mortgage_company_name_LENGTHS_ErrorCount
          ,le.rec_dt_mortgage_company_name_CUSTOM_ErrorCount
          ,le.loan_amount_ALLOW_ErrorCount
          ,le.src_loan_amount_ENUM_ErrorCount,le.src_loan_amount_LENGTHS_ErrorCount
          ,le.rec_dt_loan_amount_CUSTOM_ErrorCount
          ,le.second_loan_amount_ALLOW_ErrorCount
          ,le.src_second_loan_amount_ENUM_ErrorCount,le.src_second_loan_amount_LENGTHS_ErrorCount
          ,le.rec_dt_second_loan_amount_CUSTOM_ErrorCount
          ,le.loan_type_code_CUSTOM_ErrorCount
          ,le.src_loan_type_code_ENUM_ErrorCount,le.src_loan_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_loan_type_code_CUSTOM_ErrorCount
          ,le.interest_rate_type_code_CUSTOM_ErrorCount
          ,le.src_interest_rate_type_code_ENUM_ErrorCount,le.src_interest_rate_type_code_LENGTHS_ErrorCount
          ,le.rec_dt_interest_rate_type_code_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Property_Characteristics));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'property_rid:' + getFieldTypeText(h.property_rid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_sortby_date:' + getFieldTypeText(h.tax_sortby_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_sortby_date:' + getFieldTypeText(h.deed_sortby_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_source:' + getFieldTypeText(h.vendor_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fares_unformatted_apn:' + getFieldTypeText(h.fares_unformatted_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_street_address:' + getFieldTypeText(h.property_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_city_state_zip:' + getFieldTypeText(h.property_city_state_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_raw_aid:' + getFieldTypeText(h.property_raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'building_square_footage:' + getFieldTypeText(h.building_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_building_square_footage:' + getFieldTypeText(h.src_building_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_building_square_footage:' + getFieldTypeText(h.tax_dt_building_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_conditioning_type:' + getFieldTypeText(h.air_conditioning_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_air_conditioning_type:' + getFieldTypeText(h.src_air_conditioning_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_air_conditioning_type:' + getFieldTypeText(h.tax_dt_air_conditioning_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'basement_finish:' + getFieldTypeText(h.basement_finish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_basement_finish:' + getFieldTypeText(h.src_basement_finish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_basement_finish:' + getFieldTypeText(h.tax_dt_basement_finish) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'construction_type:' + getFieldTypeText(h.construction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_construction_type:' + getFieldTypeText(h.src_construction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_construction_type:' + getFieldTypeText(h.tax_dt_construction_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exterior_wall:' + getFieldTypeText(h.exterior_wall) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_exterior_wall:' + getFieldTypeText(h.src_exterior_wall) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_exterior_wall:' + getFieldTypeText(h.tax_dt_exterior_wall) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fireplace_ind:' + getFieldTypeText(h.fireplace_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_fireplace_ind:' + getFieldTypeText(h.src_fireplace_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_fireplace_ind:' + getFieldTypeText(h.tax_dt_fireplace_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fireplace_type:' + getFieldTypeText(h.fireplace_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_fireplace_type:' + getFieldTypeText(h.src_fireplace_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_fireplace_type:' + getFieldTypeText(h.tax_dt_fireplace_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'flood_zone_panel:' + getFieldTypeText(h.flood_zone_panel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_flood_zone_panel:' + getFieldTypeText(h.src_flood_zone_panel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_flood_zone_panel:' + getFieldTypeText(h.tax_dt_flood_zone_panel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'garage:' + getFieldTypeText(h.garage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_garage:' + getFieldTypeText(h.src_garage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_garage:' + getFieldTypeText(h.tax_dt_garage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_floor_square_footage:' + getFieldTypeText(h.first_floor_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_first_floor_square_footage:' + getFieldTypeText(h.src_first_floor_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_first_floor_square_footage:' + getFieldTypeText(h.tax_dt_first_floor_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'heating:' + getFieldTypeText(h.heating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_heating:' + getFieldTypeText(h.src_heating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_heating:' + getFieldTypeText(h.tax_dt_heating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'living_area_square_footage:' + getFieldTypeText(h.living_area_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_living_area_square_footage:' + getFieldTypeText(h.src_living_area_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_living_area_square_footage:' + getFieldTypeText(h.tax_dt_living_area_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_baths:' + getFieldTypeText(h.no_of_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_baths:' + getFieldTypeText(h.src_no_of_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_baths:' + getFieldTypeText(h.tax_dt_no_of_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_bedrooms:' + getFieldTypeText(h.no_of_bedrooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_bedrooms:' + getFieldTypeText(h.src_no_of_bedrooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_bedrooms:' + getFieldTypeText(h.tax_dt_no_of_bedrooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_fireplaces:' + getFieldTypeText(h.no_of_fireplaces) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_fireplaces:' + getFieldTypeText(h.src_no_of_fireplaces) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_fireplaces:' + getFieldTypeText(h.tax_dt_no_of_fireplaces) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_full_baths:' + getFieldTypeText(h.no_of_full_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_full_baths:' + getFieldTypeText(h.src_no_of_full_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_full_baths:' + getFieldTypeText(h.tax_dt_no_of_full_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_half_baths:' + getFieldTypeText(h.no_of_half_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_half_baths:' + getFieldTypeText(h.src_no_of_half_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_half_baths:' + getFieldTypeText(h.tax_dt_no_of_half_baths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_stories:' + getFieldTypeText(h.no_of_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_stories:' + getFieldTypeText(h.src_no_of_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_stories:' + getFieldTypeText(h.tax_dt_no_of_stories) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parking_type:' + getFieldTypeText(h.parking_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_parking_type:' + getFieldTypeText(h.src_parking_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_parking_type:' + getFieldTypeText(h.tax_dt_parking_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pool_indicator:' + getFieldTypeText(h.pool_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_pool_indicator:' + getFieldTypeText(h.src_pool_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_pool_indicator:' + getFieldTypeText(h.tax_dt_pool_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pool_type:' + getFieldTypeText(h.pool_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_pool_type:' + getFieldTypeText(h.src_pool_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_pool_type:' + getFieldTypeText(h.tax_dt_pool_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'roof_cover:' + getFieldTypeText(h.roof_cover) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_roof_cover:' + getFieldTypeText(h.src_roof_cover) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_roof_cover:' + getFieldTypeText(h.tax_dt_roof_cover) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_built:' + getFieldTypeText(h.year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_year_built:' + getFieldTypeText(h.src_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_year_built:' + getFieldTypeText(h.tax_dt_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'foundation:' + getFieldTypeText(h.foundation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_foundation:' + getFieldTypeText(h.src_foundation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_foundation:' + getFieldTypeText(h.tax_dt_foundation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'basement_square_footage:' + getFieldTypeText(h.basement_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_basement_square_footage:' + getFieldTypeText(h.src_basement_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_basement_square_footage:' + getFieldTypeText(h.tax_dt_basement_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'effective_year_built:' + getFieldTypeText(h.effective_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_effective_year_built:' + getFieldTypeText(h.src_effective_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_effective_year_built:' + getFieldTypeText(h.tax_dt_effective_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'garage_square_footage:' + getFieldTypeText(h.garage_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_garage_square_footage:' + getFieldTypeText(h.src_garage_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_garage_square_footage:' + getFieldTypeText(h.tax_dt_garage_square_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stories_type:' + getFieldTypeText(h.stories_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_stories_type:' + getFieldTypeText(h.src_stories_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_stories_type:' + getFieldTypeText(h.tax_dt_stories_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apn_number:' + getFieldTypeText(h.apn_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_apn_number:' + getFieldTypeText(h.src_apn_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_apn_number:' + getFieldTypeText(h.tax_dt_apn_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'census_tract:' + getFieldTypeText(h.census_tract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_census_tract:' + getFieldTypeText(h.src_census_tract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_census_tract:' + getFieldTypeText(h.tax_dt_census_tract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'range:' + getFieldTypeText(h.range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_range:' + getFieldTypeText(h.src_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_range:' + getFieldTypeText(h.tax_dt_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zoning:' + getFieldTypeText(h.zoning) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_zoning:' + getFieldTypeText(h.src_zoning) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_zoning:' + getFieldTypeText(h.tax_dt_zoning) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'block_number:' + getFieldTypeText(h.block_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_block_number:' + getFieldTypeText(h.src_block_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_block_number:' + getFieldTypeText(h.tax_dt_block_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_county_name:' + getFieldTypeText(h.src_county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_county_name:' + getFieldTypeText(h.tax_dt_county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_code:' + getFieldTypeText(h.fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_fips_code:' + getFieldTypeText(h.src_fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_fips_code:' + getFieldTypeText(h.tax_dt_fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subdivision:' + getFieldTypeText(h.subdivision) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_subdivision:' + getFieldTypeText(h.src_subdivision) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_subdivision:' + getFieldTypeText(h.tax_dt_subdivision) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'municipality:' + getFieldTypeText(h.municipality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_municipality:' + getFieldTypeText(h.src_municipality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_municipality:' + getFieldTypeText(h.tax_dt_municipality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'township:' + getFieldTypeText(h.township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_township:' + getFieldTypeText(h.src_township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_township:' + getFieldTypeText(h.tax_dt_township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homestead_exemption_ind:' + getFieldTypeText(h.homestead_exemption_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_homestead_exemption_ind:' + getFieldTypeText(h.src_homestead_exemption_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_homestead_exemption_ind:' + getFieldTypeText(h.tax_dt_homestead_exemption_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_use_code:' + getFieldTypeText(h.land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_land_use_code:' + getFieldTypeText(h.src_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_land_use_code:' + getFieldTypeText(h.tax_dt_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latitude:' + getFieldTypeText(h.latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_latitude:' + getFieldTypeText(h.src_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_latitude:' + getFieldTypeText(h.tax_dt_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'longitude:' + getFieldTypeText(h.longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_longitude:' + getFieldTypeText(h.src_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_longitude:' + getFieldTypeText(h.tax_dt_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_influence_code:' + getFieldTypeText(h.location_influence_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_location_influence_code:' + getFieldTypeText(h.src_location_influence_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_location_influence_code:' + getFieldTypeText(h.tax_dt_location_influence_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'acres:' + getFieldTypeText(h.acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_acres:' + getFieldTypeText(h.src_acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_acres:' + getFieldTypeText(h.tax_dt_acres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_depth_footage:' + getFieldTypeText(h.lot_depth_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_lot_depth_footage:' + getFieldTypeText(h.src_lot_depth_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_lot_depth_footage:' + getFieldTypeText(h.tax_dt_lot_depth_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_front_footage:' + getFieldTypeText(h.lot_front_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_lot_front_footage:' + getFieldTypeText(h.src_lot_front_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_lot_front_footage:' + getFieldTypeText(h.tax_dt_lot_front_footage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_number:' + getFieldTypeText(h.lot_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_lot_number:' + getFieldTypeText(h.src_lot_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_lot_number:' + getFieldTypeText(h.tax_dt_lot_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_size:' + getFieldTypeText(h.lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_lot_size:' + getFieldTypeText(h.src_lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_lot_size:' + getFieldTypeText(h.tax_dt_lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_type_code:' + getFieldTypeText(h.property_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_property_type_code:' + getFieldTypeText(h.src_property_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_property_type_code:' + getFieldTypeText(h.tax_dt_property_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'structure_quality:' + getFieldTypeText(h.structure_quality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_structure_quality:' + getFieldTypeText(h.src_structure_quality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_structure_quality:' + getFieldTypeText(h.tax_dt_structure_quality) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'water:' + getFieldTypeText(h.water) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_water:' + getFieldTypeText(h.src_water) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_water:' + getFieldTypeText(h.tax_dt_water) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sewer:' + getFieldTypeText(h.sewer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_sewer:' + getFieldTypeText(h.src_sewer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_sewer:' + getFieldTypeText(h.tax_dt_sewer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_land_value:' + getFieldTypeText(h.assessed_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_assessed_land_value:' + getFieldTypeText(h.src_assessed_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_assessed_land_value:' + getFieldTypeText(h.tax_dt_assessed_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessed_year:' + getFieldTypeText(h.assessed_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_assessed_year:' + getFieldTypeText(h.src_assessed_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_assessed_year:' + getFieldTypeText(h.tax_dt_assessed_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_amount:' + getFieldTypeText(h.tax_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_tax_amount:' + getFieldTypeText(h.src_tax_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_tax_amount:' + getFieldTypeText(h.tax_dt_tax_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_year:' + getFieldTypeText(h.tax_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_tax_year:' + getFieldTypeText(h.src_tax_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_land_value:' + getFieldTypeText(h.market_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_market_land_value:' + getFieldTypeText(h.src_market_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_market_land_value:' + getFieldTypeText(h.tax_dt_market_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'improvement_value:' + getFieldTypeText(h.improvement_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_improvement_value:' + getFieldTypeText(h.src_improvement_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_improvement_value:' + getFieldTypeText(h.tax_dt_improvement_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'percent_improved:' + getFieldTypeText(h.percent_improved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_percent_improved:' + getFieldTypeText(h.src_percent_improved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_percent_improved:' + getFieldTypeText(h.tax_dt_percent_improved) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_assessed_value:' + getFieldTypeText(h.total_assessed_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_total_assessed_value:' + getFieldTypeText(h.src_total_assessed_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_total_assessed_value:' + getFieldTypeText(h.tax_dt_total_assessed_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_calculated_value:' + getFieldTypeText(h.total_calculated_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_total_calculated_value:' + getFieldTypeText(h.src_total_calculated_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_total_calculated_value:' + getFieldTypeText(h.tax_dt_total_calculated_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_land_value:' + getFieldTypeText(h.total_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_total_land_value:' + getFieldTypeText(h.src_total_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_total_land_value:' + getFieldTypeText(h.tax_dt_total_land_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_market_value:' + getFieldTypeText(h.total_market_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_total_market_value:' + getFieldTypeText(h.src_total_market_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_total_market_value:' + getFieldTypeText(h.tax_dt_total_market_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'floor_type:' + getFieldTypeText(h.floor_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_floor_type:' + getFieldTypeText(h.src_floor_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_floor_type:' + getFieldTypeText(h.tax_dt_floor_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'frame_type:' + getFieldTypeText(h.frame_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_frame_type:' + getFieldTypeText(h.src_frame_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_frame_type:' + getFieldTypeText(h.tax_dt_frame_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fuel_type:' + getFieldTypeText(h.fuel_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_fuel_type:' + getFieldTypeText(h.src_fuel_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_fuel_type:' + getFieldTypeText(h.tax_dt_fuel_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_bath_fixtures:' + getFieldTypeText(h.no_of_bath_fixtures) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_bath_fixtures:' + getFieldTypeText(h.src_no_of_bath_fixtures) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_bath_fixtures:' + getFieldTypeText(h.tax_dt_no_of_bath_fixtures) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_rooms:' + getFieldTypeText(h.no_of_rooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_rooms:' + getFieldTypeText(h.src_no_of_rooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_rooms:' + getFieldTypeText(h.tax_dt_no_of_rooms) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_of_units:' + getFieldTypeText(h.no_of_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_no_of_units:' + getFieldTypeText(h.src_no_of_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_no_of_units:' + getFieldTypeText(h.tax_dt_no_of_units) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'style_type:' + getFieldTypeText(h.style_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_style_type:' + getFieldTypeText(h.src_style_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_style_type:' + getFieldTypeText(h.tax_dt_style_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessment_document_number:' + getFieldTypeText(h.assessment_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_assessment_document_number:' + getFieldTypeText(h.src_assessment_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_assessment_document_number:' + getFieldTypeText(h.tax_dt_assessment_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessment_recording_date:' + getFieldTypeText(h.assessment_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_assessment_recording_date:' + getFieldTypeText(h.src_assessment_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_dt_assessment_recording_date:' + getFieldTypeText(h.tax_dt_assessment_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_document_number:' + getFieldTypeText(h.deed_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_deed_document_number:' + getFieldTypeText(h.src_deed_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_deed_document_number:' + getFieldTypeText(h.rec_dt_deed_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deed_recording_date:' + getFieldTypeText(h.deed_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_deed_recording_date:' + getFieldTypeText(h.src_deed_recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_part_sale:' + getFieldTypeText(h.full_part_sale) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_full_part_sale:' + getFieldTypeText(h.src_full_part_sale) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_full_part_sale:' + getFieldTypeText(h.rec_dt_full_part_sale) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sale_amount:' + getFieldTypeText(h.sale_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_sale_amount:' + getFieldTypeText(h.src_sale_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_sale_amount:' + getFieldTypeText(h.rec_dt_sale_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sale_date:' + getFieldTypeText(h.sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_sale_date:' + getFieldTypeText(h.src_sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_sale_date:' + getFieldTypeText(h.rec_dt_sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sale_type_code:' + getFieldTypeText(h.sale_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_sale_type_code:' + getFieldTypeText(h.src_sale_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_sale_type_code:' + getFieldTypeText(h.rec_dt_sale_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage_company_name:' + getFieldTypeText(h.mortgage_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_mortgage_company_name:' + getFieldTypeText(h.src_mortgage_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_mortgage_company_name:' + getFieldTypeText(h.rec_dt_mortgage_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_amount:' + getFieldTypeText(h.loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_loan_amount:' + getFieldTypeText(h.src_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_loan_amount:' + getFieldTypeText(h.rec_dt_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_loan_amount:' + getFieldTypeText(h.second_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_second_loan_amount:' + getFieldTypeText(h.src_second_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_second_loan_amount:' + getFieldTypeText(h.rec_dt_second_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_type_code:' + getFieldTypeText(h.loan_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_loan_type_code:' + getFieldTypeText(h.src_loan_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_loan_type_code:' + getFieldTypeText(h.rec_dt_loan_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'interest_rate_type_code:' + getFieldTypeText(h.interest_rate_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'src_interest_rate_type_code:' + getFieldTypeText(h.src_interest_rate_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_dt_interest_rate_type_code:' + getFieldTypeText(h.rec_dt_interest_rate_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_property_rid_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_tax_sortby_date_cnt
          ,le.populated_deed_sortby_date_cnt
          ,le.populated_vendor_source_cnt
          ,le.populated_fares_unformatted_apn_cnt
          ,le.populated_property_street_address_cnt
          ,le.populated_property_city_state_zip_cnt
          ,le.populated_property_raw_aid_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_building_square_footage_cnt
          ,le.populated_src_building_square_footage_cnt
          ,le.populated_tax_dt_building_square_footage_cnt
          ,le.populated_air_conditioning_type_cnt
          ,le.populated_src_air_conditioning_type_cnt
          ,le.populated_tax_dt_air_conditioning_type_cnt
          ,le.populated_basement_finish_cnt
          ,le.populated_src_basement_finish_cnt
          ,le.populated_tax_dt_basement_finish_cnt
          ,le.populated_construction_type_cnt
          ,le.populated_src_construction_type_cnt
          ,le.populated_tax_dt_construction_type_cnt
          ,le.populated_exterior_wall_cnt
          ,le.populated_src_exterior_wall_cnt
          ,le.populated_tax_dt_exterior_wall_cnt
          ,le.populated_fireplace_ind_cnt
          ,le.populated_src_fireplace_ind_cnt
          ,le.populated_tax_dt_fireplace_ind_cnt
          ,le.populated_fireplace_type_cnt
          ,le.populated_src_fireplace_type_cnt
          ,le.populated_tax_dt_fireplace_type_cnt
          ,le.populated_flood_zone_panel_cnt
          ,le.populated_src_flood_zone_panel_cnt
          ,le.populated_tax_dt_flood_zone_panel_cnt
          ,le.populated_garage_cnt
          ,le.populated_src_garage_cnt
          ,le.populated_tax_dt_garage_cnt
          ,le.populated_first_floor_square_footage_cnt
          ,le.populated_src_first_floor_square_footage_cnt
          ,le.populated_tax_dt_first_floor_square_footage_cnt
          ,le.populated_heating_cnt
          ,le.populated_src_heating_cnt
          ,le.populated_tax_dt_heating_cnt
          ,le.populated_living_area_square_footage_cnt
          ,le.populated_src_living_area_square_footage_cnt
          ,le.populated_tax_dt_living_area_square_footage_cnt
          ,le.populated_no_of_baths_cnt
          ,le.populated_src_no_of_baths_cnt
          ,le.populated_tax_dt_no_of_baths_cnt
          ,le.populated_no_of_bedrooms_cnt
          ,le.populated_src_no_of_bedrooms_cnt
          ,le.populated_tax_dt_no_of_bedrooms_cnt
          ,le.populated_no_of_fireplaces_cnt
          ,le.populated_src_no_of_fireplaces_cnt
          ,le.populated_tax_dt_no_of_fireplaces_cnt
          ,le.populated_no_of_full_baths_cnt
          ,le.populated_src_no_of_full_baths_cnt
          ,le.populated_tax_dt_no_of_full_baths_cnt
          ,le.populated_no_of_half_baths_cnt
          ,le.populated_src_no_of_half_baths_cnt
          ,le.populated_tax_dt_no_of_half_baths_cnt
          ,le.populated_no_of_stories_cnt
          ,le.populated_src_no_of_stories_cnt
          ,le.populated_tax_dt_no_of_stories_cnt
          ,le.populated_parking_type_cnt
          ,le.populated_src_parking_type_cnt
          ,le.populated_tax_dt_parking_type_cnt
          ,le.populated_pool_indicator_cnt
          ,le.populated_src_pool_indicator_cnt
          ,le.populated_tax_dt_pool_indicator_cnt
          ,le.populated_pool_type_cnt
          ,le.populated_src_pool_type_cnt
          ,le.populated_tax_dt_pool_type_cnt
          ,le.populated_roof_cover_cnt
          ,le.populated_src_roof_cover_cnt
          ,le.populated_tax_dt_roof_cover_cnt
          ,le.populated_year_built_cnt
          ,le.populated_src_year_built_cnt
          ,le.populated_tax_dt_year_built_cnt
          ,le.populated_foundation_cnt
          ,le.populated_src_foundation_cnt
          ,le.populated_tax_dt_foundation_cnt
          ,le.populated_basement_square_footage_cnt
          ,le.populated_src_basement_square_footage_cnt
          ,le.populated_tax_dt_basement_square_footage_cnt
          ,le.populated_effective_year_built_cnt
          ,le.populated_src_effective_year_built_cnt
          ,le.populated_tax_dt_effective_year_built_cnt
          ,le.populated_garage_square_footage_cnt
          ,le.populated_src_garage_square_footage_cnt
          ,le.populated_tax_dt_garage_square_footage_cnt
          ,le.populated_stories_type_cnt
          ,le.populated_src_stories_type_cnt
          ,le.populated_tax_dt_stories_type_cnt
          ,le.populated_apn_number_cnt
          ,le.populated_src_apn_number_cnt
          ,le.populated_tax_dt_apn_number_cnt
          ,le.populated_census_tract_cnt
          ,le.populated_src_census_tract_cnt
          ,le.populated_tax_dt_census_tract_cnt
          ,le.populated_range_cnt
          ,le.populated_src_range_cnt
          ,le.populated_tax_dt_range_cnt
          ,le.populated_zoning_cnt
          ,le.populated_src_zoning_cnt
          ,le.populated_tax_dt_zoning_cnt
          ,le.populated_block_number_cnt
          ,le.populated_src_block_number_cnt
          ,le.populated_tax_dt_block_number_cnt
          ,le.populated_county_name_cnt
          ,le.populated_src_county_name_cnt
          ,le.populated_tax_dt_county_name_cnt
          ,le.populated_fips_code_cnt
          ,le.populated_src_fips_code_cnt
          ,le.populated_tax_dt_fips_code_cnt
          ,le.populated_subdivision_cnt
          ,le.populated_src_subdivision_cnt
          ,le.populated_tax_dt_subdivision_cnt
          ,le.populated_municipality_cnt
          ,le.populated_src_municipality_cnt
          ,le.populated_tax_dt_municipality_cnt
          ,le.populated_township_cnt
          ,le.populated_src_township_cnt
          ,le.populated_tax_dt_township_cnt
          ,le.populated_homestead_exemption_ind_cnt
          ,le.populated_src_homestead_exemption_ind_cnt
          ,le.populated_tax_dt_homestead_exemption_ind_cnt
          ,le.populated_land_use_code_cnt
          ,le.populated_src_land_use_code_cnt
          ,le.populated_tax_dt_land_use_code_cnt
          ,le.populated_latitude_cnt
          ,le.populated_src_latitude_cnt
          ,le.populated_tax_dt_latitude_cnt
          ,le.populated_longitude_cnt
          ,le.populated_src_longitude_cnt
          ,le.populated_tax_dt_longitude_cnt
          ,le.populated_location_influence_code_cnt
          ,le.populated_src_location_influence_code_cnt
          ,le.populated_tax_dt_location_influence_code_cnt
          ,le.populated_acres_cnt
          ,le.populated_src_acres_cnt
          ,le.populated_tax_dt_acres_cnt
          ,le.populated_lot_depth_footage_cnt
          ,le.populated_src_lot_depth_footage_cnt
          ,le.populated_tax_dt_lot_depth_footage_cnt
          ,le.populated_lot_front_footage_cnt
          ,le.populated_src_lot_front_footage_cnt
          ,le.populated_tax_dt_lot_front_footage_cnt
          ,le.populated_lot_number_cnt
          ,le.populated_src_lot_number_cnt
          ,le.populated_tax_dt_lot_number_cnt
          ,le.populated_lot_size_cnt
          ,le.populated_src_lot_size_cnt
          ,le.populated_tax_dt_lot_size_cnt
          ,le.populated_property_type_code_cnt
          ,le.populated_src_property_type_code_cnt
          ,le.populated_tax_dt_property_type_code_cnt
          ,le.populated_structure_quality_cnt
          ,le.populated_src_structure_quality_cnt
          ,le.populated_tax_dt_structure_quality_cnt
          ,le.populated_water_cnt
          ,le.populated_src_water_cnt
          ,le.populated_tax_dt_water_cnt
          ,le.populated_sewer_cnt
          ,le.populated_src_sewer_cnt
          ,le.populated_tax_dt_sewer_cnt
          ,le.populated_assessed_land_value_cnt
          ,le.populated_src_assessed_land_value_cnt
          ,le.populated_tax_dt_assessed_land_value_cnt
          ,le.populated_assessed_year_cnt
          ,le.populated_src_assessed_year_cnt
          ,le.populated_tax_dt_assessed_year_cnt
          ,le.populated_tax_amount_cnt
          ,le.populated_src_tax_amount_cnt
          ,le.populated_tax_dt_tax_amount_cnt
          ,le.populated_tax_year_cnt
          ,le.populated_src_tax_year_cnt
          ,le.populated_market_land_value_cnt
          ,le.populated_src_market_land_value_cnt
          ,le.populated_tax_dt_market_land_value_cnt
          ,le.populated_improvement_value_cnt
          ,le.populated_src_improvement_value_cnt
          ,le.populated_tax_dt_improvement_value_cnt
          ,le.populated_percent_improved_cnt
          ,le.populated_src_percent_improved_cnt
          ,le.populated_tax_dt_percent_improved_cnt
          ,le.populated_total_assessed_value_cnt
          ,le.populated_src_total_assessed_value_cnt
          ,le.populated_tax_dt_total_assessed_value_cnt
          ,le.populated_total_calculated_value_cnt
          ,le.populated_src_total_calculated_value_cnt
          ,le.populated_tax_dt_total_calculated_value_cnt
          ,le.populated_total_land_value_cnt
          ,le.populated_src_total_land_value_cnt
          ,le.populated_tax_dt_total_land_value_cnt
          ,le.populated_total_market_value_cnt
          ,le.populated_src_total_market_value_cnt
          ,le.populated_tax_dt_total_market_value_cnt
          ,le.populated_floor_type_cnt
          ,le.populated_src_floor_type_cnt
          ,le.populated_tax_dt_floor_type_cnt
          ,le.populated_frame_type_cnt
          ,le.populated_src_frame_type_cnt
          ,le.populated_tax_dt_frame_type_cnt
          ,le.populated_fuel_type_cnt
          ,le.populated_src_fuel_type_cnt
          ,le.populated_tax_dt_fuel_type_cnt
          ,le.populated_no_of_bath_fixtures_cnt
          ,le.populated_src_no_of_bath_fixtures_cnt
          ,le.populated_tax_dt_no_of_bath_fixtures_cnt
          ,le.populated_no_of_rooms_cnt
          ,le.populated_src_no_of_rooms_cnt
          ,le.populated_tax_dt_no_of_rooms_cnt
          ,le.populated_no_of_units_cnt
          ,le.populated_src_no_of_units_cnt
          ,le.populated_tax_dt_no_of_units_cnt
          ,le.populated_style_type_cnt
          ,le.populated_src_style_type_cnt
          ,le.populated_tax_dt_style_type_cnt
          ,le.populated_assessment_document_number_cnt
          ,le.populated_src_assessment_document_number_cnt
          ,le.populated_tax_dt_assessment_document_number_cnt
          ,le.populated_assessment_recording_date_cnt
          ,le.populated_src_assessment_recording_date_cnt
          ,le.populated_tax_dt_assessment_recording_date_cnt
          ,le.populated_deed_document_number_cnt
          ,le.populated_src_deed_document_number_cnt
          ,le.populated_rec_dt_deed_document_number_cnt
          ,le.populated_deed_recording_date_cnt
          ,le.populated_src_deed_recording_date_cnt
          ,le.populated_full_part_sale_cnt
          ,le.populated_src_full_part_sale_cnt
          ,le.populated_rec_dt_full_part_sale_cnt
          ,le.populated_sale_amount_cnt
          ,le.populated_src_sale_amount_cnt
          ,le.populated_rec_dt_sale_amount_cnt
          ,le.populated_sale_date_cnt
          ,le.populated_src_sale_date_cnt
          ,le.populated_rec_dt_sale_date_cnt
          ,le.populated_sale_type_code_cnt
          ,le.populated_src_sale_type_code_cnt
          ,le.populated_rec_dt_sale_type_code_cnt
          ,le.populated_mortgage_company_name_cnt
          ,le.populated_src_mortgage_company_name_cnt
          ,le.populated_rec_dt_mortgage_company_name_cnt
          ,le.populated_loan_amount_cnt
          ,le.populated_src_loan_amount_cnt
          ,le.populated_rec_dt_loan_amount_cnt
          ,le.populated_second_loan_amount_cnt
          ,le.populated_src_second_loan_amount_cnt
          ,le.populated_rec_dt_second_loan_amount_cnt
          ,le.populated_loan_type_code_cnt
          ,le.populated_src_loan_type_code_cnt
          ,le.populated_rec_dt_loan_type_code_cnt
          ,le.populated_interest_rate_type_code_cnt
          ,le.populated_src_interest_rate_type_code_cnt
          ,le.populated_rec_dt_interest_rate_type_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_property_rid_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_tax_sortby_date_pcnt
          ,le.populated_deed_sortby_date_pcnt
          ,le.populated_vendor_source_pcnt
          ,le.populated_fares_unformatted_apn_pcnt
          ,le.populated_property_street_address_pcnt
          ,le.populated_property_city_state_zip_pcnt
          ,le.populated_property_raw_aid_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_building_square_footage_pcnt
          ,le.populated_src_building_square_footage_pcnt
          ,le.populated_tax_dt_building_square_footage_pcnt
          ,le.populated_air_conditioning_type_pcnt
          ,le.populated_src_air_conditioning_type_pcnt
          ,le.populated_tax_dt_air_conditioning_type_pcnt
          ,le.populated_basement_finish_pcnt
          ,le.populated_src_basement_finish_pcnt
          ,le.populated_tax_dt_basement_finish_pcnt
          ,le.populated_construction_type_pcnt
          ,le.populated_src_construction_type_pcnt
          ,le.populated_tax_dt_construction_type_pcnt
          ,le.populated_exterior_wall_pcnt
          ,le.populated_src_exterior_wall_pcnt
          ,le.populated_tax_dt_exterior_wall_pcnt
          ,le.populated_fireplace_ind_pcnt
          ,le.populated_src_fireplace_ind_pcnt
          ,le.populated_tax_dt_fireplace_ind_pcnt
          ,le.populated_fireplace_type_pcnt
          ,le.populated_src_fireplace_type_pcnt
          ,le.populated_tax_dt_fireplace_type_pcnt
          ,le.populated_flood_zone_panel_pcnt
          ,le.populated_src_flood_zone_panel_pcnt
          ,le.populated_tax_dt_flood_zone_panel_pcnt
          ,le.populated_garage_pcnt
          ,le.populated_src_garage_pcnt
          ,le.populated_tax_dt_garage_pcnt
          ,le.populated_first_floor_square_footage_pcnt
          ,le.populated_src_first_floor_square_footage_pcnt
          ,le.populated_tax_dt_first_floor_square_footage_pcnt
          ,le.populated_heating_pcnt
          ,le.populated_src_heating_pcnt
          ,le.populated_tax_dt_heating_pcnt
          ,le.populated_living_area_square_footage_pcnt
          ,le.populated_src_living_area_square_footage_pcnt
          ,le.populated_tax_dt_living_area_square_footage_pcnt
          ,le.populated_no_of_baths_pcnt
          ,le.populated_src_no_of_baths_pcnt
          ,le.populated_tax_dt_no_of_baths_pcnt
          ,le.populated_no_of_bedrooms_pcnt
          ,le.populated_src_no_of_bedrooms_pcnt
          ,le.populated_tax_dt_no_of_bedrooms_pcnt
          ,le.populated_no_of_fireplaces_pcnt
          ,le.populated_src_no_of_fireplaces_pcnt
          ,le.populated_tax_dt_no_of_fireplaces_pcnt
          ,le.populated_no_of_full_baths_pcnt
          ,le.populated_src_no_of_full_baths_pcnt
          ,le.populated_tax_dt_no_of_full_baths_pcnt
          ,le.populated_no_of_half_baths_pcnt
          ,le.populated_src_no_of_half_baths_pcnt
          ,le.populated_tax_dt_no_of_half_baths_pcnt
          ,le.populated_no_of_stories_pcnt
          ,le.populated_src_no_of_stories_pcnt
          ,le.populated_tax_dt_no_of_stories_pcnt
          ,le.populated_parking_type_pcnt
          ,le.populated_src_parking_type_pcnt
          ,le.populated_tax_dt_parking_type_pcnt
          ,le.populated_pool_indicator_pcnt
          ,le.populated_src_pool_indicator_pcnt
          ,le.populated_tax_dt_pool_indicator_pcnt
          ,le.populated_pool_type_pcnt
          ,le.populated_src_pool_type_pcnt
          ,le.populated_tax_dt_pool_type_pcnt
          ,le.populated_roof_cover_pcnt
          ,le.populated_src_roof_cover_pcnt
          ,le.populated_tax_dt_roof_cover_pcnt
          ,le.populated_year_built_pcnt
          ,le.populated_src_year_built_pcnt
          ,le.populated_tax_dt_year_built_pcnt
          ,le.populated_foundation_pcnt
          ,le.populated_src_foundation_pcnt
          ,le.populated_tax_dt_foundation_pcnt
          ,le.populated_basement_square_footage_pcnt
          ,le.populated_src_basement_square_footage_pcnt
          ,le.populated_tax_dt_basement_square_footage_pcnt
          ,le.populated_effective_year_built_pcnt
          ,le.populated_src_effective_year_built_pcnt
          ,le.populated_tax_dt_effective_year_built_pcnt
          ,le.populated_garage_square_footage_pcnt
          ,le.populated_src_garage_square_footage_pcnt
          ,le.populated_tax_dt_garage_square_footage_pcnt
          ,le.populated_stories_type_pcnt
          ,le.populated_src_stories_type_pcnt
          ,le.populated_tax_dt_stories_type_pcnt
          ,le.populated_apn_number_pcnt
          ,le.populated_src_apn_number_pcnt
          ,le.populated_tax_dt_apn_number_pcnt
          ,le.populated_census_tract_pcnt
          ,le.populated_src_census_tract_pcnt
          ,le.populated_tax_dt_census_tract_pcnt
          ,le.populated_range_pcnt
          ,le.populated_src_range_pcnt
          ,le.populated_tax_dt_range_pcnt
          ,le.populated_zoning_pcnt
          ,le.populated_src_zoning_pcnt
          ,le.populated_tax_dt_zoning_pcnt
          ,le.populated_block_number_pcnt
          ,le.populated_src_block_number_pcnt
          ,le.populated_tax_dt_block_number_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_src_county_name_pcnt
          ,le.populated_tax_dt_county_name_pcnt
          ,le.populated_fips_code_pcnt
          ,le.populated_src_fips_code_pcnt
          ,le.populated_tax_dt_fips_code_pcnt
          ,le.populated_subdivision_pcnt
          ,le.populated_src_subdivision_pcnt
          ,le.populated_tax_dt_subdivision_pcnt
          ,le.populated_municipality_pcnt
          ,le.populated_src_municipality_pcnt
          ,le.populated_tax_dt_municipality_pcnt
          ,le.populated_township_pcnt
          ,le.populated_src_township_pcnt
          ,le.populated_tax_dt_township_pcnt
          ,le.populated_homestead_exemption_ind_pcnt
          ,le.populated_src_homestead_exemption_ind_pcnt
          ,le.populated_tax_dt_homestead_exemption_ind_pcnt
          ,le.populated_land_use_code_pcnt
          ,le.populated_src_land_use_code_pcnt
          ,le.populated_tax_dt_land_use_code_pcnt
          ,le.populated_latitude_pcnt
          ,le.populated_src_latitude_pcnt
          ,le.populated_tax_dt_latitude_pcnt
          ,le.populated_longitude_pcnt
          ,le.populated_src_longitude_pcnt
          ,le.populated_tax_dt_longitude_pcnt
          ,le.populated_location_influence_code_pcnt
          ,le.populated_src_location_influence_code_pcnt
          ,le.populated_tax_dt_location_influence_code_pcnt
          ,le.populated_acres_pcnt
          ,le.populated_src_acres_pcnt
          ,le.populated_tax_dt_acres_pcnt
          ,le.populated_lot_depth_footage_pcnt
          ,le.populated_src_lot_depth_footage_pcnt
          ,le.populated_tax_dt_lot_depth_footage_pcnt
          ,le.populated_lot_front_footage_pcnt
          ,le.populated_src_lot_front_footage_pcnt
          ,le.populated_tax_dt_lot_front_footage_pcnt
          ,le.populated_lot_number_pcnt
          ,le.populated_src_lot_number_pcnt
          ,le.populated_tax_dt_lot_number_pcnt
          ,le.populated_lot_size_pcnt
          ,le.populated_src_lot_size_pcnt
          ,le.populated_tax_dt_lot_size_pcnt
          ,le.populated_property_type_code_pcnt
          ,le.populated_src_property_type_code_pcnt
          ,le.populated_tax_dt_property_type_code_pcnt
          ,le.populated_structure_quality_pcnt
          ,le.populated_src_structure_quality_pcnt
          ,le.populated_tax_dt_structure_quality_pcnt
          ,le.populated_water_pcnt
          ,le.populated_src_water_pcnt
          ,le.populated_tax_dt_water_pcnt
          ,le.populated_sewer_pcnt
          ,le.populated_src_sewer_pcnt
          ,le.populated_tax_dt_sewer_pcnt
          ,le.populated_assessed_land_value_pcnt
          ,le.populated_src_assessed_land_value_pcnt
          ,le.populated_tax_dt_assessed_land_value_pcnt
          ,le.populated_assessed_year_pcnt
          ,le.populated_src_assessed_year_pcnt
          ,le.populated_tax_dt_assessed_year_pcnt
          ,le.populated_tax_amount_pcnt
          ,le.populated_src_tax_amount_pcnt
          ,le.populated_tax_dt_tax_amount_pcnt
          ,le.populated_tax_year_pcnt
          ,le.populated_src_tax_year_pcnt
          ,le.populated_market_land_value_pcnt
          ,le.populated_src_market_land_value_pcnt
          ,le.populated_tax_dt_market_land_value_pcnt
          ,le.populated_improvement_value_pcnt
          ,le.populated_src_improvement_value_pcnt
          ,le.populated_tax_dt_improvement_value_pcnt
          ,le.populated_percent_improved_pcnt
          ,le.populated_src_percent_improved_pcnt
          ,le.populated_tax_dt_percent_improved_pcnt
          ,le.populated_total_assessed_value_pcnt
          ,le.populated_src_total_assessed_value_pcnt
          ,le.populated_tax_dt_total_assessed_value_pcnt
          ,le.populated_total_calculated_value_pcnt
          ,le.populated_src_total_calculated_value_pcnt
          ,le.populated_tax_dt_total_calculated_value_pcnt
          ,le.populated_total_land_value_pcnt
          ,le.populated_src_total_land_value_pcnt
          ,le.populated_tax_dt_total_land_value_pcnt
          ,le.populated_total_market_value_pcnt
          ,le.populated_src_total_market_value_pcnt
          ,le.populated_tax_dt_total_market_value_pcnt
          ,le.populated_floor_type_pcnt
          ,le.populated_src_floor_type_pcnt
          ,le.populated_tax_dt_floor_type_pcnt
          ,le.populated_frame_type_pcnt
          ,le.populated_src_frame_type_pcnt
          ,le.populated_tax_dt_frame_type_pcnt
          ,le.populated_fuel_type_pcnt
          ,le.populated_src_fuel_type_pcnt
          ,le.populated_tax_dt_fuel_type_pcnt
          ,le.populated_no_of_bath_fixtures_pcnt
          ,le.populated_src_no_of_bath_fixtures_pcnt
          ,le.populated_tax_dt_no_of_bath_fixtures_pcnt
          ,le.populated_no_of_rooms_pcnt
          ,le.populated_src_no_of_rooms_pcnt
          ,le.populated_tax_dt_no_of_rooms_pcnt
          ,le.populated_no_of_units_pcnt
          ,le.populated_src_no_of_units_pcnt
          ,le.populated_tax_dt_no_of_units_pcnt
          ,le.populated_style_type_pcnt
          ,le.populated_src_style_type_pcnt
          ,le.populated_tax_dt_style_type_pcnt
          ,le.populated_assessment_document_number_pcnt
          ,le.populated_src_assessment_document_number_pcnt
          ,le.populated_tax_dt_assessment_document_number_pcnt
          ,le.populated_assessment_recording_date_pcnt
          ,le.populated_src_assessment_recording_date_pcnt
          ,le.populated_tax_dt_assessment_recording_date_pcnt
          ,le.populated_deed_document_number_pcnt
          ,le.populated_src_deed_document_number_pcnt
          ,le.populated_rec_dt_deed_document_number_pcnt
          ,le.populated_deed_recording_date_pcnt
          ,le.populated_src_deed_recording_date_pcnt
          ,le.populated_full_part_sale_pcnt
          ,le.populated_src_full_part_sale_pcnt
          ,le.populated_rec_dt_full_part_sale_pcnt
          ,le.populated_sale_amount_pcnt
          ,le.populated_src_sale_amount_pcnt
          ,le.populated_rec_dt_sale_amount_pcnt
          ,le.populated_sale_date_pcnt
          ,le.populated_src_sale_date_pcnt
          ,le.populated_rec_dt_sale_date_pcnt
          ,le.populated_sale_type_code_pcnt
          ,le.populated_src_sale_type_code_pcnt
          ,le.populated_rec_dt_sale_type_code_pcnt
          ,le.populated_mortgage_company_name_pcnt
          ,le.populated_src_mortgage_company_name_pcnt
          ,le.populated_rec_dt_mortgage_company_name_pcnt
          ,le.populated_loan_amount_pcnt
          ,le.populated_src_loan_amount_pcnt
          ,le.populated_rec_dt_loan_amount_pcnt
          ,le.populated_second_loan_amount_pcnt
          ,le.populated_src_second_loan_amount_pcnt
          ,le.populated_rec_dt_second_loan_amount_pcnt
          ,le.populated_loan_type_code_pcnt
          ,le.populated_src_loan_type_code_pcnt
          ,le.populated_rec_dt_loan_type_code_pcnt
          ,le.populated_interest_rate_type_code_pcnt
          ,le.populated_src_interest_rate_type_code_pcnt
          ,le.populated_rec_dt_interest_rate_type_code_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,283,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Property_Characteristics));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),283,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Property_Characteristics) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Property_Characteristics, Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor_source');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, vendor_source, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
