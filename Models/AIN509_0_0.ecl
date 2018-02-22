import ut, risk_indicators, RiskWise, std;

export AIN509_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC=true, boolean useTweak=true) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM
	
	sysyear := IF(le.historydate <> 999999, (integer)(((string)le.historydate)[1..4]), (integer)((STRING)Std.Date.Today())[1..4]);
	today := if(le.historydate <> 999999, ((string)le.historydate)[1..6] + '01', (STRING8)Std.Date.Today());
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);
	
	
	/* Age */
	byr := le.shell_input.dob[1..4];
	bmn := le.shell_input.dob[5..6];
	bdy := le.shell_input.dob[7..8];    	    
	birthdt := if(le.shell_input.dob = '', 0, ut.DaysSince1900(byr, bmn, bdy));
	in_age := if(birthdt = 0, 0, (integer)((today1900 - birthdt)/365.25));
	
	
	agevar := if(in_age <= 10, le.name_verification.age, in_age);
	
	agevar2 := map(agevar < 15 => 25,
				agevar > 50 => 50,
				agevar);
	
	agevar2l := log(agevar2) / 0.434294481903;
	
	
	
	
	/* Census */
	
	cenage := map(le.address_verification.input_address_information.census_age = '' => 51,
			    (integer)le.address_verification.input_address_information.census_age <= 20 => 20,
			    (integer)le.address_verification.input_address_information.census_age >= 51 => 51,
			    (integer)le.address_verification.input_address_information.census_age);
	
	ceninc := map(le.address_verification.input_address_information.census_income = '' => 70000,
			    (integer)le.address_verification.input_address_information.census_income <= 19999 => 19999,
			    (integer)le.address_verification.input_address_information.census_income >= 90000 => 90000,
			    (integer)le.address_verification.input_address_information.census_income);
	
	cenedu := map(le.address_verification.input_address_information.census_education = '' => 15,
			    (integer)le.address_verification.input_address_information.census_education <= 9 => 9,
			    (integer)le.address_verification.input_address_information.census_education >= 17 => 17,
			    (integer)le.address_verification.input_address_information.census_education);
	
	ceninclog := log(ceninc) / 0.434294481903;
	
	
	/* Relatives */
	
	rel_incomem := map(le.relatives.relative_incomeover100_count > 0  => 0.0108744,
				    le.relatives.relative_incomeunder100_count > 0 => 0.0130442,
				    le.relatives.relative_incomeunder75_count > 0  => 0.0197242,
				    le.relatives.relative_incomeunder50_count > 0  => 0.0259928,
				    le.relatives.relative_incomeunder25_count > 0  => 0.0259928,
				    0.0465306);
	
	rel_criminal_flag := if(le.relatives.relative_criminal_count > 0, 1,0);
	rel_bk_flag := if(le.relatives.relative_bankrupt_count > 0, 1,0);
	
	rel_crimbkm := map(rel_criminal_flag = 1 and  rel_bk_flag = 1 => 0.0294906,
				    rel_criminal_flag = 1 or   rel_bk_flag = 1 => 0.0272161,
				    0.0165794);
	
	rel_prop_tot :=  le.relatives.ambiguous.relatives_property_count + le.relatives.owned.relatives_property_count + le.relatives.sold.relatives_property_count;
	
	rel_prop_auto := map(rel_prop_tot <= 0 => 0,
					 rel_prop_tot <= 1 => 1,
					 rel_prop_tot <= 2 => 2,
					 3);
	
	rel_prop_autom := map(rel_prop_auto = 0 => 0.0319350,
					  rel_prop_auto = 1 => 0.0189383,
					  rel_prop_auto = 2 => 0.0160715,
					  0.0113957);
	
	/* Phone Prob */
	
	phnzip := if(le.iid.nap_summary <= 6 and le.phone_verification.phone_zip_mismatch, 1,0);
	
	telcordia_typen :=  (integer)le.phone_verification.telcordia_type;
	
	pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0,1);
	
	phnprobm := map(pnotpots = 1     => 0.0393245,
				 le.phone_verification.disconnected => 0.0290825,
				 phnzip = 1       => 0.0289256,
				 0.0145626);
	
	
	/* Criminal */
	
	crimx := if(le.bjl.criminal_count >= 1, 1,le.bjl.criminal_count);
	
	/* lien  */
	
	lien_recent_un := if(le.bjl.liens_recent_unreleased_count <= 2, le.bjl.liens_recent_unreleased_count, 2);
     lien_hist_un := if(le.bjl.liens_historical_unreleased_count <= 2, le.bjl.liens_historical_unreleased_count, 2);
     lien_recent_rel := if(le.bjl.liens_recent_released_count <= 2, le.bjl.liens_recent_released_count, 2);
	lien_hist_rel := if(le.bjl.liens_historical_released_count <= 2, le.bjl.liens_historical_released_count, 2);

		
	lienflagm := map(lien_recent_un = 2   => 0.0545455,
				  lien_recent_un = 1   => 0.0545455,
				  lien_hist_un = 2     => 0.0425273,
				  lien_hist_un = 1     => 0.0384749,
				  lien_recent_rel >= 1 => 0.0384749,
				  lien_hist_rel >= 1   => 0.0211111,
				  0.0187482);
	
	/* Bk Flag */
	
	bkflagm := map(le.bjl.filing_count >= 2 => 0.0566298,
				le.bjl.bankrupt and (trim(Stringlib.stringtouppercase(le.bjl.disposition))) in ['DISMISSED','CASE DISMISSED'] => 0.0477612,
				le.bjl.bankrupt => 0.0308811,
				0.0188952);
	
	/* Prop tree */
	
	proptreem := map(le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 4 and 
								le.address_verification.owned.property_total > 2 => 0.0030426,
				  le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 4 and 
								le.address_verification.owned.property_total <= 2 => 0.0072184,
				  le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 3 => 0.0084801,
				  le.address_verification.input_address_information.naprop = 4 => 0.0108997,
				  le.address_verification.input_address_information.naprop <= 2 and le.address_verification.address_history_1.naprop <= 2 and 
								le.address_verification.owned.property_total >= 1 => 0.0159395,
				  le.address_verification.input_address_information.naprop <= 2 and le.address_verification.address_history_1.naprop <= 2 and 
								le.address_verification.owned.property_total = 0 => 0.0335708,
				  le.address_verification.address_history_1.naprop = 4 => 0.0159395,
				  0.0232860);
	
	
	
	/* SSN Problem */
	
	high_issue_dateyr := (integer)(((STRING)le.ssn_verification.validation.high_issue_date)[1..4]);
	
	ssnage := sysyear - high_issue_dateyr;
	
	agediff := agevar2 - ssnage;
	
	ssndob2 := map(agediff <= -1000 => 0,
				agediff < 0 => 1,
				0);
	
	ssnage10 := if(ssnage <= 10, 1,0);
	
	ssninval := if(~le.ssn_verification.validation.valid, 1,0);
	
	ssnprob := if(le.input_validation.ssn and (ssninval = 1 or (ssndob2 = 1 and birthdt <> 0) or ssnage10 = 1), 1, 0);
	
	
	/* CVIbest */
	
	cvibestm := map(le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch and le.iid.nas_summary in [1,4,7,9] => 0.0552258,
				 le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch => 0.0432990,
				 le.iid.cvi = 30 and ~le.address_verification.input_address_information.isbestmatch  => 0.0320687,
				 le.iid.cvi <= 30 and le.address_verification.input_address_information.isbestmatch  => 0.0250698,
				 le.iid.cvi >= 40 and ~le.address_verification.input_address_information.isbestmatch => 0.0250698,
				 le.iid.cvi = 40 and le.address_verification.input_address_information.isbestmatch   => 0.0173471,
				 0.0155638);
	
	
	/* Lrescode */
	
	add1_year_first_seen := (integer)(((STRING)le.address_verification.input_address_information.date_first_seen)[1..4]);
	
	lres_years := if(add1_year_first_seen = 0, 0,(sysyear - add1_year_first_seen));
	
	lres_codem := map(lres_years <= 0  => 0.0387891,
				   lres_years <= 1  => 0.0316581,
				   lres_years <= 4  => 0.0227616,
				   lres_years <= 9  => 0.0148338,
				   lres_years <= 16 => 0.0121888,
				   0.0085807);
	
	
	/* credit first seen */
	
	cred_fs_pop := if(le.ssn_verification.credit_first_seen = 0, 1,0);
	
	
	/* source count TU */
	
	source_cnt_tum := map(~le.ssn_verification.tu_sourced and le.name_verification.source_count <= 1 and le.name_verification.lname_utility_sourced  => 0.0610143,
					  ~le.ssn_verification.tu_sourced and le.name_verification.source_count <= 1 and ~le.name_verification.lname_utility_sourced => 0.0442316,
					  ~le.ssn_verification.tu_sourced and le.name_verification.source_count = 2 => 0.0408163,
					  ~le.ssn_verification.tu_sourced and le.name_verification.source_count = 3 => 0.0360436,
					  le.ssn_verification.tu_sourced and le.name_verification.source_count <= 2 => 0.0259789,
					  ~le.ssn_verification.tu_sourced and le.name_verification.source_count = 4 => 0.0259789,
					  le.ssn_verification.tu_sourced and le.name_verification.source_count <= 4 => 0.0189457,
					  0.0157850);
	
	
	/* ADLSSN */
	
	adlssn3 := if(le.ssn_verification.adlperssn_count >= 3, 3,le.ssn_verification.adlperssn_count);

	
	
	test := -0.298198052
		   + phnprobm  * 26.530930835
		   + proptreem  * 25.990860988
		   + ssnprob  * 0.2855241964
		   + source_cnt_tum  * 9.230429926
		   + cvibestm  * 11.307704746
		   + cenage  * -0.015137561
		   + cenedu  * -0.119707329
		   + ceninclog  * -0.2355524
		   + rel_incomem  * 16.004747665
		   + rel_crimbkm  * 36.435272597
		   + rel_prop_autom  * 12.375709593
		   + crimx  * 0.6498637682
		   + lienflagm  * 26.306606862
		   + bkflagm  * 21.213918277
		   + agevar2l  * -0.953509812
		   + lres_codem  * 13.408301232
		   + cred_fs_pop  * -0.310966587
		   + adlssn3  * 0.1379856042;
	
	test1 := (exp(test)) / (1+exp(test));
	phat :=  test1;
	
	base  := 608.0;
	odds  := 0.04;
	point := -60.0;
	
	test4_scr := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
	
	/* Tweak */
	auto_scr2 := (integer)((230/526*test4_scr) + 390);
	
	auto_scr1 := MAP(auto_scr2 < 0 => 0,
				  auto_scr2 > 999 => 999,
				  auto_scr2);
	
	
	//**** scale fix 2/20/06 ****
     auto_scr := IF(auto_scr1 <= 498, auto_scr1 + 150, (integer)(.00104*(auto_scr1*auto_scr1) - (1.0375*auto_scr1) + 908.35484));
	

	self.score := if(useTweak, intformat(auto_scr,3,1), intformat(test4_scr,3,1));
	self.seq := le.seq;
	self.ri := [];
END;
out := project(clam, doModel(left));


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
	self.ri := RiskWise.mmReasonCodes(ri, 4, OFAC, false, TRUE);
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right));

RETURN (final);

END;