import ut, risk_indicators, RiskWise, RiskWiseFCRA;

export FD3510_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true, 
			   boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false, boolean nugen=false, boolean other_watchlists = false) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM

	sysyear := IF(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	
	
	best_match_level := MAP(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);
	
	
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	verssn_s := if(le.iid.nas_summary in [4,6,7,9,10,11,12], 1,0);
	
	

	nas_ver := IF(le.iid.nas_summary >= 10, 1,0);

     ver_pl_p := MAP(best_match_level = 2 and nas_ver = 1 and verphn_p = 1 and verlst_p = 1 => 2,
				 best_match_level = 2 and nas_ver = 1 and verphn_p = 1 => 1,
				 verphn_p = 1 and verlst_p = 1 => 1,
				 0);


     ver_tree := MAP(best_match_level = 0 and  nas_ver = 0 and ver_pl_p = 0  => 0,
				 best_match_level = 0 and  nas_ver = 1 and ver_pl_p = 1  => 5,
				 best_match_level = 0 and (nas_ver = 1 or  ver_pl_p = 1) => 2,

				 best_match_level = 1 and  nas_ver = 0 and ver_pl_p = 0  => 1,
				 best_match_level = 1 and  nas_ver = 1 and ver_pl_p = 1  => 6,
				 best_match_level = 1 and (nas_ver = 1 or  ver_pl_p = 1) => 3,

				 best_match_level = 2 and  nas_ver = 0 and ver_pl_p = 0  => 1,
				 best_match_level = 2 and  nas_ver = 0 and ver_pl_p = 1  => 3,
				 best_match_level = 2 and  nas_ver = 1 and ver_pl_p = 0  => 4,
				 best_match_level = 2 and  nas_ver = 1 and ver_pl_p = 1  => 6,
				 7);


     ver_tree_adj_m := MAP(ver_tree = 0 => 0.2580256,
					  ver_tree = 1 => 0.1998092,
					  ver_tree = 2 => 0.1441303,
					  ver_tree = 3 => 0.0824258,
					  ver_tree = 4 => 0.0508425,
					  ver_tree = 5 => 0.0491798,
					  ver_tree = 6 => 0.033238531,
					  0.0172097);



     naprop_ver := MAP(le.address_verification.input_address_information.naprop = 4 => 2,
				   le.address_verification.input_address_information.naprop = 3 => 1,
				   0);



     criminal_flag := IF(le.bjl.criminal_count > 0, 1,0);

	
	
	/* FP */

     aptflag := if(trim(le.address_validation.dwelling_type) = 'A', 1,0);

     ssninval := if(~le.ssn_verification.validation.valid, 1,0);

     ssndead := (integer)le.ssn_verification.validation.deceased;


     high_issue_dateyr := (integer)(le.ssn_verification.validation.high_issue_date[1..4]);

     ssnage := sysyear - high_issue_dateyr;


     hr_address_n := (integer)le.address_validation.hr_address;


     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0,1);

	phone_zip_mismatch_n := (integer)le.phone_verification.phone_zip_mismatch;
     disconnected_n := (integer)le.phone_verification.disconnected;
     hr_phone_n := (integer)le.phone_verification.hr_phone;


     not_connected := if(trim(le.iid.nap_status) = 'C' and disconnected_n = 0, 0,1);


     mult_adl_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
					  le.ssn_verification.adlperssn_count <= 2 => 1,
					  2);


     not_deliverable := if(~le.address_validation.usps_deliverable, 1,0);


     phnprob_fa := map(pnotpots = 1 or phone_zip_mismatch_n = 1 => 2,
				   not_connected = 1 => 1,
				   0);



     ssnprior_fa := if(ssnage <= 16, 1,0);

     ssnprob_fa := map(ssninval = 1 or ssndead = 1 => 2,
				   ssnprior_fa = 1 => 1,
				   0);



     phnprob_fa_m := map(phnprob_fa = 0 => 0.0296986461,
					phnprob_fa = 1 => 0.0572437078,
					0.1305099395);



     time_on_header_years := sysyear - (integer)(le.ssn_verification.header_first_seen[1..4]);
     time_since_header_years := sysyear - (integer)(le.ssn_verification.header_last_seen[1..4]);


     time_since_header_code := map(time_since_header_years >= 14 => 3,
							time_since_header_years >= 8 => 2,
							time_since_header_years >= 2 => 1,
							0);


     time_on_header_large := if(time_on_header_years <= 5 or time_on_header_years = sysyear, 0,1);


     Header_Combo := if((1 + time_since_header_code - time_on_header_large) <= 3,  1 + time_since_header_code - time_on_header_large,3);

     header_combo_m := map(header_combo = 0 => 0.0483458234,
					  header_combo = 1 => 0.0526112186,
					  header_combo = 2 => 0.0667040359,
					  0.1126158232);



     rel_dist := map(le.relatives.relative_count = 0 => 0,
				 le.relatives.relative_within25miles_count  > 0 => 25,
				 le.relatives.relative_within100miles_count > 0 => 100,
				 le.relatives.relative_within500miles_count > 0 => 500,
				 501);

     rel_dist_code := map(rel_dist = 0 => 2,
					 rel_dist =  25 => 0,
					 rel_dist = 100 => 1,
					 rel_dist = 500 => 3,
					 4);


     rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);

     rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);


     rel_crimbk := map(rel_criminal_flag = 1 and rel_bk_flag = 1 => 2,
				   rel_criminal_flag = 1 or  rel_bk_flag = 1 => 1,
				   0);


     rel_crimbk_m := map(rel_crimbk = 0 => 0.0510735612,
					rel_crimbk = 1 => 0.0585435507,
					0.0984615385);


	today := IF(le.historydate <> 999999, (string)le.historydate[1..6] + '01', ut.GetDate);
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);

     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));	
     age_years := if(age_years1 <= 0, -99,age_years1);

     age_combo := if(age_years = -99, le.name_verification.age,age_years);

     xx_age_combo := age_combo * age_combo;

     
     add1_census_age_fa := map(le.address_verification.input_address_information.census_age = '' => 29,
						 (integer)le.address_verification.input_address_information.census_age <= 26 => 26,
						 (integer)le.address_verification.input_address_information.census_age >= 40 => 40,
						 (integer)le.address_verification.input_address_information.census_age);

     add1_census_income_fa := map(le.address_verification.input_address_information.census_income = '' => 30000,
						    (integer)le.address_verification.input_address_information.census_income <= 15000 => 15000,
						    (integer)le.address_verification.input_address_information.census_income >= 85000 => 85000,
						    (integer)le.address_verification.input_address_information.census_income);

     add1_census_education_fa := map(le.address_verification.input_address_information.census_education = ''  => 12,
							  (integer)le.address_verification.input_address_information.census_education <= 11 => 11,
							  (integer)le.address_verification.input_address_information.census_education >= 16 => 16,
							  (integer)le.address_verification.input_address_information.census_education);



     i_add1_census_age := if(add1_census_age_fa = 0, 35,1000 / add1_census_age_fa);
     i_add1_census_income := if(add1_census_income_fa = 0, 33,1000000 / add1_census_income_fa);
     i_add1_census_education := if(add1_census_education_fa = 0, 87,1000 / add1_census_education_fa);



     lname_change_year := (integer)(le.name_verification.lname_change_date[1..4]);
     recent_name_change_jpmc := if(sysyear - lname_change_year < 10, 1,0);
	
	
	
	/* Models */
	
     mod71 := -8.30898133
                  + ver_tree_adj_m  * 9.6872335695
                  + naprop_ver  * -0.069070401
                  + criminal_flag  * 0.7180926895
                  + aptflag  * 0.3397691103
                  + mult_adl_count  * 0.1130249011
                  + ssnprob_fa  * 0.5077951355
                  + phnprob_fa_m  * 8.3531120725
                  + header_combo_m  * 4.7843691464
                  + rel_crimbk_m  * 13.446150712
                  + rel_dist_code  * 0.0802068848
                  + i_add1_census_age  * 0.0436564536
                  + i_add1_census_income  * 0.0100335428
                  + i_add1_census_education  * 0.0088553395
                  + xx_age_combo  * 0.0003120758
                  + recent_name_change_jpmc  * 0.1569042013;
     
     mod72 := (exp(mod71)) / (1+exp(mod71));
     phat := mod72;


     base  := 660.0;
     odds  := 0.0531 / 0.9469;
     point := -20.0;


     mod7_score := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);



     Fraud_Score_510_1 := map((ssninval = 1 or ssndead = 1 or le.iid.socsdobflag = '1') and mod7_score > 624 => 624,
					     verssn_s = 0 and mod7_score > 641 => 641,
					     le.iid.nas_summary <= 9 and mod7_score > 679 => 679,
					     mod7_score);
     Fraud_Score_510_2 := if(not_deliverable = 1 and Fraud_Score_510_1 > 679, 679,Fraud_Score_510_1);
     Fraud_Score_510_3 := if(verphn_p = 0 and disconnected_n = 1 and Fraud_Score_510_2 > 641, 641,Fraud_Score_510_2);
     Fraud_Score_510_4 := if(verphn_p = 0 and pnotpots = 1 and Fraud_Score_510_3 > 679, 679,Fraud_Score_510_3);
     Fraud_Score_510_6 := if(verphn_p = 0 and phone_zip_mismatch_n = 1 and Fraud_Score_510_4 > 641, 641,Fraud_Score_510_4);
     Fraud_Score_510_7 := if(le.ssn_verification.adlperssn_count >= 10 and Fraud_Score_510_6 > 641, 641,Fraud_Score_510_6);
     Fraud_Score_510_8 := if(hr_address_n = 1 and Fraud_Score_510_7 > 679, 679,Fraud_Score_510_7);
     Fraud_Score_510 := if(hr_phone_n = 1 and Fraud_Score_510_8 > 679, 679,Fraud_Score_510_8);
		 
		 
		 Fraud_Score_510_capped := map(Fraud_Score_510 > 999 => 999,
																	 Fraud_Score_510 < 300 => 300,
																	 Fraud_Score_510);		 


	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
     self.score := if(isFCRA and self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)Fraud_Score_510_capped);
	self.seq := le.seq;
END;
out := PROJECT(clam, doModel(LEFT));


Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
	self := [];
END;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
	self.ri := map(
				isFCRA and (le.ri[1].hri <> '00')	=> le.ri,
				isFCRA								=> RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif ),
				nugen								=> RiskWise.bdReasonCodesConsumer( ri, 4, OFAC, other_watchlists, nugen ),
				fdReasonsWith38						=> Riskwise.Bus_fdReasoncodes(ri, 4, OFAC),
				RiskWise.fdReasonCodes(ri, 4, OFAC, other_watchlists)
				);
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;