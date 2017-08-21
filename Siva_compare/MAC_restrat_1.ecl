EXPORT MAC_restrat_1(no_of_keys,primary_list, key1,  key2,  key3, compare_file_name ) := functionmacro


probme_layout :=
RECORD
  string80 address_id;
  string80 state_code;
  string80 zip_code;
  string80 city_name_abbr;
  string80 address_quality_indicator;
  string80 county_code;
  string80 county_name;
  string80 census_tract;
  string80 census_block;
  string80 latitude;
  string80 longitude;
  string80 level_latitude_longitude;
  string80 ispsa;
  string80 wealth_rating;
  string80 uid;
  string80 phone_pander_flag;
  string80 unscrubbed_do_not_use_phone;
  string80 special_usage_flag;
  string80 pander_source_flags;
  string80 dwelling_unit_size;
  string80 dwelling_type_drv;
  string80 homeowner_probability_model;
  string80 ownership_code_drv;
  string80 ins_est_income_wo_summarized_credit;
  string80 income_code_drv;
  string80 move_update_code;
  string80 move_update_date;
  string80 recipient_reliability_code_old;
  string80 cppm_mail_order_buyer;
  string80 dma_pander_flag;
  string80 home_business;
  string80 lor_drv_numeric;
  string80 number_of_persons_in_living_unit;
  string80 number_of_adults_in_household;
  string80 rural_urban_county_size_code;
  string80 last_activity_date_of_lu;
  string80 pid;
  string80 name_type;
  string80 first_name;
  string80 middle_initial;
  string80 last_name;
  string80 surname_suffix_p1;
  string80 title_of_respect_p1;
  string80 ethnic_detail_code;
  string80 cppm_ethnic_plus;
  string80 ethnic_religion_code;
  string80 ethnic_language_pref;
  string80 ethnic_grouping_code;
  string80 ethnic_country_of_origin_code;
  string80 gender_code_drv;
  string80 exact_dob_drv_orig;
  string80 estimated_age_p1;
  string80 exact_age_p1;
  string80 combined_age_indicator;
  string80 age_in_years_drv_numeric;
  string80 education_p1;
  string80 marital_status_confidence_flag;
  string80 marital_code_drv;
  string80 occupation_group_p1;
  string80 occupation_code_polk;
  string80 business_owner_p1;
  string80 presence_of_email;
  string80 email_id_number;
  string80 number_children_drv;
  string80 mor_bank_upscale_merch_buyer;
  string80 mor_bank_male_merch_buyer;
  string80 mor_bank_female_merch_buyer;
  string80 mor_bank_crafts_hobb_merch_buyer;
  string80 mor_bank_gardening_farming_buyer;
  string80 mor_bank_book_buyer;
  string80 mor_bank_collect_special_foods_buyer;
  string80 mor_bank_gifts_and_gadgets_buyer;
  string80 mor_bank_general_merch_buyer;
  string80 mor_bank_family_and_general_magazine;
  string80 mor_bank_female_oriented_magazine;
  string80 mor_bank_male_sports_magazine;
  string80 mor_bank_religious_magazine;
  string80 mor_bank_gardening_farming_magazine;
  string80 mor_bank_culinary_interests_magazine;
  string80 mor_bank_health_and_fitness_magazine;
  string80 mor_bank_do_it_yourselfers;
  string80 mor_bank_news_and_financial;
  string80 mor_bank_photography;
  string80 mor_bank_opportunity_seekers_and_ce;
  string80 mor_bank_religious_contributor;
  string80 mor_bank_political_contributor;
  string80 mor_bank_health_and_institution_contributor;
  string80 mor_bank_general_contributor;
  string80 mor_bank_miscellaneous;
  string80 mor_bank_odds_and_ends;
  string80 mor_bank_deduped_category_hit_count;
  string80 mor_bank_non_deduped_category_hit_count;
  string80 home_purch_price;
  string80 home_purch_date_char;
  string80 year_built_fam2;
  string80 home_land_value;
  string80 home_property_ind;
  string80 enh_mktval_drv_orig;
  string80 in_the_market_model;
  string80 new_car_model;
  string80 used_car_model;
  string80 year_built_new_confidence_flag;
  string80 eff_year_built;
  string80 auto_in_the_market_new;
  string80 auto_in_the_market_used;
  string80 auto_in_the_market_used_0_5;
  string80 auto_in_the_market_used_6_10;
  string80 auto_in_the_market_used_11_plus;
  string80 donates_to_environmental_causes;
  string80 contributes_to_charities;
  string80 presence_of_credit_card;
  string80 presence_of_premium_credit_card;
  string80 interest_in_reading;
  string80 computer_owner;
  string80 estimated_current_median_family_income;
  string80 mosaic_household_2011;
  string80 mosaic_z4_2011;
  string80 mosaic_household_global_2011;
  string80 mosaic_z4_global_2011;
  string80 household_composition;
  string80 persons_per_household;
  string80 prizm_ne_prizm_licensees_only;
  string80 census_median_age_2000;
  string80 census_pct_white_only_2000;
  string80 census_pct_black_only_2000;
  string80 census_pct_asian_only_2000;
  string80 census_pct_hispanic_2000;
  string80 census_pct_households_with_children_2000;
  string80 census_pct_households_married_couples_2000;
  string80 census_pct_dwelling_units_owner_occupied_2000;
  string80 census_pct_dwelling_units_renter_occupied_2000;
  string80 census_average_household_size_2000;
  string80 census_pct_population_age_65plus_2000;
  string80 census_married_couple_families_with_any_person_under18_2000;
  string80 census_married_couple_families_wo_any_person_under18_2000;
  string80 census_median_housing_value_2000;
  string80 census_pct_population_age_under_18_2000;
  string80 census_pct_population_age_18plus_2000;
  string80 census_units_in_structure_mobile_home_2000;
  string80 census_median_dwelling_age_2000;
  string80 census_pct_households_spanish_speaking_2000;
  string80 census_median_years_school_completed_2000;
  string80 core_based_statistical_areas_cbsa;
  string80 core_based_statistical_area_type;
  string80 home_total_value;
  string80 total_tax;
  string80 home_improvement_value;
  string80 home_swimming_pool_indicator;
  string80 home_base_square_footage;
  string80 home_exterior_wall_type;
  string80 interest_in_gardening;
  string80 interest_in_automotive;
  string80 interest_in_gourmet_cooking;
  string80 home_decorating_furnishing;
  string80 dog_enthusiasts;
  string80 cat_enthusiast;
  string80 pet_enthusiast;
  string80 interest_in_travel;
  string80 interest_in_fitness;
  string80 interest_in_the_outdoors;
  string80 interest_in_sports;
  string80 investor_flag;
  string80 purchased_through_the_mail;
  string80 cruise_enthusiasts;
  string80 invest_in_mutual_funds_annuities;
  string80 purchase_via_phone;
  string80 internet_online_subscriber;
  string80 purchase_via_on_line;
  string80 interest_in_domestic_travel;
  string80 interest_in_foreign_travel;
  string80 type_of_purchase;
  string80 oo_home_mortgage_amt;
  string80 mortgage_lender_name;
  string80 mortgage_rate_type;
  string80 mortgage_term_in_months;
  string80 home_mortgage_type;
  string80 deed_date_of_equity_loan;
  string80 equity_amount_in_thousands;
  string80 equity_lender_name;
  string80 equity_rate_type;
  string80 equity_term;
  string80 equity_loan_type;
  string80 deed_date_of_refi_loan;
  string80 refi_mortgage_amt;
  string80 refinance_lender_name;
  string80 refinance_rate_type;
  string80 refinance_term_in_months;
  string80 refinance_loan_type;
  string80 purchase_amount_in_thousands;
  string80 mortgage_amount_in_thousands2;
  string80 home_lender_name_old;
  string80 dl_cppm_mortgage_term;
  string80 i_home_mortgage_type;
  string80 refinance_term;
  string80 landlord_flag;
  string80 mes_score;
  string80 income_index;
  string80 pct_population_25plus_with_a_degree;
  string80 mortgage_home_purchase_estimated_current_mortgage_amount_new;
  string80 mortgage_home_purchase_estimated_current_monthly_mortgage_payment_new;
  string80 enh_ltv_drv_confidence_flag;
  string80 enh_ltv_drv;
  string80 mortgage_home_purchase_estimated_available_equity_new;
  string80 psycle_code_indicator;
  string80 psycle_code_new;
  string80 ipa_psycle_code_indicator;
  string80 ipa_psycle_code;
  string80 net_worth;
  string80 children_0_18_v3;
  string80 children_0_3_v3;
  string80 children_0_3_score_v3;
  string80 children_0_3_gender;
  string80 children_4_6_v3;
  string80 children_4_6_score_v3;
  string80 children_4_6_gender;
  string80 children_7_9_v3;
  string80 children_7_9_score_v3;
  string80 children_7_9_gender;
  string80 children_10_12_v3;
  string80 children_10_12_score_v3;
  string80 children_10_12_gender;
  string80 children_13_15_v3;
  string80 children_13_15_score_v3;
  string80 children_13_15_gender;
  string80 children_16_18_v3;
  string80 children_16_18_score_v3;
  string80 children_16_18_gender;
  string80 truetouch_buyamerican;
  string80 truetouch_showmethemoney;
  string80 truetouch_gowiththeflow;
  string80 truetouch_notimelikethepresent;
  string80 truetouch_nevershowupemptyhanded;
  string80 truetouch_ontheroadagain;
  string80 truetouch_lookatmenow;
  string80 truetouch_stopandsmelltheroses;
  string80 truetouch_workhardplayhard;
  string80 truetouch_apennysavedapennyearned;
  string80 truetouch_itsallinthename;
  string80 census_2010_tract_and_block_code;
  string80 census_median_age_2010;
  string80 census_pct_population_age_under_18_2010;
  string80 census_pct_population_age_18plus_2010;
  string80 census_pct_population_age_65plus_2010;
  string80 census_pct_white_only_2010;
  string80 census_pct_black_only_2010;
  string80 census_pct_asian_only_2010;
  string80 census_pct_hispanic_2010;
  string80 census_persons_per_household_2010;
  string80 census_average_household_size_2010;
  string80 census_pct_households_married_couples_2010;
  string80 census_pct_households_with_children_2010;
  string80 census_married_couple_families_with_any_person_under18_2010;
  string80 census_married_couple_families_wo_any_person_under18_2010;
  string80 census_pct_households_spanish_speaking_2010;
  string80 census_pct_25plus_median_years_school_completed_2010;
  string80 census_pct_25plus_25plus_with_a_degree_2010;
  string80 census_median_housing_value_2010;
  string80 census_units_in_structure_mobile_home_2010;
  string80 census_median_dwelling_age_2010;
  string80 census_pct_dwelling_units_owner_occupied_2010;
  string80 census_pct_dwelling_units_renter_occupied_2010;
  string80 cape_ispsa;
  string80 cape_ispsa_decile_within_state;
  string80 census_wealth_rating_2010;
  string80 census_state_median_family_income_2010;
  string80 census_income_index_2010;
  string80 ace_prim_addr;
  string80 ace_sec_addr;
  string80 city;
  string80 state;
  string80 zip;
  string80 zip4;
  string80 ace_prim_range;
  string80 ace_predir;
  string80 ace_prim_name;
  string80 ace_suffix;
  string80 ace_postdir;
  string80 ace_unit_desig;
  string80 ace_sec_range;
  string80 ace_rr_number;
  string80 ace_rr_box;
  string80 ace_z4_record_type;
  string80 ace_county;
  string80 dpbc_check_digit;
  string80 dpbc;
  string80 carrier_rt_code;
  string80 ace_trunc_flag;
  string80 ace_dns_flag;
  string80 ace_err_stat;
  string80 lot;
  string80 lot_order;
  string80 ace_addr_numerics;
  string80 uik;
  string80 uhk;
  string80 uak;
  string80 address;
  string80 hisp_score_drv;
  string80 slpi_drv;
  string80 source_usage;
  string80 wealth;
  string80 wealth_state;
  string80 always_y;
  string80 birth_month;
  string80 mortgage_age;
  string80 home_purch_month;
  string80 exact_dob_mm_yyyy;
  string80 refi_flag_txn;
  string80 mes_score_numeric;
  string80 phone_drv;
  string80 phone_flag_drv;
  string80 prd_auto_month;
  string80 prd_prop_month;
  string80 children_age_0_2;
  string80 children_age_16_17;
  string80 presence_of_boat;
  string80 motorcycle_ownership_code;
  string80 recreational_vehicle_ownership_code;
  string80 number_of_vehicles_registered;
  string80 recipient_reliability_code;
  string80 source_vehicle;
  string80 marketing_risk_index;
  string80 hisp_pct;
  string80 first_match;
  string80 last_match;
  string80 citykey_drv;
  string80 scf_drv;
  string80 unscrubbed_do_not_use_areacode;
  string80 wsl_dwelling_code;
  string80 zip9;
  string80 allstate_decile;
  string80 allstate_score;
  string80 auto_score;
  string80 competitivenessscore;
  string80 competitiveness_tile;
  string80 activity_tile;
  string80 allstate_original_tier;
  string80 allstate_iscontrol;
  string80 scorerespmedsup;
  string80 bk_score;
  string80 age_16_24_in_hh;
  string80 apt_flag;
  string80 sfdu_flag_drv;
  string80 followup_dt;
  string80 presence_boat_motorcycle_rv;
  string80 unscrubbed_area_code;
  string80 scorerespltc;
  string80 rural_flag_drv;
  string80 home_lender_name;
  string80 state_county_lookup_numeric;
  string80 home_purch_date;
  string80 linkid;
  string80 best_phone;
  string80 file_seq;
  string80 aca_qualifies;
  string80 formatted_phone;
  string80 formatted_phone_u;
  string80 phone_number_no_u;
  string80 mortgage_protection_model;
  string80 source_mc;
  string80 life_attrition_model;
  string80 source_boat;
  string80 life_attrition_model_decile;
  string80 enh_mktval_drv;
  string80 linkhhid;
  string80 presence_of_snowmobile;
  string80 boca_confidence_score;
  string80 email_id_number_drv;
  string80 channel_pref_d_score;
  string80 channel_pref_e_score;
  string80 channel_pref_i_score;
  string80 roofcode;
  string80 rooflt5;
  string80 rooflt10;
  string80 rooflt15;
  string80 roofyear;
  string80 constructionyear;
  string80 trvcompetemodel;
  string80 finalexpensebasenew;
  string80 trv_compete_decile;
  string80 fe_tier;
  string80 channel_pref_i_decile;
  string80 channel_pref_d_decile;
  string80 channel_pref_e_decile;
  string80 children_0_3;
  string80 children_4_6;
  string80 children_7_9;
  string80 children_10_12;
  string80 shelterresponsemodel;
  string80 num_mails;
  string80 prospectsurvival_model;
  string80 prospectsurvival_decile;
  string80 activity_model;
  string80 amp_arq_model;
  string80 premium_decile;
  string80 child_flag_drv;
  string80 census_tract_2010;
  string80 census_block_2010;
  string80 census_ispsa_2010;
  string80 children_0_3_flag;
  string80 children_4_6_flag;
  string80 children_7_9_flag;
  string80 children_10_12_flag;
  string80 children_13_18_flag;
  string80 children_13_18;
  string80 annuitybase;
  string80 annuity_decile_full;
  string80 shelterindexscore;
  string80 sic_activity;
  string80 premiummodelbase;
  string80 zip_excl_flag;
  string80 yearbuilt_or_roofyear_lt8;
  string80 yearbuilt_or_roofyear_lt9;
  string80 exact_dob_drv;
  string80 krm_dwelling_code;
  string80 age_drv;
  string80 ccp_age_21_40;
  string80 ccp_age_40_64;
  string80 ccp_age_45_75;
  string80 ccp_age_21_64;
  string80 mortgage_protection_decile;
  string80 mortgage_protection_decile_aca;
  string80 shelter_response_tier;
  string80 premium_score;
  string80 ppd_flag;
  string80 trv_qualifies_flag;
  string80 scorerespfinalexpense;
  string80 tier_ltc;
  string80 tier_medsup;
  string80 mri_tier_trv;
  string80 annuity_model;
  string80 amp_arq_decile;
  string80 shelterindexdecile;
  string80 channel_preference;
  string80 allstate_comp_activity_segment;
  string80 annuity_decile;
  string80 bktier;
  string1 _unnamed_437;
  integer1 flag_data;
 END;






        prob_records_0 := dataset('~pview::compare::mcr_distribute', probme_layout, thor); 
		 

        prob_records := distribute(prob_records_0, hash(key1)) :independent ;
				
				siva_compare.MAC_compare_file_columns(prob_records, file5, no_of_keys, primary_list, key1,  key2,  key3);

			// output(file5);


			 siva_compare.MAC_compare_file_text(file5,  file6 , primary_list);

			// output(file6);


			final_result_0 := join(prob_records, file6,
																													// (qstring) left.key1 = (qstring) right.key1 and
																													// (qstring) left.key2 = (qstring) right.key2 and
																													// (qstring) left.key3 = (qstring) right.key3 );
											
			 #if ( (integer) no_of_keys = 1 )
													(qstring) left.key1 = (qstring) right.key1, local );
													
													
			 #elseif ( (integer) no_of_keys = 3 )
													 (qstring) left.key1 = (qstring) right.key1  and		 
													 (qstring) left.key2 = (qstring) right.key2  and
													 (qstring) left.key3 = (qstring) right.key3, local );
			 #elseif ( (integer) no_of_keys = 2 )
													 (qstring) left.key1 = (qstring) right.key1  and		                    
													 (qstring) left.key2 = (qstring) right.key2, local );
			 #end														
													
					 //output(	count(final_result_0), named('counts_where_files_differ_restart'));
					 
			 
			 
      final_result_1	:=  project( final_result_0, transform({recordof(final_result_0) },
						                  self.text_string := TRIM(StringLib.StringCleanSpaces(left.text_string));
											        self := left));
															
      final_result_99	:=  project( final_result_1, transform({recordof(final_result_1) },															
												self.text_string := if( left.text_string[1] in [','], left.text_string[2 .. length(left.text_string) - 1],  left.text_string);
			                  self := left));
												
			 
			 final_result := distribute( final_result_99, hash64(text_string));
			 
			 
						 //group by text_string
			grp_rec := record


			cnt_grp := count(group);
			trim(final_result.text_string);


			end;

			 
			 
			 group_result := table(final_result, grp_rec, text_string, local);
			 
			//output(sort(group_result, cnt_grp ), named ('aggregate_report_restart'));
			
			out := output( final_result, ,'~pview::compare::' + ut.getdate, overwrite);
	return 	out	;										
endmacro;