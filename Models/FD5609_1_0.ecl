import ut, risk_indicators, address, RiskWise, RiskWiseFCRA, std;

export FD5609_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM

	sysyear := IF(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
	
	
	best_match_level := MAP(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);
	
	
	verphn_p := le.iid.nap_summary in [4,6,7,9,10,11,12];
	verssn_s := le.iid.nas_summary in [4,6,7,9,10,11,12];
	
	contrary_phone := le.iid.nap_summary = 1;
	contrary_ssn := le.iid.nas_summary = 1;
	
	eda_source_ver := map(le.name_verification.fname_eda_sourced and le.name_verification.lname_eda_sourced => 3,
					  le.name_verification.lname_eda_sourced and le.address_verification.input_address_information.eda_sourced => 2,
					  ((integer)le.name_verification.fname_eda_sourced + (integer)le.name_verification.lname_eda_sourced + 
								(integer)le.address_verification.input_address_information.eda_sourced) = 0 => 0,
					  1);
					  
	addr2 := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,le.address_verification.address_history_1.predir,le.address_verification.address_history_1.prim_name,
								  le.address_verification.address_history_1.addr_suffix,le.address_verification.address_history_1.postdir,le.address_verification.address_history_1.unit_desig,
								  le.address_verification.address_history_1.sec_range);
     addr2pop := if(addr2 = '' , 0, 1);
	
	nas_ver := le.iid.nas_summary >= 10;
	
	
	/* FCRA Verification */
	
	nap_ver2 := map(le.iid.nap_summary in [0,1] => 0,
				 le.iid.nap_summary = 12 => 3,
				 le.iid.nap_summary in [10,11] => 2,
				 1);
				 
	verx := map(best_match_level = 2 and contrary_phone => 5,
			  contrary_phone or contrary_ssn => 0,
			  best_match_level = 2 and nas_ver and nap_ver2 >= 2 => 9,
			  best_match_level = 2 and verphn_p and eda_source_ver = 3 => 9,
			  best_match_level = 2 and verphn_p => 8,
			  best_match_level = 2 => 7,
			  eda_source_ver = 0 => 1,
			  nas_ver and nap_ver2 >= 3 => 8,
			  nas_ver and nap_ver2 >= 2 and verphn_p => 6,
			  nas_ver and nap_ver2 >= 2 => 5,
			  nas_ver and nap_ver2 >= 1 => 4,
			  (nas_ver and nap_ver2 >= 0) or nap_ver2 >= 1 => 3,
			  1);


     verx2 := map(verx >= 4 and le.address_verification.input_address_information.source_count <= 2 => verx - 1,
			   verx >= 7 and le.address_verification.input_address_information.source_count >= 5 => verx + 1,
			   verx);

     verx3 := if(verx2 >= 5 and le.name_verification.source_count <= 1, verx2 - 1, verx2);

     verx4 := map(verx3 <= 1 => verx3 + (integer)nas_ver,
			   ~nas_ver => 2,
			   verx3 - 1);

     verx5 := if(verx4 >= 3 and addr2pop = 0, verx4 - 1, verx4);



     verx5_m := map(verx5 = 0 => 0.3216783,
				verx5 = 1 => 0.2435986,
				verx5 = 2 => 0.1255274,
				verx5 = 3 => 0.0781563,
				verx5 = 4 => 0.0546260,
				verx5 = 5 => 0.0412294,
				verx5 = 6 => 0.0358795,
				verx5 = 7 => 0.0283630,
				verx5 = 8 => 0.0211196,
				0.0183876);



	/* Property */

	/* FP */
	
	aptflag := trim(le.address_validation.dwelling_type) = 'A';
	standardization_error := trim(le.shell_input.addr_status)[1] = 'E';
	high_risk_address := le.address_verification.input_address_information.hr_address or le.address_verification.address_history_1.hr_address or le.address_verification.address_history_2.hr_address;
	ssninval := ~le.ssn_verification.validation.valid;
	ssndead := le.ssn_verification.validation.deceased;
	
	high_issue_dateyr := (integer)(((STRING)le.ssn_verification.validation.high_issue_date)[1..4]);
     ssnage := sysyear - high_issue_dateyr;
	
	hr_address_n := le.address_validation.hr_address;
	pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);
	hphnpop_n := le.input_validation.homephone;
     phone_zip_mismatch_n := le.phone_verification.phone_zip_mismatch;
     disconnected_n := le.phone_verification.disconnected;
	hr_phone_n := le.phone_verification.hr_phone;
	
     not_connected := if(trim(le.iid.nap_status) = 'C' and ~disconnected_n, 0, 1);
	
	not_deliverable := ~le.address_validation.usps_deliverable;
	
	risky_address := high_risk_address or hr_address_n;
	
	addprob_fa := map(aptflag => 2,
				   not_deliverable or risky_address => 1,
				   0);
				   
	phnprob_fa := map(pnotpots = 1 or phone_zip_mismatch_n => 2,
				   not_connected = 1 => 1,
				   0);



     ssnprior_fa := ssnage <= 16;

     ssnprob_fa := map(ssninval or ssndead => 2,
				   ssnprior_fa => 1,
				   0);
				   
	addprob_fa_m := map(addprob_fa = 0 => 0.0444119082,
					addprob_fa = 1 => 0.0671875,
					0.1034020895);


     phnprob_fa_m := map(phnprob_fa = 0 => 0.0296986461,
					phnprob_fa = 1 => 0.0572437078,
					0.1305099395);


     ssnprob_fa_m := map(ssnprob_fa = 0 => 0.0493629387,
					ssnprob_fa = 1 => 0.0808713817,
					0.2291666667);
					
					
	/* Bureau / Time on Bureau */
	
	cred_fs_pop := le.ssn_verification.credit_first_seen = 0;
	time_on_bureau_years := if(cred_fs_pop, -1, sysyear - (integer)(((STRING)le.ssn_verification.credit_first_seen)[1..4]));

     time_on_bureau_jpmc_code := map(time_on_bureau_years = -1 or time_on_bureau_years = sysyear => 4,
							  time_on_bureau_years <= 3  => 0,
							  time_on_bureau_years <= 4  => 1,
							  time_on_bureau_years <= 5  => 2,
							  time_on_bureau_years <= 14 => 3,
							  time_on_bureau_years <= 15 => 4,
							  time_on_bureau_years <= 21 => 5,
							  6);



     Low_Header_Flag := le.ssn_verification.header_count <= 1;
	
	
	/* Age */

	today := IF(le.historydate <> 999999, ((string)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);

     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));	
     age_years := if(age_years1 <= 0, -99, age_years1);
	
	age_combo := map(age_years <= 20 => 20,
				  age_years >= 58 => 58,
				  age_years);

     xx_age_years := age_combo * age_combo;
	
	
	/* Model  */

     mod2 := -5.53298938
                  + verx5_m  * 9.67712446
                  + addprob_fa_m  * 8.571934298
                  + phnprob_fa_m  * 8.6242524291
                  + ssnprob_fa_m  * 9.8366030753
                  + time_on_bureau_jpmc_code  * -0.111381407
                  + (integer)Low_Header_Flag  * -0.13380358
                  + xx_age_years  * 0.0004630934;
			   
     phat := (exp(mod2 )) / (1+exp(mod2 ));


     base := 660;
     odds := 0.0531 / 0.9469;
     point := -20;


     Fraud_Score_609 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);


	/*  Overrides */

     over := map((ssninval or ssndead) and Fraud_Score_609 > 632 => 632,
			  ~verssn_s and Fraud_Score_609 > 651 => 651,
			  le.iid.nas_summary <= 9 and Fraud_Score_609 > 672 => 672,
			  Fraud_Score_609);

     over2 := if(not_deliverable and over > 672, 672, over);

     over3 := if(~verphn_p and disconnected_n and over2 > 651, 651, over2);
     over4 := if(~verphn_p and pnotpots = 1 and over3 > 672, 672, over3);
     over5 := if(~verphn_p and phone_zip_mismatch_n and over4 > 651, 651, over4);

     over6 := if(le.ssn_verification.adlperssn_count >= 10 and over5 > 651, 651, over5);

     over7 := if(hr_address_n and over6 > 672, 672, over6);
     over8 := if(hr_phone_n and over7 > 672, 672, over7);


	/* Create 10-50 Scale */

     Fraud_Score_609_5 := map(over8 <= 598 => '010',
						over8 <= 632 => '020',
						over8 <= 651 => '030',
						over8 <= 672 => '040',
						'050');

	SELF.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
     SELF.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)Fraud_Score_609_5);
	SELF.seq := le.seq;
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
	SELF.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif));
	SELF := le;
end;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;