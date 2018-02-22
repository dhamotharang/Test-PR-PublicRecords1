import ut, risk_indicators, riskwise, riskwisefcra, std;

export AWD605_2_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := FUNCTION

Layout_ModelOut doModel(clam le) := TRANSFORM

	sysyear := IF(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));
	
	neither_best_match := if(~le.address_verification.input_address_information.isbestmatch and ~le.address_verification.address_history_1.isbestmatch, 1, 0);
	
	best_match_level := MAP(le.address_verification.input_address_information.isbestmatch => 2,
					    le.address_verification.address_history_1.isbestmatch => 0,
					    1);
	
	verfst_p := if(le.iid.nap_summary in [2,3,4,8,9,10,12], 1,0);
	verlst_p := if(le.iid.nap_summary in [2,5,7,8,9,11,12], 1,0);
	verphn_p := if(le.iid.nap_summary in [4,6,7,9,10,11,12], 1,0);
	verssn_s := if(le.iid.nas_summary in [4,6,7,9,10,11,12], 1,0);	
	
	nas_ver := if(le.iid.nas_summary >= 10, 1,0);
	
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

	aptflag := if(trim(le.address_validation.dwelling_type) = 'A', 1,0);

	ssninval := if(~le.ssn_verification.validation.valid, 1,0);
		
     ssndead := (integer)le.ssn_verification.validation.deceased;
	
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


	ssnprob_aw := if(ssninval = 1 or ssndead = 1, 1, 0);
	
	phnprob_aw := map(disconnect_level > 0 and (pnotpots > 0 or phone_zip_mismatch_n > 0) => 3,
				   disconnect_level = 2 => 2,
				   disconnect_level > 0 or pnotpots > 0 or phone_zip_mismatch_n > 0 => 1,
				   0);
				   
	lien_recent_un := if(le.bjl.liens_recent_unreleased_count <= 2, le.bjl.liens_recent_unreleased_count, 2);
     lien_hist_un := if(le.bjl.liens_historical_unreleased_count <= 2, le.bjl.liens_historical_unreleased_count, 2);
     lien_recent_rel := if(le.bjl.liens_recent_released_count <= 2, le.bjl.liens_recent_released_count, 2);


     lienflag2 := map(lien_recent_un = 2 => 4,
				  lien_recent_un = 1 => 3,
				  lien_hist_un = 2 => 2,
				  lien_hist_un = 1 => 1,
				  lien_recent_rel >= 1 => 1,
				  0);


	today := IF(le.historydate <> 999999, ((string)le.historydate)[1..6] + '01', (STRING)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);

     dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	input_dob := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);
	
	age_years1 := if(input_dob = -99, -99, round((today1900-input_dob)/365.25));
     age_years := if(age_years1 <= 0, -99, age_years1);

     age_combo := map(age_years < 21 => 21,
				  age_years > 55 => 55,
				  age_years);


	 /* New Fields Used in Declinable Version */

     time_since_header_years := (sysyear - (integer)(le.ssn_verification.header_last_seen/100));

     time_since_header_code := map(time_since_header_years >= 14 => 3,
							time_since_header_years >= 8 => 2,
							time_since_header_years >= 2 => 1,
							0);


     time_on_header_years := (sysyear - (integer)(((STRING)le.ssn_verification.header_first_seen)[1..4]));

	time_on_header_code := map(time_on_header_years <= 5 or time_on_header_years = sysyear => 0,
						  time_on_header_years <= 15 => 1,
						  time_on_header_years <= 20 => 2,
						  3);
    

     header_matrix_aw := map(time_on_header_code = 0 and time_since_header_code <= 1 => 1,
					    time_on_header_code = 0 => 0,
					    time_on_header_code = 1 and time_since_header_code = 0 => 2,
					    time_on_header_code = 1 and time_since_header_code <= 2 => 1,
					    time_on_header_code = 1 => 0,
					    time_on_header_code = 2 and time_since_header_code = 0 => 3,
					    time_on_header_code = 2 and time_since_header_code = 1 => 2,
					    time_on_header_code = 2 => 1,
					    time_on_header_code = 3 and time_since_header_code = 0 => 4,
					    time_on_header_code = 3 and time_since_header_code <= 2 => 2,
					    1);


     lienflag2_m := map(lienflag2 = 0 => 0.1185356812,
				    lienflag2 = 1 => 0.148409894,
				    lienflag2 = 2 => 0.179047619,
				    lienflag2 = 3 => 0.2024691358,
				    0.2922077922);


	
	/* From Airwaves510 Code */

     criminal_flag := if(le.bjl.criminal_count > 0, 1, 0);

     mult_adl_count := map(le.ssn_verification.adlperssn_count <= 1 => 0,
					  le.ssn_verification.adlperssn_count <= 2 => 1,
					  2);


     prop_tree_aw2 := map(NaProp_Tree = 2 and property_total_x => 3,
					 NaProp_Tree = 2 => 2,
					 NaProp_Tree = 1 and property_total_x => 2,
					 NaProp_Tree = 1 => 1,
					 NaProp_Tree = 0 and property_total_x => 2,
					 0);


     prop_tree_aw2_m := map(prop_tree_aw2 = 0 => 0.176343893,
					   prop_tree_aw2 = 1 => 0.1206441394,
					   prop_tree_aw2 = 2 => 0.0672090555,
					   0.0509122502);
	

     header_matrix_aw_m := map(header_matrix_aw = 0 => 0.2179768243,
						 header_matrix_aw = 1 => 0.1741452991,
						 header_matrix_aw = 2 => 0.1134377825,
						 header_matrix_aw = 3 => 0.0692032686,
						 0.0498795181);
						 
						 
	/* New for AW605 */

     fpprob_aw2 := map(ssnprob_aw = 1 => 3,
				   addprob_aw = 0 and phnprob_aw = 0 => 0,
				   addprob_aw = 0 and phnprob_aw = 1 => 1,
				   addprob_aw = 0 and phnprob_aw <= 3 => 2,
				   addprob_aw = 1 and phnprob_aw = 0 => 1,
				   addprob_aw = 1 and phnprob_aw <= 3 => 2,
				   addprob_aw = 2 => 2,
				   0);


     fpprob_aw2_m := map(fpprob_aw2 = 0 => 0.0954533,
					fpprob_aw2 = 1 => 0.1199403,
					fpprob_aw2 = 2 => 0.1819362,
					0.2925170);


     verx := if(best_match_level = 2,
								map(verlst_p = 1 and verphn_p = 1 and verfst_p = 1 and nas_ver = 1 => 6,
								    verlst_p = 1 and verphn_p = 1 and nas_ver = 1 => 5,
								    nas_ver = 1 => 4,
								    3),
								map(verlst_p = 1 and verphn_p = 1 and verfst_p = 1 and nas_ver = 1 => 5,
								    verlst_p = 1 and nas_ver = 1 => 4,
								    nas_ver = 1 => 3,
								    verlst_p = 1 and verphn_p = 1 => 2,
								    verssn_s = 0 or neither_best_match = 1 => 0,
								    1));


     verx_m := map(verx = 0 => 0.2971926,
			    verx = 1 => 0.2342371,
			    verx = 2 => 0.1654321,
			    verx = 3 => 0.1338311,
			    verx = 4 => 0.1049375,
			    verx = 5 => 0.0783922,
			    0.0504587);


     airwaves_mod_clean_fixed := -5.075732687
							   + criminal_flag  * 0.5865445043
							   + mult_adl_count  * 0.1262527001
							   + age_combo  * -0.015929294
							   + prop_tree_aw2_m    * 5.4494258101
							   + lienflag2_m  * 8.1318094255
							   + header_matrix_aw_m  * 4.0110086453
							   + fpprob_aw2_m  * 3.6802993867
							   + verx_m  * 5.1103598382;
			   
     phat := (exp(airwaves_mod_clean_fixed)) / (1+exp(airwaves_mod_clean_fixed));

     Score_Temp := 983.8 - (990 * phat);	
	
     AWD605_2_0_raw := 604.706497387364
                + Score_Temp	* (-2.8427007490329)
                + (power(Score_Temp, 2.0)) * (0.00646445547306646)
                + (power(Score_Temp, 3.0)) * (-3.24829807787695)*(0.000001);
			 	 
	awd60520 := if(AWD605_2_0_raw > 940, 940 + 1.5*(AWD605_2_0_raw-940), AWD605_2_0_raw);

     AWD605_2_0_no_ov := round(awd60520);
	
     AWD605_2_0_no_override := map(AWD605_2_0_no_ov < 250 => 250,
							AWD605_2_0_no_ov > 999 => 999,
							AWD605_2_0_no_ov);
	
/* other caps and overrides */

	veradd_p := if(le.iid.nap_summary in [3,5,6,8,10,11,12], 1,0);
	verfst_s := if(le.iid.nas_summary in [2,3,4,8,9,10,12], 1,0);	
	verlst_s := if(le.iid.nas_summary in [2,5,7,8,9,11,12], 1,0);	
	veradd_s := if(le.iid.nas_summary in [3,5,6,8,10,11,12], 1,0);	

     verfst := if( (verfst_p + verfst_s) > 0, 1, 0);
     verlst := if( (verlst_p + verlst_s) > 0, 1, 0);
     veradd := if( (veradd_p + veradd_s) > 0, 1, 0);
     verphn := if(verphn_p > 0, 1, 0);
     verssn := if(verssn_s > 0, 1, 0);
     verdob := if(le.name_verification.dob_score between 90 and 100, 1, 0);

     verifyCount := verfst + verlst + veradd + verphn + verssn + verdob;
	prisonflag := if(le.address_validation.corrections or le.phone_verification.corrections, 1, 0);
	ssninval_pop := if(trim(le.shell_input.ssn)<>'' and (ssninval=1 or le.ssn_verification.validation.issued=false), 1, 0);	
	ssnprior := if(le.iid.reason1 = '03' or le.iid.reason2 = '03' or le.iid.reason3 = '03' or 
				le.iid.reason4 = '03' or le.iid.reason5 = '03' or le.iid.reason6 = '03', 1, 0);
			  
  
     /* override 250 */
     	
	ssnbad := map(le.shell_input.ssn in ['000000000','111111111','222222222','333333333','444444444','555555555','666666666','777777777',
							 '888888888','999999999','123123123','123456789','987654321','010101010','101010101'] => 1,
		    le.shell_input.ssn[1..3] = '000' => 2,
		    0);
			    
     score249 := if(ssnbad = 1 or ssnbad = 2 and verfst = 0 and verlst = 0 and veradd = 1 and verphn = 1, 1, 0);

	AWD605_2a := if(AWD605_2_0_no_override > 500 and score249 = 1, 250, AWD605_2_0_no_override);
	
	 /* cap 840 */
	score840 := if(ssnbad=1 or ssnbad=2, 1, 0);
	AWD605_2b := if(AWD605_2a > 840 and score840 = 1, 840, AWD605_2a);	
	
	AWD605_2_0 := map(ssndead=1 => 202,
				   ssnprior=1 => 204,
				   verifycount=0 => 200,
				   prisonflag=1 => 260,
				   ssninval_pop=1 => 201,
				   AWD605_2b > 999 => 999,
				   AWD605_2b < 0 => 0,
				   AWD605_2b);
	
	
	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);


	// 16 aug 2007 override checking for unable to verify ssn + some ssn mismatch
	iid_rcs := [le.iid.reason1,le.iid.reason2,le.iid.reason3,le.iid.reason4,le.iid.reason5,le.iid.reason6];
	rc26 := '26' in iid_rcs;
	rc51 := '51' in iid_rcs;
	rc28 := '28' in iid_rcs;
	
	rc72 := Risk_Indicators.rcSet.isCode72((string)le.iid.socsverlevel, le.shell_input.ssn, le.iid.ssnExists, le.iid.lastssnmatch2);

	
	AWD605_2_1 := map( AWD605_2_0 > 260 AND rc26 AND rc72 => 207,
						AWD605_2_0 > 260 AND rc26 AND ( rc51 OR rc28 ) => 206,
						AWD605_2_0
	);
	
	self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), intformat(AWD605_2_1,3,1));
	self.seq := le.seq;
END;
out := project(clam, doModel(LEFT));

Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
	self.seq := le.seq;
	self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
	self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
	self.socsverlevel := le.iid.NAS_summary;
	self.nxx_type := le.phone_verification.telcordia_type;
	self := le.iid;
	self := le.shell_input;
	self := le;
END;
iid := project(clam, into_layout_output(left));


Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
	self.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.mmReasonCodes(ri, 4, OFAC, inCalif));
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;