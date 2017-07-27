import ut, risk_indicators, address, RiskWise;

export AWN510_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) := 

FUNCTION

   
Models.Layout_ModelOut doModel(clam le) := transform

	sysyear := IF(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	
	
	neither_best_match := if(~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch, 1,0);
	
	best_match_level := MAP(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);
	
	
	verfst_p := if(le.iid.nap_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	verssn_s := if(le.iid.nas_summary in [4,6,7,9,10,11,12], 1,0);
	
	
	
	
	tu_source_flag := if((le.name_verification.fname_tu_sourced or le.name_verification.lname_tu_sourced) and le.ssn_verification.tu_sourced, 1,0);
     utility_sourced_flag := if(((integer)le.name_verification.fname_utility_sourced + (integer)le.name_verification.lname_utility_sourced + (integer)le.ssn_verification.utility_sourced) > 0, 1,0);



     nas_ver := if(le.iid.nas_summary >= 10, 1,0);



     v_level1 := map(best_match_level = 2 and nas_ver = 1 and verlst_p = 1 and verphn_p = 1 => 6,
				best_match_level = 2 and nas_ver = 0 and (verlst_p + verphn_p) <= 1 => 2,
				best_match_level = 2 => 4,
				best_match_level in [0,1] and nas_ver = 1 and verlst_p = 1 and verphn_p = 1 => 5,
				best_match_level in [0,1] and nas_ver = 0 and (verlst_p + verphn_p) <= 1 and neither_best_match = 1 => 0,
				best_match_level in [0,1] and nas_ver = 0 and (verlst_p + verphn_p) <= 1 => 1,
				//best_match_level in [0,1] => 3,
				3);


     v_level5 := if(v_level1 >= 5 and verfst_p = 1, v_level1 + 1,v_level1);
     v_level3 := v_level5 + verssn_s;
     v_level4 := if(v_level3 >= 5 and utility_sourced_flag = 0, v_level3 + 2,v_level3);
     v_level := v_level4 + 2 * tu_source_flag;

     v_level2 := map(v_level <= 1  => 0,
				 v_level <= 2  => 1,
				 v_level <= 5  => 2,
				 v_level <= 8  => 3,
				 v_level <= 9  => 4,
				 v_level <= 11 => 5,
				 6);


     property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1,0);
     property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1,0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1,0);

     property_total_x := property_owned_total_x = 1 or property_sold_total_x = 1 or property_ambig_total_x = 1;
	
	
	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or 
				   le.address_verification.address_history_2.naprop = 4, 1,0);

     NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or 
				   le.address_verification.address_history_2.naprop = 3, 1,0);

     NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);



     prop_tree_cred2 := map(NaProp_Tree = 2 and property_total_x => 3,
					   NaProp_Tree = 2                      => 2,
					   NaProp_Tree = 1 and property_total_x => 2,
					   NaProp_Tree = 1                      => 1,
					   NaProp_Tree = 0 and property_total_x => 2,
					   //NaProp_Tree = 0                      => 0,
					   0);


	add1_year_first_seen := (integer)(le.address_verification.input_address_information.date_first_seen[1..4]);
	
     lres_years := IF((sysyear - add1_year_first_seen) > 100, 0,sysyear - add1_year_first_seen);


     lres_code := map(lres_years <= 0 => 0,
				  lres_years <= 5 => 1,
				  lres_years <= 8 => 2,
				  3);



     aptflag := if(trim(le.address_validation.dwelling_type) = 'A', 1,0);


     ssninval := if(~le.ssn_verification.validation.valid, 1,0);

     ssndead := (integer)le.ssn_verification.validation.deceased;


     high_issue_dateyr := (integer)(le.ssn_verification.validation.high_issue_date[1..4]);

     ssnage := sysyear - high_issue_dateyr;


     hr_address_n := (integer)le.address_validation.hr_address;

     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0,1);

     phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;


     not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0,1);

     disconnect_level := map(le.input_validation.homephone and disconnected_n = 1 => 2,
					    le.input_validation.homephone and not_connected = 1 => 1,
					    ~le.input_validation.homephone => 1,
					    0);



     not_deliverable := if(~le.address_validation.usps_deliverable, 1,0);



     addprob_aw := map(aptflag = 1 => 2,
				   not_deliverable = 1 or hr_address_n = 1 => 1,
				   0);

	
	ssnprior_fa := if(ssnage <= 16, 1,0);

     ssnprob_fa := map(ssninval = 1 or ssndead = 1 => 2,
				   ssnprior_fa = 1 => 1,
				   0);




     phnprob_aw := map(disconnect_level > 0 and (pnotpots > 0 or phone_zip_mismatch_n > 0) => 3,
				   disconnect_level = 2 => 2,
				   disconnect_level > 0 or pnotpots > 0 or phone_zip_mismatch_n > 0 => 1,
				   0);


     fpprob_aw := map(ssnprob_fa = 2 				  => 6,
				  ssnprob_fa = 1 				  => 5,
				  addprob_aw = 0 and phnprob_aw = 0  => 0,
				  addprob_aw = 0 and phnprob_aw = 1  => 1,
				  addprob_aw = 0 and phnprob_aw = 2  => 2,
				  addprob_aw = 0 and phnprob_aw = 3  => 3,
				  addprob_aw = 1 and phnprob_aw = 0  => 1,
				  addprob_aw = 1 and phnprob_aw <= 2 => 3,
				  addprob_aw = 1 and phnprob_aw = 3  => 4,
				  addprob_aw = 2 and phnprob_aw <= 1 => 3,
				  //addprob_aw = 2                     => 4,
				  4);






     rel_home_val := map(le.relatives.relative_homeover500_count > 0 => 501,
					le.relatives.relative_homeunder500_count > 0 => 500,
					le.relatives.relative_homeunder300_count > 0 => 300,
					le.relatives.relative_homeunder200_count > 0 => 200,
					le.relatives.relative_homeunder150_count > 0 => 150,
					le.relatives.relative_homeunder100_count > 0 => 100,
					le.relatives.relative_homeunder50_count > 0 => 50,
					0);	


     rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);


     rel_prop_sum := le.relatives.owned.relatives_property_count + le.relatives.sold.relatives_property_count + le.relatives.ambiguous.relatives_property_count;

     rel_prop_code := map(rel_prop_sum <= 0 => 0,
					 rel_prop_sum <= 1 => 1,
					 rel_prop_sum <= 2 => 2,
					 3);


     rel_home_val_cred := map(rel_home_val = 0 => 0,
						rel_home_val <= 100 => 1,
						rel_home_val <= 150 => 2,
						rel_home_val <= 200 => 3,
						rel_home_val <= 500 => 4,
						5);



     lien_recent_un := if(le.bjl.liens_recent_unreleased_count <= 2, le.bjl.liens_recent_unreleased_count, 2);
     lien_hist_un := if(le.bjl.liens_historical_unreleased_count <= 2, le.bjl.liens_historical_unreleased_count, 2);
     lien_recent_rel := if(le.bjl.liens_recent_released_count <= 2, le.bjl.liens_recent_released_count, 2);


     lienflag2 := map(lien_recent_un = 2   => 4,
				  lien_recent_un = 1   => 3,
				  lien_hist_un = 2     => 2,
				  lien_hist_un = 1     => 1,
				  lien_recent_rel >= 1 => 1,
				  0);


	today := IF(le.historydate <> 999999, (string)le.historydate[1..6] + '01', ut.GetDate);
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);

     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));
     age_years := if(age_years1 <= 0, -99,age_years1);

     age_combo := if(age_years = -99, le.name_verification.age,age_years);



     car_owned := if(le.vehicles.historical_count > 0, 1,0);



     add1_census_age_aw := map(le.address_verification.input_address_information.census_age = '' => 32,
						 (integer)le.address_verification.input_address_information.census_age <= 28 => 28,
						 (integer)le.address_verification.input_address_information.census_age >= 40 => 40,
						 (integer)le.address_verification.input_address_information.census_age);

     add1_census_income_aw := map(le.address_verification.input_address_information.census_income = '' => 34500,
						    (integer)le.address_verification.input_address_information.census_income <= 21000 => 21000,
						    (integer)le.address_verification.input_address_information.census_income >= 85000 => 85000,
						    (integer)le.address_verification.input_address_information.census_income);

     add1_census_home_value_aw := map(le.address_verification.input_address_information.census_home_value = '' => 90000,
							   (integer)le.address_verification.input_address_information.census_home_value <= 40000 => 40000,
							   (integer)le.address_verification.input_address_information.census_home_value >= 235000 => 235000,
							   (integer)le.address_verification.input_address_information.census_home_value);

     add1_census_education_aw := map(le.address_verification.input_address_information.census_education  = '' => 12.5,
							  (integer)le.address_verification.input_address_information.census_education <= 11 => 11,
							  (integer)le.address_verification.input_address_information.census_education >= 15 => 15,
							  (integer)le.address_verification.input_address_information.census_education);


     i_add1_census_income_aw := if(add1_census_income_aw = 0, 0, 1 / add1_census_income_aw);



     lname_change_year := (integer)(le.name_verification.lname_change_date[1..4]);
     recent_name_change_cred := if(sysyear - lname_change_year < 10, 1,0);


     v_level2_m := map(v_level2 = 0 => 0.2970168612,
				   v_level2 = 1 => 0.2702702703,
				   v_level2 = 2 => 0.2097737943,
				   v_level2 = 3 => 0.1205189484,
				   v_level2 = 4 => 0.0838235294,
				   v_level2 = 5 => 0.061976124,
				   //v_level2 = 6 => 0.039800995,
				   0.039800995);


     prop_tree_cred2_m := map(prop_tree_cred2 = 0 => 0.176343893,
						prop_tree_cred2 = 1 => 0.1206441394,
						prop_tree_cred2 = 2 => 0.0672090555,
						//prop_tree_cred2 = 3 => 0.0509122502,
						0.0509122502);


     lres_code_m := map(lres_code = 0 => 0.2075383899,
				    lres_code = 1 => 0.1132178869,
				    lres_code = 2 => 0.0827928272,
				    //lres_code = 3 => 0.0595752678,
				    0.0595752678);

     rel_prop_code_m := map(rel_prop_code = 0 => 0.1764376922,
					   rel_prop_code = 1 => 0.0929194956,
					   rel_prop_code = 2 => 0.0746764023,
					   //rel_prop_code = 3 => 0.0667244367,
					   0.0667244367);



     add1_census_education_aw_m := map(add1_census_education_aw = 11   => 0.1899921814,
							    add1_census_education_aw = 12   => 0.157006478,
							    add1_census_education_aw = 12.5 => 0.1347305389,
							    add1_census_education_aw = 13   => 0.1065155807,
							    add1_census_education_aw = 14   => 0.0796752093,
							    //add1_census_education_aw = 15   => 0.0581818182,
							    0.0581818182);



     mod3a := -3.432086138
                  + fpprob_aw  * 0.1689948032
                  + rel_bk_flag  * 0.2989202822
                  + rel_home_val_cred  * -0.066345706
                  + lienflag2  * 0.2828283649
                  + age_combo  * -0.016156626
                  + car_owned  * -0.2488167
                  + add1_census_age_aw  * -0.011755083
                  + add1_census_home_value_aw  * -1.282131E-6
                  + i_add1_census_income_aw  * 5862.6905283
                  + recent_name_change_cred  * 0.1228882624
                  + v_level2_m  * 4.35203314
                  + prop_tree_cred2_m  * 3.328429795
                  + lres_code_m  * 1.2347455502
                  + rel_prop_code_m  * 2.4486353359
                  + add1_census_education_aw_m  * 4.7466784092;
     
     mod3b := (exp(mod3a)) / (1+exp(mod3a));
     phat := mod3b;

     mod3_score_aw := round(971.4 - ( 910 * phat ));

     airwaves_510 := (string)mod3_score_aw;
	

	SELF.score := IF(length(airwaves_510) < 3, '0'+airwaves_510, airwaves_510);
	SELF.seq := le.seq;
	SELF.ri := [];
	
END;
out := PROJECT(clam, doModel(LEFT));


// need to project boca shell results into layout.output, look at daves email on jan 27th
Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
end;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := transform
	SELF.ri := RiskWise.mmReasonCodes(ri, 4, OFAC, false, TRUE);
	SELF := le;
end;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;