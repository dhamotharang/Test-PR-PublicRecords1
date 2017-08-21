import lib_fileservices, property, ln_mortgage, ln_functions, ut, ln_property, ln_propertyv2, LN_PropertyV2_Fast;

export Mapping_Fares_Base(
	dataset(recordof(LN_PropertyV2_Fast.Layout_Fares_Deeds))     fares_deed,
	dataset(recordof(LN_PropertyV2_Fast.Layout_Fares_Assessor))  fares_Assessor,
	dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod)) fares_search) := 
MODULE

// clean & dedup input fares files

shared deed_dedup   := LN_PropertyV2_Fast.Fares_deeds_dedup(fares_deed); 
shared asses_dedup  := LN_PropertyV2_Fast.Fares_assessor_dedup(fares_Assessor) ; 
shared search_dedup := LN_PropertyV2_Fast.Fares_search_dedup(fares_search,deed_dedup,asses_dedup); 

// https://bugzilla.seisint.com/show_bug.cgi?id=152516
shared fn_RemoveSpecialChars(string s, string replacement='') := 
															REGEXREPLACE('\\x00',s,replacement);

//  Grab Fares deeds ##########################################################

LN_PropertyV2_Fast.Layout_prep_deed_mortg MapToCommonModel(deed_dedup L) := TRANSFORM
  
  self.ln_fares_id                           := L.fares_id;
  self.process_date                          := L.process_date;
  self.vendor_source_flag                    := if(L.vendor = 'FAR_F','F','S');
  self.from_file                             := 'F';
  self.fips_code                             := L.fips;
  self.state                                 := if(L.prop_state!='',L.prop_state,L.prop_ace_state);
  self.county_name                           := '';
  self.apnt_or_pin_number                    := ut.fn_KeepPrintableChars(L.apn_parcel_number_formatted);
  self.tax_id_number                         := L.account_number;
  self.multi_apn_flag                        := L.multi_apn_count;
  
	self.buyer_or_borrower_ind                  := 'O'  ;     // No  borrower for fares data
	self.name1                                  := ut.fn_KeepPrintableChars(LN_Functions.Function_CombineFirstLastCorpNames(L.owner_buyer_last_name, L.owner_buyer_first_name)); //new
	self.mailing_care_of                        := L.c_o_name;  
	string v_buyer_mailing_full_street_address  := l.owner_house_number_prefix
																								+ ' '+if((integer)l.owner_house_number<>0,regexreplace('^0*',trim(L.owner_house_number,left,right),''),'')
																								+ ' '+l.owner_house_number_suffix
																								+ ' '+l.owner_street_direction
																								+ ' '+regexreplace('^0*',trim(L.owner_street_name,left,right),'')
																								+ ' '+l.owner_mode
																								+ ' '+l.owner_quadrant
																								;

	self.mailing_street                         := stringlib.stringcleanspaces(v_buyer_mailing_full_street_address); //new
	self.mailing_unit_number                    := L.owner_apartment_unit; 
	self.mailing_csz                            := LN_Functions.Function_CombineCityStateZip(L.owner_city, L.owner_state, if(length(trim(l.owner_zip_code))=9,l.owner_zip_code[1..5]+'-'+l.owner_zip_code[6..9],L.owner_zip_code), ''); //new


  self.seller1                               := ut.fn_KeepPrintableChars(L.seller_name);
  string v_property_full_street_address      := l.prop_house_number_prefix
																								+ ' '+if((integer)l.prop_house_number<>0,regexreplace('^0*',trim(L.prop_house_number,left,right),''),'')
																								+ ' '+l.prop_house_number_suffix
																								+ ' '+regexreplace('^0*',trim(L.prop_street_name,left,right),'')
																								+ ' '+l.prop_mode
																								+ ' '+l.prop_direction
																								+ ' '+l.prop_quadrant
																								;
  self.property_full_street_address          := stringlib.stringcleanspaces(v_property_full_street_address);
  self.property_address_unit_number          := L.prop_apartment_unit;
  self.property_address_code                 := L.address_indicator;
  self.property_address_citystatezip         := trim(LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, if(length(trim(l.prop_property_address_zip_code_))=9,l.prop_property_address_zip_code_[1..5]+'-'+l.prop_property_address_zip_code_[6..9],L.prop_property_address_zip_code_), ''),left,right);
  self.legal_city_municipality_township			 := L.municipality_code;
	self.contract_date                         := L.sale_date_yyyymmdd;
  self.recording_date                        := L.recording_date_yyyymmdd;
  self.document_number                       := ut.fn_KeepPrintableChars(L.document_number);
  self.document_type_code                    := L.document_type;
  self.recorder_book_number                  := L.book_page_6x6[1..6];
  self.recorder_page_number                  := L.book_page_6x6[7..12];
  self.sales_price                           := L.sale_amount;
  self.sales_price_code                      := L.sale_code;
  self.first_td_loan_amount                  := L.mortgage_amount;
  self.first_td_loan_type_code               := L.mortgage_loan_type_code;
  self.first_td_due_date                     := L.mortgage_due_date;
  self.type_financing                        := L.mortgage_interest_rate_type;
  self.title_company_name                    := ut.fn_KeepPrintableChars(L.title_company_name);
  self.partial_interest_transferred          := L.ownership_transfer_percentage;
  self.lender_name                           := ut.fn_KeepPrintableChars(trim(trim(if(trim(L.lender_last_name,left,right)='PRIVATE INDIVIDUAL','',trim(L.lender_last_name,left,right)) +
                                                ' ' + trim(L.lender_first_name,left,right),left,right),left,right));  
  self.assessment_match_land_use_code        := L.universal_luse_code;
  self.property_use_code                     := L.property_indicator_code;
  self.fares_unformatted_apn                 := L.apn_parcel_number_unformatted;
  self.second_td_loan_amount                 := if(trim(L.second_mortgage_amount)!='','00'+L.second_mortgage_amount[1..9],'');
	self.ln_buyer_mailing_country_code				 := L.ln_buyer_mailing_country_code;
	self.ln_seller_mailing_country_code				 := L.ln_seller_mailing_country_code;
	self.raw_file_name												 := L.raw_file_name;
	self                                       := [];
END;

DeedWithLN_Format := PROJECT(deed_dedup, MapToCommonModel(LEFT));


EXPORT DeedWithC_layout  := DeedWithLN_Format;

// Grab addl fares deeds ##########################################################

LN_PropertyV2.layout_addl_fares_deed MapToaddldeed(deed_dedup L) := transform 
  
  self.ln_fares_id                           := L.fares_id;
	self.fares_owner_etal_indicator						 := L.owner_etal_ind;
	self.fares_owner_relationship_code				 := L.owner_relationship_rights_code;
	self.fares_owner_relationship_type				 := L.owner_relationship_type;
	self.fares_match_code											 := L.match_code;
	self.fares_document_year									 := L.document_year;
  self.fares_corporate_indicator             := L.corporate_indicator;
  self.fares_transaction_type                := L.transaction_type;
  self.fares_lender_address                  := L.lender_address;
	self.fares_sales_transaction_code					 := L.sales_transaction_code;
	self.fares_residential_model_ind					 := L.residential_model_indicator;
  self.fares_mortgage_deed_type              := L.mortgage_deed_type;
  self.fares_mortgage_term_code              := L.mortgage_term_code;
  self.fares_mortgage_term                   := L.mortgage_term;
	self.fares_mortgage_assumption_amt				 := L.mortgage_assumption_amount;
	self.fares_second_mortgage_loan_type_code	 := L.second_mortgage_loan_type_code;
	self.fares_second_deed_type 							 := L.second_deed_type;
	self.fares_prior_doc_year 								 := L.prior_doc_year;
	self.fares_prior_doc_number								 := L.prior_doc_number;
	self.fares_prior_book_page								 := L.prior_book_and_page;
	self.fares_prior_sales_deed_cat_code			 := L.prior_sales_deed_category_code;
	self.fares_prior_recording_date						 := L.prior_recording_date;
	self.fares_prior_sales_date								 := L.prior_sales_date;
	self.fares_prior_sales_price							 := L.prior_sales_price;
	self.fares_prior_sales_code								 := L.prior_sales_code;
	self.fares_prior_sales_transaction_code		 := L.prior_sales_transaction_code;
	self.fares_prior_mortgage_amount					 := L.prior_mortgage_amount;
	self.fares_prior_deed_type								 := L.prior_deed_type;
	self.fares_absentee_indicator							 := L.absentee_indicator;
	self.fares_partial_interest_ind						 := L.partial_interest_indicator;
	self.fares_pri_cat_code										 := L.pri_cat_code;
	self.fares_private_party_lender						 := fn_RemoveSpecialChars(trim(L.private_party_lender), '');
	self.fares_construction_loan							 := fn_RemoveSpecialChars(trim(L.construction_loan), '');
	self.fares_resale_new_construction				 := fn_RemoveSpecialChars(trim(L.resale_new_construction_m_resale_n_), '');
	self.fares_inter_family										 := fn_RemoveSpecialChars(trim(L.inter_family), '');
	self.fares_cash_mortgage_purchase					 := fn_RemoveSpecialChars(trim(L.cash_mortgage_purchase_q_cash_r_mor), '');
  self.fares_building_square_feet            := L.building_square_feet;
  self.fares_foreclosure                     := L.foreclosure;
  self.fares_refi_flag                       := L.refi_flag;
  self.fares_equity_flag                     := L.equity_flag;
  self.fares_iris_apn                        := L.Iris_apn;  
  self.fares_mortgage_date                   := L.mortgage_date ;
  
END; 

Addl_fares_deed := PROJECT(deed_dedup, MapToaddldeed(LEFT));

EXPORT Addl_fares_deedWithC_layout :=  Addl_fares_deed;

// Grab  property fares assessors ##########################################################

LN_PropertyV2_Fast.Layout_prep_assessment MapToCommonModel2(asses_dedup L) := TRANSFORM
  self.ln_fares_id                           := L.fares_id;
  self.process_date                          := L.process_date;
  self.vendor_source_flag                    := if(L.vendor = 'FAR_F','F','S');
  self.fips_code                             := L.fips_code;
  self.state_code                            := if(trim(L.prop_st)!='',L.prop_st,L.prop_state);
  self.county_name                           := '';
  self.apna_or_pin_number                    := ut.fn_KeepPrintableChars(L.formatted_apn);
  self.assessee_name                         := ut.fn_KeepPrintableChars(stringlib.stringcleanspaces(L.owner_name))	+
																								if(	regexfind('^(!|\\\\)',stringlib.stringcleanspaces(L.owner_name_2)),
																										regexreplace('^(!|\\\\)',stringlib.stringcleanspaces(L.owner_name_2),''),
																										''
																									);
  self.second_assessee_name                  := if(	ut.fn_KeepPrintableChars(stringlib.stringcleanspaces(L.owner_name))	!=	self.assessee_name,
																										'',
																										ut.fn_KeepPrintableChars(L.owner_name_2)
																									);
  self.assessee_ownership_rights_code        := L.owner_ownership_rights_code;
  self.assessee_relationship_code            := L.owner_relationship_code;
  self.assessee_phone_number                 := L.owner_phone;
  self.tax_account_number                    := L.account_num;
  self.assessee_name_type_code               := L.owner_corp_ind;
  string v_mailing_full_street_address 			 := l.own_house_number_prefix
																								+ ' '+if((integer)l.own_house_number<>0,regexreplace('^0*',trim(L.own_house_number,left,right),''),'')
																								+ ' '+l.own_house_number_suffix
																								+ ' '+l.own_direction
																								+ ' '+regexreplace('^0*',trim(L.own_street_name,left,right),'')
																								+ ' '+l.own_mode
																								+ ' '+l.own_quadrant
																								;
  self.mailing_full_street_address     			 := stringlib.stringcleanspaces(v_mailing_full_street_address);												
  self.mailing_unit_number                   := L.own_apt_unit_num;
  self.mailing_city_state_zip                := LN_Functions.Function_CombineCityStateZip(L.own_city, L.own_state, if(length(trim(l.own_zipcode))=9,l.own_zipcode[1..5]+'-'+l.own_zipcode[6..9],L.own_zipcode), '');
  string v_property_full_street_address      := l.prop_house_number_prefix
																								+ ' '+if((integer)l.prop_house_number<>0,regexreplace('^0*',trim(L.prop_house_number,left,right),''),'')
																								+ ' '+l.prop_house_number_suffix
																								+ ' '+regexreplace('^0*',trim(L.prop_street_name,left,right),'')
																								+ ' '+l.prop_mode
																								+ ' '+l.prop_direction
																								+ ' '+l.prop_quadrant
																								;
  self.property_full_street_address          := stringlib.stringcleanspaces(v_property_full_street_address); 
  self.property_unit_number                  := L.prop_apt_unit_num;
  self.property_city_state_zip               := trim(LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, if(length(trim(l.prop_zipcode))=9,l.prop_zipcode[1..5]+'-'+l.prop_zipcode[6..9],L.prop_zipcode), ''),left,right);
  self.property_address_code                 := L.prop_address_indicator;
  self.legal_lot_number                      := L.lot_number;
  self.legal_block                           := L.block_number;
  self.legal_city_municipality_township      := L.municipality_name;
  self.legal_subdivision_name                := ut.fn_KeepPrintableChars(L.subdivision_name);
  string v_section                           := if(trim(L.section)!='','SEC ' + trim(L.section) + ' ','');
  string v_township                          := if(trim(L.township)!='','TWN ' + trim(L.township) + ' ','');
  string v_range                             := if(trim(L._range)!='','RNG '+trim(L._range),'');
  self.legal_sec_twn_rng_mer                 := v_section+v_township+v_range;
  self.legal_brief_description               := ut.fn_KeepPrintableChars(L.legal1);
  self.census_tract                          := L.census_tract;
  self.county_land_use_code                  := L.county_use1;
  self.zoning                                := L.zoning;
  self.recorder_document_number              := ut.fn_KeepPrintableChars(L.document_number);
  self.recorder_book_number                  := L.book_page[1..6];
  self.recorder_page_number                  := L.book_page[7..12];
  self.transfer_date                         := L.document_year;
  self.recording_date                        := L.recording_date;
  self.sale_date                             := L.sale_date;
  self.sales_price                           := L.sale_price;
  self.sales_price_code                      := L.sale_code;
  self.mortgage_loan_amount                  := L.first_motgage_amount;
  self.mortgage_loan_type_code               := L.mortgage_loan_type_code;
  self.mortgage_lender_name                  := ut.fn_KeepPrintableChars(L.lender_name);
  self.prior_transfer_date                   := L.prior_document_year;
  self.prior_recording_date                  := L.prior_recording_date;
  self.prior_sales_price                     := L.prior_sales_price;
  self.prior_sales_price_code                := L.prior_sales_code;
  self.assessed_land_value                   := L.assd_land_val;
  self.assessed_improvement_value            := L.assd_improvement_value;
  self.assessed_total_value                  := L.assd_total_val;
  self.market_land_value                     := L.mkt_land_val;
  self.market_improvement_value              := L.mkt_improvement_val;
  self.market_total_value                    := L.mkt_total_val;
  self.homestead_homeowner_exemption         := L.homestead_exempt;
  self.tax_amount                            := L.tax_amount;
  self.tax_year                              := L.tax_year;
  self.school_tax_district1                  := L.tax_code_area;
	self.lot_size															 := L.lot_area;
	self.lot_size_frontage_feet								 := L.front_footage;
	self.lot_size_depth_feet									 := L.depth_footage;
  self.land_acres                            := L.acres;
  self.land_square_footage                   := L.land_square_footage;
  self.land_dimensions                       := trim(L.front_footage,left,right)+'X'+trim(L.depth_footage,left,right);
  self.building_area                         := L.universal_building_sq_feet;
  self.building_area_indicator               := L.building_sq_feet_ind;
  self.year_built                            := L.year_built;
  self.effective_year_built                  := L.effective_year_built;
  self.no_of_buildings                       := L.number_of_buildings;
  self.no_of_stories                         := L.stories_number;
  self.no_of_units                           := L.units_number;
  self.no_of_rooms                           := L.total_rooms;
  self.no_of_bedrooms                        := L.bedrooms;
  self.no_of_baths                           := L.total_baths;
  self.garage_type_code                      := L.garage;
  self.parking_no_of_cars                    := L.parking_spaces;
  self.pool_code                             := L.pool_code;
  self.style_code                            := L.style;
	self.building_quality_code								 := L.quality;
  self.type_construction_code                := L.construction_type;
  self.exterior_walls_code                   := L.exterior_walls;
  self.foundation_code                       := L.foundation;
	self.floor_cover_code											 := L.floor;
  self.roof_cover_code                       := L.roof_cover;
  self.roof_type_code                        := L.roof_type;
  self.heating_code                          := L.heating;
  self.heating_fuel_type_code                := L.fuel;
  self.air_conditioning_code                 := L.air_conditioning;
  self.fireplace_indicator                   := L.fireplace_ind;
  self.fireplace_number                      := L.fireplace_number;
  self.basement_code                         := L.basement_finish;
  self.site_influence1_code                  := L.location_influence;
  self.other_buildings1_code                 := L.bldg_impv_code;
  self.fares_unformatted_apn                 := L.unformatted_apn;
  self.sewer_code                      			 := L.sewer;
  self.water_code                      			 := L.water;
  self.building_condition_code               := L.condition;
  self.standardized_land_use_code            := L.land_use;
	self.update_type													 := L.update_type;
	self.ln_mailing_country_code							 := L.ln_mailing_country_code;
	self.raw_file_name												 := L.raw_file_name;
  self                                       := [];
END;

AssessorWithLN_Format := project(asses_dedup, MapToCommonModel2(left));


EXPORT AssessorWithC_Layout := AssessorWithLN_Format;

//Grab Addl Fares Tax ##########################################################

LN_PropertyV2.layout_addl_fares_tax   MapToaddlTax(asses_dedup L) := transform 
  
  self.ln_fares_id                           				:= L.fares_id;
  self.fares_iris_apn                        				:= L.Iris_apn;
  self.fares_non_parsed_assessee_name        				:= ut.fn_KeepPrintableChars(L.owner_name1);
  self.fares_non_parsed_second_assessee_name 				:= ut.fn_KeepPrintableChars(L.owner_name2);
	self.fares_seller_name                     				:= ut.fn_KeepPrintableChars(L.seller_name);
	self.fares_absentee_owner									 				:= L.absentee_owner;
	self.fares_flood_zone											 				:= L.flood_zone_comm_panel_id;
	self.fares_county_use2										 				:= L.county_use2;
	self.fares_property_indicator 										:= L.property_ind;
	self.fares_view 																	:= L.view;
	self.fares_map_ref_1															:= L.map_ref_1;
	self.fares_map_ref_2															:= L.map_ref_2;
	self.fares_quarter												 				:= L.quater_section;
	self.fares_multi_apn_flag													:= L.multi_apn_flag_1;
	self.fares_subdiv_tract_num 											:= L.subdivision_tract_num;
	self.fares_subdiv_plat_book 											:= L.subdivision_plat_book;
	self.fares_subdiv_plat_page 											:= L.subdivision_plat_page;
	self.fares_owner_match_code 											:= L.own_match_code;
	self.fares_owner_etal_indicator 									:= L.owner_etal_ind;
	self.fares_owner_phone_opt_out_code 							:= L.owner_phone_opt_out_code;
	self.fares_owner_mailing_opt_out_code 						:= L.mailing_opt_out_code;
	self.fares_land_use 															:= L.land_use;
	self.fares_calculated_land_value_ind 							:= L.land_value_calc_ind;
	self.fares_calculated_land_value           				:= L.land_val_calc;
	self.fares_calculated_improvement_value_ind 			:= L.improvement_value_calc_ind;
	self.fares_calculated_improvement_value    				:= L.improvement_value_calc;
	self.fares_calculated_total_value_ind 						:= L.total_value_calc_ind;
  self.fares_calculated_total_value          				:= L.total_val_calc; 
	self.fares_appr_total_value 											:= L.appr_total_val;
	self.fares_appr_land_value 												:= L.appr_land_val;
	self.fares_appr_improvement_value 								:= L.appr_improvement_val;
	self.fares_sales_deed_cat_type 										:= L.sales_deed_cat_type;
	self.fares_sale_transaction_code 									:= L.sale_trans_code;
	self.fares_title_company_name 										:= L.title_company_name;
	self.fares_residential_model_ind 									:= L.residential_model_ind;
	self.fares_mortgage_date 													:= L.mortgage_date;
	self.fares_mortgage_deed_type 										:= L.mortgage_deed_type;
	self.fares_mortgage_term_code 										:= L.mortgage_term_code;
	self.fares_mortgage_term 													:= L.mortgage_term;
	self.fares_mortgage_due_date 											:= L.mortgage_due_date;
	self.fares_mortgage_assumption_amt 								:= L.mortgage_assumption_amount;
	self.fares_lender_code 														:= L.lender_code;
	self.fares_second_mortgage_amt 										:= L.second_mortgage_amount;
	self.fares_second_mortgage_loan_type_code 				:= L.second_mortgage_loan_type_code;
	self.fares_second_deed_type 											:= L.second_deed_type;
	self.fares_prior_document_number 									:= L.prior_document_number;
	self.fares_prior_book_page 												:= L.prior_book_page;
	self.fares_prior_sales_deed_cat_type 							:= L.prior_sls_deed_cat_type;
	self.fares_prior_mortgage_amount 									:= L.prior_mortgage_amount;
	self.fares_prior_deed_type 												:= L.prior_deed_type;
	self.fares_bldg_code															:= L.bldg_code;
	self.fares_living_square_feet 										:= L.living_square_feet;
	self.fares_gross_square_feet 											:= L.gross_square_feet;
  self.fares_adjusted_gross_square_feet      				:= L.adjusted_gross_square_feet;
	self.fares_ground_floor_square_feet								:= L.ground_floor_square_feet;
	self.fares_basement_square_feet 									:= L.basement_square_feet;
	self.fares_garage_square_feet 										:= L.garage_parking_square_feet;
	self.fares_total_baths_calculated 								:= L.total_baths_calculated;
	self.fares_no_of_full_baths                				:= L.full_baths;
  self.fares_no_of_half_baths                				:= L.half_baths;
  self.fares_no_of_one_qtr_baths 										:= L.one_qtr_baths;
	self.fares_no_of_three_qtr_baths 									:= L.three_qtr_baths;
	self.fares_no_of_bath_fixtures 										:= L.bath_fixtures;
	self.fares_fire_place_type 												:= L.fireplace_type;
	self.fares_mobile_home_indicator 									:= L.mobile_home_ind;
  self.fares_pool_indicator                  				:= L.pool;
	self.fares_frame                           				:= if(trim(regexreplace('^[0]{2,}',L.frame,''),left,right) in ['0','1','999'],
																													 regexreplace('^[0]{2,}',trim(L.frame,left,right),''),
																													 if(length(trim(stringlib.stringfilter(L.frame,'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right)) = 1,trim(stringlib.stringfilter(L.frame,'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'),left,right),''));
	self.fares_electric_energy                 				:= L.electric_energy;
	self.fares_parking_type 													:= L.parking_type;
	self.fares_stories_code 													:= L.stories_code;
	self.fares_sewer																	:= L.sewer;
	self.fares_water																	:= L.water;
	self.fares_condition															:= L.condition;
end;

Addl_fares_tax :=  project(asses_dedup, MapToaddlTax(left));

EXPORT Addl_fares_taxWithC_layout := Addl_fares_tax;

//Grab Addl Fares Legal ##########################################################

LN_PropertyV2.layout_addl_legal MapToaddlLegal(asses_dedup L) := transform 

  self.ln_fares_id                           := L.fares_id;
  self.addl_legal                            := ut.fn_KeepPrintableChars(L.legal2) + ut.fn_KeepPrintableChars(L.legal3) ; 

END; 

Addl_legal :=  project(asses_dedup(legal2 != '' or legal3 != ''), MapToaddlLegal(left));

EXPORT Addl_legalWithC_layout := Addl_legal ; 

end;