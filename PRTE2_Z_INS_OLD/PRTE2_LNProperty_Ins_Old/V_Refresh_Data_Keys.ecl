/*
 These may be in PRTE_CSV, but it's just easier to grab them right now from the web page
 Key layouts and INDEX definitions for 
addr_search.fid
fcra - addr_search.fid		-- we'll use FCRA versions unless we hit problems.
fcra_assessor.fid
fcra_deed.fid

*/

IMPORT ut;

EXPORT V_Refresh_Data_Keys := MODULE

EXPORT addr_search_fcra_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::fcra::qa::addr_search.fid';
EXPORT addr_search_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::qa::addr_search.fid';
EXPORT fcra_assessor_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::fcra::qa::assessor.fid';
EXPORT fcra_deeds_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::fcra::qa::deed.fid';

// ----------------------------------------------------------------------------------------------------------------
// NOTE: the fcra version limits how many years back, and doesn't need the "keep" in the JOIN
//       the non-fcra will hit an error with too many matches without the "keep" 
EXPORT addr_search_Noni := RECORD
  string12 ln_fares_id;
  string20 lname;
  string20 fname;
  string5 name_suffix;
  unsigned8 __internal_fpos__;
END;
EXPORT addr_search_iFields := RECORD
  string28 prim_name;
  string10 prim_range;
  string5 zip;
  string2 predir;
  string2 postdir;
  string4 suffix;
  string8 sec_range;
  string1 source_code_2;
  boolean ln_owner;
  boolean owner;
  boolean nofares_owner;
  string1 source_code_1;
END;
EXPORT address_search_key := INDEX({addr_search_iFields}, addr_search_Noni, addr_search_key_name);
EXPORT fcra_address_search_key := INDEX({addr_search_iFields}, addr_search_Noni, addr_search_fcra_key_name);

// ----------------------------------------------------------------------------------------------------------------

EXPORT assessorKey_Noni := RECORD
  string8 process_date;
  string1 vendor_source_flag;
  string1 current_record;
  string5 fips_code;
  string2 state_code;
  string30 county_name;
  string31 old_apn;
  string45 apna_or_pin_number;
  string45 fares_unformatted_apn;
  string2 duplicate_apn_multiple_address_id;
  string80 assessee_name;
  string60 second_assessee_name;
  string3 assessee_ownership_rights_code;
  string2 assessee_relationship_code;
  string10 assessee_phone_number;
  string30 tax_account_number;
  string45 contract_owner;
  string1 assessee_name_type_code;
  string1 second_assessee_name_type_code;
  string1 mail_care_of_name_type_code;
  string60 mailing_care_of_name;
  string80 mailing_full_street_address;
  string6 mailing_unit_number;
  string51 mailing_city_state_zip;
  string60 property_full_street_address;
  string6 property_unit_number;
  string51 property_city_state_zip;
  string3 property_country_code;
  string1 property_address_code;
  string2 legal_lot_code;
  string7 legal_lot_number;
  string10 legal_land_lot;
  string7 legal_block;
  string7 legal_section;
  string12 legal_district;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string40 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string250 legal_brief_description;
  string15 legal_assessor_map_ref;
  string10 census_tract;
  string2 record_type_code;
  string2 ownership_type_code;
  string2 new_record_type_code;
  string10 state_land_use_code;
  string10 county_land_use_code;
  string45 county_land_use_description;
  string4 standardized_land_use_code;
  string1 timeshare_code;
  string25 zoning;
  string1 owner_occupied;
  string20 recorder_document_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string8 transfer_date;
  string8 recording_date;
  string8 sale_date;
  string25 document_type;
  string11 sales_price;
  string1 sales_price_code;
  string11 mortgage_loan_amount;
  string5 mortgage_loan_type_code;
  string60 mortgage_lender_name;
  string1 mortgage_lender_type_code;
  string8 prior_transfer_date;
  string8 prior_recording_date;
  string11 prior_sales_price;
  string1 prior_sales_price_code;
  string11 assessed_land_value;
  string11 assessed_improvement_value;
  string11 assessed_total_value;
  string4 assessed_value_year;
  string11 market_land_value;
  string11 market_improvement_value;
  string11 market_total_value;
  string4 market_value_year;
  string1 homestead_homeowner_exemption;
  string1 tax_exemption1_code;
  string1 tax_exemption2_code;
  string1 tax_exemption3_code;
  string1 tax_exemption4_code;
  string18 tax_rate_code_area;
  string13 tax_amount;
  string4 tax_year;
  string4 tax_delinquent_year;
  string15 school_tax_district1;
  string1 school_tax_district1_indicator;
  string15 school_tax_district2;
  string1 school_tax_district2_indicator;
  string15 school_tax_district3;
  string1 school_tax_district3_indicator;
  string20 lot_size;
  string10 lot_size_acres;
  string10 lot_size_frontage_feet;
  string10 lot_size_depth_feet;
  string30 land_acres;
  string30 land_square_footage;
  string30 land_dimensions;
  string9 building_area;
  string1 building_area_indicator;
  string8 building_area1;
  string2 building_area1_indicator;
  string8 building_area2;
  string2 building_area2_indicator;
  string8 building_area3;
  string2 building_area3_indicator;
  string8 building_area4;
  string2 building_area4_indicator;
  string8 building_area5;
  string2 building_area5_indicator;
  string8 building_area6;
  string2 building_area6_indicator;
  string8 building_area7;
  string2 building_area7_indicator;
  string4 year_built;
  string4 effective_year_built;
  string3 no_of_buildings;
  string5 no_of_stories;
  string5 no_of_units;
  string5 no_of_rooms;
  string5 no_of_bedrooms;
  string8 no_of_baths;
  string2 no_of_partial_baths;
  string3 no_of_plumbing_fixtures;
  string3 garage_type_code;
  string5 parking_no_of_cars;
  string3 pool_code;
  string5 style_code;
  string3 type_construction_code;
  string3 foundation_code;
  string3 building_quality_code;
  string3 building_condition_code;
  string3 exterior_walls_code;
  string1 interior_walls_code;
  string3 roof_cover_code;
  string5 roof_type_code;
  string3 floor_cover_code;
  string3 water_code;
  string3 sewer_code;
  string3 heating_code;
  string3 heating_fuel_type_code;
  string3 air_conditioning_code;
  string1 air_conditioning_type_code;
  string1 elevator;
  string1 fireplace_indicator;
  string3 fireplace_number;
  string3 basement_code;
  string3 building_class_code;
  string3 site_influence1_code;
  string1 site_influence2_code;
  string1 site_influence3_code;
  string1 site_influence4_code;
  string1 site_influence5_code;
  string1 amenities1_code;
  string1 amenities2_code;
  string1 amenities3_code;
  string1 amenities4_code;
  string1 amenities5_code;
  string1 amenities2_code1;
  string1 amenities2_code2;
  string1 amenities2_code3;
  string1 amenities2_code4;
  string1 amenities2_code5;
  string9 extra_features1_area;
  string2 extra_features1_indicator;
  string9 extra_features2_area;
  string2 extra_features2_indicator;
  string9 extra_features3_area;
  string2 extra_features3_indicator;
  string9 extra_features4_area;
  string2 extra_features4_indicator;
  string3 other_buildings1_code;
  string1 other_buildings2_code;
  string1 other_buildings3_code;
  string1 other_buildings4_code;
  string1 other_buildings5_code;
  string2 other_impr_building1_indicator;
  string2 other_impr_building2_indicator;
  string2 other_impr_building3_indicator;
  string2 other_impr_building4_indicator;
  string2 other_impr_building5_indicator;
  string9 other_impr_building_area1;
  string9 other_impr_building_area2;
  string9 other_impr_building_area3;
  string9 other_impr_building_area4;
  string9 other_impr_building_area5;
  string1 topograpy_code;
  string9 neighborhood_code;
  string20 condo_project_or_building_name;
  string1 assessee_name_indicator;
  string1 second_assessee_name_indicator;
  string5 other_rooms_indicator;
  string1 mail_care_of_name_indicator;
  string120 comments;
  string6 tape_cut_date;
  string8 certification_date;
  string2 edition_number;
  string1 prop_addr_propagated_ind;
  string3 ln_ownership_rights;
  string2 ln_relationship_type;
  string3 ln_mailing_country_code;
  string50 ln_property_name;
  string1 ln_property_name_type;
  string1 ln_land_use_category;
  string20 ln_lot;
  string20 ln_block;
  string6 ln_unit;
  string1 ln_subfloor;
  string3 ln_floor_cover;
  string1 ln_mobile_home_indicator;
  string1 ln_condo_indicator;
  string1 ln_property_tax_exemption;
  string1 ln_veteran_status;
  string1 ln_old_apn_indicator;
  unsigned8 __internal_fpos__;
END;
EXPORT assessorKey_Noni_Base := RECORD
	assessorKey_Noni and NOT __internal_fpos__
END;
EXPORT assessorKey_iFields := RECORD
  string12 ln_fares_id;
  unsigned6 proc_date;
END;
EXPORT fcra_assessor_key := INDEX({assessorKey_iFields}, assessorKey_Noni, fcra_assessor_key_name);

// ----------------------------------------------------------------------------------------------------------------

EXPORT DeedsKey_Noni := RECORD
  string8 process_date;
  string1 vendor_source_flag;
  string1 current_record;
  string1 from_file;
  string5 fips_code;
  string2 state;
  string18 county_name;
  string1 record_type;
  string45 apnt_or_pin_number;
  string45 fares_unformatted_apn;
  string4 multi_apn_flag;
  string39 tax_id_number;
  string10 excise_tax_number;
  string1 buyer_or_borrower_ind;
  string80 name1;
  string2 name1_id_code;
  string80 name2;
  string2 name2_id_code;
  string2 vesting_code;
  string1 addendum_flag;
  string10 phone_number;
  string40 mailing_care_of;
  string70 mailing_street;
  string6 mailing_unit_number;
  string51 mailing_csz;
  string1 mailing_address_cd;
  string80 seller1;
  string2 seller1_id_code;
  string80 seller2;
  string2 seller2_id_code;
  string1 seller_addendum_flag;
  string70 seller_mailing_full_street_address;
  string6 seller_mailing_address_unit_number;
  string51 seller_mailing_address_citystatezip;
  string70 property_full_street_address;
  string6 property_address_unit_number;
  string51 property_address_citystatezip;
  string1 property_address_code;
  string2 legal_lot_code;
  string10 legal_lot_number;
  string7 legal_block;
  string7 legal_section;
  string7 legal_district;
  string7 legal_land_lot;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string50 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string100 legal_brief_description;
  string20 recorder_map_reference;
  string1 complete_legal_description_code;
  string8 contract_date;
  string8 recording_date;
  string8 arm_reset_date;
  string20 document_number;
  string3 document_type_code;
  string20 loan_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string19 concurrent_mortgage_book_page_document_number;
  string11 sales_price;
  string1 sales_price_code;
  string8 city_transfer_tax;
  string8 county_transfer_tax;
  string8 total_transfer_tax;
  string11 first_td_loan_amount;
  string11 second_td_loan_amount;
  string1 first_td_lender_type_code;
  string5 second_td_lender_type_code;
  string5 first_td_loan_type_code;
  string4 type_financing;
  string5 first_td_interest_rate;
  string8 first_td_due_date;
  string60 title_company_name;
  string3 partial_interest_transferred;
  string5 loan_term_months;
  string5 loan_term_years;
  string40 lender_name;
  string6 lender_name_id;
  string40 lender_dba_aka_name;
  string60 lender_full_street_address;
  string6 lender_address_unit_number;
  string41 lender_address_citystatezip;
  string4 assessment_match_land_use_code;
  string3 property_use_code;
  string1 condo_code;
  string1 timeshare_flag;
  string10 land_lot_size;
  string6 hawaii_tct;
  string4 hawaii_condo_cpr_code;
  string30 hawaii_condo_name;
  string1 filler_except_hawaii;
  string1 rate_change_frequency;
  string4 change_index;
  string15 adjustable_rate_index;
  string1 adjustable_rate_rider;
  string1 graduated_payment_rider;
  string1 balloon_rider;
  string1 fixed_step_rate_rider;
  string1 condominium_rider;
  string1 planned_unit_development_rider;
  string1 rate_improvement_rider;
  string1 assumability_rider;
  string1 prepayment_rider;
  string1 one_four_family_rider;
  string1 biweekly_payment_rider;
  string1 second_home_rider;
  string3 data_source_code;
  string1 main_record_id_code;
  string1 addl_name_flag;
  string1 prop_addr_propagated_ind;
  string3 ln_ownership_rights;
  string2 ln_relationship_type;
  string3 ln_buyer_mailing_country_code;
  string3 ln_seller_mailing_country_code;
  unsigned8 __internal_fpos__;
END;
EXPORT DeedsKey_iFields := RECORD
  string12 ln_fares_id;
  unsigned6 proc_date;
END;
EXPORT fcra_Deeds_Key := INDEX({DeedsKey_iFields}, DeedsKey_Noni, fcra_deeds_key_name);


// ----------------------------------------------------------------------------------------------------------------
// do we need this one?
// ----------------------------------------------------------------------------------------------------------------
// --- do we need this? ----- I do not think so but I'll leave it here for now ------------------------------------
EXPORT search_fid_fcra_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::fcra::20151204::search.fid';
EXPORT search_fid_key_name := ut.foreign_prod+'thor_data400::key::ln_propertyv2::qa::search.fid';
EXPORT search_fid_Noni := RECORD
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_vendor_last_reported;
  string1 vendor_source_flag;
  string8 process_date;
  string2 source_code;
  string1 conjunctive_name_seq;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string80 cname;
  string80 nameasis;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string10 phone_number;
  unsigned6 did;
  unsigned6 bdid;
  string9 app_ssn;
  string9 app_tax_id;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  string2 ln_party_status;
  string6 ln_percentage_ownership;
  string2 ln_entity_type;
  string8 ln_estate_trust_date;
  string1 ln_goverment_type;
  integer2 xadl2_weight;
  string2 addr_ind;
  string1 best_addr_ind;
  unsigned6 addr_tx_id;
  string1 best_addr_tx_id;
  unsigned8 location_id;
  string1 best_locid;
  unsigned8 __internal_fpos__;
END;
EXPORT search_fid_iFields := RECORD
  string12 ln_fares_id;
  string1 which_orig;
  string1 source_code_2;
  string1 source_code_1;
 END;
EXPORT search_fid_key := INDEX({search_fid_iFields}, search_fid_Noni, search_fid_key_name);
EXPORT fcra_search_fid_key := INDEX({search_fid_iFields}, search_fid_Noni, search_fid_fcra_key_name);

EXPORT search_fid_Layout := RECORD
	search_fid_iFields;
	search_fid_Noni;
END;

// ----------------------------------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------------------------------

EXPORT addr_search_Layout := RECORD
	addr_search_iFields;
	addr_search_Noni;
END;
EXPORT assessorKey_Layout := RECORD
	assessorKey_iFields;
	assessorKey_Noni;
END;
EXPORT deedsKey_Layout := RECORD
	DeedsKey_iFields;
	DeedsKey_Noni;
END;

// ----------------------------------------------------------------------------------------------------------------


END;