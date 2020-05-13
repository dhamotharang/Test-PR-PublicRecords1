// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'CollateralAnalytics';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rid'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'CollateralAnalytics';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:rid';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,ca_id,mls_geo_full_address,mls_geo_city,mls_geo_state,mls_geo_zip_code,ca_assessed_improvements,ca_assessed_land,ca_assessed_val,ca_assessment_perc_replacement_value,ca_avm_high,ca_avm_low,ca_avm_value,ca_building_percent,ca_fsd_score,ca_land_price_implied_replacement_value,ca_market_condition,ca_most_recent_loan,ca_most_recent_sale_price,ca_original_loan_1st_loan_amt,ca_original_purchase_loan_amt,ca_original_purchase_loan_date,ca_refi_1st_loan_amt,ca_refi_date,ca_sold_date_1,ca_sold_price_1,mls_air_conditioning_type,mls_apn,mls_bath_total,mls_baths_full,mls_baths_partial,mls_bedrooms,mls_block_number,mls_building_square_footage,mls_construction_type,mls_dom,mls_exterior_wall_type,mls_fireplace_type,mls_fireplace_yn,mls_first_floor_square_footage,mls_flood_zone_panel,mls_floor_type,mls_foundation,mls_fuel_type,mls_garage,mls_geo_county,mls_geo_fips,mls_geo_lat,mls_geo_lon,mls_heating,mls_interest_rate_type_code,mls_list_date_1,mls_list_dt,mls_list_price,mls_list_price_1,mls_living_area,mls_loan_amount,mls_loan_type_code,mls_lot_depth_footage,mls_lot_number,mls_lot_size,mls_lot_size_acre,mls_mortgage_company_name,mls_nbr_stories,mls_neighborhood,mls_number_of_bath_fixtures,mls_number_of_fireplaces,mls_number_of_rooms,mls_number_of_units,mls_parking_type,mls_pool_type,mls_pool_yn,mls_prop_style,mls_property_condition,mls_property_type,mls_roof_cover,mls_sale_date_pr,mls_sale_price_pr,mls_sale_type_code,mls_second_loan_amount,mls_sewer,mls_sold_date,mls_sold_price,mls_tax_amount,mls_tax_year,mls_water,mls_year_built,mls_zoning,mls_remarks,rawaid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gn\n'
    + 'MODULE:CollateralAnalytics\n'
    + 'FILENAME:CollateralAnalytics\n'
    + 'RIDFIELD:rid:GENERATE\n'
    + 'INGESTFILE:CollaterialAnalytics_Update:NAMED(CollateralAnalytics.File_CollaterialAnalytics_Base)\n'
    + '\n'
    + 'FIELD:process_date:RECORDDATE(LAST):TYPE(STRING8):0,0\n'
    + 'FIELD:date_first_seen:RECORDDATE(FIRST):TYPE(STRING8):0,0\n'
    + 'FIELD:date_last_seen:RECORDDATE(LAST):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_first_reported:RECORDDATE(FIRST):TYPE(STRING8):0,0\n'
    + 'FIELD:date_vendor_last_reported:RECORDDATE(LAST):TYPE(STRING8):0,0\n'
    + 'FIELD:ca_id:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_full_address:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_city:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_state:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_zip_code:TYPE(STRING):0,0\n'
    + 'FIELD:ca_assessed_improvements:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_assessed_land:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_assessed_val:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_assessment_perc_replacement_value:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_avm_high:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_avm_low:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_avm_value:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_building_percent:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_fsd_score:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_land_price_implied_replacement_value:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_market_condition:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_most_recent_loan:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_most_recent_sale_price:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_original_loan_1st_loan_amt:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_original_purchase_loan_amt:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_original_purchase_loan_date:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_refi_1st_loan_amt:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_refi_date:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_sold_date_1:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:ca_sold_price_1:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_air_conditioning_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_apn:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_bath_total:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_baths_full:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_baths_partial:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_bedrooms:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_block_number:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_building_square_footage:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_construction_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_dom:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_exterior_wall_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_fireplace_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_fireplace_yn:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_first_floor_square_footage:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_flood_zone_panel:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_floor_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_foundation:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_fuel_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_garage:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_county:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_fips:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_lat:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_geo_lon:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_heating:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_interest_rate_type_code:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_list_date_1:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_list_dt:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_list_price:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_list_price_1:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_living_area:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_loan_amount:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_loan_type_code:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_lot_depth_footage:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_lot_number:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_lot_size:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_lot_size_acre:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_mortgage_company_name:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_nbr_stories:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_neighborhood:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_number_of_bath_fixtures:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_number_of_fireplaces:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_number_of_rooms:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_number_of_units:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_parking_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_pool_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_pool_yn:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_prop_style:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_property_condition:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_property_type:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_roof_cover:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sale_date_pr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sale_price_pr:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sale_type_code:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_second_loan_amount:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sewer:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sold_date:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_sold_price:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_tax_amount:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_tax_year:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_water:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_year_built:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_zoning:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:mls_remarks:DERIVED:TYPE(STRING):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:county:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

