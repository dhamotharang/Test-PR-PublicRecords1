﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Assessor.BWR_PopulationStatistics - Population Statistics - SALT V3.11.0');
IMPORT Scrubs_LN_PropertyV2_Assessor,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_LN_PropertyV2_Assessor.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*fips_code Field*/,/* ln_fares_id_field */,/* process_date_field */,/* vendor_source_flag_field */,/* current_record_field */,/* fips_code_field */,/* state_code_field */,/* county_name_field */,/* old_apn_field */,/* apna_or_pin_number_field */,/* fares_unformatted_apn_field */,/* duplicate_apn_multiple_address_id_field */,/* assessee_name_field */,/* second_assessee_name_field */,/* assessee_ownership_rights_code_field */,/* assessee_relationship_code_field */,/* assessee_phone_number_field */,/* tax_account_number_field */,/* contract_owner_field */,/* assessee_name_type_code_field */,/* second_assessee_name_type_code_field */,/* mail_care_of_name_type_code_field */,/* mailing_care_of_name_field */,/* mailing_full_street_address_field */,/* mailing_unit_number_field */,/* mailing_city_state_zip_field */,/* property_full_street_address_field */,/* property_unit_number_field */,/* property_city_state_zip_field */,/* property_country_code_field */,/* property_address_code_field */,/* legal_lot_code_field */,/* legal_lot_number_field */,/* legal_land_lot_field */,/* legal_block_field */,/* legal_section_field */,/* legal_district_field */,/* legal_unit_field */,/* legal_city_municipality_township_field */,/* legal_subdivision_name_field */,/* legal_phase_number_field */,/* legal_tract_number_field */,/* legal_sec_twn_rng_mer_field */,/* legal_brief_description_field */,/* legal_assessor_map_ref_field */,/* census_tract_field */,/* record_type_code_field */,/* ownership_type_code_field */,/* new_record_type_code_field */,/* state_land_use_code_field */,/* county_land_use_code_field */,/* county_land_use_description_field */,/* standardized_land_use_code_field */,/* timeshare_code_field */,/* zoning_field */,/* owner_occupied_field */,/* recorder_document_number_field */,/* recorder_book_number_field */,/* recorder_page_number_field */,/* transfer_date_field */,/* recording_date_field */,/* sale_date_field */,/* document_type_field */,/* sales_price_field */,/* sales_price_code_field */,/* mortgage_loan_amount_field */,/* mortgage_loan_type_code_field */,/* mortgage_lender_name_field */,/* mortgage_lender_type_code_field */,/* prior_transfer_date_field */,/* prior_recording_date_field */,/* prior_sales_price_field */,/* prior_sales_price_code_field */,/* assessed_land_value_field */,/* assessed_improvement_value_field */,/* assessed_total_value_field */,/* assessed_value_year_field */,/* market_land_value_field */,/* market_improvement_value_field */,/* market_total_value_field */,/* market_value_year_field */,/* homestead_homeowner_exemption_field */,/* tax_exemption1_code_field */,/* tax_exemption2_code_field */,/* tax_exemption3_code_field */,/* tax_exemption4_code_field */,/* tax_rate_code_area_field */,/* tax_amount_field */,/* tax_year_field */,/* tax_delinquent_year_field */,/* school_tax_district1_field */,/* school_tax_district1_indicator_field */,/* school_tax_district2_field */,/* school_tax_district2_indicator_field */,/* school_tax_district3_field */,/* school_tax_district3_indicator_field */,/* lot_size_field */,/* lot_size_acres_field */,/* lot_size_frontage_feet_field */,/* lot_size_depth_feet_field */,/* land_acres_field */,/* land_square_footage_field */,/* land_dimensions_field */,/* building_area_field */,/* building_area_indicator_field */,/* building_area1_field */,/* building_area1_indicator_field */,/* building_area2_field */,/* building_area2_indicator_field */,/* building_area3_field */,/* building_area3_indicator_field */,/* building_area4_field */,/* building_area4_indicator_field */,/* building_area5_field */,/* building_area5_indicator_field */,/* building_area6_field */,/* building_area6_indicator_field */,/* building_area7_field */,/* building_area7_indicator_field */,/* year_built_field */,/* effective_year_built_field */,/* no_of_buildings_field */,/* no_of_stories_field */,/* no_of_units_field */,/* no_of_rooms_field */,/* no_of_bedrooms_field */,/* no_of_baths_field */,/* no_of_partial_baths_field */,/* no_of_plumbing_fixtures_field */,/* garage_type_code_field */,/* parking_no_of_cars_field */,/* pool_code_field */,/* style_code_field */,/* type_construction_code_field */,/* foundation_code_field */,/* building_quality_code_field */,/* building_condition_code_field */,/* exterior_walls_code_field */,/* interior_walls_code_field */,/* roof_cover_code_field */,/* roof_type_code_field */,/* floor_cover_code_field */,/* water_code_field */,/* sewer_code_field */,/* heating_code_field */,/* heating_fuel_type_code_field */,/* air_conditioning_code_field */,/* air_conditioning_type_code_field */,/* elevator_field */,/* fireplace_indicator_field */,/* fireplace_number_field */,/* basement_code_field */,/* building_class_code_field */,/* site_influence1_code_field */,/* site_influence2_code_field */,/* site_influence3_code_field */,/* site_influence4_code_field */,/* site_influence5_code_field */,/* amenities1_code_field */,/* amenities2_code_field */,/* amenities3_code_field */,/* amenities4_code_field */,/* amenities5_code_field */,/* amenities2_code1_field */,/* amenities2_code2_field */,/* amenities2_code3_field */,/* amenities2_code4_field */,/* amenities2_code5_field */,/* extra_features1_area_field */,/* extra_features1_indicator_field */,/* extra_features2_area_field */,/* extra_features2_indicator_field */,/* extra_features3_area_field */,/* extra_features3_indicator_field */,/* extra_features4_area_field */,/* extra_features4_indicator_field */,/* other_buildings1_code_field */,/* other_buildings2_code_field */,/* other_buildings3_code_field */,/* other_buildings4_code_field */,/* other_buildings5_code_field */,/* other_impr_building1_indicator_field */,/* other_impr_building2_indicator_field */,/* other_impr_building3_indicator_field */,/* other_impr_building4_indicator_field */,/* other_impr_building5_indicator_field */,/* other_impr_building_area1_field */,/* other_impr_building_area2_field */,/* other_impr_building_area3_field */,/* other_impr_building_area4_field */,/* other_impr_building_area5_field */,/* topograpy_code_field */,/* neighborhood_code_field */,/* condo_project_or_building_name_field */,/* assessee_name_indicator_field */,/* second_assessee_name_indicator_field */,/* other_rooms_indicator_field */,/* mail_care_of_name_indicator_field */,/* comments_field */,/* tape_cut_date_field */,/* certification_date_field */,/* edition_number_field */,/* prop_addr_propagated_ind_field */,/* ln_ownership_rights_field */,/* ln_relationship_type_field */,/* ln_mailing_country_code_field */,/* ln_property_name_field */,/* ln_property_name_type_field */,/* ln_land_use_category_field */,/* ln_lot_field */,/* ln_block_field */,/* ln_unit_field */,/* ln_subfloor_field */,/* ln_floor_cover_field */,/* ln_mobile_home_indicator_field */,/* ln_condo_indicator_field */,/* ln_property_tax_exemption_field */,/* ln_veteran_status_field */,/* ln_old_apn_indicator_field */,/* fips_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
