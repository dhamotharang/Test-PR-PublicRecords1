﻿Generated by SALT V3.11.9
Command line options: -MScrubs_Property_Characteristics -eC:\Users\granjo01\AppData\Local\Temp\TFREF72.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_Property_Characteristics
FILENAME:Property_Characteristics
 
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
 
SOURCEFIELD:vendor_source
 
FIELDTYPE:invalid_nums:ALLOW(0123456789.):SPACES( )
FIELDTYPE:invalid_vendor_source:LENGTHS(0,5):ENUM(FARES|OKCTY|DEFLT|)
FIELDTYPE:invalid_fireplace_indicator:ENUM(Y|N|)
FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.'#:;*+;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
//FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789;-.@%&'#\/,`:):SPACES( <>{}[]-^+&,./#()):LENGTHS(1..)
FIELDTYPE:invalid_address:SPACES( ):ALLOW(',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
//FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ/-&'):SPACES( -.):LENGTHS(1..)
FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -):WORDS(1,2,3,4,5)
FIELDTYPE:invalid_apn:SPACES( ):ALLOW( _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(1..)
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)
FIELDTYPE:invalid_year:ALLOW(0123456789):LENGTHS(0,4)
FIELDTYPE:invalid_date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_fips:SPACES( ):ALLOW(0123456789):LENGTHS(0,5):WITHIN(Scrubs_LN_PropertyV2_Assessor.file_fips,fips_code)
FIELDTYPE:invalid_prop_amount:ALLOW(0123456789.):INRANGE(0,10000000)
FIELDTYPE:invalid_tax_amount:ALLOW(0123456789.):INRANGE(0,1000000)
FIELDTYPE:invalid_document_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz0123456789()/-&':_.):SPACES( )
FIELDTYPE:invalid_land_use:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_land_use_code,'LAND_USE_CODE', 'PROPERTYINFO') 
FIELDTYPE:invalid_air_conditioning_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_air_conditioning_type,'AIR_CONDITIONING_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_basement_finish_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_basement_finish,'BASEMENT_FINISH', 'PROPERTYINFO')
FIELDTYPE:invalid_construction_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_construction_type,'CONSTRUCTION_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_exterior_walls_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_exterior_wall,'EXTERIOR_WALL', 'PROPERTYINFO')
FIELDTYPE:invalid_fireplace_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_fireplace_type,'FIREPLACE_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_floor_cover_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_floor_type,'FLOOR_COVER', 'PROPERTYINFO')
FIELDTYPE:invalid_frame_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_frame_type,'FRAME', 'PROPERTYINFO')
FIELDTYPE:invalid_foundation_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_foundation,'FOUNDATION_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_garage_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_garage,'GARAGE_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_heating_fuel_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_fuel_type,'FUEL_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_heating_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_heating,'HEATING_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_location_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_location_influence_code,'LOCATION_INFLUENCE', 'PROPERTYINFO')
FIELDTYPE:invalid_parking_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_parking_type,'PARKING_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_pool_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_pool_type,'POOL_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_property_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_property_type_code,'PROPERTY_IND', 'PROPERTYINFO')
FIELDTYPE:invalid_roof_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_roof_cover,'ROOF_COVER_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_sale_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_full_part_sale,'SALE_CODE', 'PROPERTYINFO')
FIELDTYPE:invalid_sale_tran_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_sale_type_code,'SALE_TRANS_CODE', 'PROPERTYINFO')
FIELDTYPE:invalid_sewer_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_sewer,'SEWER_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_stories_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_stories_type,'STORIES_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_structure_quality_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_structure_quality,'QUALITY', 'PROPERTYINFO')
FIELDTYPE:invalid_style_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_style_type,'STYLE_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_water_type:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_water,'WATER_TYPE', 'PROPERTYINFO')
FIELDTYPE:invalid_financing_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_interest_rate_type_code,'TYPE_FINANCING', 'PROPERTYINFO')
FIELDTYPE:invalid_mortgage_loan_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_loan_type_code,'MORTGAGE_LOAN_TYPE_CODE', 'PROPERTYINFO') 
// FIELDTYPE:invalid_document_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,vendor_source,'DOCUMENT_TYPE_CODE', 'PROPERTYINFO')
FIELDTYPE:invalid_mortgage_lender_type_code:CUSTOM(Scrubs_Property_Characteristics.fn_valid_codesv3_propertyinfo > 0,src_loan_type_code,'MORTGAGE_LENDER_TYPE_CODE', 'PROPERTYINFO') 
 
FIELD:property_rid:0,0
DATEFIELD:dt_vendor_first_reported:LIKE(invalid_date):0,0
DATEFIELD:dt_vendor_last_reported:LIKE(invalid_date):0,0
DATEFIELD:tax_sortby_date:LIKE(invalid_date):0,0
DATEFIELD:deed_sortby_date:LIKE(invalid_date):0,0
FIELD:vendor_source:0,0
FIELD:fares_unformatted_apn:LIKE(invalid_apn):0,0
FIELD:property_street_address:LIKE(invalid_address):0,0
FIELD:property_city_state_zip:LIKE(invalid_csz):0,0
FIELD:property_raw_aid:0,0
FIELD:prim_range:LIKE(invalid_address):0,0
FIELD:predir:LIKE(invalid_address):0,0
FIELD:prim_name:LIKE(invalid_address):0,0
FIELD:addr_suffix:LIKE(invalid_address):0,0
FIELD:postdir:LIKE(invalid_address):0,0
FIELD:unit_desig:LIKE(invalid_address):0,0
FIELD:sec_range:LIKE(invalid_address):0,0
FIELD:p_city_name:LIKE(invalid_csz):0,0
FIELD:v_city_name:LIKE(invalid_csz):0,0
FIELD:st:0,0
FIELD:zip:LIKE(invalid_nums):0,0
FIELD:zip4:LIKE(invalid_nums):0,0
FIELD:cart:0,0
FIELD:cr_sort_sz:0,0
FIELD:lot:0,0
FIELD:lot_order:0,0
FIELD:dbpc:0,0
FIELD:chk_digit:0,0
FIELD:rec_type:0,0
FIELD:county:0,0
FIELD:geo_lat:0,0
FIELD:geo_long:0,0
FIELD:msa:0,0
FIELD:geo_blk:0,0
FIELD:geo_match:0,0
FIELD:err_stat:0,0
FIELD:building_square_footage:LIKE(invalid_nums):0,0
FIELD:src_building_square_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_building_square_footage:LIKE(invalid_date):0,0
FIELD:air_conditioning_type:LIKE(invalid_air_conditioning_type_code):0,0
FIELD:src_air_conditioning_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_air_conditioning_type:LIKE(invalid_date):0,0
FIELD:basement_finish:LIKE(invalid_basement_finish_type_code):0,0
FIELD:src_basement_finish:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_basement_finish:LIKE(invalid_date):0,0
FIELD:construction_type:LIKE(invalid_construction_type_code):0,0
FIELD:src_construction_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_construction_type:LIKE(invalid_date):0,0
FIELD:exterior_wall:LIKE(invalid_exterior_walls_code):0,0
FIELD:src_exterior_wall:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_exterior_wall:LIKE(invalid_date):0,0
FIELD:fireplace_ind:LIKE(invalid_fireplace_indicator):0,0
FIELD:src_fireplace_ind:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_fireplace_ind:LIKE(invalid_date):0,0
FIELD:fireplace_type:LIKE(invalid_fireplace_type):0,0
FIELD:src_fireplace_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_fireplace_type:LIKE(invalid_date):0,0
FIELD:flood_zone_panel:0,0
FIELD:src_flood_zone_panel:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_flood_zone_panel:LIKE(invalid_date):0,0
FIELD:garage:LIKE(invalid_garage_type):0,0
FIELD:src_garage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_garage:LIKE(invalid_date):0,0
FIELD:first_floor_square_footage:LIKE(invalid_nums):0,0
FIELD:src_first_floor_square_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_first_floor_square_footage:LIKE(invalid_date):0,0
FIELD:heating:LIKE(invalid_heating_type):0,0
FIELD:src_heating:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_heating:LIKE(invalid_date):0,0
FIELD:living_area_square_footage:LIKE(invalid_nums):0,0
FIELD:src_living_area_square_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_living_area_square_footage:LIKE(invalid_date):0,0
FIELD:no_of_baths:LIKE(invalid_nums):0,0
FIELD:src_no_of_baths:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_baths:LIKE(invalid_date):0,0
FIELD:no_of_bedrooms:LIKE(invalid_nums):0,0
FIELD:src_no_of_bedrooms:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_bedrooms:LIKE(invalid_date):0,0
FIELD:no_of_fireplaces:LIKE(invalid_nums):0,0
FIELD:src_no_of_fireplaces:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_fireplaces:LIKE(invalid_date):0,0
FIELD:no_of_full_baths:LIKE(invalid_nums):0,0
FIELD:src_no_of_full_baths:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_full_baths:LIKE(invalid_date):0,0
FIELD:no_of_half_baths:LIKE(invalid_nums):0,0
FIELD:src_no_of_half_baths:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_half_baths:LIKE(invalid_date):0,0
FIELD:no_of_stories:LIKE(invalid_nums):0,0
FIELD:src_no_of_stories:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_stories:LIKE(invalid_date):0,0
FIELD:parking_type:LIKE(invalid_parking_type):0,0
FIELD:src_parking_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_parking_type:LIKE(invalid_date):0,0
FIELD:pool_indicator:0,0
FIELD:src_pool_indicator:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_pool_indicator:LIKE(invalid_date):0,0
FIELD:pool_type:LIKE(invalid_pool_type):0,0
FIELD:src_pool_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_pool_type:LIKE(invalid_date):0,0
FIELD:roof_cover:LIKE(invalid_roof_type):0,0
FIELD:src_roof_cover:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_roof_cover:LIKE(invalid_date):0,0
FIELD:year_built:LIKE(invalid_year):0,0
FIELD:src_year_built:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_year_built:LIKE(invalid_date):0,0
FIELD:foundation:LIKE(invalid_foundation_type):0,0
FIELD:src_foundation:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_foundation:LIKE(invalid_date):0,0
FIELD:basement_square_footage:LIKE(invalid_nums):0,0
FIELD:src_basement_square_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_basement_square_footage:LIKE(invalid_date):0,0
FIELD:effective_year_built:LIKE(invalid_year):0,0
FIELD:src_effective_year_built:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_effective_year_built:LIKE(invalid_date):0,0
FIELD:garage_square_footage:LIKE(invalid_nums):0,0
FIELD:src_garage_square_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_garage_square_footage:LIKE(invalid_date):0,0
FIELD:stories_type:LIKE(invalid_stories_type):0,0
FIELD:src_stories_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_stories_type:LIKE(invalid_date):0,0
FIELD:apn_number:LIKE(invalid_apn):0,0
FIELD:src_apn_number:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_apn_number:LIKE(invalid_date):0,0
FIELD:census_tract:0,0
FIELD:src_census_tract:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_census_tract:LIKE(invalid_date):0,0
FIELD:range:0,0
FIELD:src_range:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_range:LIKE(invalid_date):0,0
FIELD:zoning:0,0
FIELD:src_zoning:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_zoning:LIKE(invalid_date):0,0
FIELD:block_number:0,0
FIELD:src_block_number:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_block_number:LIKE(invalid_date):0,0
FIELD:county_name:LIKE(invalid_county_name):0,0
FIELD:src_county_name:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_county_name:LIKE(invalid_date):0,0
FIELD:fips_code:LIKE(invalid_fips):0,0
FIELD:src_fips_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_fips_code:LIKE(invalid_date):0,0
FIELD:subdivision:0,0
FIELD:src_subdivision:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_subdivision:LIKE(invalid_date):0,0
FIELD:municipality:0,0
FIELD:src_municipality:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_municipality:LIKE(invalid_date):0,0
FIELD:township:0,0
FIELD:src_township:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_township:LIKE(invalid_date):0,0
FIELD:homestead_exemption_ind:0,0
FIELD:src_homestead_exemption_ind:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_homestead_exemption_ind:LIKE(invalid_date):0,0
FIELD:land_use_code:LIKE(invalid_land_use):0,0
FIELD:src_land_use_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_land_use_code:LIKE(invalid_date):0,0
FIELD:latitude:0,0
FIELD:src_latitude:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_latitude:LIKE(invalid_date):0,0
FIELD:longitude:0,0
FIELD:src_longitude:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_longitude:LIKE(invalid_date):0,0
FIELD:location_influence_code:LIKE(invalid_location_code):0,0
FIELD:src_location_influence_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_location_influence_code:LIKE(invalid_date):0,0
FIELD:acres:0,0
FIELD:src_acres:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_acres:LIKE(invalid_date):0,0
FIELD:lot_depth_footage:0,0
FIELD:src_lot_depth_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_lot_depth_footage:LIKE(invalid_date):0,0
FIELD:lot_front_footage:0,0
FIELD:src_lot_front_footage:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_lot_front_footage:LIKE(invalid_date):0,0
FIELD:lot_number:0,0
FIELD:src_lot_number:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_lot_number:LIKE(invalid_date):0,0
FIELD:lot_size:0,0
FIELD:src_lot_size:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_lot_size:LIKE(invalid_date):0,0
FIELD:property_type_code:LIKE(invalid_property_code):0,0
FIELD:src_property_type_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_property_type_code:LIKE(invalid_date):0,0
FIELD:structure_quality:LIKE(invalid_structure_quality_code):0,0
FIELD:src_structure_quality:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_structure_quality:LIKE(invalid_date):0,0
FIELD:water:LIKE(invalid_water_type):0,0
FIELD:src_water:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_water:LIKE(invalid_date):0,0
FIELD:sewer:LIKE(invalid_sewer_type):0,0
FIELD:src_sewer:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_sewer:LIKE(invalid_date):0,0
FIELD:assessed_land_value:LIKE(invalid_tax_amount):0,0
FIELD:src_assessed_land_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_assessed_land_value:LIKE(invalid_date):0,0
FIELD:assessed_year:LIKE(invalid_year):0,0
FIELD:src_assessed_year:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_assessed_year:LIKE(invalid_date):0,0
FIELD:tax_amount:LIKE(invalid_tax_amount):0,0
FIELD:src_tax_amount:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_tax_amount:LIKE(invalid_date):0,0
FIELD:tax_year:LIKE(invalid_year):0,0
FIELD:src_tax_year:LIKE(invalid_vendor_source):0,0
FIELD:market_land_value:LIKE(invalid_tax_amount):0,0
FIELD:src_market_land_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_market_land_value:LIKE(invalid_date):0,0
FIELD:improvement_value:LIKE(invalid_tax_amount):0,0
FIELD:src_improvement_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_improvement_value:LIKE(invalid_date):0,0
FIELD:percent_improved:0,0
FIELD:src_percent_improved:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_percent_improved:LIKE(invalid_date):0,0
FIELD:total_assessed_value:LIKE(invalid_tax_amount):0,0
FIELD:src_total_assessed_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_total_assessed_value:LIKE(invalid_date):0,0
FIELD:total_calculated_value:LIKE(invalid_tax_amount):0,0
FIELD:src_total_calculated_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_total_calculated_value:LIKE(invalid_date):0,0
FIELD:total_land_value:LIKE(invalid_tax_amount):0,0
FIELD:src_total_land_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_total_land_value:LIKE(invalid_date):0,0
FIELD:total_market_value:LIKE(invalid_tax_amount):0,0
FIELD:src_total_market_value:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_total_market_value:LIKE(invalid_date):0,0
FIELD:floor_type:LIKE(invalid_floor_cover_code):0,0
FIELD:src_floor_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_floor_type:LIKE(invalid_date):0,0
FIELD:frame_type:LIKE(invalid_frame_code):0,0
FIELD:src_frame_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_frame_type:LIKE(invalid_date):0,0
FIELD:fuel_type:LIKE(invalid_heating_fuel_type):0,0
FIELD:src_fuel_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_fuel_type:LIKE(invalid_date):0,0
FIELD:no_of_bath_fixtures:LIKE(invalid_nums):0,0
FIELD:src_no_of_bath_fixtures:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_bath_fixtures:LIKE(invalid_date):0,0
FIELD:no_of_rooms:LIKE(invalid_nums):0,0
FIELD:src_no_of_rooms:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_rooms:LIKE(invalid_date):0,0
FIELD:no_of_units:LIKE(invalid_nums):0,0
FIELD:src_no_of_units:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_no_of_units:LIKE(invalid_date):0,0
FIELD:style_type:LIKE(invalid_style_type):0,0
FIELD:src_style_type:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_style_type:LIKE(invalid_date):0,0
FIELD:assessment_document_number:LIKE(invalid_document_number):0,0
FIELD:src_assessment_document_number:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_assessment_document_number:LIKE(invalid_date):0,0
DATEFIELD:assessment_recording_date:LIKE(invalid_date):0,0
FIELD:src_assessment_recording_date:LIKE(invalid_vendor_source):0,0
DATEFIELD:tax_dt_assessment_recording_date:LIKE(invalid_date):0,0
FIELD:deed_document_number:LIKE(invalid_document_number):0,0
FIELD:src_deed_document_number:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_deed_document_number:LIKE(invalid_date):0,0
DATEFIELD:deed_recording_date:LIKE(invalid_date):0,0
FIELD:src_deed_recording_date:LIKE(invalid_vendor_source):0,0
FIELD:full_part_sale:LIKE(invalid_sale_code):0,0
FIELD:src_full_part_sale:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_full_part_sale:LIKE(invalid_date):0,0
FIELD:sale_amount:LIKE(invalid_tax_amount):0,0
FIELD:src_sale_amount:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_sale_amount:LIKE(invalid_date):0,0
DATEFIELD:sale_date:LIKE(invalid_date):0,0
FIELD:src_sale_date:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_sale_date:LIKE(invalid_date):0,0
FIELD:sale_type_code:like(invalid_sale_tran_code):0,0
FIELD:src_sale_type_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_sale_type_code:LIKE(invalid_date):0,0
FIELD:mortgage_company_name:LIKE(invalid_alpha):0,0
FIELD:src_mortgage_company_name:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_mortgage_company_name:LIKE(invalid_date):0,0
FIELD:loan_amount:LIKE(invalid_tax_amount):0,0
FIELD:src_loan_amount:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_loan_amount:LIKE(invalid_date):0,0
FIELD:second_loan_amount:LIKE(invalid_tax_amount):0,0
FIELD:src_second_loan_amount:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_second_loan_amount:LIKE(invalid_date):0,0
FIELD:loan_type_code:LIKE(invalid_mortgage_loan_type_code):0,0
FIELD:src_loan_type_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_loan_type_code:LIKE(invalid_date):0,0
FIELD:interest_rate_type_code:LIKE(invalid_financing_type_code):0,0
FIELD:src_interest_rate_type_code:LIKE(invalid_vendor_source):0,0
DATEFIELD:rec_dt_interest_rate_type_code:LIKE(invalid_date):0,0
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
