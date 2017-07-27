import ut, risk_indicators, address, RiskWise;

export TRN509_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, unsigned3 history_date=999999, boolean OFAC=true) :=
FUNCTION


Layout_ModelOut doModel(clam le) := transform

	contrary_phone := if(le.iid.nap_summary = 1, 1,0);
	
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	
	ssn479 := if(le.iid.nas_summary in [4,7,9], 1,0);


	incomplete_credit_ver := if((le.name_verification.fname_credit_sourced or le.name_verification.lname_credit_sourced) and ~(le.address_verification.input_address_information.credit_sourced), 1,0);

	
	nap_ver := map(le.iid.nap_summary in [0,1] => 0,
				le.iid.nap_summary = 12 => 3,
				le.iid.nap_summary in [6,10,11] => 2,
				1);

     eda_source_ver := map(le.name_verification.fname_eda_sourced and le.name_verification.lname_eda_sourced => 3,
					  le.name_verification.lname_eda_sourced and le.address_verification.input_address_information.eda_sourced => 2,
					  ((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + 
								(integer)le.address_verification.input_address_information.eda_sourced) = 0 => 0,
					  1);

	eda_combo_ver1 := map(contrary_phone = 1 => 0,
					 nap_ver = 0 and eda_source_ver = 0 => 0,
					 nap_ver = 0 and eda_source_ver <= 2 => 1,
					 nap_ver = 0 => 3,
					 nap_ver = 1 and eda_source_ver = 0 => 1,
					 nap_ver = 1 and eda_source_ver = 1 => 2,
					 nap_ver = 1 => 3,
					 nap_ver = 2 and eda_source_ver = 0 => 1,
					 nap_ver = 2 => 3,
					 nap_ver = 3 and eda_source_ver <= 2 => 3,
					 nap_ver = 3 => 4,
					 4);
					 
	eda_combo_ver := if(verphn_p = 0 ,if(eda_combo_ver1<=2, eda_combo_ver1,2),eda_combo_ver1);

     incomplete_dl_ver := if(le.available_sources.dl and ~(le.address_verification.input_address_information.dl_sourced) ,1,0);
     incomplete_ver_combo := (incomplete_credit_ver + incomplete_dl_ver);

     source_ver_total1 := eda_combo_ver;
     source_ver_total2 := map(source_ver_total1 >= 3 and incomplete_ver_combo > 0 =>source_ver_total1 - 1,
						incomplete_ver_combo = 2 => 0,
						source_ver_total1);

     source_ver_total := if(source_ver_total2 <= 1 and ssn479 = 0, source_ver_total2 + 1,source_ver_total2);

     source_ver_total_m := map(source_ver_total = 0 => 0.0993630573,
						 source_ver_total = 1 => 0.0737759893,
						 source_ver_total = 2 => 0.0656973613,
						 source_ver_total = 3 => 0.051713948,
						 source_ver_total = 4 => 0.0386836028,
						 0.0386836028);
						 

	
	/* Age */

     dob_y := (integer)(le.shell_input.dob[1..4]);
     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
     input_dob := if(dob_m > 0 and dob_d > 0, dob_m + dob_d + dob_y,-99);

     age_years1 := if(input_dob = -99, -99, round((ut.daysapart(ut.GetDate,le.shell_input.dob))/365.25));	
     age_years := if(age_years1 <= 0, -99,age_years1);

     age_combo := if(age_years = -99, le.name_verification.age,age_years);

     age_combo2 := map(age_combo <= 20 => 20,
				   age_combo >= 58 => 58,
				   age_combo);



	NaProp4_any := if(le.address_verification.input_address_information.naprop = 4 or le.address_verification.address_history_1.naprop = 4 or le.address_verification.address_history_2.naprop = 4, 1,0);
	NaProp3_any := if(le.address_verification.input_address_information.naprop = 3 or le.address_verification.address_history_1.naprop = 3 or le.address_verification.address_history_2.naprop = 3, 1,0);
	
	NaProp_Tree := map(NaProp4_any = 1 => 2,
				    NaProp3_any = 1 => 1,
				    0);
				    

     naprop_tree_retail := map(le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 4 => 4,
						 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop in [2,3] => 3,
						 le.address_verification.input_address_information.isbestmatch => 2,
						 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.address_history_1.isbestmatch and naprop_tree > 0 => 1,
						 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.address_history_1.isbestmatch => 0,
						 ~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch and le.address_verification.input_address_information.naprop = 4 => 4,
						 ~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch and le.address_verification.input_address_information.naprop in [2,3] => 3,
						 ~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch => 1,
						 1);

     naprop_tree_retail_m := map(naprop_tree_retail = 0 => 0.082288008,
						   naprop_tree_retail = 1 => 0.0640934844,
						   naprop_tree_retail = 2 => 0.0609411476,
						   naprop_tree_retail = 3 => 0.0527906977,
						   naprop_tree_retail = 4 => 0.026371308,
						   0.026371308);


     lien_unrel_flag := if(le.bjl.liens_historical_unreleased_count = 0, 0,1);
     criminal_flag := if(le.bjl.criminal_count > 0, 1,0);
     crimlien := if(criminal_flag = 1 or lien_unrel_flag = 1, 1,0);


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

     rel_prop_count := le.relatives.owned.relatives_property_count + le.relatives.sold.relatives_property_count + le.relatives.ambiguous.relatives_property_count;


     rel_prop_retail := map(rel_prop_count <= 0 => 0,
					   rel_prop_count <= 1 => 1,
					   rel_prop_count <= 2 => 2,
					   3);

     rel_income_retail := map(rel_income = 0 => 1,
						rel_income <= 50 => 0,
						rel_income <= 75 => 2,
						rel_income <= 100 => 3,
						4);

     rel_home_val_retail := map(rel_home_val = 0 => 1,
						  rel_home_val <= 150 => 0,
						  rel_home_val <= 200 => 2,
						  rel_home_val <= 300 => 3,
						  rel_home_val <= 500 => 4,
						  5);


     rel_prop_retail_m := map(rel_prop_retail = 0 => 0.0648186919,
						rel_prop_retail = 1 => 0.0609043371,
						rel_prop_retail = 2 => 0.0471063257,
						rel_prop_retail = 3 => 0.0334207077,
						0.0334207077);

     rel_income_retail_m := map(rel_income_retail = 0 => 0.0709174546,
						  rel_income_retail = 1 => 0.0600938967,
						  rel_income_retail = 2 => 0.0547051443,
						  rel_income_retail = 3 => 0.0356887937,
						  rel_income_retail = 4 => 0.0191256831,
						  0.0191256831);

     rel_home_val_retail_m := map(rel_home_val_retail = 0 => 0.0767981096,
						    rel_home_val_retail = 1 => 0.0600938967,
						    rel_home_val_retail = 2 => 0.0552526354,
						    rel_home_val_retail = 3 => 0.0420070012,
						    rel_home_val_retail = 4 => 0.0361356932,
						    rel_home_val_retail = 5 => 0.0161616162,
						    0.0161616162);


     relmod_retail1 := -5.378246006
					+ rel_prop_retail_m * 19.451002962
					+ rel_income_retail_m * 8.5433737384
					+ rel_home_val_retail_m * 13.343814675
					+ rel_criminal_flag  * 0.4830327565
					+ rel_bk_flag  * 0.6188949895;
					
     relmod_retail2 := (exp(relmod_retail1)) / (1+exp(relmod_retail1));
     relmod_retail3 := round(1000 * relmod_retail2);
	relmod_retail := relmod_retail3 / 10;
	


     add1_census_age_retail := map(le.address_verification.input_address_information.census_age = '' => 27,
							(integer)le.address_verification.input_address_information.census_age <= 25 => 25,
							(integer)le.address_verification.input_address_information.census_age >= 52 => 52,
							(integer)le.address_verification.input_address_information.census_age);


     add1_census_income_retail := map(le.address_verification.input_address_information.census_income = '' => 25000,
							   (integer)le.address_verification.input_address_information.census_income <= 15000 => 15000,
							   (integer)le.address_verification.input_address_information.census_income >= 100000 => 100000,
							   (integer)le.address_verification.input_address_information.census_income);


     add1_census_home_value_retail := map(le.address_verification.input_address_information.census_home_value = '' => 78000,
								  (integer)le.address_verification.input_address_information.census_home_value <= 15000 => 15000,
								  (integer)le.address_verification.input_address_information.census_home_value >= 600000 => 600000,
								  (integer)le.address_verification.input_address_information.census_home_value);



     cenmod_retail1 := -0.896426083
					+ add1_census_age_retail * -0.028874472
					+ add1_census_income_retail * -0.000010027
					+ add1_census_home_value_retail * -2.34542E-6;
					
     cenmod_retail2 := (exp(cenmod_retail1)) / (1+exp(cenmod_retail1));
     cenmod_retail3 := round(1000 * cenmod_retail2);
	cenmod_retail := cenmod_retail3 / 10;



     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0,1);


     phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;
	
	
	not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0,1);

 

     phnprob := map(not_connected = 1 and (pnotpots = 1 or phone_zip_mismatch_n = 1) => 2,
				not_connected = 1 or pnotpots = 1 or phone_zip_mismatch_n = 1 => 1,
				0);

     phnprob_m := map(phnprob = 0 => 0.0408595642,
				  phnprob = 1 => 0.0684386773,
				  phnprob = 2 => 0.0828431373,
				  0.0828431373);


     mult_adl_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
					  le.ssn_verification.adlperssn_count <= 2 => 1,
					  2);



     mod5_retail1 := -4.353308945
					+ source_ver_total_m  * 2.9850064657
					+ age_combo2  * -0.05589518
					+ mult_adl_count  * 0.2731748786
					+ crimlien  * 0.7877458985
					+ relmod_retail * 0.0913160303
					+ cenmod_retail * 0.1069932847
					+ naprop_tree_retail_m * 13.348135256
					+ phnprob_m  * 13.248631756;
					
     mod5_retail2 := (exp(mod5_retail1)) / (1+exp(mod5_retail1));
     phat := mod5_retail2;


     base := 672;
     odds := 0.06 / 0.94;
     point := -16;


     mod5_retail_fico := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

     thindex_retail1 := mod5_retail_fico;
	
	
     SELF.score := if(le.ssn_verification.validation.deceased and thindex_retail1 > 625, '625',(string)thindex_retail1);
	SELF.seq := le.seq;
	SELF.ri := [];
END;
out := PROJECT(clam, doModel(LEFT));


Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self := le.iid;
	self := le.shell_input;
	self := [];
end;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := transform
	SELF.ri := RiskWise.mmReasonCodes(ri, 4, OFAC, false);
	SELF := le;
end;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;