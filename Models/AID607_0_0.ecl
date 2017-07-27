import ut, risk_indicators, RiskWise, RiskWiseFCRA;

export AID607_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean OFAC, boolean inCalif) := 

FUNCTION


Layout_ModelOut doModel(clam le) := TRANSFORM

	sysyear := IF(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));
	today := if(le.historydate <> 999999, (string)le.historydate[1..6] + '01', ut.GetDate);
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);


	byr := le.shell_input.dob[1..4];
	bmn := le.shell_input.dob[5..6];
	bdy := le.shell_input.dob[7..8];    	    
	birthdt := if(le.shell_input.dob = '', 0, ut.DaysSince1900(byr, bmn, bdy));
	agevar := if(birthdt = 0, 0, (integer)((today1900 - birthdt)/365.25));
	
	// new code
	low_issue_dateyr := (integer)((string)le.ssn_verification.validation.low_issue_date[1..4]);
	ssnage_low := if(low_issue_dateyr = 0, 0, sysyear - low_issue_dateyr);
	
	agevar3 := map(birthdt = 0 and ssnage_low <> 0 => ssnage_low,
				agevar = 0 => 36,
				agevar <= 10 => 15,
				agevar);
				
	agevar2 := map(agevar3 < 15 => 25,
				agevar3 > 50 => 50,
				agevar3);
				 
	agevar2l := log(agevar2)/ 0.434294481903;
	
	/* Phone Prob */

     phnzip := if(le.iid.nap_summary <= 6 and le.phone_verification.phone_zip_mismatch, 1, 0);

     pnotpots := if(le.phone_verification.telcordia_type in ['00','50','51','52','54'], 0, 1);

	phnprobm := map(pnotpots = 1 => 0.0423543,
				 le.phone_verification.disconnected => 0.0423543,
				 phnzip = 1 => 0.0300573,
				 0.0174321);


	/* Criminal */

     crimx := ut.imin2(1, le.bjl.criminal_count);

	/* lien  */

     lien_recent_un := ut.imin2(2, le.bjl.liens_recent_unreleased_count);
     lien_hist_un := ut.imin2(2, le.bjl.liens_historical_unreleased_count);
     lien_recent_rel := ut.imin2(2, le.bjl.liens_recent_released_count);
     lien_hist_rel := ut.imin2(2, le.bjl.liens_historical_released_count);

     lienflagm := map(lien_recent_un = 2 => 0.0506520,
				  lien_recent_un = 1 => 0.0506520,
				  lien_hist_un = 2 => 0.0482433,
				  lien_hist_un = 1 => 0.0358185,
				  lien_recent_rel >= 1 => 0.0358185,
				  lien_hist_rel >= 1 => 0.0188518,
				  0.0184164);


	/* Bk Flag */

     bkflag := map(le.bjl.filing_count >= 2 => 3,
			    le.bjl.bankrupt and trim(StringLib.StringToUpperCase(le.bjl.disposition)) in ['DISMISSED','CASE DISMISSED'] => 2,
			    le.bjl.bankrupt => 1,
			    0);



	/* Prop tree */

	proptreem := map(le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 4 and 
								le.address_verification.owned.property_total >= 2 => 0.0029703,
				  le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 4 and 
								le.address_verification.owned.property_total < 2 =>  0.0075901,
				  le.address_verification.input_address_information.naprop = 4 and le.address_verification.address_history_1.naprop = 3 => 0.0088106,
				  le.address_verification.input_address_information.naprop = 4 => 0.0121761,
				  le.address_verification.input_address_information.naprop <= 2 and le.address_verification.address_history_1.naprop <= 2 and 
								le.address_verification.owned.property_total >= 1 => 0.0163578,
				  le.address_verification.input_address_information.naprop <= 2 and le.address_verification.address_history_1.naprop <= 2 and 
								le.address_verification.owned.property_total = 0 => 0.0236860,
				  le.address_verification.address_history_1.naprop = 4 => 0.0163578,
				  0.0236860);


	/* SSN Problem */

     high_issue_dateyr := (integer)(le.ssn_verification.validation.high_issue_date[1..4]);

     ssnage := sysyear - high_issue_dateyr;

     agediff := agevar2 - ssnage;

     ssndob2 := map(agediff <= -1000 => 0,
				agediff < 0 => 1,
				0);

     ssnage10 := if(ssnage <= 10, 1, 0);
     ssninval := if(~le.ssn_verification.validation.valid, 1, 0);

	ssnprob := if(le.input_validation.ssn and (ssninval = 1 or (ssndob2 = 1 and birthdt <> 0) or ssnage10 = 1), 1, 0);


	/* CVIbest */

     cvibestm := map(le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch and (string)le.iid.nas_summary in ['1','4','7','9'] => 0.0525544,
				 le.iid.cvi <= 20 and ~le.address_verification.input_address_information.isbestmatch => 0.0525544,
				 le.iid.cvi = 30 and ~le.address_verification.input_address_information.isbestmatch => 0.0276498,
				 le.iid.cvi <= 30 and le.address_verification.input_address_information.isbestmatch => 0.0270856,
				 le.iid.cvi >= 40 and ~le.address_verification.input_address_information.isbestmatch => 0.0270856,
				 le.iid.cvi = 40 and le.address_verification.input_address_information.isbestmatch => 0.0184629,
				 0.0154756);


	/* source count TU */

     source_cnt_tum := map(le.name_verification.source_count <= 1 => 0.0323347,
					  le.name_verification.source_count = 2 => 0.0194636,
					  le.name_verification.source_count = 3 => 0.0169275,
					  le.name_verification.source_count = 4 => 0.0135116,
					  0.0114376);
					  
					  
	/* ADLSSN */

     adlssn3 := map(le.ssn_verification.adlperssn_count = 0 => 3,
				le.ssn_verification.adlperssn_count >= 3 => 3,
				le.ssn_verification.adlperssn_count);


	/* ver_len */

     add1_year_first_seen := (integer)(le.address_verification.input_address_information.date_first_seen[1..4]);

     lres_years := if(add1_year_first_seen = 0, 0, ut.imin2((sysyear - add1_year_first_seen), 25));

     lres_code := map(lres_years <= 0 => 0,
				  lres_years <= 1 => 1,
				  lres_years <= 4 => 2,
				  lres_years <= 9 => 3,
				  lres_years <= 16 => 4,
				  5);


     cred_fs_pop := if(le.ssn_verification.credit_first_seen = 0, 1, 0);

     time_on_bureau_years := if(cred_fs_pop = 1, -1, sysyear - (integer)(le.ssn_verification.credit_first_seen[1..4]));

     credit_history := if(((integer)le.name_verification.fname_credit_sourced + (integer)le.name_verification.lname_credit_sourced + 
							(integer)le.address_verification.input_address_information.credit_sourced) = 0, 0, 1);


     time_on_bureau_code := map(time_on_bureau_years = -1 and credit_history = 0 => 1,
						  time_on_bureau_years = -1 and credit_history = 1 and agevar2 > 30 => 6,
						  time_on_bureau_years = -1 and credit_history = 1 and agevar2 <= 30 => 1,
						  time_on_bureau_years <= 3 => 1,
						  time_on_bureau_years <= 9 => 2,
						  time_on_bureau_years <= 14 => 3,
						  time_on_bureau_years <= 17 => 4,
						  5);


     ver_len1 := -2.646353676
                  + time_on_bureau_code  * -0.180194047
                  + lres_code  * -0.26802435
                  + cred_fs_pop  * -0.254681875;
     
     ver_len2 := (exp(ver_len1)) / (1+exp(ver_len1));
     ver_len3 := round(1000 * ver_len2);
	ver_len4 := ver_len3 / 10;


	ver_len := if(ver_len4 <= 1.1, 1.1, ver_len4);

     fcra := -4.182751593
                  + phnprobm  * 22.407512827
                  + ver_len  * 0.180507342
                  + proptreem  * 41.624136756
                  + ssnprob  * 0.2559584097
                  + source_cnt_tum  * 20.583051757
                  + cvibestm  * 12.061861062
                  + crimx  * 0.6011878946
                  + lienflagm  * 33.296181836
                  + agevar2l  * -0.981887127
                  + 0.0196535  * 15.206418525
                  + adlssn3  * 0.2052786127
                  + bkflag  * 0.3795690102;
     
     fcra1 := (exp(fcra)) / (1+exp(fcra));
     phat := fcra1;
	
	
	/* RiskView Transformation */

	base := 703;
	odds := 0.047619048;
	point := -40;

	RiskView := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base) - 1;
	RiskView2 := if(RiskView >= 810 and adlssn3 >= 2, RiskView - 23, RiskView);
	
	AID607 := map(RiskView2 < 501 => 501,
			    RiskView2 > 900 => 900,
			    RiskView2);
	
	
	self.ri := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	self.score := if(self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)AID607);
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
	isCalifornia := inCalif and ((integer)(boolean)ri.combo_firstcount+(integer)(boolean)ri.combo_lastcount+
								(integer)(boolean)ri.combo_addrcount+(integer)(boolean)ri.combo_hphonecount+
								(integer)(boolean)ri.combo_ssncount+(integer)(boolean)ri.combo_dobcount) < 3;
								
	self.ri := if(le.ri[1].hri <> '00', le.ri, RiskWise.mmReasonCodes(ri, 4, OFAC, isCalifornia));
	self.score := if((integer)self.ri[1].hri = 35, '000', le.score);
	self := le;
END;
final := join(out, iid, left.seq=right.seq, addReasons(left, right), left outer);

RETURN (final);

END;