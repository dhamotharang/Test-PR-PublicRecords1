import iesp, risk_indicators, fcra, doxie, ut, riskview, RiskWiseFCRA;

// for now this only supports a single input record -- that's what the fcradataservice restricts too...

EXPORT RiskViewReport_RptFunction(dataset (risk_indicators.Layout_Boca_Shell) bocashell, integer BocaShellVersion, string50 DataRestrictionMask, string50 intendedPurpose) := FUNCTION
		
		returnLayout := RECORD
			unsigned4 Seq;
			iesp.riskviewreport.t_RiskViewReport;
		END;

	  bs := bocashell[1];
		
		history_date := bs.historydate;
		
		dids_input := dataset ([bs.did], doxie.layout_references);
		nss := ut.getNonSubjectSuppression();
		intendedPurposeUpper := StringLib.StringToUpperCase(TRIM(intendedPurpose));
		isDirectToConsumerPurpose := intendedPurposeUpper = Riskview.Constants.directToConsumer;
		boolean inquiryRestrict := DataRestrictionMask[Risk_Indicators.iid_constants.posInquiriesRestriction] = '1'; 
		
    ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=bs.shell_Input.ssn, datalib.NameMatch (bs.shell_Input.fname, bs.shell_Input.mname, bs.shell_Input.lname, fname, mname, lname)<3), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
    did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)bs.did)), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
    flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
		flagrecs := CHOOSEN (dedup (flags, ALL), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);

// Watercraft information...
		watercrafts := RiskWiseFCRA._watercraft_data (dids_input, flagrecs, nss);
		watercraftreport := dedup(sort(watercrafts.details, registration_number, -registration_date), registration_number);
		
		iesp.riskviewreport.t_RvReportPersonalPropertyRecord formatwatercraft(watercraftreport l) := TRANSFORM
				self.seq := '';
				self._Type := 'Watercraft';
				self.Description := l.watercraft_make_description;
				self.Id := l.registration_number;
				self.RegistrationDate := iesp.ECL2ESP.toDate((integer)l.registration_date);
				self.RegistrationState := l.st_registration;				
		END;
// Aircraft information...
		aircrafts := RiskWiseFCRA._FAA_data (dids_input, flagrecs);
		aircraftreport := dedup(sort(aircrafts.aircrafts, serial_number, -last_action_date), serial_number);
		
		iesp.riskviewreport.t_RvReportPersonalPropertyRecord formataircraft(aircraftreport l) := TRANSFORM
				self.seq := '';
				self._Type := 'Aircraft';
				self.Description := trim(l.aircraft_mfr_name) + ' ' + trim(l.model_name); 
				self.Id := l.serial_number; // verify this
				self.RegistrationDate := iesp.ECL2ESP.toDate((integer)l.cert_issue_date); 
				self.RegistrationState := l.st;
		END;

// Estimated Income
		estimatedincome := bs.estimated_income;

// Filing Records -- liens
		RiskWiseFCRA._Lien_data(dids_input, flagrecs, liens_main_, liens_party_, nss, history_date);
		liensdata := join(liens_main_, liens_party_, Left.tmsid = Right.tmsid and Left.rmsid = Right.rmsid);
		
		iesp.riskviewreport.t_RvReportFilingRecord formatliens(liensdata l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.RecordType := l.orig_filing_type;
			self.Description := if(TRIM(l.eviction)='Y', 'Eviction', l.filing_type_desc);
			self.Status := if(TRIM(l.release_date)<>'', 'Released', '');
			self.FilingDate := iesp.ECL2ESP.toDate((integer)l.orig_filing_date);
			laDate := if( (integer)l.date_last_seen > (integer)l.release_date, (integer)l.date_last_seen, (integer)l.release_date);
			self.LastActionDate := iesp.ECL2ESP.toDate(laDate); 
		END;
// Bankruptcies................		
		RiskWiseFCRA._Bankruptcy_data(dids_input, flagrecs, bankruptcy_search, bankruptcy_, bk_courts_, history_date, bk_withdraws_);
    insurancemode := false;
    bankruptcies := join(bankruptcy_search(trim(chapter) in risk_indicators.iid_constants.set_permitted_bk_chapters(BocaShellVersion, insurancemode) ), 
												bankruptcy_, (integer)left.did = dids_input[1].did and left.tmsid = right.tmsid);		
		
		iesp.riskviewreport.t_RvReportBankruptcyRecord formatbankruptcies(bankruptcies l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.Name := Models.RiskViewReport_data.esdlName(l.orig_name, l.fname, l.mname, l.lname, '', '');
			self.CaseNumber := l.case_number;
			self.Chapter := l.chapter;
			self.CourtName := l.court_name;
			self.CourtLocation := l.court_location;
			self.Disposition := l.disposition;
			self.FilingDate := iesp.ECL2ESP.toDate((integer)l.date_filed);
			self.LastActionDate := iesp.ECL2ESP.toDate((integer)l.date_last_seen);
		end;
// Criminal...............
		criminalrecs := RiskViewReport_data.criminalrecs(dids_input, flagrecs);		
		iesp.riskviewreport.t_RvReportCriminalRecord formatcriminal(criminalrecs l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.Name := Models.RiskViewReport_data.esdlName(l.offender.pty_nm, l.offender.fname, l.offender.mname, l.offender.lname, '', '');
			self.Address := Models.RiskViewReport_data.esdlAddress(l.offender.prim_range, l.offender.predir, l.offender.prim_name, l.offender.addr_suffix, l.offender.postdir, l.offender.unit_desig, l.offender.sec_range, '','', l.offender.p_city_name, l.offender.st, l.offender.zip5, l.offender.zip4, '','','');
			self.DOB := iesp.ECL2ESP.toDate((integer)l.offender.dob);
			self.SSN := l.offender.ssn;
			self.State := l.offender.orig_state;
			self.CaseNumber := l.offender.case_num;
			dt := if( l.offense.fcra_date <> '', l.offense.fcra_date, l.offender.fcra_date);
			typ :=if( l.offense.offense_score <> '', l.offense.offense_score, l.offender.offense_score);
			self.OffenseDate := iesp.ECL2ESP.toDate((integer)dt);
			self.Charge := l.offense.chg;
			self.LevelDegree := l.offense.off_lev;
			self._Type:= map(typ ='F' => 'Felony',
											 typ ='M' => 'Misdemeanor',
											 'Unknown'
												);
			self := [];
		end;

// student .....................
		amstudentrecs := RiskViewReport_data.americanstudentrecs(dids_input, flagrecs);
		alloystudentrecs := RiskViewReport_data.alloystudentrecs(dids_input, flagrecs);
		
		iesp.riskviewreport.t_RvReportEducationRecord formatamstudent(amstudentrecs l):= TRANSFORM
			self.Seq := '';
			self.Name := Models.RiskViewReport_data.esdlName(l.full_name, l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.z5, l.zip4, '','','');
			self.SchoolCode := l.code_exploded;
			self.SchoolType := l.type_exploded;
			self.SchoolName := l.ln_college_name;
			self.FieldOfStudy := l.college_major_exploded;
		END;
		iesp.riskviewreport.t_RvReportEducationRecord formatalloystudent(alloystudentrecs l):= TRANSFORM
			self.Seq := '';
			self.Name := Models.RiskViewReport_data.esdlName('', l.clean_fname, l.clean_mname, l.clean_lname, l.clean_name_suffix, l.clean_title);
			self.Address := Models.RiskViewReport_data.esdlAddress(l.clean_prim_range, l.clean_predir, l.clean_prim_name, l.clean_addr_suffix, l.clean_postdir, l.clean_unit_desig, l.clean_sec_range, '','', l.clean_p_city_name, l.clean_st, l.clean_zip5, l.clean_zip4, '','','');
			self.SchoolCode := l.code_exploded;
			self.SchoolType := l.type_exploded;
			self.SchoolName := l.ln_college_name;
			self.FieldOfStudy := l.college_major_exploded;
		END;

//  License.......................Prof_Lic
		licenserecs := RiskWiseFCRA._Prof_License_data(dids_input, flagrecs, isDirectToConsumerPurpose);
		
		iesp.riskviewreport.t_RvReportLicenseRecord formatlicenserecs(licenserecs l, integer c):= TRANSFORM
			self.Seq := (string)c;
			self.Name := Models.RiskViewReport_data.esdlName(l.orig_name, l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.p_city_name, l.st, l.zip, l.zip4, '','','');
			self._Type := l.license_type;
			self.LastReported := iesp.ECL2ESP.toDate((integer)l.date_last_seen);
			self.Source := l.vendor;
		END;

//  Business Associates .............PAW
		pawrecs := RiskWiseFCRA._PAW_data(dids_input, flagrecs);
		
		iesp.riskviewreport.t_RvReportBusinessAssociationRecord formatpeopleatwork(pawrecs l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.Name := Models.RiskViewReport_data.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city, l.state, l.zip, l.zip4, '','','');
			self.Title := l.company_title;
			self.Company := l.company_name;
			self.CompanyAddress := Models.RiskViewReport_data.esdlAddress(l.company_prim_range, l.company_predir, l.company_prim_name, l.company_addr_suffix, l.company_postdir, l.company_unit_desig, l.company_sec_range, '','', l.company_city, l.company_state, l.company_zip, l.company_zip4, '','','');
			self.Status := l.company_status;
			self.FirstReport := iesp.ECL2ESP.toDate((integer)l.dt_first_seen);
			self.LastReport := iesp.ECL2ESP.toDate((integer)l.dt_last_seen);
		END;

//  Inquiry ...................
		inquiryrecs1 := RiskViewReport_data.inquiryrecs(dids_input, flagrecs); // these will need to be filtered...
		inquiryrecs := inquiryrecs1(permissions.fcra_purpose in ['100','164', '106'] );
		iesp.riskviewreport.t_RvReportCreditInquiryRecord formatinquiryrecs(inquiryrecs l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.Date := iesp.ECL2ESP.toDate((integer)l.search_info.datetime);
			self._Type := map( l.permissions.fcra_purpose = '100' => 'EXTENSION OF CREDIT',
												 l.permissions.fcra_purpose = '164' => 'COLLECTIONS',
												 l.permissions.fcra_purpose = '106' => 'DEMAND DEPOSIT / CHECKING',
												 'UNKNOWN'); // these are filtered -- this will not happen.
			indstr := StringLib.StringToUpperCase(TRIM(l.bus_intel.industry));
			self.Industry := map( indstr = 'PAY DAY' => 'SHORT TERM LENDING',
														indstr = 'AUTO' => 'AUTO LENDING',
														indstr = 'AUTO - CAPTIVE' => 'AUTO LENDING',
														indstr = 'COMMUNICATIONS' => 'TELECOMMUNICATIONS',
														indstr = 'UTILITIES' => 'UTILITIES',
														indstr = 'COLLECTIONS' => 'COLLECTIONS',
														'OTHER');
		END;

// Short term loans.............
		impulserecs := RiskViewReport_data.impulserecs(dids_input, flagrecs, isDirectToConsumerPurpose);
		thriverecs := RiskViewReport_data.thriverecs(dids_input, flagrecs); // need to be filtered by 'PD' src (payday) which is really 'T$'
		iesp.riskviewreport.t_RvReportLoanOfferRecord formatimpulserecs(impulserecs l) := TRANSFORM
			self.Seq := '';
			self.Name := Models.RiskViewReport_data.esdlName('', l.cln_fname, l.cln_mname, l.cln_lname, l.cln_name_suffix, '');
			// impulse doesn't have the full clean address, but esdlAddress will supply it.
			self.Address := Models.RiskViewReport_data.esdlAddress( '','','','','','','', l.address1, l.address2, l.city, l.state, l.zip, '', '','','');
			self.Date := iesp.ECL2ESP.toDate((integer)(l.lastmodified[1..4]+l.lastmodified[6..7]+l.lastmodified[9..10]));
		END;
		iesp.riskviewreport.t_RvReportLoanOfferRecord formatthriverecs(thriverecs l) := TRANSFORM 
			self.Seq := '';
			self.Name := Models.RiskViewReport_data.esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, l.unit_desig, l.sec_range, l.orig_addr,'', l.p_city_name, l.st, l.zip, l.zip4, '','','');
			self.Date := iesp.ECL2ESP.toDate((integer)(l.dt_first_seen));
		END;
		fixdate(d) := map( d = 0 => iesp.ECL2ESP.toDate(0), // if zero, leave blank
											 d < 10000 => iesp.ECL2ESP.toDate((d*10000) + 101), // no month / day
											 d < 1000000 => iesp.ECL2ESP.toDate((d*100) + 1), // no day
											 iesp.ECL2ESP.toDate(d));
		
// Property .......................
		propertyrecs := RiskViewReport_data.propertyrecs(dids_input, flagrecs);
		iesp.riskviewreport.t_RvReportRealPropertyRecord formatpropertyrecs(propertyrecs l, integer c) := TRANSFORM
			self.Seq := (string)c;
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city_name, l.st, l.zip, '', '','','');
			self.Status := if( l.saledate='', 'Current', 'Previous');
			self.PurchaseDate := iesp.ECL2ESP.toDate((integer)(l.purchasedate));
			self.PurchasePrice := l.purchaseprice;
			self.SaleDate := iesp.ECL2ESP.toDate((integer)(l.saledate));
			self.SalePrice := l.saleprice;
			self.AssessedValue := l.assessmentprice;
			self.AssessedDate := fixdate((integer)(l.assessmentdate));
		END;

// Consumer Statement .............
		ConsumerStatements := RiskViewReport_data.consumerstmt(bocashell);

// AddressHistory .................
		addrHistory := RiskViewReport_data.addrHistory(bocashell, flagrecs, BocaShellVersion, DataRestrictionMask);
		iesp.riskviewreport.t_RvReportAddressHistoryRecord formathistoryrecs(addrHistory l, integer c) := TRANSFORM
			self.Seq := (string)c;;
			self.Address := Models.RiskViewReport_data.esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city_name, l.st, l.zip, l.zip4, '','','');
			self.from := fixdate(l.dt_first_seen);
			self.to := fixdate(l.dt_last_seen);
			self.Characteristics := l.AddrCharacteristics;
			self.LandUse := l.land_use;
			self.AssessedValue := l.assessmentprice;
			self.AssessedDate :=fixdate((integer)(l.assessmentdate));
		END;
		
// Build final report record							
		returnLayout makereport(risk_indicators.Layout_Boca_Shell l) := TRANSFORM
			self.seq := l.seq;
			self.Summary := Models.RiskViewReport_data.summary(addrHistory, l, inquiryRestrict);
			self.AddressHistories := project(addrHistory, formathistoryrecs(left, counter));
			wc := project(watercraftreport, formatwatercraft(left));
			ac := project(aircraftreport, formataircraft(left));
			self.RealProperties := project(sort(propertyrecs, -purchasedate), formatpropertyrecs(left, counter));,
			self.PersonalProperties := project(sort(wc + ac, -iesp.ECL2ESP.DateToString(RegistrationDate)), TRANSFORM(iesp.riskviewreport.t_RvReportPersonalPropertyRecord, self.seq:=(string)counter, self := left));
			self.FilingRecords := project(sort(liensdata, -date_last_seen), formatliens(left, counter)); 
			self.Bankruptcies := project(sort(bankruptcies, -date_last_seen), formatbankruptcies(left, counter)); 
			self.CriminalRecords := project(sort(criminalrecs, -offender.fcra_date), formatcriminal(left, counter));
			s1 := project(amstudentrecs, formatamstudent(left));
			s2 := project(alloystudentrecs, formatalloystudent(left));
			self.EducationRecords := project(s1 + s2,TRANSFORM(iesp.riskviewreport.t_RvReportEducationRecord, self.Seq := (string)counter, self := left)); // get a date so we can order?
			self.Licenses := project(sort(ungroup(licenserecs), -date_last_seen), formatlicenserecs(left, counter));
			self.BusinessAssociations := project(sort(pawrecs, -dt_last_seen), formatpeopleatwork(left, counter));
			self.CreditInquiries := if( not inquiryRestrict, project(sort(inquiryrecs, -search_info.datetime), formatinquiryrecs(left, counter)));
			l1 := project(impulserecs(ut.DaysApart(Models.RiskViewReport_data.historydate(l.historydate),DateVendorLastReported[1..8]) < ut.DaysInNYears(1)), formatimpulserecs(left));
			l2 := project(thriverecs(ut.DaysApart(Models.RiskViewReport_data.historydate(l.historydate),dt_last_seen[1..8]) < ut.DaysInNYears(1)), formatthriverecs(left));
			self.LoanOffers :=project(sort(l1 + l2, -iesp.ECL2ESP.DateToString(Date)), TRANSFORM(iesp.riskviewreport.t_RvReportLoanOfferRecord, self.seq:=(string)counter, self := left));
			isCollections := StringLib.StringToUpperCase(TRIM(intendedPurpose)) = 'COLLECTIONS';
			self.EstimatedIncome := if(isCollections, (string)estimatedincome, '');
			self.ConsumerStatement := ConsumerStatements[1].cs_text;
			self := [];
		END;

		// OUTPUT (watercrafts.owners, NAMED ('watercraft'));
		// OUTPUT (watercrafts.coastguard, NAMED ('watercraft_coastguard'));
		// OUTPUT (watercrafts.details, NAMED ('watercraft_details'));
//		 OUTPUT (aircrafts.aircrafts, NAMED ('aircraft'));
		// OUTPUT (aircrafts.aircraft_details, NAMED ('aircraft_details'));
		// OUTPUT (aircrafts.aircraft_engine, NAMED ('aircraft_engine'));
		// OUTPUT (aircrafts.pilot_registrations, NAMED ('pilot_registration'));
		// OUTPUT (aircrafts.pilot_certificates, NAMED ('pilot_certificate'));
//		 output(aircraftreport, named('aircrafts'));
//		 output(liensdata, named('liensdata'));
//		 output(bankruptcies, named('bankruptcies'));
//		 OUTPUT (criminalrecs,      NAMED ('offenders'));
//		 output(amstudentrecs, named('americanstuden'));
//		 output(alloystudentrecs, named('alloystudent'));
		// output(licenserecs, named('license'));
		// output(pawrecs, named('busassoc'));
		// output(inquiryrecs, named('inquiry'));
		// output(propertyrecs, named('prop'));
//		output(addrHistory, named('addrhist'));
//		  output(impulserecs, named('impulse'));
//		OUTPUT (criminalrecs.offenses,       NAMED ('offenses'));
//		OUTPUT (criminalrecs.punishments,    NAMED ('punishment'));
//		OUTPUT (criminalrecs.offenders_plus, NAMED ('offenders_plus'));
//		OUTPUT (criminalrecs.court_offenses, NAMED ('court_offenses'));
//		OUTPUT (criminalrecs.activity,       NAMED ('activity'));
		
		return project(choosen(bocashell,1), makereport(left));
	
END;