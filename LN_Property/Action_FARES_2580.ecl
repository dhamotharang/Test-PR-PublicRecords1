import LN_Property, LN_Functions, Property, lib_AddrClean, lib_stringlib;

source_file := Property.File_Fares_Assessor;

/*
source_file_filtered := Property.File_Fares_Assessor(fips_code in [
                                                          '01001','01073','13013','13089',
                                                          '30031','34039','39113','51685',
										                  '56021','12011','12086','12099',
										                  '12087','12111']);

sample_data := source_file_filtered;
*/
//01001 AL-AUTAUGA
//01073 AL-JEFFERSON
//13013 GA-BARROW
//13089 GA-DEKALB
//30031 MT-GALLATIN
//34039 NJ-UNION
//39113 OH-MONTGOMERY
//51685 VA-MANASSAS PARK
//56021 WY-LARAMIE
//12011 FL-BROWARD
//12086 FL-MIAMI DADE
//12099 FL-PALM BEACH
//12087 FL-MONROE
//12111 FL-ST LUCIE


	
LN_Property.Layout_Property_Common_Model_BASE MapToCommonModel(source_file L) := TRANSFORM
  self.ln_fares_id        := L.fares_id;
  self.process_date       := L.process_date;
  self.vendor_source_flag := L.vendor;
  self.fips_code          := L.fips_code;

  self.state_code         := if(trim(L.prop_st)!='',L.prop_st,L.prop_state);
  self.county_name        := '';
  //self.county_name        := if(trim(L.prop_county)!='',L.prop_county,'');
  self.apna_or_pin_number := L.formatted_apn;
  
  self.assessee_name                         := L.owner_name;
  self.second_assessee_name                  := L.owner_name_2;
  self.assessee_ownership_rights_code        := L.owner_ownership_rights_code;
  self.assessee_relationship_code            := L.owner_relationship_code;
  self.assessee_phone_number                 := L.owner_phone;
  self.tax_account_number                    := L.account_num;
  self.assessee_name_type_code               := L.owner_corp_ind;
  self.mailing_full_street_address       := trim(trim(L.own_house_number_prefix,left,right)+' '+
                                                 trim(L.own_house_number,left,right)+' '+
											     trim(L.own_house_number_suffix,left,right)+' '+
											     trim(L.own_direction,left,right)+' '+
											     trim(L.own_street_name,left,right)+' '+
											     trim(L.own_mode,left,right)+' '+
											     trim(L.own_quadrant,left,right)
										    ,left,right);											
  self.mailing_unit_number               := L.own_apt_unit_num;
  self.mailing_city_state_zip            := LN_Functions.Function_CombineCityStateZip(L.own_city, L.own_state, L.own_zipcode, '');

  string v_property_full_street_address := trim(trim(L.prop_house_number_prefix,left,right)+' '+
                                                  (integer) L.prop_house_number+' '+
											      trim(L.prop_house_number_suffix,left,right)+' '+
											      trim(L.prop_direction,left,right)+' '+
											      trim(L.prop_street_name,left,right)+' '+
											      trim(L.prop_mode,left,right)+' '+
											      trim(L.prop_quadrant,left,right)
										     ,left,right);

  self.property_full_street_address       := if(trim(v_property_full_street_address,left,right)='0','',v_property_full_street_address);
  self.property_unit_number               := L.prop_apt_unit_num;
  self.property_city_state_zip            := LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, L.prop_zipcode, '');
  self.property_address_code              := L.prop_address_indicator;

  self.legal_lot_number                 := L.lot_number;
  self.legal_block                      := L.block_number;
  self.legal_city_municipality_township := L.municipality_name;
  self.legal_subdivision_name           := L.subdivision_name;

  //Consider breaking legal_sec_twn_rng_mer into individual fields
  //to accomodate the individual fields that exist in FARES.
  
  string v_section  := if(trim(L.section)!='','SEC '+trim(L.section)+' ','');
  string v_township := if(trim(L.township)!='','TWN '+trim(L.township)+' ','');
  string v_range    := if(trim(L._range)!='','RNG '+trim(L._range),'');
  
  self.legal_sec_twn_rng_mer            := v_section+v_township+v_range;
  self.legal_brief_description          := L.legal1;
  self.census_tract                     := L.census_tract;
  self.county_land_use_code              := L.county_use1;
  self.zoning                            := L.zoning;
  
  self.recorder_document_number             := L.document_number;
  self.recorder_book_number                 := L.book_page[1..6];
  self.recorder_page_number                 := L.book_page[7..12];
  self.transfer_date                        := L.document_year;
  self.recording_date                       := L.recording_date;
  self.sale_date                            := L.sale_date;
  self.sales_price                          := L.sale_price;
  self.sales_price_code                     := L.sale_code;
  self.mortgage_loan_amount                 := L.first_motgage_amount;
  self.mortgage_loan_type_code              := L.mortgage_loan_type_code;
  self.mortgage_lender_name                 := L.lender_name;
  self.prior_transfer_date                  := L.prior_document_year;
  self.prior_recording_date                 := L.prior_recording_date;
  self.prior_sales_price                    := L.prior_sales_price;
  self.prior_sales_price_code               := L.prior_sales_code;

  self.assessed_land_value                          := L.assd_land_val;
  self.assessed_improvement_value                   := L.assd_improvement_value;
  self.assessed_total_value                         := L.assd_total_val;
  self.market_land_value                            := L.mkt_land_val;
  self.market_improvement_value                     := L.mkt_improvement_val;
  self.market_total_value                           := L.mkt_total_val;
  self.homestead_homeowner_exemption                := L.homestead_exempt;
  self.tax_amount                                   := L.tax_amount;
  self.tax_year                                     := L.tax_year;
  self.school_tax_district1                         := L.tax_code_area;

  self.land_acres                       := L.acres;
  self.land_square_footage              := L.land_square_footage;
  //Not sure of possible issues due to combining 2 Fares fields
  //into 1 field in common model.
  self.land_dimensions                  := trim(L.front_footage,left,right)+'X'+trim(L.depth_footage,left,right);
  self.building_area                    := L.universal_building_sq_feet;
  self.building_area_indicator          := L.building_sq_feet_ind;
  self.year_built                       := L.year_built;
  self.effective_year_built             := L.effective_year_built;
  self.no_of_buildings                  := L.number_of_buildings;
  self.no_of_stories                    := L.stories_number;
  self.no_of_units                      := L.units_number;
  self.no_of_rooms                      := L.total_rooms;
  self.no_of_bedrooms                   := L.bedrooms;
  self.no_of_baths                      := L.total_baths;
  self.garage_type_code                 := L.garage;
  self.parking_no_of_cars               := L.parking_spaces;
  self.pool_code                        := L.pool_code;
  self.style_code                       := L.style;
  self.type_construction_code           := L.construction_type;
  self.exterior_walls_code              := L.exterior_walls;
  self.foundation_code                  := L.foundation;
  self.roof_cover_code                  := L.roof_cover;
  self.roof_type_code                   := L.roof_type;
  self.heating_code                     := L.heating;
  self.heating_fuel_type_code           := L.fuel;
  self.air_conditioning_code            := L.air_conditioning;
  self.fireplace_indicator              := L.fireplace_ind;
  self.fireplace_number                 := L.fireplace_number;
  self.basement_code                    := L.basement_finish;
  self.site_influence1_code             := L.location_influence;
  self.other_buildings1_code            := L.bldg_impv_code;

  self.fares_unformatted_apn                 := L.unformatted_apn;
  self.fares_iris_apn                        := L.Iris_apn;
  self.fares_non_parsed_assessee_name        := L.owner_name1;
  self.fares_non_parsed_second_assessee_name := L.owner_name2;
  self.fares_legal2                          := L.legal2;
  self.fares_legal3                          := L.legal3;
  self.fares_land_use                        := L.land_use;
  self.fares_seller_name                     := L.seller_name;
  self.fares_calculated_land_value           := L.land_val_calc;
  self.fares_calculated_improvement_value    := L.improvement_value_calc;
  self.fares_calculated_total_value          := L.total_val_calc; 
  self.fares_living_square_feet              := L.living_square_feet;
  self.fares_adjusted_gross_square_feet      := L.adjusted_gross_square_feet;
  self.fares_no_of_full_baths                := L.full_baths;
  self.fares_no_of_half_baths                := L.half_baths;
  self.fares_pool_indicator                  := L.pool;
  self.fares_frame                           := L.frame;
  self.fares_electric_energy                 := L.electric_energy;
  self.fares_sewer                           := L.sewer;
  self.fares_water                           := L.water;
  self.fares_condition                       := L.condition;  
  
  /*
  self.clean_property_address := L.prop_prim_range+L.prop_predir+L.prop_prim_name+
				                 L.prop_suffix+L.prop_postdir+L.prop_unit_desig+
							     L.prop_sec_range+L.prop_p_city_name+L.prop_v_city_name+
						         L.prop_st+L.prop_zip+L.prop_zip4+L.prop_cart+L.prop_cr_sort_sz+
							     L.prop_lot+L.prop_lot_order+L.prop_dbpc+L.prop_chk_digit+
								 L.prop_rec_type+L.prop_county+L.prop_geo_lat+L.prop_geo_long+
								 L.prop_msa+L.prop_geo_blk+L.prop_geo_match+L.prop_err_stat;
  self.clean_mailing_address := L.own_prim_range+L.own_predir+L.own_prim_name+
				                 L.own_suffix+L.own_postdir+L.own_unit_desig+
							     L.own_sec_range+L.own_p_city_name+L.own_v_city_name+
						         L.own_ace_state+L.own_ace_zip+L.own_ace_zip4+L.own_cart+L.own_cr_sort_sz+
							     L.own_lot+L.own_lot_order+L.own_dbpc+L.own_chk_digit+
								 L.own_ace_rec_type+L.own_ace_county+L.own_geo_lat+L.own_geo_long+
								 L.own_ace_msa+L.own_geo_blk+L.own_geo_match+L.own_err_stat;
  */
  //self.fares_fips_subcode := L.fips_subcode;
  //self.fares_original_apn        := L.original_apn;
  //self.fares_apn_sequence_number := L.apn_seq_nmb;
  //self.fares_owner_phone_opt_out_indicator   := L.owner_phone_opt_out_code;
  //self.fares_owner_mailing_opt_out_indicator := L.mailing_opt_out_code;
  //self.fares_absentee_owner                  := L.absentee_owner;
  //self.fares_assessee_etal_code              := L.owner_etal_ind;
  //self.fares_mailing_house_number_prefix := L.own_house_number_prefix;
  //self.mailing_house_number              := L.own_house_number;
  //self.mailing_house_alpha               := L.own_house_number_suffix;
  //self.mailing_street_direction_left     := L.own_direction;
  //self.mailing_street_name               := L.own_street_name;
  //self.mailing_street_suffix             := L.own_mode;
  //self.mailing_street_direction_right    := L.own_quadrant;
  //self.mailing_city_name                 := L.own_city;
  //self.mailing_state                     := L.own_state;
  //self.mailing_zip_code                  := L.own_zipcode;
  //self.fares_mailing_carrier_route       := L.own_carrier_code;
  //self.fares_mailing_match_code          := L.own_match_code;
  //self.fares_property_house_number_prefix := L.prop_house_number_prefix;
  //self.property_house_number              := L.prop_house_number;
  //self.property_house_alpha               := L.prop_house_number_suffix;
  //self.property_street_direction_left     := L.prop_direction;
  //self.property_street_name               := L.prop_street_name;
  //self.property_street_suffix             := L.prop_mode;
  //self.property_street_direction_right    := L.prop_quadrant;
  //self.property_city_name                 := L.prop_city;
  //self.property_state                     := L.prop_state;
  //self.property_zip_code                  := L.prop_zipcode;
  //self.fares_property_carrier_route       := L.prop_carrier_route;
  //self.fares_property_match_code          := L.prop_match_code;
  //self.fares_subdivision_tract_number   := L.subdivision_tract_num;
  //self.fares_subdivision_plat_book      := L.subdivision_plat_book;
  //self.fares_subdivision_plat_page      := L.subdivision_plat_page;
  //self.fares_quarter_section            := L.quater_section;
  //self.fares_thomas_brothers_map_number := L.thomas_bros_map_num;
  //self.fares_flood_zone_comm_panel_id   := L.flood_zone_comm_panel_id;
  //self.fares_county_use2                 := L.county_use2;
  //self.fares_property_ind                := L.property_ind;
  //self.fares_map_reference_1             := L.map_ref_1;
  //self.fares_map_reference_2             := L.map_ref_2;
  //self.fares_situs_latitude              := L.situs_latitude;
  //self.fares_situs_longitude             := L.situs_longitude;
  //self.fares_centroid_code               := L.centroid_code;
  //self.fares_residential_model_indicator := L.residential_model_ind;
  //self.fares_sales_deed_category_type       := L.sales_deed_cat_type;
  //self.fares_sales_transaction_code         := L.sale_trans_code;
  //self.fares_multiple_apn_flag              := L.multi_apn_flag_1;
  //self.fares_multiple_apn_count             := L.multi_apn_count;
  //self.fares_second_mortgage_loan_amount    := L.second_mortgage_amount;
  //self.fares_mortgage_date                  := L.mortgage_date;
  //self.fares_second_mortgage_loan_type_code := L.second_mortgage_loan_type_code;
  //self.fares_mortgage_deed_type             := L.mortgage_deed_type;
  //self.fares_second_mortgage_deed_type      := L.second_deed_type;
  //self.fares_mortgage_term                  := L.mortgage_term;
  //self.fares_mortgage_term_code             := L.mortgage_term_code;
  //self.fares_mortgage_due_date              := L.mortgage_due_date;
  //self.fares_mortgage_assumption_amount     := L.mortgage_assumption_amount;
  //self.fares_title_company_code             := L.title_company_code;
  //self.fares_title_company_description      := L.title_company_name;
  //self.fares_mortgage_lender_code           := L.lender_code;
  //self.fares_transaction_id                 := L.transaction_id;
  //self.fares_prior_recorder_document_number := L.prior_document_number;
  //self.fares_prior_book_page                := L.prior_book_page;
  //self.fares_prior_sale_date                := L.prior_sales_date;
  //self.fares_prior_sales_deed_category_type := L.prior_sls_deed_cat_type;
  //self.fares_prior_sales_transaction_code   := L.prior_sales_trans_code;
  //self.fares_prior_multiple_apn_flag        := L.prior_multi_apn_flag;
  //self.fares_prior_multiple_apn_count       := L.multi_apn_count_2;
  //self.fares_prior_mortgage_loan_amount     := L.prior_mortgage_amount;
  //self.fares_prior_mortgage_deed_type       := L.prior_deed_type;
  //self.fares_prior_transaction_id           := L.prior_trans_id;
  //self.fares_appraised_land_value                   := L.appr_land_val;
  //self.fares_appraised_improvement_value            := L.appr_improvement_val;
  //self.fares_appraised_total_value                  := L.appr_total_val;
  //self.fares_calculated_land_value_indicator        := L.land_value_calc_ind;
  //self.fares_calculated_improvement_value_indicator := L.improvement_value_calc_ind;
  //self.fares_calculated_total_value_indicator       := L.total_value_calc_ind;
  //self.fares_lot_area                   := L.lot_area;
  //self.fares_building_square_feet       := L.building_square_feet;
  //self.fares_ground_floor_square_feet   := L.ground_floor_square_feet;
  //self.fares_gross_square_feet          := L.gross_square_feet;
  //self.fares_stories_code               := L.stories_code;
  //self.fares_total_baths_calculated     := L.total_baths_calculated;
  //self.fares_no_of_one_quarter_baths    := L.one_qtr_baths;
  //self.fares_no_of_three_quarter_baths  := L.three_qtr_baths;
  //self.fares_no_of_bath_fixtures        := L.bath_fixtures;
  //self.fares_garage_parking_square_feet := L.garage_parking_square_feet;
  //self.fares_parking_type               := L.parking_type;
  //self.fares_floor                      := L.floor;
  //self.fares_fireplace_type             := L.fireplace_type;
  //self.fares_basement_square_feet       := L.basement_square_feet;
  //self.fares_building_code              := L.bldg_code;
  //self.fares_quality                    := L.quality;
  //self.fares_view                       := L.view;
  //self.fares_mobile_home_indicator      := L.mobile_home_ind;
  //self.fares_record_date                := L.record_date;
  
  self := [];
END;

Result := project(source_file, MapToCommonModel(left));

output(Result,,LN_Property.Filename_FARES_2580,overwrite);