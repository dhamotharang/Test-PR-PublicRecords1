import ut, Risk_Indicators;
// eltman
export RSN604_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

Layout_RecoverScore doModel(clam le, recoverscore_batchin rt) := TRANSFORM 

	SELF.seq := (string)le.seq;
	
	dcd_match_code_1 := if(rt.deceased='1' or le.ssn_verification.validation.deceased, '1', '0');
	addr_type_a := rt.address_type;
	addr_confidence_a := rt.address_confidence;
	chargeoffAmount := rt.debt_amount;
	chargeoffDate := rt.charge_off_date;
	opendate := rt.open_date;
	ph_phone_type_a_1 := rt.phone_type;
	bk_disp_code_1 := models.getBansDispCode(le.bjl.date_last_seen, le.bjl.disposition, rt.bankruptcy);
	
// recover score calcuations
  sysyear := (integer)(ut.GetDate[1..4]);
	today := ut.GetDate;
	
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);
	co_dt := if(trim(chargeoffdate)='', 0, ut.DaysSince1900(chargeoffDate[1..4], chargeoffDate[5..6], chargeoffDate[7..8]));
	op_dt := if(trim(opendate)='', 0, ut.DaysSince1900(opendate[1..4], opendate[5..6], opendate[7..8]));
	
	mos_co := if(co_dt=0, -999, (integer)((today1900 - co_dt)/30.25));
	mos_od := if(op_dt=0, -999, (integer)((today1900 - op_dt)/30.25));
	mos_op_co := if(co_dt=0 or op_dt=0, -999, (integer)((op_dt - co_dt)/30.25));
		
	CVI10 := IF(le.iid.cvi=10, 1, 0);
	
	add1_fst_seen_yr := (integer)(le.address_verification.input_address_information.date_first_seen[1..4]);
	add1_lst_seen_yr := (integer)(le.address_verification.input_address_information.date_last_seen[1..4]);
	add2_pur_yr      := (integer)(le.address_verification.address_history_1.purchase_date[1..4]);
	add3_pur_yr      := (integer)(le.address_verification.address_history_2.purchase_date[1..4]);
	add3_built_yr    := (integer)(le.address_verification.address_history_2.built_date[1..4]);

	add1_livtime_1 := if(add1_lst_seen_yr > 0, add1_lst_seen_yr - add1_fst_seen_yr, -999);
	add2_rec_buy := if(add2_pur_yr > 0, sysyear - add2_pur_yr, -999);
	add3_dif_pur_built := if(add3_built_yr > 0 and add3_pur_yr > 0, add3_pur_yr - add3_built_yr, -999);
 
	byr := le.shell_input.dob[1..4];
	bmn := le.shell_input.dob[5..6];
	bdy := le.shell_input.dob[7..8];    	    
	birthdt := if(le.shell_input.dob='', 0, ut.DaysSince1900(byr, bmn, bdy));
	in_age := if(birthdt=0, 0, (integer)((today1900 - birthdt)/365.25));
	
	agevar := ut.max2(in_age, (integer)le.name_verification.age);  /* if customer supplied dob is missing, use BocaShell age*/
	age_temp := if(in_age > 10, in_age, agevar);
	agevar2 := map( age_temp < 15 => 25,
				 age_temp > 50 => 50,
				 age_temp);
								   
	high_issue_dateyr := (integer)le.ssn_verification.validation.high_issue_date[1..4];
	ssnage := sysyear - high_issue_dateyr;
	agediff := agevar2 - ssnage;
	
	eda_sourced_count := (integer)le.name_verification.fname_eda_sourced + 
				(integer)le.name_verification.lname_eda_sourced + 
				(integer)le.address_verification.input_address_information.eda_sourced;
	eda_counter := map( eda_sourced_count = 3 => 2,
					eda_sourced_count = 2 => 1, 
					0 );
					
	EDA_Match_Level := map(trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'A' => 2,
					   trim(StringLib.StringToUpperCase(ph_phone_type_a_1)) = 'C' => 1,
					   0);
					   
	eda_counter2_med := map(EDA_Match_Level = 0 and eda_counter = 0 => 0,
					    EDA_Match_Level = 0 => 1,
					    EDA_Match_Level = 1 and eda_counter = 0 => 1,
					    EDA_Match_Level = 1 and eda_counter = 1 => 2,
					    EDA_Match_Level = 1 and eda_counter = 2 => 3,
					    EDA_Match_Level = 2 and eda_counter = 0 => 2,
					    EDA_Match_Level = 2 and eda_counter = 1 => 3,
					    EDA_Match_Level = 2 and eda_counter = 2 => 4,
					    4);

	address_confirmed := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'C', true,false);
	address_updated := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'U', true,false);
	address_verified := if(trim(StringLib.StringToUpperCase(addr_confidence_a)) = 'A', true,false);
		
	address_ver_sc := map(address_confirmed and address_verified => 4,
					  address_updated and address_verified => 3,
					  address_confirmed => 2,
					  address_updated => 1,
					  0);
					  	  
	proptree := map( le.address_verification.input_address_information.naprop = 4 and
				  le.address_verification.address_history_1.naprop = 4 and 
				  le.address_verification.owned.property_total > 2 => 5.5,
				  
				  le.address_verification.input_address_information.naprop = 4 and
				  le.address_verification.address_history_1.naprop = 4 and 
				  le.address_verification.owned.property_total <= 2 => 5,
				  
				  le.address_verification.input_address_information.naprop = 4 and
				  le.address_verification.address_history_1.naprop = 3 => 4,
				  
				  le.address_verification.input_address_information.naprop = 4 => 3,
				  
				  le.address_verification.input_address_information.naprop <= 2 and
				  le.address_verification.address_history_1.naprop <= 2 and 
				  le.address_verification.owned.property_total >= 1 => 2,
				  
				  le.address_verification.input_address_information.naprop <= 2 and
				  le.address_verification.address_history_1.naprop <= 2 and 
				  le.address_verification.owned.property_total = 0 => 0,
				  
				  le.address_verification.address_history_1.naprop = 4 => 2, 
				  
				  1 );
				 
			
	add1_year_first_seen := (integer)(le.address_verification.input_address_information.date_first_seen[1..4]);
	lres_years := if(sysyear - add1_year_first_seen > 100, 0, sysyear - add1_year_first_seen);
     recent_mover := if(sysyear - add1_year_first_seen <= 1, 1, 0);
	lname_change_year := (integer)(le.name_verification.lname_change_date[1..4]);
	recent_name_change := if(sysyear - lname_change_year < 3, 1, 0);
	
	aptflag := if(le.address_validation.dwelling_type='A', 1, 0);

	pnotpots := if(trim(le.phone_verification.telcordia_type) in ['00','50','51','52','54'], 0, 1);
	
	car_owner := if(le.vehicles.current_count > 0, 1,0);
	property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1,0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1,0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1,0);
	
	Prop_Owner := map(	le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or 
					le.address_verification.address_history_2.naprop = 4 => 2,
					(property_owned_total_x + property_sold_total_x + property_ambig_total_x) > 0 => 1,
					0);
	hphnpop := le.input_validation.homephone; 
	distflag := map(hphnpop and le.phone_verification.distance <= 1 => 0,
				 hphnpop => 1,
				 2);

	phnprob := map(pnotpots = 1 => 3,
				hphnpop and distflag > 0 => 2,
				hphnpop and (le.phone_verification.disconnected or le.phone_verification.hr_phone or le.phone_verification.phone_zip_mismatch) => 1,
				hphnpop => 0,
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
 
	bk_level := map(bk_disp_code_1 = '20' => 3,
				 bk_disp_code_1 = '02' => 2,
				 bk_disp_code_1 = '99' => 2,
				 bk_disp_code_1 = ''  => 1,
				 bk_disp_code_1 = '15' => 0,
				 0);
				 
	deceased_sc := if(dcd_match_code_1 = '1', 1,0);
	
	bk_stress_level := map(bk_disp_code_1 = '' => 0,
					   bk_disp_code_1 = '02' => 2,
					   bk_disp_code_1 = '99' => 2,
					   bk_disp_code_1 = '20' => 1,
					   bk_disp_code_1 = '15' => 3,
					   3);

	lien_unrel_count := map(le.bjl.liens_historical_unreleased_count = 0 => 0,
					    le.bjl.liens_historical_unreleased_count = 1 => 1,
					    2);

	criminal_flag := if(le.bjl.criminal_count > 0, 1,0);
	crimlien := if(criminal_flag = 1 or lien_unrel_count = 2, 2, lien_unrel_count);

	rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);
	rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);

	rel_home_val := map(le.relatives.relative_homeover500_count > 0 => 501,
					le.relatives.relative_homeunder500_count > 0 => 500,
					le.relatives.relative_homeunder300_count > 0 => 300,
					le.relatives.relative_homeunder200_count > 0 => 200,
					le.relatives.relative_homeunder150_count > 0 => 150,
					le.relatives.relative_homeunder100_count > 0 => 100,
					le.relatives.relative_homeunder50_count > 0 => 50,
					0);		
					
					
	mid_score1 := -2.124;
	mid_score2 := IF(le.iid.cvi=10, mid_score1 + -0.2982, mid_score1);
	mid_score3 := IF(trim(StringLib.StringToUpperCase(le.shell_input.in_state)) in ['NY','NJ','CT'], mid_score2 + 0.2062, mid_score2);
	mid_score4 := if(add1_livtime_1 between 4 and 5, mid_score3 + -0.1827, mid_score3);
	mid_score5 := if(add1_livtime_1 between 12 and 16, mid_score4 + 0.1096, mid_score4);
	mid_score6 := if(add1_livtime_1 > 16, mid_score5 + 0.1671, mid_score5);
	mid_score7 := if(add2_rec_buy between 0 and 3, mid_score6 + -0.2551, mid_score6);
	mid_score8 := if(add2_rec_buy > 6, mid_score7 + 0.0442, mid_score7);
	mid_score9 := if(ADD3_DIF_PUR_BUILT between 1 and 47, mid_score8 + -0.1988, mid_score8);
	mid_score10 := if(le.address_verification.address_history_2.dl_sourced, mid_score9 + -0.2609, mid_score9);
	mid_score11 := if(address_ver_sc > 3, mid_score10 + 0.3143, mid_score10);
	mid_score12 := if(agediff between 1 and 12, mid_score11 + 0.2319, mid_score11);
	mid_score13 := if(agediff between 13 and 16, mid_score12 + 0.2202, mid_score12);
	mid_score14 := if(agediff > 33, mid_score13 + -0.1973, mid_score13);
	mid_score15 := if(le.ssn_verification.bk_sourced, mid_score14 + 0.4995, mid_score14);
	mid_score16 := if((real)chargeoffAmount >= 0 and (real)chargeoffAmount <=1055, mid_score15 + -0.0921, mid_score15);
	mid_score17 := if((real)chargeoffAmount > 4779 and (real)chargeoffAmount <= 7257, mid_score16 + -0.4762, mid_score16);
	mid_score18 := if((real)chargeoffAmount > 7257, mid_score17 + -0.7461, mid_score17);
	mid_score19 := if(le.bjl.criminal_count>0, mid_score18 + -0.5838, mid_score18);
	mid_score20 := if(le.vehicles.current_count between 1 and 2, mid_score19 + 0.2875, mid_score19);
	mid_score21 := if(le.vehicles.current_count > 2, mid_score20 + 0.3749, mid_score20);
	mid_score22 := if(eda_counter2_med between 1 and 3, mid_score21 + 0.2329, mid_score21);
	mid_score23 := if(eda_counter2_med > 3, mid_score22 + 0.3161, mid_score22);
	mid_score24 := if(agevar > 87, mid_score23 + -0.4365, mid_score23);
	mid_score25 := if(mos_op_co between -36 and -20, mid_score24 + 0.0906, mid_score24);
	mid_score26 := if(mos_op_co between -12 and -9, mid_score25 + -0.4332, mid_score25);
	mid_score27 := if(mos_op_co > -9, mid_score26 + -1.1249, mid_score26);
	mid_score28 := if(mos_od between 69 and 91, mid_score27 + 0.1659, mid_score27);
	mid_score29 := if(mos_od between 92 and 126, mid_score28 + 0.2304, mid_score28);
	mid_score30 := if(mos_co between 0 and 25, mid_score29 + -0.221, mid_score29);
	mid_score31 := if(mos_co > 36, mid_score30 + -0.0978, mid_score30);
	mid_score32 := if(le.address_verification.owned.property_total > 0, mid_score31 + 0.3196, mid_score31);
	mid_score33 := if(proptree > 2, mid_score32 + 0.3466, mid_score32);
	mid_score34 := if(le.relatives.relative_count between 5 and 10, mid_score33 + 0.1548, mid_score33);
	mid_score35 := if(le.relatives.relative_criminal_total between 4 and 5, mid_score34 + -0.1055, mid_score34);
	mid_score36 := if(le.relatives.relative_criminal_total > 5, mid_score35 + -0.2275, mid_score35);
	mid_score37 := if(le.relatives.relative_homeunder200_count > 2, mid_score36 + 0.1472, mid_score36);
	mid_score38 := if(ssnage between 0 and 15, mid_score37 + -0.4078, mid_score37);
	
	MID_SCORE := (exp(MID_SCORE38)) / (1+exp(MID_SCORE38));

     phat := MID_SCORE;

     base  :=  700;
	 ODDS := .12/.88;
     point :=  50;

     RECOVER_ELTMAN_pre_cap := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		 RECOVER_ELTMAN := MAP(RECOVER_ELTMAN_pre_cap < 250 => 250,
													 RECOVER_ELTMAN_pre_cap > 999 => 999,
													 RECOVER_ELTMAN_pre_cap);
													 
	SELF.recover_score := intformat(RECOVER_ELTMAN,3,1);	
// end of recover score calculation
	
// telephone index calculations 
	phn_index_mod := -1.9305
                       +  0.1016  * EDA_Match_Level
                       +  0.1068  * eda_ver_level
                       + -0.0359 * phnprob;
	phn_phat := (exp(phn_index_mod )) / (1+exp(phn_index_mod ));
	phn_case1 := (integer)(55*(log(phn_phat/(1-phn_phat)) - log(.12 /.88))/log(2) + 60);
	phn_case2 := map(EDA_match_Level = 0 and eda_ver_level = 0 => 7,
			       EDA_match_Level = 0 and eda_ver_level = 1 => 42,
				  93);
	ELTMAN_Phn_Index := if(hphnpop, phn_case1, phn_case2);
	self.telephone_index := intformat(map(ELTMAN_Phn_Index > 100 => 100,
								   ELTMAN_Phn_Index < 0 => 0,
						             ELTMAN_Phn_Index), 3, 1);
// end of telephone index calc
						   	
// contactability index calculations
	contactibility_index_mod := -2.3977
			 +  0.1064 * EDA_Match_Level
			 +  0.0630 * eda_ver_level
			 + -0.0286 * phnprob
			 +  0.1356 * address_ver_sc
			 +  0.0576 * le.address_verification.input_address_information.source_count
			 +  0.0163 * lres_years
			 + -0.2744 * aptflag
			 + -0.5397 * (integer)le.address_verification.input_address_information.hr_address;
	
	contactibility_case1 := (exp(contactibility_index_mod )) / (1+exp(contactibility_index_mod ));
  
     contactibility_index_mod2 := -2.7843
				   + 0 * EDA_Match_Level
                       + 0.0955  * eda_ver_level
                       + 0.2203  * address_ver_sc
                       + 0.1290  * le.address_verification.input_address_information.source_count
                       + 0.0101  * lres_years
                       + -0.2502 * aptflag
                       + -0.5022 * (integer)le.address_verification.input_address_information.hr_address;
				  
	contactibility_case2 := (exp(contactibility_index_mod2 )) / (1+exp(contactibility_index_mod2 ));

	contactibility_phat := if(hphnpop, contactibility_case1, contactibility_case2);

     ELTMAN_Contactibility_Index := (integer)(28*(log(contactibility_phat/(1-contactibility_phat)) - log(.12 /.88))/log(2) + 58);    

	self.contactability_score := intformat(map(ELTMAN_Contactibility_Index > 100 => 100,
							             ELTMAN_Contactibility_Index < 0 => 0,
							             ELTMAN_Contactibility_Index), 3, 1);
// end contactability calc
	
// lifecycle stress calcs
	ELTMAN_LifeStress_Index1 := 0;
	ELTMAN_LifeStress_Index2 := if(bk_stress_level = 1, ELTMAN_LifeStress_Index1 + 11, ELTMAN_LifeStress_Index1);
	ELTMAN_LifeStress_Index3 := if(bk_stress_level = 2, ELTMAN_LifeStress_Index2 + 19, ELTMAN_LifeStress_Index2);
	ELTMAN_LifeStress_Index4 := if(bk_stress_level = 3, ELTMAN_LifeStress_Index3 + 28, ELTMAN_LifeStress_Index3);
	ELTMAN_LifeStress_Index5 := if(criminal_flag = 1, ELTMAN_LifeStress_Index4 + 37, ELTMAN_LifeStress_Index4);
	ELTMAN_LifeStress_Index6 := if(lien_unrel_count >= 2, ELTMAN_LifeStress_Index5 + 24, ELTMAN_LifeStress_Index5);
	ELTMAN_LifeStress_Index7 := if(lien_unrel_count = 1, ELTMAN_LifeStress_Index6 + 17, ELTMAN_LifeStress_Index6);
	ELTMAN_LifeStress_Index8 := if(deceased_sc = 1, ELTMAN_LifeStress_Index7 + 37, ELTMAN_LifeStress_Index7);
	ELTMAN_LifeStress_Index9 := if(rel_criminal_flag = 1, ELTMAN_LifeStress_Index8 + 19, ELTMAN_LifeStress_Index8);
	ELTMAN_LifeStress_Index10 := if(rel_bk_flag = 1, ELTMAN_LifeStress_Index9 + 5, ELTMAN_LifeStress_Index9);
	ELTMAN_LifeStress_Index11 := if(recent_name_change = 1, ELTMAN_LifeStress_Index10 + 8, ELTMAN_LifeStress_Index10);
	ELTMAN_LifeStress_Index12 := if(recent_mover = 1, ELTMAN_LifeStress_Index11 + 12, ELTMAN_LifeStress_Index11);
     self.lifecycle_stress_index := intformat(if(ELTMAN_LifeStress_Index12 > 100, 100, ELTMAN_LifeStress_Index12), 3, 1);
// end lifecylcle calc
	
// address index calculation
	add_index_mod :=  -2.4913
				  + 0.2236  * address_ver_sc 
                  + 0.0748  * le.address_verification.input_address_information.source_count 
                  + 0.0161  * lres_years 
                  + -0.2995 * aptflag
                  + -0.5694 * (integer)le.address_verification.input_address_information.hr_address;
			   
     add_phat := (exp(add_index_mod )) / (1+exp(add_index_mod ));
	
     ELTMAN_Add_Index := (integer)(30*(log(add_phat/(1-add_phat)) - log(.12 /.88))/log(2) + 55);

	self.address_index := intformat(map(ELTMAN_Add_Index > 100 => 100,
								   ELTMAN_Add_Index < 0 => 0,
						             ELTMAN_Add_Index), 3, 1);								   
// end address index calc

// asset index calculation
	 asset_index_mod :=  -2.1225
                  +  0.0235   * le.relatives.owned.relatives_property_count
                  +  0.000173 * rel_home_val
                  + -0.1042   * rel_criminal_flag
                  +  4.992E-6 * (integer)le.address_verification.input_address_information.census_income
                  +  -2.82E-7 * (integer)le.address_verification.input_address_information.census_home_value
                  +  0.2782   * Prop_Owner
                  + -0.1107   * aptflag
                  +  0.3257   * car_owner;
			   
     asset_phat := (exp(asset_index_mod )) / (1+exp(asset_index_mod ));

     ELTMAN_Asset_Index := (integer)(28*(log(asset_phat/(1-asset_phat)) - log(.12 /.88))/log(2) + 55);
	
	self.asset_index := intformat(map(ELTMAN_Asset_Index > 100 => 100,
								   ELTMAN_Asset_Index < 0 => 0,
						             ELTMAN_Asset_Index), 3, 1);	
// end asset index calc

// liquidity score calculation
	liquidity_index_mod :=   -2.0898
                  +  0.0238   * le.relatives.owned.relatives_property_count
                  +  0.000146 * rel_home_val
                  + -0.0961   * rel_criminal_flag
                  +  5.044E-6 * (integer)le.address_verification.input_address_information.census_income
                  +  -3.08E-7 * (integer)le.address_verification.input_address_information.census_home_value
                  +  0.2786   * Prop_Owner
                  + -0.1122   * aptflag  
                  +  0.3305   * car_owner
                  + -0.1209   * crimlien
                  + 0         * bk_level
                  + 0         * deceased_sc
                  + -0.0396   * recent_name_change;
			   
     liquidity_phat := (exp(liquidity_index_mod )) / (1+exp(liquidity_index_mod ));

     ELTMAN_Liquidity_Index := (integer)(25*(log(liquidity_phat/(1-liquidity_phat)) - log(.12 /.88))/log(2) + 57);
	
	self.liquidity_score := intformat(map(ELTMAN_Liquidity_Index > 100 => 100,
								   ELTMAN_Liquidity_Index < 0 => 0,
						             ELTMAN_Liquidity_Index), 3, 1);
// end liquidity score calc
	
	self.bankcard_recover_score := '';
	self.medical_recover_score := '';
	self.telco_recover_score := '';	
END;

scores := join(clam, recoverscore_batchin, left.seq=right.seq, doModel(LEFT, right));

RETURN (scores);

END;