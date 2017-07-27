import ut, risk_indicators, RiskWise, daybatchpcnsr;

export FD9607_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean isStudent, boolean other_watchlists = false) := 

FUNCTION


layout_prinCount := RECORD
	risk_indicators.layout_boca_shell;
	string prinLast;
	integer principalCount;
END;

layout_prinCount addPrin(clam le, daybatchpcnsr.Key_PCNSR_Address ri) := TRANSFORM
	self.prinLast := ri.lname;
	self.principalCount := if(ri.lname<>'', 1, 0);
	self := le;
END;
pcnsr1 := join(clam, daybatchpcnsr.Key_PCNSR_Address,
						left.shell_input.z5 <> '' and left.shell_input.prim_name <> '' and 
						(keyed(left.shell_input.z5=right.zip) and 
						keyed(left.shell_input.prim_name=right.prim_name) and 
						keyed(left.shell_input.prim_range=right.prim_range) and
						ut.NNEQ(left.shell_input.sec_range,right.sec_range)) and
						left.shell_input.addr_suffix=right.addr_suffix and left.shell_input.predir=right.predir and 
						left.shell_input.postdir=right.postdir,
						addPrin(left,right), left outer,
						ATMOST(
							keyed(left.shell_input.z5=right.zip) and 
							keyed(left.shell_input.prim_name=right.prim_name) and 
							keyed(left.shell_input.prim_range=right.prim_range),
							RiskWise.max_atmost
						),
						KEEP(100));
						 
pcnsr2 := group(sort(pcnsr1, seq, prinLast), seq);						 
//pcnsr3 := dedup(pcnsr2, seq, prinLast);


layout_prinCount countLast(pcnsr2 le, pcnsr2 ri) := TRANSFORM
	//self.principalCount := le.principalCount + ri.principalCount;
	self.principalCount := if(le.prinLast=ri.prinLast, le.principalCount, le.principalCount + ri.principalCount);
	self := le;
END;	
pcnsr := rollup(pcnsr2, true, countLast(left,right));


Layout_ModelOut doModel(pcnsr le) := TRANSFORM

	sysyear := if(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	
	
	// STUDENTS MODEL
	
	ver_level_st := map(~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary >= 10 and le.iid.nap_summary >= 0 => 4,
				     ~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary >= 0 and le.iid.nap_summary = 1 => 0,
				     ~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary = 9 and le.iid.nap_summary >= 0 => 2,
				     ~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary <= 8 and le.iid.nap_summary >= 0 => 1,
				     le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary >= 0 and le.iid.nap_summary >= 11 => 4,
				     le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary >= 0 and le.iid.nap_summary = 1 => 0,
				     3);
					
	add1_year_first_seen1 := (integer)(le.address_verification.input_address_information.date_first_seen[1..4]);
	add1_year_first_seen := if(add1_year_first_seen1 < 1900, -99, add1_year_first_seen1);

	lres_years_st1 := if(add1_year_first_seen = -99, -99, sysyear - add1_year_first_seen);
	lres_years_st := if(lres_years_st1 <> -99, ut.imin2(lres_years_st1, 7), -99);

	lres_code_st := map(lres_years_st = -99 => 0,
					lres_years_st = 0 => 0,
					lres_years_st <= 6 => 1,
					2);


	time_on_bureau_years_st := if(le.ssn_verification.credit_first_seen <> 0, ut.imin2((sysyear - (integer)le.ssn_verification.credit_first_seen[1..4]), 24), 0);

	time_on_bureau_code_st := map(time_on_bureau_years_st <= 0 => 0,
							time_on_bureau_years_st <= 2 => 1,
							2);

	stab_max_st := map(time_on_bureau_code_st = 0 and lres_code_st = 0 => 1, 
				    time_on_bureau_code_st = 2 and lres_code_st = 0 => 2,
				    time_on_bureau_code_st = 1 and lres_code_st = 0 => 3, 
				    time_on_bureau_code_st <= 1 and lres_code_st = 1 => 4, 
				    time_on_bureau_code_st = 2 and lres_code_st = 1 => 5, 
				    6); 
				    
	naproptree_st := map(~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 1 and 
													le.address_verification.address_history_1.naprop = 1 => 1,
					 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 1 and 
													le.address_verification.address_history_1.naprop = 0 => 2,
					 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 1 and 
													le.address_verification.address_history_1.naprop = 0 => 2,
					 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 0 and 
													le.address_verification.address_history_1.naprop <= 3 => 2,
					 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 1 and 
													le.address_verification.address_history_1.naprop >= 0 => 3,
					 ~le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop >= 0 and 
													le.address_verification.address_history_1.naprop >= 0 => 4,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 1 and 
													le.address_verification.address_history_1.naprop = 1 => 2,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 1 and 
													le.address_verification.address_history_1.naprop = 0 => 3,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 4 and 
													le.address_verification.address_history_1.naprop = 0 => 4,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 4 and 
													le.address_verification.address_history_1.naprop = 1 => 4,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 2 and 
													le.address_verification.address_history_1.naprop = 2 => 4,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop <= 2 and 
													le.address_verification.address_history_1.naprop = 2 => 4,
					 le.address_verification.input_address_information.isbestmatch and le.address_verification.input_address_information.naprop = 0 and 
													le.address_verification.address_history_1.naprop = 3 => 4,
					 5);

	property_owner_st := le.address_verification.owned.property_total > 0; 

	proptree_st := map(naproptree_st = 1 => 1,					// does he mean it could be true or false ?
				    naproptree_st = 2 => 2,
				    naproptree_st = 3 and ~property_owner_st => 3,
				    naproptree_st = 3 and property_owner_st => 4,
				    naproptree_st = 4 and ~property_owner_st => 4,
				    naproptree_st = 4 and property_owner_st => 5,
				    naproptree_st = 5 and ~property_owner_st => 6,
				    7);
				    
	principal_count_st := if(le.principalCount <> 0, ut.max2(ut.imin2(le.principalCount, 6), 2), 3.5); 	// can principal count be a decimal?
	
	
	apt_flag := trim(le.address_validation.dwelling_type) <> '';		// is this correct?

	addtype_st := map(~le.address_verification.input_address_information.isbestmatch and apt_flag => 1,
				   ~le.address_verification.input_address_information.isbestmatch and ~apt_flag => 2,
				   le.address_verification.input_address_information.isbestmatch and apt_flag => 3,
				   4);

	addtype2_st := map(principal_count_st >= 6 and addtype_st >= 1 => 1,
				    principal_count_st  = 5 and addtype_st >= 1 => 2,
				    principal_count_st <= 4 and addtype_st  = 1 => 3,
				    principal_count_st  = 4 and addtype_st  = 4 => 3,
				    principal_count_st  = 4 and addtype_st  = 3 => 3,
				    principal_count_st <= 4 and addtype_st  = 3 => 3,
				    principal_count_st  = 3 and addtype_st  = 4 => 5,
				    4);
				    
				    
	add1_census_income_st := if((integer)le.address_verification.input_address_information.census_income <> 0,
															ut.imin2(ut.max2((integer)le.address_verification.input_address_information.census_income, 30000), 75000), 30000);
	
	add1_census_education_st := if((integer)le.address_verification.input_address_information.census_education <> 0, 
															ut.imin2(ut.max2((integer)le.address_verification.input_address_information.census_education, 9), 17), 9.5);
															
															
	lien_recent_un_st := ut.imin2(1, le.bjl.liens_recent_unreleased_count);
	lien_hist_un_st := ut.imin2(1, le.bjl.liens_historical_unreleased_count);

	lienflag_st := map(lien_recent_un_st > 0 and lien_hist_un_st >= 0 => 1,
				    lien_recent_un_st >= 0 and lien_hist_un_st > 0 => 2,
				    3);
				    
				    

	voter_level_st_m := map(~le.available_sources.voter => 0.0722022,
					    le.available_sources.voter and le.ssn_verification.voter_sourced => 0.0272109,
					    le.available_sources.voter and le.name_verification.lname_voter_sourced => 0.0882740,
					    0.1148515);
					    
					    
					    
	 sm_students_score1 := 3.8165844042
						   + ver_level_st  * -0.14255838
						   + stab_max_st  * -0.096265706
						   + proptree_st  * -0.253347207
						   + addtype2_st  * -0.37439562
						   + add1_census_income_st  * -0.000010791
						   + add1_census_education_st  * -0.158813628
						   + lienflag_st  * -0.662763489
						   + voter_level_st_m  * 12.82397536;
     
	base  := 600;
     odds  := 0.2;
     point := -50;

     phat := (exp(sm_students_score1)) / (1+exp(sm_students_score1));
     sm_students_score := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);




	// NON-STUDENTS MODEL
	
	phnzip := (integer)le.phone_verification.phone_zip_mismatch;
	disconnect_flag := (integer)le.phone_verification.disconnected;
	pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);
	
	phnprob_ns := map(pnotpots  = 1 and phnzip  = 1 and disconnect_flag >= 0 => 1,
				   pnotpots >= 0 and phnzip >= 0 and disconnect_flag  = 1 => 1,
				   pnotpots  = 0 and phnzip  = 1 and disconnect_flag  = 0 => 2, 
				   pnotpots  = 1 and phnzip  = 0 and disconnect_flag  = 0 => 3,
				   4); 
				   
				   
	best_match_level_ns := map(le.address_verification.input_address_information.isbestmatch => 2,
						  le.address_verification.address_history_1.isbestmatch => 1,
						  0);

	cvitree_ns := map(le.iid.cvi <= 10 and best_match_level_ns >= 0 => 0,
				   le.iid.cvi  = 20 and best_match_level_ns >= 0 => 1,
				   le.iid.cvi <= 50 and best_match_level_ns  = 0 => 2,
				   le.iid.cvi <= 50 and best_match_level_ns  = 1 => 3,
				   le.iid.cvi  = 30 and best_match_level_ns  = 2 => 3,
				   le.iid.cvi  = 40 and best_match_level_ns  = 2 => 4,
				   5);
				   
	
	proptree_ns := map(best_match_level_ns = 0 and le.address_verification.input_address_information.naprop <= 1 and le.address_verification.address_history_1.naprop >= 0 => 0,
				    best_match_level_ns = 0 and le.address_verification.input_address_information.naprop <= 4 and le.address_verification.address_history_1.naprop >= 0 => 6,
				    best_match_level_ns = 1 and le.address_verification.input_address_information.naprop  = 1 and le.address_verification.address_history_1.naprop >= 0 => 0,
				    best_match_level_ns = 1 and le.address_verification.input_address_information.naprop <= 3 and le.address_verification.address_history_1.naprop >= 0 => 1,
				    best_match_level_ns = 1 and le.address_verification.input_address_information.naprop  = 4 and le.address_verification.address_history_1.naprop >= 0 => 3,
				    best_match_level_ns = 2 and le.address_verification.input_address_information.naprop  = 1 and le.address_verification.address_history_1.naprop >= 0 => 2,
				    best_match_level_ns = 2 and le.address_verification.input_address_information.naprop  = 0 and le.address_verification.address_history_1.naprop >= 0 => 4,
				    best_match_level_ns = 2 and le.address_verification.input_address_information.naprop <= 4 and le.address_verification.address_history_1.naprop  = 0 => 5,
				    best_match_level_ns = 2 and le.address_verification.input_address_information.naprop <= 3 and le.address_verification.address_history_1.naprop  = 1 => 5,
				    6);
				    
				    
	add1_census_income_ns := if((integer)le.address_verification.input_address_information.census_income <> 0,
																ut.imin2(ut.max2((integer)le.address_verification.input_address_information.census_income, 18000), 85000), 30000);
																
																
	lien_hist_un_ns := ut.imin2(1, le.bjl.liens_historical_unreleased_count);
	lien_hist_rel_ns := ut.imin2(1, le.bjl.liens_historical_released_count);

	lienflag_ns := (lien_hist_un_ns = 1 or lien_hist_rel_ns = 1);		
	
	
	
	today := if(le.historydate <> 999999, (string)le.historydate[1..6], ut.GetDate);
	appdate := ut.DaysSince1900(today[1..4], today[5..6], '15');
	
	dob_m := (integer)(le.shell_input.dob[5..6]);
     dob_d := (integer)(le.shell_input.dob[7..8]);
	birthdate := if(dob_m > 0 and dob_d > 0, ut.DaysSince1900(le.shell_input.dob[1..4], le.shell_input.dob[5..6], le.shell_input.dob[7..8]), -99);

	input_age := if(birthdate <> -99, (integer)((appdate - birthdate)/365.25), -99);
	//input_age = intck('year', birthdate, appdate);

	age := if(le.name_verification.age = 0, -99, le.name_verification.age);

	age_diff_ns := if(input_age <> -99 and age <> -99, ut.max2(ut.imin2(input_age - age, 10), -10), -99);
	age_diff_ns_flag := age_diff_ns not in [0,1];

	input_age2 := if(input_age = -99 and age <> -99, age, input_age);  // override the null input age if the age was found from verification, 
													       // just to be used in agediff_ssn calculation
	high_issue_dateyr := (integer)(le.ssn_verification.validation.high_issue_date[1..4]);
	ssnage := sysyear - high_issue_dateyr;
	agediff_ssn := input_age2 - ssnage;

	ssndob_ns := if(agediff_ssn <= 0, 1, 0);

	ssnage_ns_flag := if(ssnage <= 17, 1, 0);

	ssninval := if(~le.ssn_verification.validation.valid, 1, 0);

	ssnprob_ns := map(le.ssn_verification.validation.deceased => 1,
				   age_diff_ns_flag and (ssndob_ns = 1 or ssnage_ns_flag = 1 or ssninval = 1) => 1,
				   ssndob_ns = 1 => 1, 
				   age_diff_ns_flag => 2,
				   ssnage_ns_flag = 1 => 3,
				   4);
				   
				   
	current_count_ns := ut.imin2(le.vehicles.current_count, 4);		// is this what current count means
	
	
	sm_nonstudents_score1 := 4.5960653001
						   + cvitree_ns  * -0.399744971
						   + proptree_ns  * -0.187161864
						   + phnprob_ns  * -0.617280511
						   + add1_census_income_ns  * -0.000019293
						   + (integer)lienflag_ns  * 1.6391372622
						   + ssnprob_ns  * -0.410444006
						   + current_count_ns  * -0.246258094;
     

     phat_ns := (exp(sm_nonstudents_score1)) / (1+exp(sm_nonstudents_score1));
     sm_nonstudents_score := (integer)(point*(log(phat_ns/(1-phat_ns)) - log(odds))/log(2) + base);
	
	
	/******************** sm_students_score is the "default" score  *****************************************/
	sm_final_score := if(isStudent, sm_students_score, sm_nonstudents_score);

	FD9607_1_0 := map(sm_final_score <= 508 => 10,
				   sm_final_score <= 565 => 20,
				   sm_final_score <= 601 => 30,
				   sm_final_score <= 625 => 40,
				   sm_final_score <= 644 => 50,
				   sm_final_score <= 654 => 60,
				   sm_final_score <= 678 => 70,
				   sm_final_score <= 694 => 80,
				   90);
				   
	FD10to50 := ut.imin2(FD9607_1_0, 50); /* cap at 50 */

	FD3digit := map(sm_final_score < 250 => 250,
				 sm_final_score > 999 => 999,
				 sm_final_score); 
				 
	self.ri := [];     
	self.score := (string)FD3digit + '0'+(string)FD10to50 + '0'+(string)FD9607_1_0;	
	self.seq := le.seq;
END;
out := project(pcnsr, doModel(left));


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
	reasons := RiskWise.fdReasonCodes(ri, 4, OFAC, other_watchlists);
	reason34 := DATASET([{'34',risk_indicators.getHRIDesc('34')},{'00',''},{'00',''},{'00',''}],risk_indicators.Layout_Desc);
	SELF.ri := if((integer)le.score[4..6] <= 30 and reasons[1].hri='00', reason34, reasons);
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;