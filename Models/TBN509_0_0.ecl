/* Modeling group is calling this model TBN509_0_1 as it is the second version with score caps added. We are keeping the 
		original name TBN509_0_0  */

import ut, risk_indicators, address, RiskWise, std;

export TBN509_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true) := 
FUNCTION


Layout_ModelOut doModel(clam le) := transform

	sysyear := IF(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
	
	contrary_phone := if(le.iid.nap_summary = 1, 1,0);
	
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	veradd_p := if(le.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	
	ssn479 := if(le.iid.nas_summary in [4,7,9], 1,0);


     tu_source_flag := if((le.name_verification.fname_tu_sourced or le.name_verification.lname_tu_sourced) and le.ssn_verification.tu_sourced, 1,0);
     utility_sourced_flag := if(((integer)le.name_verification.fname_utility_sourced + (integer)le.name_verification.lname_utility_sourced + (integer)le.ssn_verification.utility_sourced) > 0, 1,0);
	
	
	verla_p := if(verlst_p = 1 or veradd_p = 1, 1,0);

     best_match_level := map(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);


	addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,le.address_verification.address_history_1.predir,le.address_verification.address_history_1.prim_name,
								  le.address_verification.address_history_1.addr_suffix,le.address_verification.address_history_1.postdir,le.address_verification.address_history_1.unit_desig,
								  le.address_verification.address_history_1.sec_range);
     addr2pop := if(addr2 = '' and le.address_verification.address_history_1.city_name = '' and le.address_verification.address_history_1.st = '', 0,1);


     ver_level := map(best_match_level = 0 and ssn479 = 1 => 0,
				  best_match_level in [0,1] => 1,
				  ssn479 = 1 => 0,
				  addr2pop = 0 and verphn_p = 1 and verla_p = 1 => 2,
				  addr2pop = 0 => 0,
				  addr2pop = 1 and verphn_p = 1 and verla_p = 1 => 3,
				  2);


     ver_level2 := if(contrary_phone = 1, if(ver_level<=1, ver_level,1),ver_level);
     ver_level3 := ver_level2 + tu_source_flag;
	
	
	

     property_owned_total_x := if(le.address_verification.owned.property_total > 0, 1,0);
	property_sold_total_x := if(le.address_verification.sold.property_total > 0, 1,0);
	property_ambig_total_x := if(le.address_verification.ambiguous.property_total > 0, 1,0);

     property_total_x := property_owned_total_x = 1 or property_sold_total_x = 1 or property_ambig_total_x = 1;


	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    


     prop_tree_credit2 := map(NaProp_Tree = 2 and property_total_x => 3,
						NaProp_Tree = 2 => 2,
						NaProp_Tree = 1 and property_total_x => 2,
						NaProp_Tree = 1 => 1,
						NaProp_Tree = 0 and property_total_x => 2,
						NaProp_Tree = 0 => 0,
						0);

	time_on_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_first_seen)[1..4]));

     time_on_header_code := map(time_on_header_years <= 5 or time_on_header_years = sysyear => 0,
						  time_on_header_years <= 15 => 1,
						  time_on_header_years <= 20 => 2,
						  3);


     time_since_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_last_seen)[1..4]));

     time_since_header_code := map(time_since_header_years >= 4 => 2,
							time_since_header_years >= 2 => 1,
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


     rel_home_val_credit := map(rel_home_val = 0 => 0,
						  rel_home_val <= 100 => 1,
						  rel_home_val <= 150 => 2,
						  rel_home_val <= 200 => 3,
						  rel_home_val <= 500 => 4,
						  5);


	
	rel_home_val_credit_m := map(rel_home_val_credit = 0 => 0.1241050119,
						    rel_home_val_credit = 1 => 0.081570997,
						    rel_home_val_credit = 2 => 0.0618456294,
						    rel_home_val_credit = 3 => 0.0515373353,
						    rel_home_val_credit = 4 => 0.0458298231,
						    rel_home_val_credit = 5 => 0.0348258706,
						    0.0348258706);




     add1_census_age_credit := map(le.address_verification.input_address_information.census_age = '' => 35,
							(integer)le.address_verification.input_address_information.census_age <= 25 => 25,
							(integer)le.address_verification.input_address_information.census_age >= 52 => 52,
							(integer)le.address_verification.input_address_information.census_age);


     add1_census_home_value_credit := map(le.address_verification.input_address_information.census_home_value = '' => 120000,
								  (integer)le.address_verification.input_address_information.census_home_value <= 15000 => 38000,
								  (integer)le.address_verification.input_address_information.census_home_value >= 600000 => 540000,
								  (integer)le.address_verification.input_address_information.census_home_value);


     add1_census_education_credit := map(le.address_verification.input_address_information.census_education = '' => 13,
								 (integer)le.address_verification.input_address_information.census_education <= 12 => 12,
								 (integer)le.address_verification.input_address_information.census_education >= 15 => 16,
								 (integer)le.address_verification.input_address_information.census_education);


     hr_address_n := (integer)le.address_validation.hr_address;


     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0,1);


     phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;
	
	
	not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0,1);

     disconnect_level := map(le.input_validation.homephone and disconnected_n = 1 => 2,
					    le.input_validation.homephone and not_connected = 1 => 1,
					    ~(le.input_validation.homephone) => 1,
					    0);


     phnprob_credit := map(~(le.input_validation.homephone) => 1,
					  disconnect_level = 2 or pnotpots = 1 or phone_zip_mismatch_n = 1 => 2,
					  disconnect_level = 1 => 1,
					  0);


     mult_adl_credit_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
						    le.ssn_verification.adlperssn_count <= 4 => 1,
						    2);



     addprob := map(trim(le.address_validation.dwelling_type) = 'A' => 1,
				hr_address_n = 1 => 1,
				le.input_validation.address and ~le.address_validation.usps_deliverable => 1,
				0);


     fp_prob := phnprob_credit + addprob;


     fp_prob_m := map(fp_prob = 0 => 0.0343578043,
				  fp_prob = 1 => 0.058488228,
				  fp_prob = 2 => 0.081668729,
				  fp_prob = 3 => 0.0957215373,
				  0.0957215373);



     prop_tree_credit2_m := map(prop_tree_credit2 = 0 => 0.0841056129,
						  prop_tree_credit2 = 1 => 0.0652818991,
						  prop_tree_credit2 = 2 => 0.0594237695,
						  prop_tree_credit2 = 3 => 0.039094894,
						  0.039094894);



	
	ceninc := map(le.address_verification.input_address_information.census_income = '' => 70000,
			    (integer)le.address_verification.input_address_information.census_income <= 19999 => 19999,
			    (integer)le.address_verification.input_address_information.census_income >= 90000 => 90000,
			    (integer)le.address_verification.input_address_information.census_income);

     ceninclog :=     log(ceninc) / 0.434294481903;


     cred_fs_pop := if(le.ssn_verification.credit_first_seen = 0, 1,0);	//seems backwards


     rel_crimbk := map(rel_criminal_flag = 1 and rel_bk_flag = 1 => 2,
				   rel_criminal_flag = 1 or rel_bk_flag = 1 => 1,
				   0);

     rel_crimbk_m := map(rel_crimbk = 0 => 0.0545341443,
					rel_crimbk = 1 => 0.0720228809,
					rel_crimbk = 2 => 0.0961538462,
					0.0961538462);



     lien_recent_un := if(le.bjl.liens_recent_unreleased_count > 2, 2, le.bjl.liens_recent_unreleased_count);
     lien_hist_un := if(le.bjl.liens_historical_unreleased_count > 2, 2, le.bjl.liens_historical_unreleased_count);
     lien_recent_rel := if(le.bjl.liens_recent_released_count > 2, 2, le.bjl.liens_recent_released_count);
     lien_hist_rel := if(le.bjl.liens_historical_released_count > 2, 2, le.bjl.liens_historical_released_count);
	
	
	lienflag := map(lien_recent_un = 2 => 6,
				 lien_recent_un = 1 => 5,
				 lien_hist_un = 2 => 4,
				 lien_hist_un = 1 => 3,
				 lien_recent_rel >= 1 => 3,
				 lien_hist_rel >= 1 => 2,
				 1);

     lienflag_m := map(lienflag = 1 => 0.0578530576,
				   lienflag = 2 => 0.0810810811,
				   lienflag = 3 => 0.095505618,
				   lienflag = 4 => 0.12,
				   lienflag = 5 => 0.1333333333,
				   lienflag = 6 => 0.1666666667,
				   0.1666666667);


     cvibest := map(le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary in [1,4,7,9] => 0,
				le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch => 1,
				le.iid.cvi = 30 and ~le.address_verification.input_address_information.isbestmatch => 2,
				le.iid.cvi <= 30 and le.address_verification.input_address_information.isbestmatch => 3,
				le.iid.cvi >= 40 and ~le.address_verification.input_address_information.isbestmatch => 3,
				le.iid.cvi = 40 and le.address_verification.input_address_information.isbestmatch => 4,
				le.iid.cvi = 50 and le.address_verification.input_address_information.isbestmatch => 5,
				5);

     cvibest_eda := cvibest + (integer)le.name_verification.lname_eda_sourced;
	
	
	ver_level4 := map(ver_level3 = 0 and cvibest_eda <= 4 => 0,
				   ver_level3 = 0 => 1,
				   ver_level3 = 1 and cvibest_eda <= 2 => 0,
				   ver_level3 = 1 => 1,
				   ver_level3 = 2 => 2,
				   ver_level3 = 3 and cvibest_eda <= 5 => 3,
				   ver_level3 = 3 => 4,
				   ver_level3 = 4 and cvibest_eda <= 5 => 4,
				   ver_level3 = 4 => 5,
				   5);

     ver_level4_m := map(ver_level4 = 0 => 0.1582491582,
					ver_level4 = 1 => 0.0966484801,
					ver_level4 = 2 => 0.0692504987,
					ver_level4 = 3 => 0.0553846154,
					ver_level4 = 4 => 0.0480735242,
					ver_level4 = 5 => 0.0387573964,
					0.0387573964);



     header_matrix := map(time_on_header_code = 0 and time_since_header_code = 2 => 0,
					 time_on_header_code = 0 => 1,
					 time_on_header_code = 1 and time_since_header_code = 2 => 2,
					 time_on_header_code = 1 => 3,
					 time_on_header_code = 2 and time_since_header_code = 2 => 2,
					 time_on_header_code = 2 and time_since_header_code = 1 => 3,
					 time_on_header_code = 2 and time_since_header_code = 0 => 4,
					 time_on_header_code = 3 and time_since_header_code = 0 => 5,
					 time_on_header_code = 3 => 4,
					 4);

     header_matrix_m := map(header_matrix = 0 => 0.1382694023,
					   header_matrix = 1 => 0.0913140312,
					   header_matrix = 2 => 0.0780452225,
					   header_matrix = 3 => 0.0629022213,
					   header_matrix = 4 => 0.0455956539,
					   header_matrix = 5 => 0.0395272234,
					   0.0395272234);



     mod8_credit1 := -2.054968189
				   + fp_prob_m  * 12.886493263
				   + add1_census_education_credit * -0.109119527
				   + add1_census_home_value_credit * -1.407371E-6
				   + add1_census_age_credit * -0.029853253
				   + prop_tree_credit2_m * 5.4808746605
				   + rel_home_val_credit_m * 5.2602719694
				   + mult_adl_credit_count * 0.1465135639
				   + utility_sourced_flag  * 0.1827912631
				   + ceninclog  * -0.218299775
				   + cred_fs_pop  * -0.232368076
				   + rel_crimbk_m  * 18.008687506
				   + lienflag_m  * 14.271620359
				   + ver_level4_m  * 8.1684874263
				   + header_matrix_m  * 6.2481010852;
				   
     mod8_credit := (exp(mod8_credit1)) / (1+exp(mod8_credit1));
     phat2 := mod8_credit;


     base2 := 660.0;
     odds2 := 0.06 / 0.94;
     point2 := -20.0;


     mod8_credit_fico := (integer)(point2*(log(phat2/(1-phat2)) - log(odds2))/log(2) + base2);


     thindex_credit_pre_cap := round(power((2- log(999-mod8_credit_fico)),2.0)*100.0) + mod8_credit_fico;	
	
		 thindex_credit := MAP(le.ssn_verification.validation.deceased and thindex_credit_pre_cap > 625 => '625',
													 thindex_credit_pre_cap > 999 => '999',
													 thindex_credit_pre_cap < 250 => '250',
													 (string)thindex_credit_pre_cap);
	
		 SELF.score := thindex_credit;
		 SELF.seq := le.seq;
		 SELF.ri := [];
END;
out := PROJECT(clam, doModel(LEFT));


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