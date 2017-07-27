EXPORT Layout_Fares_Assessor := RECORD
string5			vendor;
string12        fares_id;
string5         fips_code;
string3         fips_subcode;
string45        unformatted_apn;
string3         apn_seq_nmb;
string45        formatted_apn;
string45        original_apn;
string15        account_num;
string60        map_ref_1;
string60        map_ref_2;
string10        census_tract;
string10        zoning;
string5         block_number;
string5         lot_number;
string3         _range;
string3         township;
string3         section;
string3         quater_section;
string11        thomas_bros_map_num;
string11        flood_zone_comm_panel_id;
string8         situs_latitude;
string9         situs_longitude;
string4         centroid_code;
string1         homestead_exempt;
string1         absentee_owner;
string10        tax_code_area;
string10        land_use;
string10        county_use1;
string10        county_use2;
string3         property_ind;
string30        municipality_name;
string3         view;
string3         location_influence;
string3         number_of_buildings;
string15        subdivision_tract_num;
string6         subdivision_plat_book;
string6         subdivision_plat_page;
string30        subdivision_name;
string1         prop_address_indicator;
string5         prop_house_number_prefix;
string10        prop_house_number;
string10        prop_house_number_suffix;
string2         prop_direction;
string30        prop_street_name;
string5         prop_mode;
string2         prop_quadrant;
string6         prop_apt_unit_num;
string40        prop_city;
string2         prop_state;
string9         prop_zipcode;
string4         prop_carrier_route;
string4         prop_match_code;
string1         owner_corp_ind;
string30        owner_name;
string30        owner_name_2;
string60        owner_name1;
string60        owner_name2;
string10        owner_phone;
string1         owner_phone_opt_out_code;
string1         owner_etal_ind;
string3         owner_ownership_rights_code;
string2         owner_relationship_code;
string5         own_house_number_prefix;
string10        own_house_number;
string10        own_house_number_suffix;
string2         own_direction;
string30        own_street_name;
string5         own_mode;
string2         own_quadrant;
string6         own_apt_unit_num;
string40        own_city;
string2         own_state;
string9         own_zipcode;
string4         own_carrier_code;
string4         own_match_code;
string1         mailing_opt_out_code;
string11        total_val_calc;
string11        land_val_calc;
string11        improvement_value_calc;
string1         total_value_calc_ind;
string1         land_value_calc_ind;
string1         improvement_value_calc_ind;
string11        assd_total_val;
string11        assd_land_val;
string11        assd_improvement_value;
string11        mkt_total_val;
string11        mkt_land_val;
string11        mkt_improvement_val;
string11        appr_total_val;
string11        appr_land_val;
string11        appr_improvement_val;
string11        tax_amount;
string4         tax_year;
string17        transaction_id;
string4         document_year;
string12        document_number;
string12        book_page;
string3         sales_deed_cat_type;
string8         recording_date;
string8         sale_date;
string11        sale_price;
string1         sale_code;
string60        seller_name;
string3         sale_trans_code;
string1         multi_apn_flag_1;
string4         multi_apn_count;
string5         title_company_code;
string60        title_company_name;
string1         residential_model_ind;
string11        first_motgage_amount;
string8         mortgage_date;
string5         mortgage_loan_type_code;
string6         mortgage_deed_type;
string4         mortgage_term_code;
string5         mortgage_term;
string8         mortgage_due_date;
string9         mortgage_assumption_amount;
string10        lender_code;
string60        lender_name;
string11        second_mortgage_amount;
string5         second_mortgage_loan_type_code;
string6         second_deed_type;
string13        prior_trans_id;
string4         prior_document_year;
string12        prior_document_number;
string12        prior_book_page;
string1         prior_sls_deed_cat_type;
string8         prior_recording_date;
string8         prior_sales_date;
string11        prior_sales_price;
string1         prior_sales_code;
string3         prior_sales_trans_code;
string1         prior_multi_apn_flag;
string4         multi_apn_count_2;
string11        prior_mortgage_amount;
string1         prior_deed_type;
string7         front_footage;
string7         depth_footage;
string13        acres;
string9         land_square_footage;
string20        lot_area;
string9         universal_building_sq_feet;
string1         building_sq_feet_ind;
string9         building_square_feet;
string7         living_square_feet;
string7         ground_floor_square_feet;
string7         gross_square_feet;
string7         adjusted_gross_square_feet;
string7         basement_square_feet;
string7         garage_parking_square_feet;
string4         year_built;
string4         effective_year_built;
string5         bedrooms;
string5         total_rooms;
string7         total_baths_calculated;
string7         total_baths;
string5         full_baths;
string5         half_baths;
string5         one_qtr_baths;
string5         three_qtr_baths;
string5         bath_fixtures;
string3         air_conditioning;
string3         basement_finish;
string3         bldg_code;
string3         bldg_impv_code;
string3         condition;
string3         construction_type;
string3         exterior_walls;
string1         fireplace_ind;
string3         fireplace_number;
string3         fireplace_type;
string3         foundation;
string3         floor;
string3         frame;
string3         garage;
string3         heating;
string1         mobile_home_ind;
string5         parking_spaces;
string3         parking_type;
string1         pool;
string3         pool_code;
string3         quality;
string3         roof_cover;
string3         roof_type;
string3         stories_code;
string3         stories_number;
string5         style;
string5         units_number;
string3         electric_energy;
string3         fuel;
string3         sewer;
string3         water;
string250       legal1;
string250       legal2;
string250       legal3;
string8         record_date;
string8         process_date;
string10        prop_prim_range;
string2         prop_predir;
string28        prop_prim_name;
string4         prop_suffix;
string2         prop_postdir;
string10        prop_unit_desig;
string8         prop_sec_range;
string25        prop_p_city_name;
string25        prop_v_city_name;
string2         prop_st;
string5         prop_zip;
string4         prop_zip4;
string4         prop_cart;
string1         prop_cr_sort_sz;
string4         prop_lot;
string1         prop_lot_order;
string2         prop_dbpc;
string1         prop_chk_digit;
string2         prop_rec_type;
string5         prop_county;
string10        prop_geo_lat;
string11        prop_geo_long;
string4         prop_msa;
string7         prop_geo_blk;
string1         prop_geo_match;
string4         prop_err_stat;
string10        own_prim_range;
string2         own_predir;
string28        own_prim_name;
string4         own_suffix;
string2         own_postdir;
string10        own_unit_desig;
string8         own_sec_range;
string25        own_p_city_name;
string25        own_v_city_name;
string2         own_ace_state;
string5         own_ace_zip;
string4         own_ace_zip4;
string4         own_cart;
string1         own_cr_sort_sz;
string4         own_lot;
string1         own_lot_order;
string2         own_dbpc;
string1         own_chk_digit;
string2         own_ace_rec_type;
string5         own_ace_county;
string10        own_geo_lat;
string11        own_geo_long;
string4         own_ace_msa;
string7         own_geo_blk;
string1         own_geo_match;
string4         own_err_stat;
string60 		Iris_apn;
string2         crlf;
end;