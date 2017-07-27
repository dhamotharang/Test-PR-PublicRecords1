import Risk_Indicators, Gateway, iesp, Models, ut;

export getFICOScoreXD(dataset(Risk_Indicators.Layout_Input) indata, dataset(Gateway.Layouts.Config) gateways, String10 MemberNumber, String3 SecurityCode) := function

	gateway_cfg	:= gateways(Gateway.Configuration.IsEquifaxSts(servicename))[1];

	iesp.equifax_sts.t_EquifaxSTSRequest prep(indata le) := transform
		self.User.QueryId := if((string)le.seq <> '', trim((string)le.seq), '');
		
		self.searchby.Name.Prefix := trim(le.title);
		self.searchby.Name.First := trim(le.fname);
		self.searchby.Name.Middle := trim(le.mname);
		self.searchby.Name.Last := trim(le.lname);
		self.searchby.Name.Suffix := trim(le.suffix);
		self.searchby.address.streetname := trim(if(le.in_streetAddress <> '', le.in_streetAddress,
																						le.prim_range + ' ' + le.prim_name + ' ' + le.unit_desig));
		self.searchby.address.city := trim(le.in_city);
		self.searchby.address.state := trim(le.in_state);
		self.searchby.address.zip := trim(le.in_zipCode);
		self.searchby.SSN := trim(le.ssn);
		self.searchby.DOB.year := trim(le.dob[1..4]);
		self.searchby.DOB.month := trim(le.dob[5..6]);
		self.searchby.DOB.day := trim(le.dob[7..8]);
		
		// These options are not being used at this time, Equifax will populate these based on MemberNumber
		// self.searchby.enduser.CompanyName := trim('LEXISNEXID-DEV');
		// self.searchby.enduser.permisablepurpose := map( Purpose = 'application'      => '52',
																										// Purpose = 'portfolio review' => '13',
																																										// ''
																									// );
		self.EquifaxCredentials.CustomerNumber := trim(MemberNumber);
		self.EquifaxCredentials.SecurityCode := trim(SecurityCode);
		self.searchby.models := project(Risk_Indicators.iid_constants.ds_Record, transform(iesp.equifax_sts.t_EqSTSModel,
																											self.modelNumber := trim('05265'), //per the requirements, this is the FICO Score XD model 
																											self.Field1 := '', //used for PowerView but not for FICO Score XD
																											self.Field2 := ''  //used for PowerView but not for FICO Score XD
																											));
	self := [];
	end;

	FICOScoreXD_pass := project(indata, prep(left));

	// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie 
	// ever decides to execute both sides of the IF statement.
	makeGatewayCall := gateway_cfg.url!='' and count(FICOScoreXD_pass)>0;
	fxd_results := if(makeGatewayCall, Gateway.SoapCall_FICOScoreXD(FICOScoreXD_pass, gateway_cfg, makeGatewayCall), dataset([], iesp.equifax_sts.t_EquifaxSTSResponseEx));

	//Put the results into model out format
	Models.Layout_ModelOut format_FICOScoreXD(fxd_results le) := transform
		self.seq := (Integer)le.response._Header.QueryId;
		tranRejected := le.response.report.marketmaxes[1].rejectcode in Risk_Indicators.iid_constants.SetFICOScoreXDRejectCodes;
		self.score := if(le.response.report.marketmaxes[1].NumericScore = '' and le.response.report.marketmaxes[1].reasoncode1 = '', error('No score returned from Equifax Gateway'),
											if(tranRejected, '00222', le.response.report.marketmaxes[1].NumericScore));
		//populate any reason codes/reject codes from equifax
		myreasons := dataset([{le.response.report.marketmaxes[1].reasoncode1[3..5], ''},
													{le.response.report.marketmaxes[1].reasoncode2[3..5], ''},
													{le.response.report.marketmaxes[1].reasoncode3[3..5], ''},
													{le.response.report.marketmaxes[1].reasoncode4[3..5], ''},
													{le.response.report.marketmaxes[1].FactActKeyFactor , ''}],
													Risk_Indicators.Layout_Desc);

		myrejectcode := dataset([{le.response.report.marketmaxes[1].rejectcode, ''},
														 {'', ''},
														 {'', ''},
														 {'', ''},
														 {'', ''}],
															Risk_Indicators.Layout_Desc);		
															
		self.ri := if(tranrejected, myrejectcode, myreasons(hri <> ''));
		self := [];
	end;

	ret := project(fxd_results, format_FICOScoreXD(left));
	
	return ret;

end;