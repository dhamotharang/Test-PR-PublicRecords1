import iesp, Seed_Files, risk_indicators, Address, Suppress, ut, STD, FFD;

EXPORT TestSeed_Function(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy in_rec,
												 ConsumerProfile_Services.IParam.options in_param) := FUNCTION
		
	lookupkey := RECORD
		string30 in_seq;
		string20 dataset_name;
		data16 hashkey;
	END;
	
	lookupkey getSearchKey(iesp.fcraconsumerprofilereport.t_ConsumerProfileReportBy L) := TRANSFORM
		self.in_seq := '1';
		self.dataset_name := in_param.test_data_table_name;	
		useCleanName := L.Name.Full<>'';
		cleanName		:= Address.CleanNameFields(Address.CleanPerson73(L.Name.Full)).CleanNameRecord;
		string fname_val := if(useCleanName, cleanName.fname, stringlib.stringtouppercase(L.Name.First));
		string lname_val := if(useCleanName, cleanName.lname, stringlib.stringtouppercase(L.Name.Last));
		self.hashkey := 		Seed_Files.Hash_InstantID(
   															(string15)stringlib.stringtouppercase(fname_val),
   															(string20)stringlib.stringtouppercase(lname_val),
   															(string9)L.SSN,
   															risk_indicators.nullstring,
   															(string5)(L.Address.zip5),
   															(string10)L.Phone10,
   															risk_indicators.nullstring
   															);

	END;
	
	search_rec := project(dataset(in_rec), getSearchKey(LEFT));

	cpReport := join(search_rec, Seed_Files.ConsumerProfile_keys.Report,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		LEFT OUTER, KEEP(1)
	);
	suppress.MAC_Mask(cpReport, cpReport_masked, cp_ssn, blank, true, false,,,,in_param.ssnmask);
	cpAddrHist := join(search_rec, Seed_Files.ConsumerProfile_keys.AddressHistory,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(ConsumerProfile_Services.Constants.MAX_SEEDS_REC)
	);
	cpAkas := join(search_rec, Seed_Files.ConsumerProfile_keys.AKAs,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(ConsumerProfile_Services.Constants.MAX_SEEDS_REC)
	);

	iesp.fcraconsumerprofilereport.t_ConsumerProfileAddressHistory xformSeedAddrHist(cpAddrHist L) := TRANSFORM
		self.DateFirstSeen 	:= iesp.ECL2ESP.toDatestring8(L.dt_first_seen);
		self.DateLastSeen 	:= iesp.ECL2ESP.toDatestring8(L.dt_last_seen);
		self.Address 				:= L;
		self := [];
	END;
	
	dob_mask 			:= in_param.dob_mask;
	sc 						:= suppress.Constants.datemask;
	iesp.fcraconsumerprofilereport.t_ConsumerProfileInformation xformSeedConsumerInfo(cpReport L) := transform
		self.UniqueId := (string)L.did;
		self.SSN 			:= L.cp_ssn;
		consumer_dob 	:= iesp.ECL2ESP.toDatestring8(L.dob);
		self.DOB 			:= project(consumer_dob, transform(iesp.share.t_MaskableDate,
																						Self.Year  := if ((dob_mask = sc.YEAR) or (dob_mask = sc.ALL), 'XXXX', (string)consumer_dob.Year),
																						Self.Month := if ((dob_mask = sc.MONTH) or (dob_mask = sc.ALL), 'XX', (string)consumer_dob.Month),
																						Self.Day   := if ((dob_mask = sc.DAY) or (dob_mask = sc.ALL), 'XX', (string)consumer_dob.Day)));
		self.Name			:= L;
		self.Address	:= L;
		self := [];
	end;
	
	iesp.fcraconsumerprofilereport.t_ConsumerProfileInputConfirmation xformSeedInputConf(cpReport L) := transform
		self.SSNVerification.Code 						:= L.SSNVerificationCode;
		self.SSNVerification.Description 			:= L.SSNVerificationDescription;
		self.AddressVerification.Code				 	:= L.AddressVerificationCode;
		self.AddressVerification.Description 	:= L.AddressVerificationDescription;
		self.DOBVerification.Code 						:= L.DOBVerificationCode;
		self.DOBVerification.Description 			:= L.DOBVerificationDescription;
		self.PhoneVerification.Code 					:= L.PhoneVerificationCode;
		self.PhoneVerification.Description 		:= L.PhoneVerificationDescription;
	end;
	
	iesp.share.t_RiskIndicator xformSeedHRI(cpReport L, INTEGER C) := transform
		hri_code := choose(C, L.hri, L.hri2, L.hri3, L.hri4, L.hri5);
		hri_desc := choose(C, L.hri_desc, L.hri2_desc, L.hri3_desc, L.hri4_desc, L.hri5_desc);
		self.RiskCode := if(hri_code <> '', hri_code, skip);
		self.Description := hri_desc;
	end;
	
	iesp.fcraconsumerprofilereport.t_ConsumerProfileAlert xformSeedAlerts(cpReport L, INTEGER C) := transform
		alert_code := choose(C, L.alertcode, L.alertcode2, L.alertcode3, L.alertcode4, L.alertcode5);
		alert_desc := choose(C, L.alertcode_desc, L.alertcode2_desc, L.alertcode3_desc, L.alertcode4_desc, L.alertcode5_desc);
		self.Code := if(alert_code <> '', alert_code, skip);
		self.Description := alert_desc;
		self.Message := '';
	end;
	
	iesp.fcraconsumerprofilereport.t_ConsumerProfileAKA xformAKAsOut(recordof(cpAKAs) L) := transform
		self.StatementIds := [];
		self.isDisputed := [];
		self := L;
	end;
		
	iesp.share_fcra.t_ConsumerStatement xformAddConsumerStatement(recordof(cpReport) L, integer c) := transform
		self.uniqueId := (string16)L.did;
		self.content := IF(L.consumerstatement <> '', L.consumerstatement, skip);
		self.StatementId := 1000 + c;
		self.StatementType := FFD.Constants.RecordType.CS;
		self.DataGroup := '';
		self.Timestamp := iesp.ECL2ESP.toTimeStamp((STRING8)(STD.Date.Today()));
	end;
		
	boolean isBillable := false;
	iesp.fcraconsumerprofilereport.t_ConsumerProfileResult xformSeedResult(cpReport L) := TRANSFORM		
		self.isBillable 					:= isBillable;
		self.ConsumerInformation 	:= project(L, xformSeedConsumerInfo(left));
		self.AKAs 									:= choosen(project(sort(cpAkas,seq), xformAKAsOut(left)), iesp.Constants.ConsumerProfile.MAX_COUNT_AKAS); 
		self.InputConfirmation 		:= project(L, xformSeedInputConf(left));
		self.AddressStability 		:= L.AddressStability;
		self.AddressHistories 		:= choosen(project(sort(cpAddrHist, seq), xformSeedAddrHist(left)), iesp.Constants.ConsumerProfile.MAX_COUNT_ADDR_HIST);
		self.SSNInfo.SSN					:= L.ssnInfo_ssn;
		self.SSNInfo.Valid				:= L.ssnInfo_valid;
		self.SSNInfo.IssuedLocation	:= if(length(trim(L.ssnInfo_issuedLocation)) = 2, ut.St2Name(L.ssnInfo_issuedLocation), L.ssnInfo_issuedLocation);
		self.SSNInfo.IssuedStartDate:= iesp.ECL2ESP.toDatestring8(L.ssnInfo_issuedStartDate);
		self.SSNInfo.IssuedEndDate 	:= iesp.ECL2ESP.toDatestring8(L.ssnInfo_issuedEndDate);
		self.HighRiskIndicators 	:= choosen(normalize(cpReport_masked, 5, xformSeedHRI(left, counter)), iesp.Constants.MaxCountHRI);
		self.ConsumerStatement 		:= L.consumerstatement;
		self.Alerts 							:= choosen(normalize(cpReport_masked, 5, xformSeedAlerts(left, counter)), iesp.Constants.ConsumerProfile.MAX_COUNT_ALERTS);
		self := [];	
	END;
		
	ConsumerProfile_Services.Layouts.cp_out_layout xformSeedOut() := transform
		self.Result := project(cpReport_masked, xformSeedResult(LEFT))[1];
		self.Royalty := [];
		self.ConsumerStatements := project(cpReport, xformAddConsumerStatement(left, counter));
		self := []; // no resolved LexId will be logged for test seed
	end;
	final_seed:= dataset([xformSeedOut()]);
	
	return final_seed;
END;

