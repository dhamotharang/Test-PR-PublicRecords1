import iesp, Risk_Indicators;

export GetIntlIID(DATASET(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) input, string20 TestDataTableName) := FUNCTION
	
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	
	iesp.iid_international.t_InstantIDInternationalResponse_Unicode getIntlSeeds(input le, Key_IntlIID ri) := transform
		self.Result.InputEcho := le.searchby;
		self.Result.InternationalVerificationIndex := ri.InternationalVerificationIndex;
		self.Result.ComplianceLevel := ri.ComplianceLevel;
		self.Result.VerificationIndex := ri.VerificationIndex;

		self.Result.WatchList := ri.WatchList;
		self.Result.IPAddressInfo := ri.IPAddressInfo;
		self.Result.PassportNumberValidated := ri.PassportNumberValidated;
		self.Result.VisaNumberValidated := ri.VisaNumberValidated;
		self.Result.IsBillable := false;
		self.Result.BillingCountry := ri.BillingCountry;
		self.Result.BillingCountryCode := ri.BillingCountryCode;
		
		risk := dataset([{ri.rc1,ri.desc1},{ri.rc2,ri.desc2},{ri.rc3,ri.desc3},{ri.rc4,ri.desc4},{ri.rc5,ri.desc5},
										 {ri.rc6,ri.desc6},{ri.rc7,ri.desc7},{ri.rc8,ri.desc8},{ri.rc9,ri.desc9},{ri.rc10,ri.desc10}], iesp.share.t_RiskIndicator);
			
		self.Result.RiskIndicators := risk(RiskCode <> '');
		
		ver := dataset([{'FirstName',ri.isVer1,ri.Count1},
										{'FirstInitial',ri.isVer2,ri.Count2},
										{'MiddleName',ri.isVer3,ri.Count3},
										{'LastName',ri.isVer4,ri.Count4},
										{'FullName',ri.isVer5,ri.Count5},
										{'FullStreet',ri.isVer6,ri.Count6},
										{'UnitNumber',ri.isVer7,ri.Count7},
										{'StreetNumber',ri.isVer8,ri.Count8},
										{'StreetName',ri.isVer9,ri.Count9},
										{'StreetType',ri.isVer10,ri.Count10},
										{'Suburb',ri.isVer11,ri.Count11},
										{'Area',ri.isVer12,ri.Count12},
										{'State',ri.isVer13,ri.Count13},
										{'PostalCode',ri.isVer13,ri.Count14},
										{'DateOfBirth',ri.isVer13,ri.Count15},
										{'PhoneNumber',ri.isVer13,ri.Count16},
										{'IdNumber',ri.isVer13,ri.Count17}],
										iesp.iid_international.t_VerificationResult);
		
		self.Result.VerificationResults := ver;
		
		dsvA := dataset([{'FirstName',ri.dsVer_A1,ri.dsMatch_A1},
											{'FirstInitial',ri.dsVer_A2,ri.dsMatch_A2},
											{'MiddleName',ri.dsVer_A3,ri.dsMatch_A3},
											{'LastName',ri.dsVer_A4,ri.dsMatch_A4},
											{'FullName',ri.dsVer_A5,ri.dsMatch_A5},
											{'FullStreet',ri.dsVer_A6,ri.dsMatch_A6},
											{'UnitNumber',ri.dsVer_A7,ri.dsMatch_A7},
											{'StreetNumber',ri.dsVer_A8,ri.dsMatch_A8},
											{'StreetName',ri.dsVer_A9,ri.dsMatch_A9},
											{'StreetType',ri.dsVer_A10,ri.dsMatch_A10},
											{'Suburb',ri.dsVer_A11,ri.dsMatch_A11},
											{'Area',ri.dsVer_A12,ri.dsMatch_A12},
											{'State',ri.dsVer_A13,ri.dsMatch_A13},
											{'PostalCode',ri.dsVer_A14,ri.dsMatch_A14},
											{'PhoneNumber',ri.dsVer_A15,ri.dsMatch_A15},
											{'DayOfBirth',ri.dsVer_A16,ri.dsMatch_A16},
											{'MonthOfBirth',ri.dsVer_A17,ri.dsMatch_A17},
											{'YearOfBirth',ri.dsVer_A18,ri.dsMatch_A18},
											{'DOB',ri.dsVer_A19,ri.dsMatch_A19},
											{'IdNumber',ri.dsVer_A20,ri.dsMatch_A20}],
											iesp.iid_international.t_DataSourceVerification);
						
		dsvB := dataset([{'FirstName',ri.dsVer_B1,ri.dsMatch_B1},
											{'FirstInitial',ri.dsVer_B2,ri.dsMatch_B2},
											{'MiddleName',ri.dsVer_B3,ri.dsMatch_B3},
											{'LastName',ri.dsVer_B4,ri.dsMatch_B4},
											{'FullName',ri.dsVer_B5,ri.dsMatch_B5},
											{'FullStreet',ri.dsVer_B6,ri.dsMatch_B6},
											{'UnitNumber',ri.dsVer_B7,ri.dsMatch_B7},
											{'StreetNumber',ri.dsVer_B8,ri.dsMatch_B8},
											{'StreetName',ri.dsVer_B9,ri.dsMatch_B9},
											{'StreetType',ri.dsVer_B10,ri.dsMatch_B10},
											{'Suburb',ri.dsVer_B11,ri.dsMatch_B11},
											{'Area',ri.dsVer_B12,ri.dsMatch_B12},
											{'State',ri.dsVer_B13,ri.dsMatch_B13},
											{'PostalCode',ri.dsVer_B14,ri.dsMatch_B14},
											{'PhoneNumber',ri.dsVer_B15,ri.dsMatch_B15},
											{'DayOfBirth',ri.dsVer_B16,ri.dsMatch_B16},
											{'MonthOfBirth',ri.dsVer_B17,ri.dsMatch_B17},
											{'YearOfBirth',ri.dsVer_B18,ri.dsMatch_B18},
											{'DOB',ri.dsVer_B19,ri.dsMatch_B19},
											{'IdNumber',ri.dsVer_B20,ri.dsMatch_B20}],
											iesp.iid_international.t_DataSourceVerification);
						
		dsr := dataset([{ri.dsName_A,ri.dsID_A,ri.dsType_A,ri.dsError_A,ri.dsMessage_A,ri.dsPhoto_A,dsvA},
										{ri.dsName_B,ri.dsID_B,ri.dsType_B,ri.dsError_B,ri.dsMessage_B,ri.dsPhoto_B,dsvB}],
										iesp.iid_international.t_DataSourceResult);
				
		self.Result.DataSourceResults := dsr(DataSourceName <> '');		

		self.CountrySettings := [];
		self._Header := [];
		self := [];
	end;
	wSeedFile := Join(input, Key_IntlIID,  
										keyed(right.dataset_name=Test_Data_Table_Name) and 
										keyed(right.hashvalue=Hash_IntlIID(	(unicode20)unicodelib.unicodetouppercase(left.Searchby.Name.First),
																												(unicode20)unicodelib.unicodetouppercase(left.Searchby.Name.Last),
																												(string)left.Searchby.NationalIDNumber,
																												(unicode9)unicodelib.unicodetouppercase(left.Searchby.Address.PostalCode),
																												(string)left.Searchby.HomePhone)), 
										getIntlSeeds(LEFT, RIGHT), LEFT OUTER, KEEP(1));
										
	return wSeedFile;
	
END;