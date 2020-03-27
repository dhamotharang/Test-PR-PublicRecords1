MODULE:Scrubs_LN_PropertyV2_Assessor
FILENAME:Property_Assessor
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 2.295662e+263tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_address:SPACES( ):ALLOW(',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -):WORDS(1,2,3,4,5)
FIELDTYPE:invalid_apn:SPACES( ):ALLOW( _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LENGTHS(1..)
FIELDTYPE:invalid_csz:SPACES( ):ALLOW( ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)
FIELDTYPE:invalid_year:custom(Scrubs_LN_PropertyV2_Assessor.fn_valid_year>0)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:invalid_phone:ALLOW(0123456789):LENGTHS(0..10)
FIELDTYPE:invalid_fips:SPACES( ):ALLOW(0123456789):LENGTHS(5):WITHIN(Scrubs_LN_PropertyV2_Assessor.file_fips,fips_code)
FIELDTYPE:invalid_prop_amount:ALLOW(0123456789.)
FIELDTYPE:invalid_tax_amount:ALLOW(0123456789.)
FIELDTYPE:invalid_state_num:ALLOW(0123456789):LENGTHS(2):INRANGE(1,78)
FIELDTYPE:invalid_state_code:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2)
FIELDTYPE:invalud_document_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-&'):SPACES( -.)
FIELDTYPE:invalid_land_use:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'LAND_USE', 'FARES_2580')
FIELDTYPE:invalid_ownership_rights_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'OWNER_OWNERSHIP_RIGHTS_CODE', 'FARES_2580')
FIELDTYPE:invalid_relationship_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'OWNER_RELATIONSHIP_CODE', 'FARES_2580')
FIELDTYPE:invalid_name_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'ASSESSEE_NAME_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_second_name_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'SECOND_ASSESSEE_NAME_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_mail_care_of_name_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'MAIL_CARE_OF_NAME_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_record_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'RECORD_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_legal_lot_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'LEGAL_LOT_CODE', 'FARES_2580')
FIELDTYPE:invalid_ownership_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'OWNERSHIP_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_new_record_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'NEW_RECORD_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_sale_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'SALE_CODE', 'FARES_2580')
//FIELDTYPE:invalid_prior_sales_price_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'PRIOR_SALES_PRICE_CODE', 'FARES_2580')
FIELDTYPE:invalid_prior_sales_price_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'PRIOR_SALES_CODE', 'FARES_2580')
FIELDTYPE:invalid_mortgage_loan_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'MORTGAGE_LOAN_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_mortgage_lender_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'MORTGAGE_LENDER_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_tax_exemption1_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'TAX_EXEMPTION1_CODE', 'FARES_2580')
FIELDTYPE:invalid_tax_exemption2_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'TAX_EXEMPTION2_CODE', 'FARES_2580')
FIELDTYPE:invalid_tax_exemption3_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'TAX_EXEMPTION3_CODE', 'FARES_2580')
FIELDTYPE:invalid_tax_exemption4_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'TAX_EXEMPTION4_CODE', 'FARES_2580')
FIELDTYPE:invalid_no_of_stories:ALLOW(0123456789.AB+):LENGTHS(0..5)
FIELDTYPE:invalid_garage_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'GARAGE', 'FARES_2580')
FIELDTYPE:invalid_pool_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'POOL_CODE', 'FARES_2580')
FIELDTYPE:invalid_exterior_walls_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'EXTERIOR_WALLS', 'FARES_2580')
FIELDTYPE:invalid_roof_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'ROOF_TYPE', 'FARES_2580')
FIELDTYPE:invalid_heating_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'HEATING', 'FARES_2580')
FIELDTYPE:invalid_heating_fuel_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'FUEL', 'FARES_2580')
FIELDTYPE:invalid_air_conditioning_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'AIR_CONDITIONING_TYPE_CODE', 'FARES_2580')
FIELDTYPE:invalid_building_class_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_CLASS_CODE', 'FARES_2580')
FIELDTYPE:invalid_site_influence1_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'LOCATION_INFLUENCE', 'FARES_2580')
FIELDTYPE:invalid_amenities1_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'AMENITIES1_CODE', 'FARES_2580')
FIELDTYPE:invalid_amenities2_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'AMENITIES2_CODE', 'FARES_2580')
FIELDTYPE:invalid_amenities3_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'AMENITIES3_CODE', 'FARES_2580')
FIELDTYPE:invalid_amenities4_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'AMENITIES4_CODE', 'FARES_2580')
FIELDTYPE:invalid_other_buildings1_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BLDG_IMPV_CODE', 'FARES_2580')
FIELDTYPE:invalid_fireplace_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'FIREPLACE_INDICATOR', 'FARES_2580')
FIELDTYPE:invalid_property_address_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'PROPERTY_ADDRESS_CODE', 'FARES_2580')
FIELDTYPE:invalid_floor_cover_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'FLOOR_COVER', 'FARES_2580')
FIELDTYPE:invalid_building_quality_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'QUALITY','FARES_2580')
FIELDTYPE:invalid_document_type_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'DOCUMENT_TYPE_CODE', 'FARES_2580'):SPACES( ):ALLOW( -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&'-)
//FIELDTYPE:invalid_basement_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BASEMENT_CODE', 'FARES_2580')
FIELDTYPE:invalid_basement_code:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BASEMENT_FINISH', 'FARES_2580')
//FIELDTYPE:invalid_building_area_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA_INDICATOR', 'FARES_2580')
FIELDTYPE:invalid_building_area_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_SQ_FEET_IND', 'FARES_2580')
FIELDTYPE:invalid_building_area1_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA1_INDICATOR', 'FARES_2580')                  
FIELDTYPE:invalid_building_area2_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA2_INDICATOR', 'FARES_2580')               
FIELDTYPE:invalid_building_area3_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA3_INDICATOR', 'FARES_2580')                   
FIELDTYPE:invalid_building_area4_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA4_INDICATOR', 'FARES_2580')                      
FIELDTYPE:invalid_building_area5_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA5_INDICATOR', 'FARES_2580')                      
FIELDTYPE:invalid_building_area6_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA6_INDICATOR', 'FARES_2580')                     
FIELDTYPE:invalid_building_area7_indicator:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'BUILDING_AREA7_INDICATOR', 'FARES_2580')                    
FIELDTYPE:invalid_construction_type:CUSTOM(fn_valid_codesv3_property > 0,vendor_source_flag,'CONSTRUCTION_TYPE', 'FARES_2580')                                    
                       
FIELD:ln_fares_id:0,0
DATEFIELD:process_date:LIKE(invalid_date):0,0
FIELD:vendor_source_flag:0,0
FIELD:current_record:0,0
FIELD:fips_code:LIKE(invalid_fips):0,0
FIELD:state_code:LIKE(invalid_state_code):0,0
FIELD:county_name:LIKE(invalid_county_name):0,0
FIELD:old_apn:0,0
FIELD:apna_or_pin_number:LIKE(invalid_apn):0,0
FIELD:fares_unformatted_apn:0,0
FIELD:duplicate_apn_multiple_address_id:0,0
FIELD:assessee_name:LIKE(invalid_alpha):0,0
FIELD:second_assessee_name:LIKE(invalid_alpha):0,0
FIELD:assessee_ownership_rights_code:LIKE(invalid_ownership_rights_code):0,0
FIELD:assessee_relationship_code:LIKE(invalid_relationship_code):0,0
FIELD:assessee_phone_number:LIKE(invalid_phone):0,0
FIELD:tax_account_number:0,0
FIELD:contract_owner:0,0
FIELD:assessee_name_type_code:LIKE(invalid_name_type_code):0,0
FIELD:second_assessee_name_type_code:LIKE(invalid_second_name_type_code):0,0
FIELD:mail_care_of_name_type_code:LIKE(invalid_mail_care_of_name_type_code):0,0
FIELD:mailing_care_of_name:LIKE(invalid_alpha):0,0
FIELD:mailing_full_street_address:LIKE(invalid_address):0,0
FIELD:mailing_unit_number:LIKE(invalid_address):0,0
FIELD:mailing_city_state_zip:LIKE(invalid_csz):0,0
FIELD:property_full_street_address:LIKE(invalid_address):0,0
FIELD:property_unit_number:LIKE(invalid_address):0,0
FIELD:property_city_state_zip:LIKE(invalid_csz):0,0
FIELD:property_country_code:0,0
FIELD:property_address_code:LIKE(invalid_property_address_code):0,0
FIELD:legal_lot_code:LIKE(invalid_legal_lot_code):0,0
FIELD:legal_lot_number:0,0
FIELD:legal_land_lot:0,0
FIELD:legal_block:0,0
FIELD:legal_section:0,0
FIELD:legal_district:0,0
FIELD:legal_unit:0,0
FIELD:legal_city_municipality_township:0,0
FIELD:legal_subdivision_name:0,0
FIELD:legal_phase_number:0,0
FIELD:legal_tract_number:0,0
FIELD:legal_sec_twn_rng_mer:0,0
FIELD:legal_brief_description:0,0
FIELD:legal_assessor_map_ref:0,0
FIELD:census_tract:0,0
FIELD:record_type_code:LIKE(invalid_record_type_code):0,0
FIELD:ownership_type_code:LIKE(invalid_ownership_type_code):0,0
FIELD:new_record_type_code:LIKE(invalid_new_record_type_code):0,0
FIELD:state_land_use_code:0,0
FIELD:county_land_use_code:0,0
FIELD:county_land_use_description:0,0
FIELD:standardized_land_use_code:LIKE(invalid_land_use):0,0
FIELD:timeshare_code:0,0
FIELD:zoning:0,0
FIELD:owner_occupied:0,0
FIELD:recorder_document_number:0,0
FIELD:recorder_book_number:0,0
FIELD:recorder_page_number:0,0
DATEFIELD:transfer_date:LIKE(invalid_date):0,0
DATEFIELD:recording_date:LIKE(invalid_date):0,0
DATEFIELD:sale_date:LIKE(invalid_date):0,0
FIELD:document_type:LIKE(invalid_document_type_code):0,0
FIELD:sales_price:LIKE(invalid_prop_amount):0,0
FIELD:sales_price_code:LIKE(invalid_sale_code):0,0
FIELD:mortgage_loan_amount:LIKE(invalid_prop_amount):0,0
FIELD:mortgage_loan_type_code:LIKE(invalid_mortgage_loan_type_code):0,0
FIELD:mortgage_lender_name:LIKE(invalid_alpha):0,0
FIELD:mortgage_lender_type_code:LIKE(invalid_mortgage_lender_type_code):0,0
DATEFIELD:prior_transfer_date:LIKE(invalid_date):0,0
DATEFIELD:prior_recording_date:LIKE(invalid_date):0,0
FIELD:prior_sales_price:LIKE(invalid_prop_amount):0,0
FIELD:prior_sales_price_code:LIKE(invalid_prior_sales_price_code):0,0
FIELD:assessed_land_value:LIKE(invalid_prop_amount):0,0
FIELD:assessed_improvement_value:LIKE(invalid_prop_amount):0,0
FIELD:assessed_total_value:LIKE(invalid_prop_amount):0,0
FIELD:assessed_value_year:LIKE(invalid_year):0,0
FIELD:market_land_value:LIKE(invalid_prop_amount):0,0
FIELD:market_improvement_value:LIKE(invalid_prop_amount):0,0
FIELD:market_total_value:LIKE(invalid_prop_amount):0,0
FIELD:market_value_year:LIKE(invalid_year):0,0
FIELD:homestead_homeowner_exemption:0,0
FIELD:tax_exemption1_code:LIKE(invalid_tax_exemption1_code):0,0
FIELD:tax_exemption2_code:LIKE(invalid_tax_exemption2_code):0,0
FIELD:tax_exemption3_code:LIKE(invalid_tax_exemption3_code):0,0
FIELD:tax_exemption4_code:LIKE(invalid_tax_exemption4_code):0,0
FIELD:tax_rate_code_area:0,0
FIELD:tax_amount:LIKE(invalid_tax_amount):0,0
FIELD:tax_year:LIKE(invalid_year):0,0
FIELD:tax_delinquent_year:LIKE(invalid_year):0,0
FIELD:school_tax_district1:0,0
FIELD:school_tax_district1_indicator:0,0
FIELD:school_tax_district2:0,0
FIELD:school_tax_district2_indicator:0,0
FIELD:school_tax_district3:0,0
FIELD:school_tax_district3_indicator:0,0
FIELD:lot_size:0,0
FIELD:lot_size_acres:0,0
FIELD:lot_size_frontage_feet:0,0
FIELD:lot_size_depth_feet:0,0
FIELD:land_acres:0,0
FIELD:land_square_footage:0,0
FIELD:land_dimensions:0,0
FIELD:building_area:0,0
FIELD:building_area_indicator:LIKE(invalid_building_area_indicator):0,0
FIELD:building_area1:0,0
FIELD:building_area1_indicator:LIKE(invalid_building_area1_indicator):0,0
FIELD:building_area2:0,0
FIELD:building_area2_indicator:LIKE(invalid_building_area2_indicator):0,0
FIELD:building_area3:0,0
FIELD:building_area3_indicator:LIKE(invalid_building_area3_indicator):0,0
FIELD:building_area4:0,0
FIELD:building_area4_indicator:LIKE(invalid_building_area4_indicator):0,0
FIELD:building_area5:0,0
FIELD:building_area5_indicator:LIKE(invalid_building_area5_indicator):0,0
FIELD:building_area6:0,0
FIELD:building_area6_indicator:LIKE(invalid_building_area6_indicator):0,0
FIELD:building_area7:0,0
FIELD:building_area7_indicator:LIKE(invalid_building_area7_indicator):0,0
FIELD:year_built:LIKE(invalid_year):0,0
FIELD:effective_year_built:LIKE(invalid_year):0,0
FIELD:no_of_buildings:0,0
FIELD:no_of_stories:LIKE(invalid_no_of_stories):0,0
FIELD:no_of_units:0,0
FIELD:no_of_rooms:0,0
FIELD:no_of_bedrooms:0,0
FIELD:no_of_baths:0,0
FIELD:no_of_partial_baths:0,0
FIELD:no_of_plumbing_fixtures:0,0
FIELD:garage_type_code:LIKE(invalid_garage_type_code):0,0
FIELD:parking_no_of_cars:0,0
FIELD:pool_code:LIKE(invalid_pool_code):0,0
FIELD:style_code:0,0
FIELD:type_construction_code:LIKE(invalid_construction_type):0,0
FIELD:foundation_code:0,0
FIELD:building_quality_code:LIKE(invalid_building_quality_code):0,0
FIELD:building_condition_code:0,0
FIELD:exterior_walls_code:LIKe(invalid_exterior_walls_code):0,0
FIELD:interior_walls_code:0,0
FIELD:roof_cover_code:0,0
FIELD:roof_type_code:LIKE(invalid_roof_type_code):0,0
FIELD:floor_cover_code:LIKe(invalid_floor_cover_code):0,0
FIELD:water_code:0,0
FIELD:sewer_code:0,0
FIELD:heating_code:LIKE(invalid_heating_code):0,0
FIELD:heating_fuel_type_code:LIKE(invalid_heating_fuel_type_code):0,0
FIELD:air_conditioning_code:0,0
FIELD:air_conditioning_type_code:LIKE(invalid_air_conditioning_type_code):0,0
FIELD:elevator:0,0
FIELD:fireplace_indicator:LIKE(invalid_fireplace_indicator):0,0
FIELD:fireplace_number:0,0
FIELD:basement_code:LIKE(invalid_basement_code):0,0
FIELD:building_class_code:LIKE(invalid_building_class_code):0,0
FIELD:site_influence1_code:LIKE(invalid_site_influence1_code):0,0
FIELD:site_influence2_code:0,0
FIELD:site_influence3_code:0,0
FIELD:site_influence4_code:0,0
FIELD:site_influence5_code:0,0
FIELD:amenities1_code:LIKe(invalid_amenities1_code):0,0
FIELD:amenities2_code:LIKe(invalid_amenities2_code):0,0
FIELD:amenities3_code:LIKe(invalid_amenities3_code):0,0
FIELD:amenities4_code:LIKe(invalid_amenities4_code):0,0
FIELD:amenities5_code:0,0
FIELD:amenities2_code1:0,0
FIELD:amenities2_code2:0,0
FIELD:amenities2_code3:0,0
FIELD:amenities2_code4:0,0
FIELD:amenities2_code5:0,0
FIELD:extra_features1_area:0,0
FIELD:extra_features1_indicator:0,0
FIELD:extra_features2_area:0,0
FIELD:extra_features2_indicator:0,0
FIELD:extra_features3_area:0,0
FIELD:extra_features3_indicator:0,0
FIELD:extra_features4_area:0,0
FIELD:extra_features4_indicator:0,0
FIELD:other_buildings1_code:LIKE(invalid_other_buildings1_code):0,0
FIELD:other_buildings2_code:0,0
FIELD:other_buildings3_code:0,0
FIELD:other_buildings4_code:0,0
FIELD:other_buildings5_code:0,0
FIELD:other_impr_building1_indicator:0,0
FIELD:other_impr_building2_indicator:0,0
FIELD:other_impr_building3_indicator:0,0
FIELD:other_impr_building4_indicator:0,0
FIELD:other_impr_building5_indicator:0,0
FIELD:other_impr_building_area1:0,0
FIELD:other_impr_building_area2:0,0
FIELD:other_impr_building_area3:0,0
FIELD:other_impr_building_area4:0,0
FIELD:other_impr_building_area5:0,0
FIELD:topograpy_code:0,0
FIELD:neighborhood_code:0,0
FIELD:condo_project_or_building_name:0,0
FIELD:assessee_name_indicator:0,0
FIELD:second_assessee_name_indicator:0,0
FIELD:other_rooms_indicator:0,0
FIELD:mail_care_of_name_indicator:0,0
FIELD:comments:0,0
DATEFIELD:tape_cut_date:LIKE(invalid_date):0,0
DATEFIELD:certification_date:LIKE(invalid_date):0,0
FIELD:edition_number:0,0
FIELD:prop_addr_propagated_ind:0,0
FIELD:ln_ownership_rights:0,0
FIELD:ln_relationship_type:0,0
FIELD:ln_mailing_country_code:0,0
FIELD:ln_property_name:0,0
FIELD:ln_property_name_type:0,0
FIELD:ln_land_use_category:0,0
FIELD:ln_lot:0,0
FIELD:ln_block:0,0
FIELD:ln_unit:0,0
FIELD:ln_subfloor:0,0
FIELD:ln_floor_cover:0,0
FIELD:ln_mobile_home_indicator:0,0
FIELD:ln_condo_indicator:0,0
FIELD:ln_property_tax_exemption:0,0
FIELD:ln_veteran_status:0,0
FIELD:ln_old_apn_indicator:0,0
FIELD:fips:LIKE(invalid_fips):0,0
SOURCEFIELD:fips_code:CONSISTENT(standardized_land_use_code,document_type,sales_price,mortgage_loan_type_code)
RECORDTYPE:trans_before_proc:CONDITION(transfer_date,<,process_date):VALID(transfer_date,process_date)
RECORDTYPE:rec_before_proc:CONDITION(recording_date,<,process_date):VALID(recording_date,process_date)
RECORDTYPE:sale_before_proc:CONDITION(sale_date,<,process_date):VALID(sale_date,process_date)
RECORDTYPE:ptrans_before_proc:CONDITION(prior_transfer_date,<,process_date):VALID(prior_transfer_date,process_date)
RECORDTYPE:prior_rec_before_proc:CONDITION(prior_recording_date,<,process_date):VALID(prior_recording_date,process_date)
RECORDTYPE:cert_before_proc:CONDITION(certification_date,<,process_date):VALID(certification_date,process_date)
RECORDTYPE:cut_before_proc:CONDITION(tape_cut_date,<,process_date):VALID(tape_cut_date,process_date)
RECORDTYPE:AssImp_Eq_AssTot:CONDITION(assessed_improvement_value,<,assessed_total_value):VALID(assessed_improvement_value,assessed_total_value) 
RECORDTYPE:MarImp_Eq_MarTot:CONDITION(market_improvement_value,<,market_total_value):VALID(market_improvement_value,market_total_value)
RECORDTYPE:AssLnd_Eq_AssTot:CONDITION(assessed_land_value,<=,assessed_total_value):VALID(assessed_land_value,assessed_total_value) 
RECORDTYPE:MarLnd_Eq_MarTot:CONDITION(market_land_value,<=,market_total_value):VALID(market_land_value,market_total_value)
RECORDTYPE:tax_less_than_total_assessed:TAG(assessed_total_value,''):NOTAG:CONDITION(tax_amount,<=,assessed_total_value):VALID(tax_amount,assessed_total_value)