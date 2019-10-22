IMPORT ut;

EXPORT Rollup_Base(DATASET(Database_USA.Layouts.Base) pDataset) := FUNCTION

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(dbusa_business_id+dbusa_executive_id));
	
	pDataset_sort := SORT( pDataset_Dist 
												,dbusa_business_id							,dbusa_executive_id						,subhq_parent_id				
												,hq_id													,ind_frm_indicator						,company_name					
												,full_name											,prefix,first_name						,middle_initial				
												,last_name											,suffix,gender								,standardized_title	
												,sourcetitle										,executive_title_rank					,primary_exec_flag			
												,exec_type											,executive_department					,executive_level			
												,phy_addr_standardized					,phy_addr_city								,phy_addr_state				
												,phy_addr_zip										,phy_addr_zip4								,phy_addr_carrierroute
												,phy_addr_deliverypt						,phy_addr_deliveryptchkdig		,mail_addr_standardized	
												,mail_addr_city									,mail_addr_state							,mail_addr_zip
												,mail_addr_zip4									,mail_addr_carrierroute				,mail_addr_deliverypt
												,mail_addr_deliveryptchkdig			,mail_score										,mail_score_desc
												,phone													,area_code										,fax,email
												,email_available_indicator			,url													,url_facebook
												,url_googleplus									,url_instagram								,url_linkedin
												,url_twitter										,url_youtube									,business_status_code
												,business_status_desc						,franchise_flag								,franchise_type
												,franchise_desc									,ticker_symbol								,stock_exchange
												,fortune_1000_flag							,fortune_1000_rank						,fortune_1000_branches
												,num_linked_locations						,county_code									,county_desc
												,cbsa_code											,cbsa_desc										,geo_match_level
												,latitude												,longitude										,scf
												,timezone												,censustract									,censusblock
												,city_population_code						,city_population_descr				,primary_sic
												,primary_sic_desc								,sic02												,sic02_desc
												,sic03													,sic03_desc										,sic04
												,sic04_desc											,sic05												,sic05_desc
												,sic06													,sic06_desc										,primarysic2
												,primary_2_digit_sic_desc				,primarysic4									,primary_4_digit_sic_desc
												,naics01												,naics01_desc									,naics02
												,naics02_desc										,naics03											,naics03_desc
												,naics04												,naics04_desc									,naics05
												,naics05_desc										,naics06											,naics06_desc
												,location_employees_total				,location_employee_code				,location_employee_desc
												,location_sales_total						,location_sales_code					,location_sales_desc
												,corporate_employee_total				,corporate_employee_code			,corporate_employee_desc
												,year_established								,years_in_business_range			,female_owned
												,minority_owned_flag						,minority_type								,home_based_indicator
												,small_business_indicator				,import_export								,manufacturing_location
												,public_indicator								,ein													,non_profit_org
												,square_footage									,square_footage_code					,square_footage_desc
												,creditscore										,creditcode										,credit_desc
												,credit_capacity								,credit_capacity_code					,credit_capacity_desc
												,advertising_expenses_code			,expense_advertising_desc			,technology_expenses_code
												,expense_technology_desc				,office_equip_expenses_code		,expense_office_equip_desc
												,rent_expenses_code							,expense_rent_desc						,telecom_expenses_code
												,expense_telecom_desc						,accounting_expenses_code			,expense_accounting_desc
												,bus_insurance_expense_code			,expense_bus_insurance_desc		,legal_expenses_code
												,expense_legal_desc							,utilities_expenses_code			,expense_utilities_desc
												,number_of_pcs_code							,number_of_pcs_desc						,nb_flag
												,hq_company_name								,hq_city											,hq_state
												,subhq_parent_name							,subhq_parent_city						,subhq_parent_state
												,domestic_foreign_owner_flag		,foreign_parent_company_name	,foreign_parent_city
												,foreign_parent_country					,db_cons_matchkey							,databaseusa_individual_id
												,db_cons_full_name							,db_cons_full_name_prefix			,db_cons_first_name	
												,db_cons_middle_initial					,db_cons_last_name						,db_cons_email
												,db_cons_gender									,db_cons_date_of_birth_year		,db_cons_date_of_birth_month
												,db_cons_age										,db_cons_age_code_desc				,db_cons_age_in_two_year_hh
												,db_cons_ethnic_code						,db_cons_religious_affil			,db_cons_language_pref
												,db_cons_phy_addr_std						,db_cons_phy_addr_city				,db_cons_phy_addr_state
												,db_cons_phy_addr_zip						,db_cons_phy_addr_zip4				,db_cons_phy_addr_carrierroute
												,db_cons_phy_addr_deliverypt		,db_cons_line_of_travel				,db_cons_geocode_results
												,db_cons_latitude								,db_cons_longitude						,db_cons_time_zone_code
												,db_cons_time_zone_desc					,db_cons_census_tract					,db_cons_census_block
												,db_cons_countyfips							,db_countyname								,db_cons_cbsa_code
												,db_cons_cbsa_desc							,db_cons_walk_sequence				,db_cons_phone
												,db_cons_dnc										,db_cons_scrubbed_phoneable		,db_cons_children_present
												,db_cons_home_value_code				,db_cons_home_value_desc			,db_cons_donor_capacity
												,db_cons_donor_capacity_code		,db_cons_donor_capacity_desc	,db_cons_home_owner_renter
												,db_cons_length_of_res					,db_cons_length_of_res_code		,db_cons_length_of_res_desc
												,db_cons_dwelling_type					,db_cons_recent_home_buyer		,db_cons_income_code
												,db_cons_income_desc						,db_cons_unsecuredcredcap			,db_cons_unsecuredcredcapcode
												,db_cons_unsecuredcredcapdesc		,db_cons_networthhomeval			,db_cons_networthhomevalcode
												,db_cons_net_worth_desc					,db_cons_discretincome				,db_cons_discretincomecode
												,db_cons_discretincomedesc			,db_cons_marital_status				,db_cons_new_parent
												,db_cons_child_near_hs_grad			,db_cons_college_graduate			,db_cons_intend_purchase_veh
												,db_cons_recent_divorce					,db_cons_newlywed							,db_cons_new_teen_driver
												,db_cons_home_year_built				,db_cons_home_sqft_ranges			,db_cons_poli_party_ind
												,db_cons_home_sqft_actual				,db_cons_occupation_ind				,db_cons_credit_card_user
												,db_cons_home_property_type			,db_cons_education_hh					,db_cons_education_ind
												,db_cons_other_pet_owner
												,LOCAL );
	
	Database_USA.Layouts.Base RollupUpdate(Database_USA.Layouts.Base L, Database_USA.Layouts.Base R) := TRANSFORM
		
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := Earliest_Date;
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.record_sid						    := IF(Earliest_Date = L.dt_vendor_first_reported, L.record_sid, R.record_sid);  //Use the earliest record_sid
		SELF                          := L;
	END;

	pDataset_rollup := ROLLUP(pDataset_sort
														,RollupUpdate(LEFT, RIGHT)
														,dbusa_business_id							,dbusa_executive_id						,subhq_parent_id				
														,hq_id													,ind_frm_indicator						,company_name					
														,full_name											,prefix,first_name						,middle_initial				
														,last_name											,suffix,gender								,standardized_title	
														,sourcetitle										,executive_title_rank					,primary_exec_flag			
														,exec_type											,executive_department					,executive_level			
														,phy_addr_standardized					,phy_addr_city								,phy_addr_state				
														,phy_addr_zip										,phy_addr_zip4								,phy_addr_carrierroute
														,phy_addr_deliverypt						,phy_addr_deliveryptchkdig		,mail_addr_standardized	
														,mail_addr_city									,mail_addr_state							,mail_addr_zip
														,mail_addr_zip4									,mail_addr_carrierroute				,mail_addr_deliverypt
														,mail_addr_deliveryptchkdig			,mail_score										,mail_score_desc
														,phone													,area_code										,fax,email
														,email_available_indicator			,url													,url_facebook
														,url_googleplus									,url_instagram								,url_linkedin
														,url_twitter										,url_youtube									,business_status_code
														,business_status_desc						,franchise_flag								,franchise_type
														,franchise_desc									,ticker_symbol								,stock_exchange
														,fortune_1000_flag							,fortune_1000_rank						,fortune_1000_branches
														,num_linked_locations						,county_code									,county_desc
														,cbsa_code											,cbsa_desc										,geo_match_level
														,latitude												,longitude										,scf
														,timezone												,censustract									,censusblock
														,city_population_code						,city_population_descr				,primary_sic
														,primary_sic_desc								,sic02												,sic02_desc
														,sic03													,sic03_desc										,sic04
														,sic04_desc											,sic05												,sic05_desc
														,sic06													,sic06_desc										,primarysic2
														,primary_2_digit_sic_desc				,primarysic4									,primary_4_digit_sic_desc
														,naics01												,naics01_desc									,naics02
														,naics02_desc										,naics03											,naics03_desc
														,naics04												,naics04_desc									,naics05
														,naics05_desc										,naics06											,naics06_desc
														,location_employees_total				,location_employee_code				,location_employee_desc
														,location_sales_total						,location_sales_code					,location_sales_desc
														,corporate_employee_total				,corporate_employee_code			,corporate_employee_desc
														,year_established								,years_in_business_range			,female_owned
														,minority_owned_flag						,minority_type								,home_based_indicator
														,small_business_indicator				,import_export								,manufacturing_location
														,public_indicator								,ein													,non_profit_org
														,square_footage									,square_footage_code					,square_footage_desc
														,creditscore										,creditcode										,credit_desc
														,credit_capacity								,credit_capacity_code					,credit_capacity_desc
														,advertising_expenses_code			,expense_advertising_desc			,technology_expenses_code
														,expense_technology_desc				,office_equip_expenses_code		,expense_office_equip_desc
														,rent_expenses_code							,expense_rent_desc						,telecom_expenses_code
														,expense_telecom_desc						,accounting_expenses_code			,expense_accounting_desc
														,bus_insurance_expense_code			,expense_bus_insurance_desc		,legal_expenses_code
														,expense_legal_desc							,utilities_expenses_code			,expense_utilities_desc
														,number_of_pcs_code							,number_of_pcs_desc						,nb_flag
														,hq_company_name								,hq_city											,hq_state
														,subhq_parent_name							,subhq_parent_city						,subhq_parent_state
														,domestic_foreign_owner_flag		,foreign_parent_company_name	,foreign_parent_city
														,foreign_parent_country					,db_cons_matchkey							,databaseusa_individual_id
														,db_cons_full_name							,db_cons_full_name_prefix			,db_cons_first_name	
														,db_cons_middle_initial					,db_cons_last_name						,db_cons_email
														,db_cons_gender									,db_cons_date_of_birth_year		,db_cons_date_of_birth_month
														,db_cons_age										,db_cons_age_code_desc				,db_cons_age_in_two_year_hh
														,db_cons_ethnic_code						,db_cons_religious_affil			,db_cons_language_pref
														,db_cons_phy_addr_std						,db_cons_phy_addr_city				,db_cons_phy_addr_state
														,db_cons_phy_addr_zip						,db_cons_phy_addr_zip4				,db_cons_phy_addr_carrierroute
														,db_cons_phy_addr_deliverypt		,db_cons_line_of_travel				,db_cons_geocode_results
														,db_cons_latitude								,db_cons_longitude						,db_cons_time_zone_code
														,db_cons_time_zone_desc					,db_cons_census_tract					,db_cons_census_block
														,db_cons_countyfips							,db_countyname								,db_cons_cbsa_code
														,db_cons_cbsa_desc							,db_cons_walk_sequence				,db_cons_phone
														,db_cons_dnc										,db_cons_scrubbed_phoneable		,db_cons_children_present
														,db_cons_home_value_code				,db_cons_home_value_desc			,db_cons_donor_capacity
														,db_cons_donor_capacity_code		,db_cons_donor_capacity_desc	,db_cons_home_owner_renter
														,db_cons_length_of_res					,db_cons_length_of_res_code		,db_cons_length_of_res_desc
														,db_cons_dwelling_type					,db_cons_recent_home_buyer		,db_cons_income_code
														,db_cons_income_desc						,db_cons_unsecuredcredcap			,db_cons_unsecuredcredcapcode
														,db_cons_unsecuredcredcapdesc		,db_cons_networthhomeval			,db_cons_networthhomevalcode
														,db_cons_net_worth_desc					,db_cons_discretincome				,db_cons_discretincomecode
														,db_cons_discretincomedesc			,db_cons_marital_status				,db_cons_new_parent
														,db_cons_child_near_hs_grad			,db_cons_college_graduate			,db_cons_intend_purchase_veh
														,db_cons_recent_divorce					,db_cons_newlywed							,db_cons_new_teen_driver
														,db_cons_home_year_built				,db_cons_home_sqft_ranges			,db_cons_poli_party_ind
														,db_cons_home_sqft_actual				,db_cons_occupation_ind				,db_cons_credit_card_user
														,db_cons_home_property_type			,db_cons_education_hh					,db_cons_education_ind
														,db_cons_other_pet_owner
														,LOCAL );

	RETURN pDataset_rollup;

END;