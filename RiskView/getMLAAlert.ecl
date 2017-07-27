import Risk_Indicators, Gateway, iesp, Models, ut, Doxie; 

layout_preMLA := record
	Risk_Indicators.Layout_Input input;
	riskview.layouts.layout_riskview5_search_results results;
end;

export getMLAAlert(dataset(layout_preMLA) indata, 
									 dataset(Gateway.Layouts.Config) gateways, 
									 String120 EndUserCompanyName,
									 String Intended_Purpose,
									 String10 CustomerNumber, 
									 String3 SecurityCode, 
									 Unsigned1 MLA_request_pos = 0) := function

	model_info := Models.LIB_RiskView_Models().ValidV50Models;
	Custom_info := model_info(Model_Name = 'MLA1608_0')[1];
	gateway_cfg	:= gateways(Gateway.Configuration.IsEquifaxSts(servicename))[1];
	IntendedPurposeUC := StringLib.StringToUpperCase(Intended_Purpose);
	allowedPurposes := ['APPLICATION','PRESCREENING','PORTFOLIO REVIEW'];
	
	// MemberNumber := '999ZB05521'; //MLA
	// SecurityCode := '@U2';
	
	iesp.equifax_sts.t_EquifaxSTSRequest prep(indata le) := transform
		self.User.QueryId := if((string)le.input.seq <> '', trim((string)le.input.seq), '');
		
		self.Options.IncludeMLAInfo := true;	//we are requesting MLA here so hard code the option
		
		self.searchby.Name.Prefix := trim(le.input.title);
		self.searchby.Name.First := trim(le.input.fname);
		self.searchby.Name.Middle := trim(le.input.mname);
		self.searchby.Name.Last := trim(le.input.lname);
		self.searchby.Name.Suffix := trim(le.input.suffix);
		self.searchby.address.streetname := trim(if(le.input.in_streetAddress <> '', le.input.in_streetAddress,
																						le.input.prim_range + ' ' + le.input.prim_name + ' ' + le.input.unit_desig));
		self.searchby.address.city := trim(le.input.in_city);
		self.searchby.address.state := trim(le.input.in_state);
		self.searchby.address.zip := trim(le.input.in_zipCode);
		self.searchby.SSN := trim(le.input.ssn);
		self.searchby.DOB.year := trim(le.input.dob[1..4]);
		self.searchby.DOB.month := trim(le.input.dob[5..6]);
		self.searchby.DOB.day := trim(le.input.dob[7..8]);
		
		self.EquifaxCredentials.CustomerNumber := trim(CustomerNumber);
		self.EquifaxCredentials.SecurityCode := trim(SecurityCode);
		self.searchby.enduser.CompanyName := EndUserCompanyName;
		self.searchby.enduser.permisablepurpose := map(IntendedPurposeUC = 'APPLICATION'				=> '60',
																									 IntendedPurposeUC = 'PRESCREENING'				=> '08',
																									 IntendedPurposeUC = 'PORTFOLIO REVIEW'		=> '13',
																																															 '');

	self := [];
	end;
	
//Equifax will fail the transaction if any of these inputs are not met so drop them here before calling the gateway
	MLAalert_pass := project(indata((Doxie.DOBTools((integer)input.dob).IsValidDOB) and 										
																	(LENGTH(TRIM(StringLib.StringFilter(input.ssn, '0123456789'))) = 9) and	
																	 EndUserCompanyName <> '' and IntendedPurposeUC in allowedPurposes and
																	 //name suffix is actually validated in Gateway ESP and fails if not in this set
																	 TRIM(input.suffix) in RiskView.Constants.set_Valid_Name_Suffix and
																	 LENGTH(TRIM(StringLib.StringFilter(input.fname, RiskView.Constants.set_alphabet))) > 0 and
																	 LENGTH(TRIM(StringLib.StringFilter(input.lname, RiskView.Constants.set_alphabet))) > 0 and
																	 input.in_city <> '' and 
																	 LENGTH(TRIM(StringLib.StringFilter(StringLib.StringToUpperCase(input.in_state), RiskView.Constants.set_alphabet))) = 2), prep(left));	
	
	makeGatewayCall := gateway_cfg.url!='' and count(MLAalert_pass)>0;
	MLA_results := if(makeGatewayCall, Gateway.SoapCall_MLAalert(MLAalert_pass, gateway_cfg, makeGatewayCall), dataset([], iesp.equifax_sts.t_EquifaxSTSResponseEx));

	riskview.layouts.layout_riskview5_search_results format_pass(indata le, MLA_results ri) := transform
		coveredBorrower		:= ri.response.report.MilitaryLendingActAlert.CoveredBorrowerStatus;
		insufficientData	:= ri.response.report.MilitaryLendingActAlert.InsufficientDataProvidedForMatch;
		gatewayError			:= ri.response.report.MilitaryLendingActAlert.CoveredBorrowerStatus not in ['Y','N'] and 
												 ri.response.report.MilitaryLendingActAlert.InsufficientDataProvidedForMatch <> 'I';
		
		self.seq := (Integer)ri.response._Header.QueryId;
		
		MLAalert	:= map(coveredBorrower = 'Y'					=> '400A',
										 coveredBorrower = 'N'					=> '400B',
										 insufficientData = 'I'					=> '400C', 
										 //if none of the above conditions hit, must mean a gateway failure and so just return blank
																											 '');
		//add the MLA alert to the existing alerts - no more than 6 ever exist so just put it in alert10 and compress
		ds_alerts := dataset([
			{le.results.alert1}, 
			{le.results.alert2}, 
			{le.results.alert3}, 
			{le.results.alert4}, 
			{le.results.alert5}, 
			{le.results.alert6}, 
			{le.results.alert7}, 
			{le.results.alert8}, 
			{le.results.alert9}, 
			{MLAalert}],{string4 alert_code})(alert_code<>'');
	
		self.alert1  := ds_alerts[1].alert_code;
		self.alert2  := ds_alerts[2].alert_code;
		self.alert3  := ds_alerts[3].alert_code;
		self.alert4  := ds_alerts[4].alert_code;
		self.alert5  := ds_alerts[5].alert_code;
		self.alert6  := ds_alerts[6].alert_code;
		self.alert7  := ds_alerts[7].alert_code;
		self.alert8  := ds_alerts[8].alert_code;
		self.alert9  := ds_alerts[9].alert_code;
		self.alert10 := ds_alerts[10].alert_code;
	
		MLAScore		 						:= if(~gatewayError, RiskView.Constants.MLAScore, '');
		MLAIndex		 						:= if(~gatewayError, (STRING)Custom_info.Billing_Index, '');
		MLAScore_Name 					:= if(~gatewayError, Custom_info.Output_Model_Name, '');

		//output the MLA results in the same numbered slot as it was requested in (among other models that may have been requested)
		self.Custom_Score 			:= if(MLA_request_pos = 1, MLAScore, le.results.Custom_Score); 
		self.Custom_Index 			:= if(MLA_request_pos = 1, MLAIndex, le.results.Custom_Index);
		self.Custom_Score_Name 	:= if(MLA_request_pos = 1, MLAScore_Name, le.results.Custom_Score_Name);

		self.Custom2_Score 			:= if(MLA_request_pos = 2, MLAScore, le.results.Custom2_Score); 
		self.Custom2_Index 			:= if(MLA_request_pos = 2, MLAIndex, le.results.Custom2_Index);
		self.Custom2_Score_Name := if(MLA_request_pos = 2, MLAScore_Name, le.results.Custom2_Score_Name);

		self.Custom3_Score 			:= if(MLA_request_pos = 3, MLAScore, le.results.Custom3_Score); 
		self.Custom3_Index 			:= if(MLA_request_pos = 3, MLAIndex, le.results.Custom3_Index);
		self.Custom3_Score_Name := if(MLA_request_pos = 3, MLAScore_Name, le.results.Custom3_Score_Name);

		self.Custom4_Score 			:= if(MLA_request_pos = 4, MLAScore, le.results.Custom4_Score); 
		self.Custom4_Index 			:= if(MLA_request_pos = 4, MLAIndex, le.results.Custom4_Index);
		self.Custom4_Score_Name := if(MLA_request_pos = 4, MLAScore_Name, le.results.Custom4_Score_Name);

		self.Custom5_Score 			:= if(MLA_request_pos = 5, MLAScore, le.results.Custom5_Score); 
		self.Custom5_Index 			:= if(MLA_request_pos = 5, MLAIndex, le.results.Custom5_Index);
		self.Custom5_Score_Name := if(MLA_request_pos = 5, MLAScore_Name, le.results.Custom5_Score_Name);
		
		self.Exception_code	:= if(~gatewayError, '', RiskView.Constants.gatewayErrorCode);  //if a gateway error, populate the code
		
		//set a second billing index to indicate the gateway was hit
		self.Billing_Index2	:= (STRING)Custom_info.Billing_Index2;
		self := le.results;
	end;

	retPass := join(indata, MLA_results,
									left.input.seq=(Integer)right.response._Header.QueryId, 
									format_pass(left, right),
									inner);

//Add those transactions that didn't meet input requirements back in
	
	riskview.layouts.layout_riskview5_search_results formatFailures(indata le) := transform
		MLAScore 			:= RiskView.Constants.MLAScore; 
		MLAIndex 			:= (STRING)Custom_info.Billing_Index;
		MLAScore_Name := Custom_info.Output_Model_Name;

		//output the MLA results in the same numbered slot as it was requested in (among other models that may have been requested)
		self.Custom_Score 			:= if(MLA_request_pos = 1, MLAScore, le.results.Custom_Score); 
		self.Custom_Index 			:= if(MLA_request_pos = 1, MLAIndex, le.results.Custom_Index);
		self.Custom_Score_Name 	:= if(MLA_request_pos = 1, MLAScore_Name, le.results.Custom_Score_Name);

		self.Custom2_Score 			:= if(MLA_request_pos = 2, MLAScore, le.results.Custom2_Score); 
		self.Custom2_Index 			:= if(MLA_request_pos = 2, MLAIndex, le.results.Custom2_Index);
		self.Custom2_Score_Name := if(MLA_request_pos = 2, MLAScore_Name, le.results.Custom2_Score_Name);

		self.Custom3_Score 			:= if(MLA_request_pos = 3, MLAScore, le.results.Custom3_Score); 
		self.Custom3_Index 			:= if(MLA_request_pos = 3, MLAIndex, le.results.Custom3_Index);
		self.Custom3_Score_Name := if(MLA_request_pos = 3, MLAScore_Name, le.results.Custom3_Score_Name);

		self.Custom4_Score 			:= if(MLA_request_pos = 4, MLAScore, le.results.Custom4_Score); 
		self.Custom4_Index 			:= if(MLA_request_pos = 4, MLAIndex, le.results.Custom4_Index);
		self.Custom4_Score_Name := if(MLA_request_pos = 4, MLAScore_Name, le.results.Custom4_Score_Name);

		self.Custom5_Score 			:= if(MLA_request_pos = 5, MLAScore, le.results.Custom5_Score); 
		self.Custom5_Index 			:= if(MLA_request_pos = 5, MLAIndex, le.results.Custom5_Index);
		self.Custom5_Score_Name := if(MLA_request_pos = 5, MLAScore_Name, le.results.Custom5_Score_Name);
		
		SELF.Exception_code	:= if(IntendedPurposeUC not in allowedPurposes, 
															RiskView.Constants.purposeErrorCode, //if purpose is invalid, set the exception code as such
															RiskView.Constants.InputErrorCode);	 //otherwise it must be insufficient input
		self := le.results;
		self := [];
	end;

	retFail := project(indata((~Doxie.DOBTools((integer)input.dob).IsValidDOB) or 
														(LENGTH(TRIM(StringLib.StringFilter(input.ssn, RiskView.Constants.set_numbers))) <> 9) or 
														 EndUserCompanyName = '' or IntendedPurposeUC not in allowedPurposes or
														 TRIM(input.suffix) not in RiskView.Constants.set_Valid_Name_Suffix or
														 LENGTH(TRIM(StringLib.StringFilter(input.fname, RiskView.Constants.set_alphabet))) <= 0 or
														 LENGTH(TRIM(StringLib.StringFilter(input.lname, RiskView.Constants.set_alphabet))) <= 0 or
														 input.in_city = '' or
														 LENGTH(TRIM(StringLib.StringFilter(StringLib.StringToUpperCase(input.in_state), RiskView.Constants.set_alphabet))) <> 2), 
										 formatFailures(left));
	
	ret := retPass + retFail;

	return ret;

end;