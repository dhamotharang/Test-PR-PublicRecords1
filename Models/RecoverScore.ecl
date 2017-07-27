import ut, Risk_Indicators;

export RecoverScore(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date=999999, string addr_type_a, string addr_confidence_a, string ph_phone_type_a_1, 
				string bk_disp_code_1, string dcd_match_code_1, string chargeoff_amount, string debt_type) := 


FUNCTION


Recover_Output := RECORD
	STRING3 address_index;
	STRING3 telephone_index;
	STRING3 contactability_score;
	STRING3 asset_index;
	STRING3 lifecycle_stress_index;
	STRING3 liquidity_score;
	STRING3 recover_score;
END;


// Project the boca shell results into the 9 scores
Recover_Output doModel(clam le) := TRANSFORM 

	sysyear := (integer)(ut.GetDate[1..4]);
	
	address_confirmed := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'C', true,false);
	address_updated := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'U', true,false);
	address_verified := if(trim(StringLib.StringToUpperCase(addr_confidence_a)) = 'A', true,false);
	
	EDA_Match_Level := map(trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'A' => 2,
					   trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'C' => 1,
					   0);
	
	bk_level := map(bk_disp_code_1 = '20' => 3,
				 bk_disp_code_1 = '02' => 2,
				 bk_disp_code_1 = '99' => 2,
				 bk_disp_code_1 = ''  => 1,
				 bk_disp_code_1 = '15' => 0,
				 0);
	
	
	deceased_sc := if(dcd_match_code_1 = '1', 1,0);
	
	address_ver_sc := map(address_confirmed and address_verified => 4,
					  address_updated and address_verified => 3,
					  address_confirmed => 2,
					  address_updated => 1,
					  0);
	
	
	/* Modeling Shell */
	
	
	/* NAP and NAS */
		
	verfst_p := if(le.iid.nap_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	veradd_p := if(le.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	
	verfst_s := if(le.iid.nas_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_s := if(le.iid.nas_summary in [2,5,7,8,9,11,12], 1,0);
	
		
	nap_nas_namever := case(verfst_s + verlst_s,
						2 => verfst_s + verlst_s + verfst_p + verlst_p,
						1 => 1,
						0 => if (verfst_p = 1 or verlst_p = 1, 1, 0),
						1);
					/*map(verfst_p + verlst_p + verfst_s + verlst_s = 0 => 0,
					   verfst_p + verlst_p + verfst_s + verlst_s = 4 => 4,
					   verfst_s = 1 and verlst_s = 1 and (verfst_p = 1 or verlst_p = 1) => 3,
					   verfst_s = 1 and verlst_s = 1 => 2,
					   1);*/
	
	verflag := map(nap_nas_namever = 0 => 0,
				le.address_verification.input_address_information.naprop = 4 and nap_nas_namever = 4 => 5,
				le.address_verification.input_address_information.naprop = 4 => 4,
				le.address_verification.input_address_information.naprop = 3 and nap_nas_namever = 4 => 4,
				le.address_verification.input_address_information.naprop = 0 and nap_nas_namever <= 2 => 1,
				le.address_verification.input_address_information.naprop = 1 and nap_nas_namever <= 2 => 2,
				3);
	
	aptflag := if(trim(StringLib.StringToUpperCase(le.address_validation.dwelling_type)) = 'A', 1,0);
	
	add1_source_count2 := ut.max2(
												ut.imin2(le.address_verification.input_address_information.source_count,6) - 3,0);
						/*map(le.address_verification.input_address_information.source_count <= 3 => 0,
						 le.address_verification.input_address_information.source_count <= 4 => 1,
						 le.address_verification.input_address_information.source_count <= 5 => 2,
						 3);*/
						 
	property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1,0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1,0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1,0);
	
	Prop_Owner := map(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4 => 2,
				   (property_owned_total_x + property_sold_total_x + property_ambig_total_x) > 0 => 1,
				   0);
	
	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    
	property_owned_total_med := if (le.address_verification.owned.property_total >= 2, 2, le.address_verification.owned.property_total);
	
							/*
							  map(le.address_verification.owned.property_total >= 2 => 2,
							  le.address_verification.owned.property_total >= 1 => 1,
							  0);
							*/  
	
	Prop_Owner_med := map(Prop_Owner = 0 and NaProp_Tree = 0 => 0,
					  Prop_Owner = 0 and NaProp_Tree > 0 => 1,
					  Prop_Owner = 1 => 2,
					  //Prop_Owner = 2 => 3,
					  3);	// added this myself so it syntax checks
	
	prop_med := map(Prop_Owner_med = 0 => 0,
				 Prop_Owner_med = 1 => 1,
				 Prop_Owner_med = 2 and property_owned_total_med <= 1 => 2,
				 Prop_Owner_med = 2 and property_owned_total_med = 2 => 5,
				 Prop_Owner_med = 3 and property_owned_total_med <= 0 => 3,
				 Prop_Owner_med = 3 and property_owned_total_med <= 1 => 4,
				 //Prop_Owner_med = 3 and property_owned_total_med <= 2 => 5,
				 5);	// added this myself so it syntax checks
				 
	add1_year_first_seen1 := le.address_verification.input_address_information.date_first_seen;
	add1_year_first_seen := (integer)(add1_year_first_seen1[1..4]);
	
	lres2 := map(add1_year_first_seen = 0 => 0,
			   (sysyear - add1_year_first_seen) >= 16 => 3,
			   (sysyear - add1_year_first_seen) >= 11 => 2,
			   (sysyear - add1_year_first_seen) >= 6  => 1,
			   0);
			   
	lien_unrel_count := map(le.bjl.liens_historical_unreleased_count = 0 => 0,
					    le.bjl.liens_historical_unreleased_count = 1 => 1,
					    2);
	criminal_flag := if(le.bjl.criminal_count > 0, 1,0);
	crimlien := if(criminal_flag = 1 or lien_unrel_count = 2, 2,lien_unrel_count);
				
	
	
	/* Relatives */
	
	rel_prop_owned_count2 := map(le.relatives.owned.relatives_property_count <= 0 => 0,
						    le.relatives.owned.relatives_property_count <= 1 => 1,
						    le.relatives.owned.relatives_property_count <= 2 => 2,
						    3);
						    
	rel_income := map(le.relatives.relative_incomeover100_count > 0 => 101,
				   le.relatives.relative_incomeunder100_count > 0 => 100,
				   le.relatives.relative_incomeunder75_count > 0 => 75,
				   le.relatives.relative_incomeunder50_count > 0 => 50,
				   le.relatives.relative_incomeunder25_count > 0 => 25,
				   0);
				   
	rel_home_val := map(le.relatives.relative_homeover500_count > 0 => 501,
					le.relatives.relative_homeunder500_count > 0 => 500,
					le.relatives.relative_homeunder300_count > 0 => 300,
					le.relatives.relative_homeunder200_count > 0 => 200,
					le.relatives.relative_homeunder150_count > 0 => 150,
					le.relatives.relative_homeunder100_count > 0 => 100,
					le.relatives.relative_homeunder50_count > 0 => 50,
					0);			   
	
	rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);
	rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);
	
	rel_prop_owned_count_med_m := map(rel_prop_owned_count2 = 0 => 0.0929209103,
							    rel_prop_owned_count2 = 1 => 0.1531404375,
							    rel_prop_owned_count2 = 2 => 0.1656441718,
							    //rel_prop_owned_count2 = 3 => 0.1960569551,
							    0.1960569551);	// set as default
							    
	rel_home_val_med := map(le.relatives.relative_homeover500_count > 0 => 501,
					    le.relatives.relative_homeunder500_count > 0 => 500,
					    le.relatives.relative_homeunder300_count > 0 => 300,
					    le.relatives.relative_homeunder200_count > 0 => 200,
					    le.relatives.relative_homeunder150_count > 0 => 200,  
					    le.relatives.relative_homeunder100_count > 0 => 100,
					    le.relatives.relative_homeunder50_count  > 0 => 50,
					    0);
					   
	rel_home_val_med_med_m := map(rel_home_val_med = 0 => 0.0445945946,
							rel_home_val_med = 50 => 0.0956210903,
							rel_home_val_med = 100 => 0.1209863403,
							rel_home_val_med = 200 => 0.1289147851,
							rel_home_val_med = 300 => 0.1441578149,
							rel_home_val_med = 500 => 0.1549586777,
							//rel_home_val_med = 501 => 0.2168674699,
							0.2168674699);	// set as default
	
	
	rel_criminal_flag_med_m := if(rel_criminal_flag = 0, 0.1288260364, 0.0838299563);
	
	
	
	/* Census    */
	
	add1_census_income_code2 := map(le.address_verification.input_address_information.census_income = '' => 3.000000001,
							  (integer)le.address_verification.input_address_information.census_income <= 30000 => 0,
							  (integer)le.address_verification.input_address_information.census_income <= 40000 => 1,
							  (integer)le.address_verification.input_address_information.census_income <= 50000 and 
										(integer)le.address_verification.input_address_information.census_home_value <= 78000 => 1,
							  (integer)le.address_verification.input_address_information.census_income <= 50000 and 
										(integer)le.address_verification.input_address_information.census_home_value <= 96000 => 2,
							  (integer)le.address_verification.input_address_information.census_income <= 50000 => 3,
							  (integer)le.address_verification.input_address_information.census_income <= 70000 => 3,
							  4);	
		
	
	/* Sources    */
	
	eda_counter := map(((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + (integer)le.address_verification.input_address_information.eda_sourced) = 3 => 2,
				    ((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + (integer)le.address_verification.input_address_information.eda_sourced) = 2 => 1,
				    0);
	
	
	voter_counter_med := if(le.available_sources.voter and ((integer)le.address_verification.input_address_information.voter_sourced + (integer)le.name_verification.fname_voter_sourced + 
												   (integer)le.name_verification.lname_voter_sourced) = 0, 0, 1);
	
	eda_counter2_med := map(EDA_Match_Level = 0 and eda_counter = 0 => 0,
					    EDA_Match_Level = 0 => 1,
					    EDA_Match_Level = 1 and eda_counter = 0 => 1,
					    EDA_Match_Level = 1 and eda_counter = 1 => 2,
					    EDA_Match_Level = 1 and eda_counter = 2 => 3,
					    EDA_Match_Level = 2 and eda_counter = 0 => 2,
					    EDA_Match_Level = 2 and eda_counter = 1 => 3,
					    //EDA_Match_Level = 2 and eda_counter = 2 => 4,
					    4);	// set as default
					    
	distflag := map(le.input_validation.homephone and le.phone_verification.distance <= 1 => 0,
				 le.input_validation.homephone => 1,
				 2);
				 
	voter_counter_med_med_m := if(voter_counter_med = 0, 0.0704837833, 0.1573340617) ;
	
	address_ver_sc_med_m := map(address_ver_sc = 0 => 0.0551181102,
						   address_ver_sc = 1 => 0.0820423304,
						   address_ver_sc = 2 => 0.1237477902,
						   address_ver_sc = 3 => 0.1712385702,
						   //address_ver_sc = 4 => 0.1945672773,
						   0.1945672773);	// set as default
						   
	eda_counter2_med_med_m := map(eda_counter2_med = 0 => 0.0781277494,
							eda_counter2_med = 1 => 0.0824902724,
							eda_counter2_med = 2 => 0.1123152709,
							eda_counter2_med = 3 => 0.1568862275,
							//eda_counter2_med = 4 => 0.2056948576,
							0.2056948576);	// set as default
							
	chargeoff_amount_code := map((integer)chargeoff_amount <= 300 => 0,
						    (integer)chargeoff_amount <= 1000 => 1,
						    (integer)chargeoff_amount <= 2000 => 2,
						    3);			
						    
	chargeoff_amount_code_med_m := map(chargeoff_amount_code = 0 => 0.1321225071,
								chargeoff_amount_code = 1 => 0.1057162534,
								chargeoff_amount_code = 2 => 0.0893118594,
								//chargeoff_amount_code = 3 => 0.0722891566,
								0.0722891566);	// set as default
								
	crimlien_med_m := map(crimlien = 0 => 0.1268323773,
					  crimlien = 1 => 0.0975954738,
					  //crimlien = 2 => 0.0686359687,
					  0.0686359687);	// set as default
	
	
	prop_med_med_m := map(prop_med = 0 => 0.0732223903,
					  prop_med = 1 => 0.1332445037,
					  prop_med = 2 => 0.1461538462,
					  prop_med = 3 => 0.1752688172,
					  prop_med = 4 => 0.1910039113,
					  //prop_med = 5 => 0.2230215827,
					  0.2230215827);	// set as default
	
	
	medmod2 := -9.1189092
				   + rel_prop_owned_count_med_m  * 2.3309596278
				   + rel_home_val_med_med_m  * 6.6641964807
				   + rel_criminal_flag_med_m  * 11.777861609
				   + add1_census_income_code2  * 0.077803504
				   + voter_counter_med_med_m  * 6.9544172174
				   + eda_counter2_med_med_m  * 4.1337471482
				   + address_ver_sc_med_m  * 3.2506693268
				   + aptflag  * -0.43582723
				   + lres2  * 0.0793089497
				   + crimlien_med_m  * 9.7533965479
				   + prop_med_med_m  * 3.7793100333
				   + chargeoff_amount_code_med_m  * 7.8821591982;
		
	medmod22 := (exp(medmod2)) / (1+exp(medmod2));
	phat := medmod22;
	
	base := 700;
	odds := 0.12 / 0.88;
	point := 50;
	
	
	Recover := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	Recover_Med := map(Recover < 250 => 250, 
				    Recover > 999 => 999,	// added this check
				    Recover);	
	
	
	
	/*******************************
	* Collections Indices          *
	********************************/
	
	lres_year := sysyear - add1_year_first_seen;
	lres_years := if(lres_year > 100, 0, lres_year);
	
	hr_address_n := (integer)le.address_validation.hr_address;
				
				
	/*   address confidence   */
	
	add_index_m := -2.723092932
				   + address_ver_sc  * 0.2720249163
				   + add1_source_count2  * 0.1261334602
				   + lres_years  * 0.0175460381
				   + aptflag  * -0.636294027
				   + hr_address_n  * -0.779330101;
		
	add_index_mod := (exp(add_index_m)) / (1+exp(add_index_m));
	phat2 := add_index_mod;
	
	base2 := 55;
	odds2 := 0.12 / 0.88;
	point2 := 30;
	
	
	Add_Ind := (integer)(point2*(log(phat2/(1-phat2)) - log(odds2))/log(2) + base2);
	
	Add_Index := map(Add_Ind > 100 => 100,
				  Add_Ind < 0 => 0,
				  Add_Ind);
				  
				  
	/*   phone confidence     */
	
	pnotpots := if(trim(le.phone_verification.telcordia_type) in ['00','50','51','52','54'], 0, 1);
	
	phnprob := map(pnotpots = 1 => 3,
				le.input_validation.homephone and distflag > 0 => 2,
				le.input_validation.homephone and (le.phone_verification.disconnected or le.phone_verification.hr_phone or le.phone_verification.phone_zip_mismatch) => 1,
				le.input_validation.homephone => 0,
				-1);
	
	
	eda_ver_level := map(verfst_p = 1 and verlst_p = 1 and veradd_p = 1 and verphn_p = 1 => 3,
					 verlst_p = 1 and veradd_p = 1 and verphn_p = 1 => 2,
					 verfst_p = 0 and verlst_p = 0 and veradd_p = 0 and verphn_p = 0 => 0,
					 verfst_p = 0 and verlst_p = 0 and veradd_p = 1 and verphn_p = 1 => -1,
					 1);
					 
	phn_index_mod := if(le.input_validation.homephone,
												-2.515818559
												+ EDA_Match_Level  * 0.3268017039
												+ eda_ver_level  * 0.1281022154
												+ phnprob  * -0.044874343, 
					0);
		   
	phn_index_mod4 := if(le.input_validation.homephone, (exp(phn_index_mod)) / (1+exp(phn_index_mod)), 0);
	phat3 := if(le.input_validation.homephone, phn_index_mod4, 0);
	
	base3 := if(le.input_validation.homephone, 60, 0);
	odds3 := if(le.input_validation.homephone, 0.12 / 0.88, 0);
	point3 := if(le.input_validation.homephone, 55, 0);
	
	Phn_Index1 := IF(le.input_validation.homephone, (integer)(point3*(log(phat3/(1-phat3)) - log(odds3))/log(2) + base3), 0);
	
	
	Phn_Index2 := map(~le.input_validation.homephone and EDA_match_Level = 0 and eda_ver_level = 0 => 7,
				   ~le.input_validation.homephone and EDA_match_Level = 0 and eda_ver_level = 1 => 42,
				   ~le.input_validation.homephone => 93,
				   0);	// set as default
		
	Phn_Index3 := if(le.input_validation.homephone, Phn_Index1, Phn_Index2);
	
	Phn_Index := map(Phn_Index3 > 100 => 100,
				  Phn_Index3 < 0 => 0,
				  Phn_Index3);				 
	
							
	
	/*   contactibility = Add + Phone    */
	
	// homephone pop
	contactibility_index_m := if(le.input_validation.homephone,
														-2.810862645
														 + EDA_Match_Level  * 0.2998325857
														 + eda_ver_level  * 0.0426818858
														 + phnprob  * -0.060120809
														 + address_ver_sc  * 0.1380910821
														 + add1_source_count2  * 0.0907197533
														 + lres_years  * 0.0175303489
														 + aptflag  * -0.497701656
														 + hr_address_n  * -0.637506454, 
							0);
		   
	contactibility_index_mod := if(le.input_validation.homephone, (exp(contactibility_index_m)) / (1+exp(contactibility_index_m)), 0);
	phat4 := if(le.input_validation.homephone, contactibility_index_mod, 0);
	
	// no homephone pop     
	contactibility_index_m2 := if(~le.input_validation.homephone, 
														-2.868859016
														   + EDA_Match_Level  * 0.7960984847
														   + eda_ver_level  * 0.0925500643
														   + address_ver_sc  * 0.2295037659
														   + add1_source_count2  * 0.1840787287
														   + lres_years  * 0.0138710928
														   + aptflag  * -0.988828046
														   + hr_address_n  * -11.57156326, 
							0);
												
	contactibility_index_mod2 := if(~le.input_validation.homephone, (exp(contactibility_index_m2 )) / (1+exp(contactibility_index_m2 )), 0);
	phat5 := if(~le.input_validation.homephone, contactibility_index_mod2, 0);
	
	
	base4 := 58;
	odds4 := 0.12 / 0.88;
	point4 := 28;
	
	
	Contactibility_Ind := if(le.input_validation.homephone, (integer)(point4*(log(phat4/(1-phat4)) - log(odds4))/log(2) + base4), (integer)(point4*(log(phat5/(1-phat5)) - log(odds4))/log(2) + base4));
	
	Contactibility_Index := map(Contactibility_Ind > 100 => 100,
						   Contactibility_Ind < 0 => 0,
						   Contactibility_Ind);			
						   
						   
	
	/*   asset              */
	
	car_owner := if(le.vehicles.current_count > 0, 1,0);
	add1_census_income2 := (integer)le.address_verification.input_address_information.census_income;
	add1_census_home_value2 := (integer)le.address_verification.input_address_information.census_home_value;
	
	
	asset_index_m := -5.990519659
					   + rel_prop_owned_count_med_m  * 3.1133624227
					   + rel_home_val_med_med_m  * 7.8544113258
					   + rel_criminal_flag_med_m  * 12.895943441
					   + add1_census_income2  * 2.5937701E-6
					   + add1_census_home_value2  * 1.7999838E-6
					   + prop_med_med_m  * 7.247877396
					   + aptflag  * -0.599609623
					   + car_owner  * -0.305779172;
					   		   
					   
	asset_index_mod := (exp(asset_index_m)) / (1+exp(asset_index_m));
	phat6 := asset_index_mod;
	
	base5 := 55.0;
	odds5 := 0.12 / 0.88;
	point5 := 28.0;
	
	Asset_Ind := (integer)(point5*(log(phat6/(1-phat6)) - log(odds5))/log(2) + base5);
	
	Asset_Index := map(Asset_Ind > 100 => 100,
				    Asset_Ind < 0 => 0,
				    Asset_Ind);	
				    
				    
				    
	//   lifestress           
	
	lname_change_year1 := le.name_verification.lname_change_date;
	lname_change_year := (integer)(lname_change_year1[1..4]);
	
	recent_name_change := if(sysyear - lname_change_year < 3, 1,0);
	
	bk_stress_level := map(bk_disp_code_1 = '' => 0,
					   bk_disp_code_1 = '02' => 2,
					   bk_disp_code_1 = '99' => 2,
					   bk_disp_code_1 = '20' => 1,
					   //bk_disp_code_1 = '15' => 3,
					   3);	// set as default
	
	recent_mover := if(lres_years <= 1, 1,0);
	
	LifeStress_Index1 := 0;
	LifeStress_Index2 := map(bk_stress_level = 1 => LifeStress_Index1 + 11,
						bk_stress_level = 2 => LifeStress_Index1 + 19,
						bk_stress_level = 3 => LifeStress_Index1 + 28,
						LifeStress_Index1);	// set as default
	
	LifeStress_Index3 := if(criminal_flag = 1, LifeStress_Index2 + 37, LifeStress_Index2);
	
	LifeStress_Index4 := map(lien_unrel_count >= 2 => LifeStress_Index3 + 24,
						lien_unrel_count >= 1 => LifeStress_Index3 + 17,
						LifeStress_Index3);	// set as default
	
	LifeStress_Index5 := if(deceased_sc = 1, LifeStress_Index4 + 37, LifeStress_Index4);
	LifeStress_Index6 := if(rel_criminal_flag = 1, LifeStress_Index5 + 19, LifeStress_Index5);
	LifeStress_Index7 := if(rel_bk_flag = 1, LifeStress_Index6 + 5, LifeStress_Index6);
	LifeStress_Index8 := if(recent_name_change = 1, LifeStress_Index7 + 8, LifeStress_Index7);
	LifeStress_Index9 := if(recent_mover = 1, LifeStress_Index8 + 12, LifeStress_Index8);
	
	LifeStress_Index := if(LifeStress_Index9 > 100, 100, LifeStress_Index9);
	
	
	//   liquidity  = Asset + Life Stress  
	
	liquidity_index_m := -7.254871747
					   + rel_prop_owned_count_med_m  * 3.0950633013
					   + rel_home_val_med_med_m  * 7.725769324
					   + rel_criminal_flag_med_m  * 11.558818552
					   + add1_census_income2  * 2.4641628E-6
					   + add1_census_home_value2  * 1.8999305E-6
					   + prop_med_med_m  * 7.1755553114
					   + aptflag  * -0.596677734
					   + car_owner  * -0.274387849
					   + crimlien_med_m  * 10.134642324
					   + bk_level  * 0.1941694112
					   + deceased_sc  * -0.421385712
					   + recent_name_change  * -0.010031783;
					   
	liquidity_index_mod := (exp(liquidity_index_m)) / (1+exp(liquidity_index_m));
	phat7 := liquidity_index_mod;
	
	base6 := 57;
	odds6 := 0.12 / 0.88;
	point6 := 25;
	
	Liquidity_Ind := (integer)(point6*(log(phat7/(1-phat7)) - log(odds6))/log(2) + base6);
	
	Liquidity_Index := map(Liquidity_Ind > 100 => 100,
					   Liquidity_Ind < 0 => 0,
					   Liquidity_Ind);
					   
	

					   
	// Telco Portion 
	
	chargeoff_amount_tel_code := map((integer)chargeoff_amount <= 100 => 0,
							   (integer)chargeoff_amount <= 300 => 1,
							   (integer)chargeoff_amount <= 600 => 2,
							   3);
	
	address_ver_sc_tel := map(address_confirmed and address_verified => 3,
						 address_updated and address_verified => 3,
						 address_confirmed => 2,
						 address_updated => 1,
						 0);
	
	dl_counter_tel := map(le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											   (integer)le.address_verification.input_address_information.dl_sourced) = 3 => 3,
					  le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											   (integer)le.address_verification.input_address_information.dl_sourced) = 0 => 1,
					  le.available_sources.dl => 2,
					  ~le.available_sources.dl and ((integer)le.name_verification.fname_dl_sourced + (integer)le.name_verification.lname_dl_sourced + 
											    (integer)le.address_verification.input_address_information.dl_sourced) > 0 => 2,
					  0);
	
	 eda_counter2_tel := map(EDA_Match_Level = 0 and eda_counter = 0 => 0,
						EDA_Match_Level = 0 => 0,
						EDA_Match_Level = 1 and eda_counter = 0 => 0,
						EDA_Match_Level = 1 and eda_counter = 1 => 1,
						EDA_Match_Level = 1 and eda_counter = 2 => 1,
						EDA_Match_Level = 2 and eda_counter = 0 => 1,
						EDA_Match_Level = 2 and eda_counter = 1 => 2,
						//EDA_Match_Level = 2 and eda_counter = 2 => 3,
						3);	// set as default
	
	agecode_tel := map(le.name_verification.age <= 24 => 0,
				    le.name_verification.age <= 38 => 1,
				    le.name_verification.age <= 48 => 2,
				    le.name_verification.age <= 56 => 3,
				    4);
	
	add1_census_income_tel_code := map(le.address_verification.input_address_information.census_income = '' => 0.75,
								(integer)le.address_verification.input_address_information.census_income <= 30000 => 0,
								(integer)le.address_verification.input_address_information.census_income <= 40000 => 1,
								(integer)le.address_verification.input_address_information.census_income <= 50000 and 
											(integer)le.address_verification.input_address_information.census_home_value <= 96000 => 1,
								(integer)le.address_verification.input_address_information.census_income <= 50000 => 2,
								(integer)le.address_verification.input_address_information.census_income <= 70000 => 2,
								3);
								
								
	// Telco Means 
	
	dl_counter_tel_tel_m := map(dl_counter_tel = 0 => 0.1997377622,
						   dl_counter_tel = 1 => 0.2302325581,
						   dl_counter_tel = 2 => 0.27,
						   //dl_counter_tel = 3 => 0.2873443983,
						   0.2873443983);	// set as default
	
	voter_counter_med_tel_m := if(voter_counter_med = 0, 0.2487100103, 0.2228773585);
	
	eda_counter2_tel_tel_m := map(eda_counter2_tel = 0 => 0.1654914973,
							eda_counter2_tel = 1 => 0.210619469,
							eda_counter2_tel = 2 => 0.303070761,
							//eda_counter2_tel = 3 => 0.4015852048,
							0.4015852048);	// set as default
	
	address_ver_sc_tel_tel_m := map(address_ver_sc_tel = 0 => 0.1578947368,
							  address_ver_sc_tel = 1 => 0.1649428416,
							  address_ver_sc_tel = 2 => 0.2522123894,
							  //address_ver_sc_tel = 3 => 0.3545554336,
							  0.3545554336);	// set as default
	
	crimlien_tel_m := map(crimlien = 0 => 0.2445853143,
					  crimlien = 1 => 0.1642335766,
					  //crimlien = 2 => 0.1848341232,
					  0.1848341232);	// set as default
	
	chargeoff_amount_tel_code_tel_m := map(chargeoff_amount_tel_code = 0 => 0.344873502,
								    chargeoff_amount_tel_code = 1 => 0.2470254958,
								    chargeoff_amount_tel_code = 2 => 0.2050040355,
								    //chargeoff_amount_tel_code = 3 => 0.1375515818,
								    0.1375515818);	// set as default
	
	Prop_med_tel_m := map(Prop_med = 0 => 0.1870064609,
					  Prop_med = 1 => 0.2440273038,
					  Prop_med = 2 => 0.310880829,
					  Prop_med = 3 => 0.3469785575,
					  Prop_med = 4 => 0.3536977492,
					  //Prop_med = 5 => 0.3978494624,
					  0.3978494624);	// set as default
	
	agecode_tel_tel_m := map(agecode_tel = 0 => 0.1744097487,
						agecode_tel = 1 => 0.2120765832,
						agecode_tel = 2 => 0.2446448703,
						agecode_tel = 3 => 0.311546841,
						//agecode_tel = 4 => 0.3698924731,
						0.3698924731);	// set as default
	
	add1_census_inc_tel_code_tel_m := map(add1_census_income_tel_code = 0 => 0.1799256506,
								   add1_census_income_tel_code = 0.75 => 0.2173913043,
								   add1_census_income_tel_code = 1 => 0.2348525469,
								   add1_census_income_tel_code = 2 => 0.2877906977,
								   //add1_census_income_tel_code = 3 => 0.3333333333,
								   0.3333333333);	// set as default
								   
								   
	// Telco Score 
	
	lres2_tel_m := map(lres2 = 0 => 0.2109553309,
				    lres2 = 1 => 0.2223756906,
				    lres2 = 2 => 0.3137254902,
				    //lres2 = 3 => 0.3992932862,
				    0.3992932862);	// set as default
	
	rel_income_tel_m := map(rel_income = 0 => 0.1558185404,
					    rel_income = 25 => 0.1921921922,
					    rel_income = 50 => 0.2124616956,
					    rel_income = 75 => 0.283476899,
					    rel_income = 100 => 0.3016949153,
					    //rel_income = 101 => 0.3482142857,
					    0.3482142857);	// set as default
	
	telmod4 := -13.48696212
			   + rel_criminal_flag_med_m  * 4.7297319811
			   + rel_bk_flag  * -0.217022123
			   + deceased_sc  * -1.305167815
			   + dl_counter_tel_tel_m  * 4.8260666658
			   + voter_counter_med_tel_m  * 13.51812306
			   + eda_counter2_tel_tel_m  * 2.8791217856
			   + address_ver_sc_tel_tel_m  * 2.4625866919
			   + crimlien_tel_m  * 7.1664196279
			   + chargeoff_amount_tel_code_tel_m  * 5.9341393033
			   + Prop_med_tel_m  * 1.7755860963
			   + agecode_tel_tel_m  * 3.4181124089
			   + add1_census_inc_tel_code_tel_m  * 3.280056821
			   + lres2_tel_m  * 2.0080092154
			   + rel_income_tel_m  * 2.654692642;
		
	telmod42 := (exp(telmod4)) / (1+exp(telmod4));
	phat8 := telmod42;
	
	base7 := 700;
	odds7 := 0.23 / 0.77;
	point7 := 50;
	
	Recover_T := (integer)(point7*(log(phat8/(1-phat8)) - log(odds7))/log(2) + base7);
	
	Recover_Tel := map(Recover_T < 250 => 250,
				    Recover_T > 999 => 999,
				    Recover_T);							   
	
	
	// Credit Model 
	
	add1_source_count2_cred_m := map(add1_source_count2 = 0 => 0.1053864169,
							   add1_source_count2 = 1 => 0.1179039301,
							   add1_source_count2 = 2 => 0.1518151815,
							   //add1_source_count2 = 3 => 0.19375,
							   0.19375);	// set as default
	
	rel_home_val_cred := map(rel_home_val <= 50 => 0,
						rel_home_val <= 300 => 1,
						2);
	
	rel_home_val_cred_cred_m := map(rel_home_val_cred = 0 => 0.0778032037,
							  rel_home_val_cred = 1 => 0.1326973114,
							  //rel_home_val_cred = 2 => 0.1601941748,
							  0.1601941748);	// set as default
	
	source_count_cred1 := if(le.name_verification.source_count < 8, le.name_verification.source_count, 8);
	source_count_cred := map(source_count_cred1 >= 6 => source_count_cred1 - 2,
						source_count_cred1 >= 3 => source_count_cred1 - 1,
						source_count_cred1);
						
	source_count_cred_cred_m := map(source_count_cred = 0 => 0.0791366906,
							  source_count_cred = 1 => 0.0931899642,
							  source_count_cred = 2 => 0.1017770598,
							  source_count_cred = 3 => 0.1173814898,
							  source_count_cred = 4 => 0.1314837153,
							  source_count_cred = 5 => 0.1616766467,
							  //source_count_cred = 6 => 0.1895424837,
							  0.1895424837);	// set as default
	
	cen_income_cred := map(le.address_verification.input_address_information.census_income = '' => 0,
					   (integer)le.address_verification.input_address_information.census_income <= 30000 => 0,
					   (integer)le.address_verification.input_address_information.census_income <= 40000 => 1,
					   (integer)le.address_verification.input_address_information.census_income <= 50000 => 2,
					   4);
	
	cen_income_cred_cred_m := map(cen_income_cred = 0 => 0.108,
							cen_income_cred = 1 => 0.123853211,
							cen_income_cred = 2 => 0.1303656598,
							//cen_income_cred = 4 => 0.1461318052,
							0.1461318052);	// set as default
	
	eda_match_level_cred_m := map(eda_match_level = 0 => 0.0935297886,
							eda_match_level = 1 => 0.1564792176,
							//eda_match_level = 2 => 0.1664964249,
							0.1664964249);	// set as default
	
	chargeoff_amount_cred := map((integer)chargeoff_amount <= 1200 => 0,
						    (integer)chargeoff_amount <= 2300 => 1,
						    (integer)chargeoff_amount <= 5000 => 2,
						    3);
	
	chargeoff_amount_cred_cred_m := map(chargeoff_amount_cred = 0 => 0.1703971119,
								 chargeoff_amount_cred = 1 => 0.1138613861,
								 chargeoff_amount_cred = 2 => 0.0833333333,
								 //chargeoff_amount_cred = 3 => 0.0622775801,
								 0.0622775801);	// set as default
	
	verflag_cred_m := map(verflag = 0 => 0.0520833333,
					  verflag = 1 => 0.0876897133,
					  verflag = 2 => 0.1060869565,
					  verflag = 3 => 0.13388735,
					  verflag = 4 => 0.171990172,
					  //verflag = 5 => 0.2051282051,
					  0.2051282051);	// set as default
	
	
	credmod8_NoBK1 := -9.557781015
				   + rel_criminal_flag_med_m  * 5.4200279248
				   + aptflag  * -0.305248752
				   + add1_source_count2_cred_m  * 5.2867816378
				   + verflag_cred_m  * 2.0464758938
				   + source_count_cred_cred_m  * 5.715429003
				   + cen_income_cred_cred_m  * 8.3409441117
				   + rel_home_val_cred_cred_m  * 11.137725842
				   + eda_match_level_cred_m  * 6.9079148316
				   + chargeoff_amount_cred_cred_m  * 14.51532547;
		
	credmod8_NoBK := (exp(credmod8_NoBK1)) / (1+exp(credmod8_NoBK1));
	phat9 := credmod8_NoBk;
	
	base8 := 700;
	odds8 := 0.126 / 0.874;
	point8 := 50;
	
	Recover_Cred1 := (integer)(point8*(log(phat9/(1-phat9)) - log(odds8))/log(2) + base8);
	
	Recover_Cred := map(Recover_Cred1 < 250 => 250,
					Recover_Cred1 > 999 => 999,
					Recover_Cred1);
					
					
	SELF.address_index := intformat(add_index,3,1);
	SELF.telephone_index := intformat(phn_index,3,1);
	SELF.contactability_score := intformat(contactibility_index,3,1);
	SELF.asset_index := intformat(asset_index,3,1);
	SELF.lifecycle_stress_index := intformat(lifestress_index,3,1);
	SELF.liquidity_score := intformat(liquidity_index,3,1);
	SELF.recover_score := MAP(debt_type = '2' => intformat(recover_med,3,1),
						 debt_type = '3' => intformat(recover_tel,3,1),
						 intformat(recover_cred,3,1));
END;
scores := PROJECT(clam, doModel(LEFT));

RETURN (scores);

END;