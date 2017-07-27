import ut, risk_indicators;

export RecoverScore_Collection_Indices(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

	sysyear := (integer)(ut.GetDate[1..4]);

	Layout_RecoverScore doIndices( clam le, recoverscore_batchin rt ) := TRANSFORM
		// map these variables from batchin since they're not passed individually anymore
		dcd_match_code_1 := if(rt.deceased='1' or le.ssn_verification.validation.deceased, '1', '0');
		addr_type_a := rt.address_type;
		addr_confidence_a := rt.address_confidence;
		ph_phone_type_a_1 := rt.phone_type;
		bk_disp_code_1 := models.getBansDispCode(le.bjl.date_last_seen, le.bjl.disposition, rt.bankruptcy);

		/*******************************
		* Collections Indices          *
		********************************/

		add1_year_first_seen1 := le.address_verification.input_address_information.date_first_seen;
		add1_year_first_seen := (integer)(add1_year_first_seen1[1..4]);
		
		
		lres_year := sysyear - add1_year_first_seen;
		lres_years := if(lres_year > 100, 0, lres_year);
		
		hr_address_n := (integer)le.address_validation.hr_address;
					
					
		/*   address confidence   */
		address_confirmed := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'C', true,false);
		address_updated   := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'U', true,false);
		address_verified  := if(trim(StringLib.StringToUpperCase(addr_confidence_a)) = 'A', true,false);
		
		address_ver_sc := map(address_confirmed and address_verified => 4,
						  address_updated and address_verified => 3,
						  address_confirmed => 2,
						  address_updated => 1,
						  0);


		add1_source_count2 := ut.max2( ut.imin2(le.address_verification.input_address_information.source_count,6) - 3,0);
		aptflag := if(trim(StringLib.StringToUpperCase(le.address_validation.dwelling_type)) = 'A', 1,0);
		add_index_m := -2.723092932
					   + address_ver_sc  * 0.2720249163
					   + add1_source_count2  * 0.1261334602
					   + lres_years  * 0.0175460381
					   + aptflag  * -0.636294027
					   + hr_address_n  * -0.779330101;
		
		
		// self.address_ver_sc  := address_ver_sc;
		// self.add1_source_count2  := add1_source_count2 ;
		// self.lres_years  := lres_years;
		// self.aptflag  := aptflag;
		// self.hr_address_n  := hr_address_n;
		
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
		
		// pnotpots is already defined and used in the recover score credit logic, re-use that variable here
		telcotype := le.phone_verification.telcordia_type;					    
		pnotpots := if((integer)telcotype in [0,50,51,52,54] and telcotype!='', 0, 1);		

		distflag := map(le.input_validation.homephone and le.phone_verification.distance <= 1 => 0,
					 le.input_validation.homephone => 1,
					 2);

		phnprob_i := map(pnotpots = 1 => 3,
					le.input_validation.homephone and distflag > 0 => 2,
					le.input_validation.homephone and (le.phone_verification.disconnected or le.phone_verification.hr_phone or le.phone_verification.phone_zip_mismatch) => 1,
					le.input_validation.homephone => 0,
					-1);
		
		verfst_p := if(le.iid.nap_summary in [2,3,4,8,9,10,12], 1,0);
		verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
		veradd_p := if(le.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
		verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
		
		eda_ver_level := map(verfst_p = 1 and verlst_p = 1 and veradd_p = 1 and verphn_p = 1 => 3,
						 verlst_p = 1 and veradd_p = 1 and verphn_p = 1 => 2,
						 verfst_p = 0 and verlst_p = 0 and veradd_p = 0 and verphn_p = 0 => 0,
						 verfst_p = 0 and verlst_p = 0 and veradd_p = 1 and verphn_p = 1 => -1,
						 1);
			
		EDA_Match_Level := map(trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'A' => 2,
					   trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'C' => 1,
					   0);

		phn_index_mod := if(le.input_validation.homephone,
													-2.515818559
													+ EDA_Match_Level  * 0.3268017039
													+ eda_ver_level  * 0.1281022154
													+ phnprob_i  * -0.044874343, 
						0);
		
		// self.EDA_Match_Level  := EDA_Match_Level;
		// self.eda_ver_level  := eda_ver_level;
		// self.phnprob_i  :=  phnprob_i; 
		
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
															 + phnprob_i  * -0.060120809
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

		rel_prop_owned_count2 := map(le.relatives.owned.relatives_property_count <= 0 => 0,
								le.relatives.owned.relatives_property_count <= 1 => 1,
								le.relatives.owned.relatives_property_count <= 2 => 2,
								3);
		rel_prop_owned_count_med_m := map(rel_prop_owned_count2 = 0 => 0.0929209103,
									rel_prop_owned_count2 = 1 => 0.1531404375,
									rel_prop_owned_count2 = 2 => 0.1656441718,
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
								0.2168674699);	// set as default
								
		rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);
		rel_criminal_flag_med_m := if(rel_criminal_flag = 0, 0.1288260364, 0.0838299563);



		property_owned_total_med := if (le.address_verification.owned.property_total >= 2, 2, le.address_verification.owned.property_total);

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
				   

		Prop_Owner_med := map(Prop_Owner = 0 and NaProp_Tree = 0 => 0,
						  Prop_Owner = 0 and NaProp_Tree > 0 => 1,
						  Prop_Owner = 1 => 2,
						  3);	// set as default
		
		prop_med := map(Prop_Owner_med = 0 => 0,
					 Prop_Owner_med = 1 => 1,
					 Prop_Owner_med = 2 and property_owned_total_med <= 1 => 2,
					 Prop_Owner_med = 2 and property_owned_total_med = 2 => 5,
					 Prop_Owner_med = 3 and property_owned_total_med <= 0 => 3,
					 Prop_Owner_med = 3 and property_owned_total_med <= 1 => 4,
					 5);	// set as default


		prop_med_med_m := map(prop_med = 0 => 0.0732223903,
						  prop_med = 1 => 0.1332445037,
						  prop_med = 2 => 0.1461538462,
						  prop_med = 3 => 0.1752688172,
						  prop_med = 4 => 0.1910039113,
						  0.2230215827);	// set as default


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

		criminal_flag := if(le.bjl.criminal_count > 0, 1,0);
		LifeStress_Index3 := if(criminal_flag = 1, LifeStress_Index2 + 37, LifeStress_Index2);

		lien_unrel_count := map(le.bjl.liens_historical_unreleased_count = 0 => 0,
							le.bjl.liens_historical_unreleased_count = 1 => 1,
							2);
		
		LifeStress_Index4 := map(lien_unrel_count >= 2 => LifeStress_Index3 + 24,
							lien_unrel_count >= 1 => LifeStress_Index3 + 17,
							LifeStress_Index3);	// set as default
		
		deceased_sc := if(dcd_match_code_1 = '1', 1,0);
		LifeStress_Index5 := if(deceased_sc = 1, LifeStress_Index4 + 37, LifeStress_Index4);
		rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);
		LifeStress_Index6 := if(rel_criminal_flag = 1, LifeStress_Index5 + 19, LifeStress_Index5);
		LifeStress_Index7 := if(rel_bk_flag = 1, LifeStress_Index6 + 5, LifeStress_Index6);
		LifeStress_Index8 := if(recent_name_change = 1, LifeStress_Index7 + 8, LifeStress_Index7);
		LifeStress_Index9 := if(recent_mover = 1, LifeStress_Index8 + 12, LifeStress_Index8);
		
		LifeStress_Index := if(LifeStress_Index9 > 100, 100, LifeStress_Index9);
		
		
		//   liquidity  = Asset + Life Stress  
		crimlien_i := if(criminal_flag = 1 or lien_unrel_count = 2, 2,lien_unrel_count);

		crimlien_med_m := map(crimlien_i = 0 => 0.1268323773,
						  crimlien_i = 1 => 0.0975954738,
						  0.0686359687);	// set as default
		

		bk_level := map(bk_disp_code_1 = '20' => 3,
					 bk_disp_code_1 = '02' => 2,
					 bk_disp_code_1 = '99' => 2,
					 bk_disp_code_1 = ''  => 1,
					 bk_disp_code_1 = '15' => 0,
					 0);
					 
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

		
		SELF.address_index := intformat(add_index,3,1);
		SELF.telephone_index := intformat(phn_index,3,1);
		SELF.contactability_score := intformat(contactibility_index,3,1);
		SELF.asset_index := intformat(asset_index,3,1);
		SELF.lifecycle_stress_index := intformat(lifestress_index,3,1);
		SELF.liquidity_score := intformat(liquidity_index,3,1);
		self.seq := (string)le.seq;
		
		self := []; // don't populate any of the scores
	END;

	indices := join(clam, recoverscore_batchin, left.seq=right.seq, doIndices(left,right));
	return indices;
END;