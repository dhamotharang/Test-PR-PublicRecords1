import FCRA, Risk_Indicators, RiskView, ut;

export Boca_Shell_Derogs_FCRA (GROUPED DATASET(layouts.layout_derogs_input) ids, 
	integer bsVersion, unsigned8 BSOptions=0, 
	boolean IncludeLnJ = false,
	GROUPED DATASET (risk_indicators.Layout_output) iid_withPersonContext,
	integer2 ReportingPeriod = 84) := function

  todaysdate := (string) risk_indicators.iid_constants.todaydate;

	checkDays(string8 d1, string8 d2, unsigned2 days) := ut.DaysApart(d1,d2) <= days and d1>d2;
	insurance_fcra_filter :=  (BSOptions & iid_constants.BSOptions.InsuranceFCRAMode) > 0;

  // Pull all derog corrections; filter by corresponding fcra-compliance
	Risk_Indicators.Layouts_Derog_Info.layout_derog_process_plus fetch_corrections(ids le) := TRANSFORM
		
		// date_filed on the override search file isn't populated (bug 58380), so we need to look at the main file to check the date
		// if bug 58380 gets fixed, we can simply do one lookup of the search file to get everything we need to count bankruptcies
		bk_corr_main := PROJECT(CHOOSEN(fcra.key_override_bkv3_main_ffid(keyed(flag_file_id IN le.bankrupt_correct_ffid)),100),
													transform(fcra.Layout_Override_bk_filing, 
													self.date_filed := left.date_filed;
													self := left;
													self := [];
													))(if(insurance_fcra_filter and chapter in ['7','13'],
														(FCRA.bankrupt_is_ok(todaysdate,date_filed, le.insurance_bk_filter, insurance_fcra_filter)),
														(FCRA.bankrupt_is_ok(todaysdate,date_filed, le.insurance_bk_filter))));
		
		bk_corr := join(bk_corr_main, fcra.key_override_bkv3_search_ffid,
										keyed(right.flag_file_id = left.flag_file_id),
										transform(fcra.Layout_Override_bk_filing, 
													self.chapter := right.chapter;
													self.disposed_date := right.discharged;
													self.filing_type := right.filing_type;
													self.disposition := right.disposition;
													self.pro_se_ind := right.pro_se_ind;
													self := left;
													), keep(1));
		// bankruptcy is special: there can be a "last" bankruptcy data in the layout; hence, find latest bk-correction											
    bk_sorted := SORT (bk_corr, -MAX ((integer)date_filed, (integer)disposed_date));
		SELF.bk_corrections := bk_sorted;  
		crim_corr := PROJECT(CHOOSEN(fcra.Key_Override_Crim.Offenders(keyed(flag_file_id IN le.crim_correct_ffid)),100),
												 transform(fcra.layout_override_crim_offender,
																	self.date_first_reported := left.process_date,
																	self.date_last_reported := left.process_date,
																	self.state_of_origin := ut.st2abbrev(left.orig_state),
																	self.off_name_type := left.pty_nm_fmt,
																	self.off_name := left.pty_nm,
																	self.dob_year := left.dob[1..4],
																	self.dob_month := left.dob[5..6],
																	self.dob_day := left.dob[7..8],
																	self.orig_ssn := left.ssn,
																	self.offender_id_num_1 := '',
																	self.offender_address_1 := left.street_address_1,
																	self.offender_address_2 := left.street_address_2,
																	self.offender_address_3 := left.street_address_3,
																	self.offender_address_4 := left.street_address_4,
																	self.offender_address_5 := left.street_address_5,
																	self.case_number := left.case_num,
																	self.case_name := '',
																	self.case_filing_date := left.case_date,
																	self.scars_marks_tattoos := left.scars_marks_tattoos_1+''+left.scars_marks_tattoos_2+''+left.scars_marks_tattoos_3+''+left.scars_marks_tattoos_4+''+left.scars_marks_tattoos_5+'',
																	self.state := left.st,
																	self := left,
																	self := [])); //offender_id_num_1, offender_id_num_type_1, offender_id_num_2, offender_id_num_type_2, sor_date_1, sor_date_type_1, sor_date_2, sor_date_type_2,
																								//sor_date_3, sor_date_type_3, sor_state, sor_offender_category, sor_risk_level_code, sor_risk_level_desc, sor_registration_type, 
																								//offender_status, case_name, ethnicity, build_type, title, cleaning_score
																	
		soff_corr := PROJECT(CHOOSEN(fcra.key_override_sexoffender.so_main(keyed(flag_file_id IN le.crim_correct_ffid)),100),
												transform(fcra.layout_override_crim_offender,
																	self.did := (string)left.did,
																	self.date_first_reported := left.dt_first_reported,
																	self.date_last_reported := left.dt_last_reported,
																	self.offender_key := left.seisint_primary_key,
																	self.vendor := left.vendor_code,
																	self.state_of_origin := ut.st2abbrev(left.orig_state),
																	self.data_type := '4', //4 represents sex offender records
																	self.dob_year := left.dob[1..4],
																	self.dob_month := left.dob[5..6],
																	self.dob_day := left.dob[7..8],
																	self.dob_alias := left.dob_aka,
																	self.offender_id_num_1 := left.sor_number,
																	self.offender_id_num_type_1 := if(left.sor_number <> '', 'SOR Number', ''),
																	self.offender_id_num_2 := left.doc_number,
																	self.offender_id_num_type_2 := if(left.doc_number <> '', 'DOC No', ''),
																	self.sor_date_1 := left.reg_date_1,
																	self.sor_date_type_1 := left.reg_date_1_type,
																	self.sor_date_2 := left.reg_date_2,
																	self.sor_date_type_2 := left.reg_date_2_type,
																	self.sor_date_3 := left.reg_date_3,
																	self.sor_date_type_3 := left.reg_date_3_type,
																	self.sor_status := left.offender_status,
																	self.sor_offender_category := left.offender_category,
																	self.sor_risk_level_code := left.risk_level_code,
																	self.sor_risk_level_desc := left.risk_description,
																	self.sor_registration_type := left.registration_type,
																	self.offender_address_1 := left.registration_address_1,
																	self.offender_address_2 := left.registration_address_2,
																	self.offender_address_3 := left.registration_address_3,
																	self.offender_address_4 := left.registration_address_4,
																	self.offender_address_5 := left.registration_address_5,
																	self.race_desc := left.race,
																	self.hair_color_desc := left.hair_color,
																	self.eye_color_desc := left.eye_color,
																	self.skin_color_desc := left.skin_tone,
																	self.state := left.st,
																	self := left,
																	self := [])); //off_name_type, off_name, orig_lname, orig_fname, orig_mname, orig_name_suffix, place_of_birth, dob_year, dob_alias,
																								//case_number, case_court, case_name, case_type, case_type_desc, case_filing_date, cleaning_score, lf, dpbc, ace_fips_st, ace_fips_county, title
		SELF.crim_corrections := (crim_corr + soff_corr)(FCRA.crim_is_ok (todaysdate, fcra_date, fcra_conviction_flag, fcra_traffic_flag));
		SELF := le;
		SELF := [];
	END;
	w_corrections := nofold(PROJECT (ids, fetch_corrections(LEFT)));

//new
	Bankruptcy := Risk_Indicators.Boca_Shell_Bankruptcy_FCRA(bsVersion, BSOptions, w_corrections); 
	BankLiens := if(bsVersion >= 3, 
		Risk_Indicators.Boca_Shell_Liens_FCRA_tmsid(bsVersion, BSOptions, Bankruptcy), 
		Risk_Indicators.Boca_Shell_Liens_FCRA(bsVersion, BSOptions, Bankruptcy)); 
 BankLiensCrim := Risk_Indicators.Boca_Shell_Crim_FCRA(bsVersion, BSOptions, BankLiens); 
	BankLiensCrimSO := Risk_Indicators.Boca_Shell_SO_FCRA(bsVersion, BSOptions, BankLiensCrim); 

	BankLiensCrimSO_LNJ :=	Risk_Indicators.Boca_Shell_Liens_LnJ_FCRA(bsVersion, BSOptions, w_corrections, 
		IncludeLnJ, iid_withPersonContext, ReportingPeriod);								
	DerogsLNJ := JOIN(BankLiensCrimSO, BankLiensCrimSO_LNJ,
					LEFT.Did = Right.Did,
					RiskView.Transforms.GetLnJInfo(LEFT, RIGHT),
					LEFT OUTER);
	// output(iid_withPersonContext, named('derogIIDPC'));		
	// output(Bankruptcy, named('Bankruptcy'));
	// output(BankLiens, named('BankLiens'));
	// output(BankLiensCrim, named('BankLiensCrim'));
	// output(BankLiensCrimSO, named('BankLiensCrimSO'));
	// output(BankLiensCrimSO_LNJ, named('BankLiensCrimSO_LNJ'));
	// output(w_corrections, named('w_correctionsbb'));
	// output(DerogsLNJ, named('DerogsLNJ'));
	// output(DerogsLNJ2, named('DerogsLNJ2'));
	// output(w_corrections, named('input'));
	return group(DerogsLNJ, seq);

end;