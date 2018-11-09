import iesp, risk_indicators, codes, doxie, riskwiseFCRA, FCRA, suppress, riskwise, Consumerstatement, Address, Royalty, MDR, gateway, FFD;

EXPORT ReportRecords_FCRA(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy in_rec,
												  ConsumerProfile_Services.IParam.options in_param,
													dataset(Gateway.Layouts.Config) in_gateways
													) := FUNCTION
	
	//Insufficient Input alert
	input_alert := ConsumerProfile_Services.Functions.checkForAlertsFromInput(in_rec, in_param);
	boolean insufficient_input := exists(input_alert);
	
	//Test data
	test_rec := ConsumerProfile_Services.TestSeed_Function(in_rec, in_param);
	
	//Create a boolean to check if Bocashell and headers should be run in case we either have an insufficient input or test data is enabled.
	//This is to avoid platform feature of IF statement which would execute this code otherwise
	boolean runReport := ~insufficient_input and ~in_param.test_data_enabled;
	
	//Clean input and project to bocashell input layout
	bsprep := ConsumerProfile_Services.Functions.getBocaShellStandardInputLayout(in_rec);
	
	Gateway.Layouts.Config gw_switch(Gateway.Layouts.Config le) := TRANSFORM
		SELF.servicename := le.servicename;
		SELF.url := IF(Gateway.Configuration.IsTargus(le.servicename), '', le.url); // Don't allow Targus Gateway
		SELF := le;
	END;
	gateways := PROJECT(in_gateways, gw_switch(LEFT));
	
	//Copied from Models.RiskView_Records
	unsigned1 dppa := 0; // not needed for FCRA
	unsigned1 glba := 0; // not needed for FCRA
	boolean   isUtility := StringLib.StringToUpperCase(in_param.industry_class) = 'UTILI';
	boolean   isLn := false; // not needed anymore
	boolean   require2ele := false;// twb what is correct force2Ele;
	boolean   doRelatives := false;
	boolean   doDL := false;
	boolean   doVehicle := false;//twb forceVehicles;
	boolean   doDerogs := true;
	boolean   ofacOnly := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   excludeWatchlists := true; // turned off the ofac searching as I don't think it is needed
	boolean   fromIT1O := false;
	unsigned1 ofacVersion := 1;
	boolean   includeOfac := false;
	boolean   includeAddWatchlists := false;
	real      watchlistThreshold := 0.84; //twb why is this not a constant
	boolean   isPreScreen := StringLib.StringToUpperCase(in_param.intended_purpose) = 'PRESCREENING';
	boolean   doScore := false;
	unsigned8 BSOptions := 0;
	
	bsVersion := 	in_param.bs_version; //41
	string50 DataRestriction := in_param.datarestrictionmask;
	
	//Generate clam
	//to avoid platform feature of IF statement which executed BocaShell call even when there was insufficient input,
	//adding extra boolean condition
	clam := if(runReport, Risk_Indicators.Boca_Shell_Function_FCRA(
		dataset(bsprep), gateways, dppa, glba, isUtility, isLN,
		require2ele, doRelatives, doDL, doVehicle, doDerogs, ofacOnly,
		suppressNearDups, fromBIID, excludeWatchlists, fromIT1O,
		ofacVersion, includeOfac, includeAddWatchlists, watchlistThreshold,
			bsVersion, isPreScreen, doScore, ADL_Based_Shell:=false, datarestriction:=datarestriction, BSOptions:=BSOptions
	));
	//Get HRIs
	hri_ds := ConsumerProfile_Services.Functions.getHighRiskIndicators(clam[1]);
	//Calculate Input Verification from NAS and NAP summaries
	input_verification := ConsumerProfile_Services.Functions.calculateNASPDVerification(clam[1]);
	
	//Isolate BocaShell DID
	bshell_dids	:= project(ungroup(clam), transform(doxie.layout_references, self.did := left.did));
	//Get FCRA files
	ds_best := project(bshell_dids,transform(doxie.layout_best,self:=left,self:=[]));
	ds_flags := FCRA.GetFlagFile (ds_best);
		
	// FFD				 
	boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(in_param.FFDOptionsMask);
	boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_param.FFDOptionsMask);

	//Get the DID 
	dids	  := 	project(ds_best, transform(FFD.Layouts.DidBatch, 
		                           self.acctno := FFD.Constants.SingleSearchAcctno, 
															 self.did := (unsigned6) left.did));
															
	//Call the person context
	pc_recs := FFD.FetchPersonContext(dids, in_gateways, FFD.Constants.DataGroupSet.HDR);
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);														
	
	//Get FCRA header records
	//to avoid platform feature of IF statement which executed FCRA header call even when there was insufficient input,
	//adding extra boolean condition
	fcra_header := if(runReport, RiskWiseFCRA._header_data(bshell_dids, ds_flags));
	
	//EN  and EQ Restrictions
	fcra_header_rest := fcra_header((src != MDR.sourceTools.src_Experian_Credit_Header or ~in_param.isECHRestricted)
																	and (src != MDR.sourceTools.src_Equifax or ~in_param.isEQCHRestricted));
	
	//--------------FFD------------------
	ConsumerProfile_Services.Layouts.working xform(RiskWiseFCRA.layouts.working L , FFD.Layouts.PersonContextBatchSlim R ) := transform,
			skip(~ShowDisputedRecords and r.isDisputed) 
			self.StatementIDs := if(ShowConsumerStatements,r.StatementIDs,FFD.Constants.BlankStatements);
			self.isDisputed :=	r.isDisputed;
			self := L;
	end;
																
	Slim_header_ds  := join(fcra_header_rest, slim_pc_recs, 
												 (string)left.persistent_record_id = right.RecID1 and
												 (((unsigned)left.did  = (unsigned) right.lexid) OR 
														(right.acctno = FFD.Constants.SingleSearchAcctno) 
												 )AND 
												 right.DataGroup = FFD.Constants.DataGroups.HDR,
  											 xform(left, right), 
												 left outer,
												 keep(1),
												 limit(0));		

	suppress.MAC_Mask(Slim_header_ds, fcra_header_final, ssn, blank, true, false,,,,in_param.ssnmask);
	
	//Calculate best record (rollup on most recent)
	fcra_header_best := ConsumerProfile_Services.Functions.getBestRecord(fcra_header_final)[1]; //only one record comes out 
	
	//Get AKAs
	fcra_akas := dedup(sort(fcra_header_final(fname <> fcra_header_best.fname or 
																		  mname <> fcra_header_best.mname or 
																		  lname <> fcra_header_best.lname or 
																		  name_suffix <> fcra_header_best.name_suffix)
											, fname, mname, lname, name_suffix)
										, fname, mname, lname, name_suffix);
										
	AKAs_filtered := project (fcra_akas, transform (ConsumerProfile_Services.Layouts.working, self.StatementIds := left.StatementIDs(RecordType = FFD.Constants.RecordType.HSN), self := left));									
	
  //Get Address History
	fcra_address_hist := ConsumerProfile_Services.Functions.getAddressHistory(fcra_header_final);	
	
	//Get consumer statement
	consumer_statement := join(bshell_dids, Consumerstatement.key.fcra.lexid, 
														left.did <> 0 and
														KEYED(left.did = right.LexID), 
														transform(right),
														atmost(riskwise.max_atmost)); //Potentially we could have more than 1 consumer statement per DID, but currently we are only returning the most recent one
	//Alerts
	clam_alerts := ConsumerProfile_Services.Functions.checkForAlertsFromClam(clam[1], in_param);
	cs_alert := ConsumerProfile_Services.Functions.getAlertDataset(FCRA.Constants.ALERT_CODE.CONSUMER_STATEMENT);
	boolean has_consumer_statement := exists(consumer_statement);
	
	alerts := if(insufficient_input, input_alert, 
								if(~in_param.test_data_enabled, clam_alerts + if(has_consumer_statement, cs_alert)));
	
	//Alerts that null all other results
	null_alerts_set := [FCRA.Constants.ALERT_CODE.INSUFFICIENT_INPUT_INFO, 
											FCRA.Constants.ALERT_CODE.SECURITY_FREEZE,
											FCRA.Constants.ALERT_CODE.STATE_EXCEPTION,
											FCRA.Constants.ALERT_CODE.NO_DID_FOUND];
	boolean nullResults := exists(alerts(Code in null_alerts_set));
	//Alerts that null results and aren't billable
	null_unbillable_alerts_set := [FCRA.Constants.ALERT_CODE.INSUFFICIENT_INPUT_INFO,
																 FCRA.Constants.ALERT_CODE.NO_DID_FOUND];
	boolean isBillable := not exists(alerts(Code in null_unbillable_alerts_set));// and exists(clam);

	//Project to output layout
	dob_mask 				:= in_param.dob_mask;
	sc 							:= suppress.Constants.datemask;
	iesp.fcraconsumerprofilereport.t_ConsumerProfileInformation xformConsumerInfoOut(ConsumerProfile_Services.Layouts.working L) := transform
		self.UniqueId 	:= (string)L.did;
		self.Name.Full 	:= Address.NameFromComponents(L.fname, L.mname, L.lname, L.name_suffix);
		self.Name.Prefix:= L.title;
		self.Name.First := L.fname;
		self.Name.Middle:= L.mname;
		self.Name.Last 	:= L.lname;
		self.Name.Suffix:= L.name_suffix;
		self.SSN 				:= L.ssn;
		consumer_dob		:= iesp.ECL2ESP.toDate(L.dob);
		self.DOB 				:= project(consumer_dob, transform(iesp.share.t_MaskableDate,
																					Self.Year  := if ((dob_mask = sc.YEAR) or (dob_mask = sc.ALL), 'XXXX', (string)consumer_dob.Year),
																					Self.Month := if ((dob_mask = sc.MONTH) or (dob_mask = sc.ALL), 'XX', (string)consumer_dob.Month),
																					Self.Day   := if ((dob_mask = sc.DAY) or (dob_mask = sc.ALL), 'XX', (string)consumer_dob.Day)));
		self.Address 		:= iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, 
																		L.predir, L.postdir, L.suffix, 
																		L.unit_desig, L.sec_range,
																		L.city_name, L.st, L.zip, 
																		L.zip4, L.county_name, '',
																		Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, 
																																l.suffix, l.postdir, l.unit_desig, l.sec_range),
																		'',
																		Address.Addr2FromComponents(l.city_name, l.st, l.zip)); 
		self.StatementIds := choosen(L.StatementIds, iesp.Constants.MaxConsumerStatementIds);			
		self.isDisputed := L.isDisputed
	end;
	
	iesp.fcraconsumerprofilereport.t_ConsumerProfileAKA xformAKAsOut(ConsumerProfile_Services.Layouts.working L) := transform
		self.Full 	:= Address.NameFromComponents(L.fname, L.mname, L.lname, L.name_suffix);
		self.Prefix := L.title;
		self.First 	:= L.fname;
		self.Middle := L.mname;
		self.Last 	:= L.lname;
		self.Suffix := L.name_suffix;
		self.StatementIds := choosen(L.StatementIds, iesp.Constants.MaxConsumerStatementIds);
		self.isDisputed := L.isDisputed
	end;
	
	iesp.fcraconsumerprofilereport.t_ConsumerProfileAddressHistory xformAddressHistoryOut(ConsumerProfile_Services.Layouts.working L) := transform
		self.DateFirstSeen:= iesp.ECL2ESP.toDateYM(L.dt_first_seen);
		self.DateLastSeen := iesp.ECL2ESP.toDateYM(L.dt_last_seen);
		self.Address 			:= iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range, 
																			L.predir, L.postdir, L.suffix, 
																			L.unit_desig, L.sec_range,
																			L.city_name, L.st, L.zip, 
																			L.zip4, L.county_name, '',
																			Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, 
																																	l.suffix, l.postdir, l.unit_desig, l.sec_range),
																			'',
																			Address.Addr2FromComponents(l.city_name, l.st, l.zip));
		self.StatementIds := choosen(L.StatementIds, iesp.Constants.MaxConsumerStatementIds);
		self.isDisputed 	:= L.isDisputed
	end;
	
	iesp.share.t_RiskIndicator xformHRIOut(risk_indicators.Layout_Desc L) := transform
		self.RiskCode		 := L.hri;
		self.Description := L.desc;
	end;
		
	iesp.fcraconsumerprofilereport.t_ConsumerProfileResult xformResultsOut() := transform
		self.isBillable 						:= isBillable;
		self.ConsumerInformation 		:= project(fcra_header_best, xformConsumerInfoOut(left));
		self.AKAs 									:= choosen(project(AKAs_filtered, xformAKAsOut(left)), iesp.Constants.ConsumerProfile.MAX_COUNT_AKAS); 
		self.InputConfirmation 			:= input_verification;
		self.AddressStability 			:= clam[1].addr_stability;
		self.AddressHistories 			:= choosen(project(fcra_address_hist, xformAddressHistoryOut(left)), iesp.Constants.ConsumerProfile.MAX_COUNT_ADDR_HIST);
		self.SSNInfo.SSN 						:= clam[1].shell_input.ssn;
		ssn_issuance 								:= clam[1].ssn_verification.validation;
		self.SSNInfo.Valid 					:= if(ssn_issuance.valid, 
																		 ConsumerProfile_Services.Constants.SSN_INFO.VALID, 
																		 ConsumerProfile_Services.Constants.SSN_INFO.INVALID);
		self.SSNInfo.IssuedLocation := codes.St2Name(ssn_issuance.issue_state);
		self.SSNInfo.IssuedStartDate:= iesp.ECL2ESP.toDate(ssn_issuance.low_issue_date);
		self.SSNInfo.IssuedEndDate 	:= iesp.ECL2ESP.toDate(ssn_issuance.high_issue_date);
		self.HighRiskIndicators 		:= choosen(project(hri_ds, xformHRIOut(left)), iesp.Constants.MaxCountHRI);
		self.ConsumerStatement 			:= if(has_consumer_statement, sort(consumer_statement, -dateCreated)[1].cs_text, '');
		self.Alerts 								 := choosen(alerts, iesp.Constants.ConsumerProfile.MAX_COUNT_ALERTS);
		// blanking out below because these are redundant and to be deprecated by ESP (JIRA: ESPBS-467)
		self.isDisputed	:= false;
		self.StatementIds := [];				
	end;
	
	statement_output_fcra := if(ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);	
	royalty_rec := Royalty.RoyaltyExperianHeader.GetFCRARoyaltySet(fcra_header_final);
	
	ConsumerProfile_Services.Layouts.cp_out_layout xformOut() := transform
		self.Result	 := row(xformResultsOut());
		self.Royalty := if(not in_param.isECHRestricted, royalty_rec);
		self.ConsumerStatements := choosen(statement_output_fcra, iesp.Constants.MaxConsumerStatements);
	end;
	final_rec := dataset([xformOut()]);
	
	ConsumerProfile_Services.Layouts.cp_out_layout xformNull() := transform
		self.Result.isBillable:= isBillable;
		self.Result.Alerts 		:= choosen(alerts/*(alertCode in null_alerts_set)*/, iesp.Constants.ConsumerProfile.MAX_COUNT_ALERTS);
		self := [];
	end;
	null_final_rec := dataset([xformNull()]);
	
	out_rec := map(nullResults => null_final_rec,
																in_param.test_data_enabled => test_rec,
																final_rec);
								 
	//DEBUG
	// output(in_rec, named('in_rec'));
	// output(clam, named('clam'));
	// output(fcra_header,named('fcra_header'));
	// output(fcra_header_final,named('fcra_header_final'));
	// output(alerts,named('alerts'));
	// output(slim_pc_recs,named('slim_pc_recs'));	
	return out_rec;
END;