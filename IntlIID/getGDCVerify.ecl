import doxie, iesp, GDCVerify, Risk_Indicators, Riskwise, ut, gateway;

export getGDCVerify(DATASET(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata, dataset(Gateway.Layouts.Config) gateways) := FUNCTION

gateway_cfg 	:= gateways(Gateway.Configuration.IsGDCVerify(servicename))[1];
gateway_check := gateway_cfg.url;
GDCVerify_gateway_url := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);
isGatewayOk := GDCVerify_gateway_url<>'';

Layout_Request := record (iesp.iid_international.t_InstantIDInternationalRequest_Unicode)
		boolean isInputOk;
end;

Layout_Request isInDataOK(indata l) := 
transform
	dsIn := project(ut.ds_oneRecord, transform(iesp.iid_international.t_InstantIDInternationalRequest_Unicode, self := l;));
	self.isInputOk := IntlIIDFunctions().hasGDCRequiredFields(dsIn);	// check what is input per country, if bad, then dont call gateway
	self := l;
end;
ok_data := project(indata, isInDataOK(left)); 

// GDC Best Practice: make names lower case so non ASCII characters match 
GDCVerify.Layout_GDCVerify_In_Unicode prep_for_GDCVerify(ok_data L) := transform

	country := IntlIIDFunctions().correctCountry(L.searchby.Address.Country);
	countryCode := IntlIIDFunctions().countryCodeISO2(country);
	uppercase := country IN Constants.UCCountries; 
	
	province := if(country = 'Canada', (unicode)IntlIIDFunctions().correctProvince((string)L.searchby.Address.Province), trim(L.searchby.Address.Province)); 
	
	self.user.QueryId := if(trim(L.user.QueryId) <> '', trim(L.user.QueryId), '1'); // batch seq #
	self.user.ReferenceCode := trim(L.user.ReferenceCode); // batch acct #
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);

	self.searchoptions.SubAccount := trim(L.options.EndUserCompanyId);
	self.searchoptions.CreditFlag := trim(L.options.CreditFlag);
	
	self.searchby.Person.FirstName := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Name.First), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Name.First)));
	self.searchby.Person.MiddleName := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Name.Middle), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Name.Middle)));
	self.searchby.Person.LastName := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Name.Last), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Name.Last)));

	self.searchby.Person.DOB.Year := L.searchby.DOB.Year;
	self.searchby.Person.DOB.Month := L.searchby.DOB.Month;
	self.searchby.Person.DOB.Day := L.searchby.DOB.Day;
	
	self.searchby.Address.FullStreet := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetAddress1), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.StreetAddress1)));
	self.searchby.Address.BuildingNumber := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetNumber), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.StreetNumber)));
	self.searchby.Address.SubBuildingNumber := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.UnitDesignation), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.UnitDesignation)));
	self.searchby.Address.StreetName := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetName), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.StreetName)));
	self.searchby.Address.StreetType := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.StreetSuffix), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.StreetSuffix)));
  // using county as input to Aza as to not have to verison the esp
	self.searchby.Address.Aza := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.County), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.County)));
	self.searchby.Address.CityTown := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.City), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.City)));
	self.searchby.Address.StateDistrict := if(uppercase, province, UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(province)));
	self.searchby.Address.PostalCode := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.PostalCode), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.PostalCode)));
	self.searchby.Address.Country := country;
	self.searchby.Address.CountryCode := countryCode;
	self.searchby.Address.County := if(uppercase, UnicodeLib.UnicodeCleanSpaces(L.searchby.Address.County), UnicodeLib.UnicodeCleanSpaces(unicodelib.unicodetolowercase(L.searchby.Address.County))); // China "Area"
	self.searchby.PhoneNumber := if(trim(L.searchby.HomePhone) <> '', trim(L.searchby.HomePhone),
																if(trim(L.searchby.MobilePhone) <> '', trim(L.searchby.MobilePhone),
																if(trim(L.searchby.WorkPhone) <> '', trim(L.searchby.WorkPhone), '')));
	self.searchby.IdNumber := trim(L.searchby.NationalIDNumber);	

	self := [];
end;
GDCVerify_in := if(isGatewayOk, project(ok_data(isInputOk), prep_for_GDCVerify(left)), dataset([], GDCVerify.Layout_GDCVerify_In_Unicode));

vMakeGWCall := TRIM(gateway_cfg.url) <> '' AND exists(GDCVerify_in);

//TODO: resolve ESP Gateway timeout issues in CERT
gateway_result := Gateway.SoapCall_GDCVerify(GDCVerify_in, gateway_cfg, constants.timeout, constants.retries, vMakeGWCall);


iesp.iid_international.t_InstantIDInternationalResponse_Unicode tran(ok_data le, gateway_result ri) := transform

	dataSourceResults := project(ri.response.datasources, transform(Layout_DataSource, self.results.idnumber := left.results.idcard, self := left, self := []));
	SourceCount_Total := count(dataSourceResults);
	
	dataSourceErrors := dataSourceResults(errormessage <> '' or errorcode <> '');
	SourceCount_Bad := count(dataSourceErrors);
	SourceCount_Good := SourceCount_Total - SourceCount_Bad; 
	SourceErrorSourceID := dataSourceErrors[1].SourceID;  
	SourceErrorCode := dataSourceErrors[1].ErrorCode;  
	SourceErrorMessage := dataSourceErrors[1].ErrorMessage;  
	SourceMessage := if(SourceCount_Bad > 0 , SourceErrorSourceID + ' ' + SourceErrorCode + ' ' + SourceErrorMessage, '');  
	
	Layout_DataSourceStats getStats(dataSourceResults L) := transform

		dsError := L.ErrorCode <> '';
		
		//if first is missing and last matches and first initial matches then consider this a first name match
		altFirstName := if(intliidFunctions().setMatchFlag(L.Results.FirstName, dsError) >= -1 
												and intliidFunctions().setMatchFlag(L.Results.LastName, dsError) > 0 
												and intliidFunctions().setMatchFlag(L.Results.FirstInitial, dsError) > 0, true, false);

		SELF.SourceName := trim(L.SourceName);
		SELF.SourceType := trim(L.SourceType);
		SELF.SourceID := trim(L.SourceId);
		SELF.SourceErrorCode := trim(L.ErrorCode);
		SELF.SourceErrorMessage := trim(L.ErrorMessage);
		
		SELF.Photo:= L.Photo;
		
		// returns -2 unknown, -1 missing, 0 no match, 1 match
		SELF.FirstName := intliidFunctions().setMatchFlag(L.Results.FirstName, dsError);
		SELF.FirstInitial := intliidFunctions().setMatchFlag(L.Results.FirstInitial, dsError);
		SELF.MiddleName := intliidFunctions().setMatchFlag(L.Results.MiddleName, dsError);
		SELF.LastName := intliidFunctions().setMatchFlag(L.Results.LastName, dsError);
		SELF.FullName := intliidFunctions().setMatchFlag(L.Results.FullName, dsError);

		address := intliidFunctions().setMatchFlag(L.Results.Address, dsError);
		fullstreet := intliidFunctions().setMatchFlag(L.Results.FullStreet, dsError);
		SELF.FullStreet := if(address > fullstreet, address, fullstreet);
		SELF.UnitNumber := intliidFunctions().setMatchFlag(L.Results.UnitNumber, dsError);
		SELF.StreetNumber := intliidFunctions().setMatchFlag(L.Results.StreetNumber, dsError);
		SELF.StreetName := intliidFunctions().setMatchFlag(L.Results.StreetName, dsError);
		SELF.StreetType := intliidFunctions().setMatchFlag(L.Results.StreetType, dsError);
		SELF.Aza := intliidFunctions().setMatchFlag(L.Results.Aza, dsError);
		SELF.Suburb := intliidFunctions().setMatchFlag(L.Results.Suburb, dsError);
		SELF.Area := intliidFunctions().setMatchFlag(L.Results.Area, dsError);
		SELF.State := intliidFunctions().setMatchFlag(L.Results.State, dsError);
		SELF.PostalCode := intliidFunctions().setMatchFlag(L.Results.PostalCode, dsError);

		SELF.DayOfBirth := intliidFunctions().setMatchFlag(L.Results.DayOfBirth, dsError);
		SELF.MonthOfBirth := intliidFunctions().setMatchFlag(L.Results.MonthOfBirth, dsError);
		SELF.YearOfBirth := intliidFunctions().setMatchFlag(L.Results.YearOfBirth, dsError);
		SELF.DateOfBirth := if(SELF.DayOfBirth = 1 and SELF.MonthOfBirth = 1 and SELF.YearOfBirth = 1, 1, 
														intliidFunctions().setMatchFlag(L.Results.DateOfBirth, dsError));

		SELF.PhoneNumber := intliidFunctions().setMatchFlag(L.Results.PhoneNumber, dsError);
		SELF.IdNumber := intliidFunctions().setMatchFlag(L.Results.IdNumber, dsError);		
		SELF.AMLBureau := intliidFunctions().setMatchFlag(L.Results.AMLBureau, dsError);		
		
		SELF.isNameVer := if(((self.FirstName > 0 or altFirstName) and self.LastName > 0) or self.FullName > 0, true, false);
		SELF.isFirstVer := if(self.FirstName > 0 or altFirstName or self.FullName > 0, true, false);
		SELF.isLastVer := if(self.LastName > 0 or self.FullName > 0, true, false);
		SELF.isNIDVer := if(self.IdNumber > 0, true, false);
		SELF.isDOBVer := if(self.DateOfBirth > 0 or (self.DayOfBirth > 0 and self.MonthOfBirth > 0 and self.YearOfBirth > 0), true, false);
		SELF.isPhoneVer := if(self.PhoneNumber > 0, true, false);
		SELF.isStAddrVer := if(self.FullStreet > 0 or 
													(self.StreetNumber > 0 and self.StreetName > 0) or 
													(self.SourceID = '40012' and self.StreetName > 0) or	// Germany Credit 2
													(self.SourceID = '40015' and self.StreetName > 0) or 	// Germany Credit
													(self.aza > 0 and (self.streetnumber = -1 or self.streetnumber > 0)),	// Japan Aza
													true, false);
		SELF.isAddrVer := if(self.isStAddrVer and (self.Suburb > 0 or self.PostalCode > 0), true, false);
		SELF.isCityStateVer := if(self.Suburb > 0 and self.State <> 0, true, false);
		SELF.isPCVer := if(self.PostalCode > 0, true, false);

		SELF.MatchCount := if(SELF.isNameVer,1,0) + if(SELF.isStAddrVer,1,0) + if(SELF.isDOBVer,1,0) + if(SELF.isNIDVer,1,0) + if(SELF.isPhoneVer,1,0);
	end;					
	dsStats := project(dataSourceResults, getStats(left));

	iesp.iid_international.t_DataSourceResult  getVerifications(dsStats L) := transform
		SELF.DataSourceName := L.SourceName;
		SELF.DataSourceID := L.SourceID;
		SELF.DataSourceType := L.SourceType;
		SELF.DataSourceError := L.SourceErrorCode;
		SELF.DataSourceMessage := L.SourceErrorMessage;
		SELF.DataSourcePhoto := L.Photo;
		self.DataSourceVerifications := dataset([{'FirstName',L.FirstName>0,(string)L.FirstName},
																						{'FirstInitial',L.FirstInitial>0,(string)L.FirstInitial},
																						{'MiddleName',L.MiddleName>0,(string)L.MiddleName},
																						{'LastName',L.LastName>0,(string)L.LastName},
																						{'FullName',L.FullName>0,(string)L.FullName},
																						{'FullStreet',L.FullStreet>0,(string)L.FullStreet},
																						{'UnitNumber',L.UnitNumber>0,(string)L.UnitNumber},
																						{'StreetNumber',L.StreetNumber>0,(string)L.StreetNumber},
																						{'StreetName',L.StreetName>0,(string)L.StreetName},
																						{'StreetType',L.StreetType>0,(string)L.StreetType},
																						{'Aza',L.Aza>0,(string)L.Aza},
																						{'Suburb',L.Suburb>0,(string)L.Suburb},
																						{'Area',L.Area>0,(string)L.Area},
																						{'State',L.State>0,(string)L.State},
																						{'PostalCode',L.PostalCode>0,(string)L.PostalCode},
																						{'DayOfBirth',L.DayOfBirth>0,(string)L.DayOfBirth},
																						{'MonthOfBirth',L.MonthOfBirth>0,(string)L.MonthOfBirth},
																						{'YearOfBirth',L.YearOfBirth>0,(string)L.YearOfBirth},
																						{'DateOfBirth',L.DateOfBirth>0,(string)L.DateOfBirth},
																						{'PhoneNumber',L.PhoneNumber>0,(string)L.PhoneNumber},
																						{'IdNumber',L.IdNumber>0,(string)L.IdNumber},
																						{'AMLBureau',L.AMLBureau>0,(string)L.AMLBureau}
																						],iesp.iid_international.t_DataSourceVerification);
	end;					
	dsVerification := project(dsStats, getVerifications(left));
	
	country := IntlIIDFunctions().correctCountry(le.searchby.address.country);
	
	dsVL := SORT(dsStats(MatchCount > 1), -MatchCount);
	dsVLCount := count(dsVL); 
	ivi := map( dsVLCount = 0 => '00',
							country = 'Mexico' => IntlIIDFunctions().getIVIMexico(dsVL),
							SourceCount_Good > 1 and dsVLCount > 1 => IntlIIDFunctions().getIVIMultiple(dsVL), 
							SourceCount_Good = 1 or  dsVLCount = 1 => IntlIIDFunctions().getIVISingle(dsVL, SourceCount_Good = 1),
							'00');

	cl := map(dsVLCount = 0 => '0',
						count(dsVL(isNameVer and isAddrVer and (isDOBVer or isNIDVer))) > 1 => '1',
						count(dsVL(isNameVer and isAddrVer and (isDOBVer or isNIDVer))) > 0 => '2',
						count(dsVL(isNameVer and isAddrVer)) > 1 => '2',
						count(dsVL(isNameVer and isAddrVer)) > 0 => '3',
						count(dsVL(isNameVer and isDOBVer)) > 0 => '3',
						count(dsVL(isNameVer and isNIDVer)) > 0 => '3',
						'0');

	FirstNameCount :=  count(dsVL(FirstName > 0));	
	FirstInitialCount :=  count(dsVL(FirstInitial > 0));
	MiddleNameCount :=  count(dsVL(MiddleName > 0));
	LastNameCount :=  count(dsVL(LastName > 0));
	FullNameCount :=  count(dsVL(FullName > 0));
	FullStreetCount :=  count(dsVL(FullStreet > 0));
	UnitNumberCount :=  count(dsVL(UnitNumber > 0));
	StreetNumberCount :=  count(dsVL(StreetNumber > 0));
	StreetNameCount :=  count(dsVL(StreetName > 0));
	StreetTypeCount :=  count(dsVL(StreetType > 0));
	AzaCount :=  count(dsVL(Aza > 0));
	SuburbCount :=  count(dsVL(Suburb > 0));
	AreaCount :=  count(dsVL(Area > 0));
	StateCount :=  count(dsVL(State > 0));
	PostalCodeCount :=  count(dsVL(PostalCode > 0));
	PhoneNumberCount :=  count(dsVL(PhoneNumber > 0));
	DOBCount :=  count(dsVL(isDOBVer = true));
	IdNumberCount :=  count(dsVL(IdNumber > 0));
	AMLBureauCount :=  count(dsVL(AMLBureau > 0));

	isNameVer:= count(dsVL(isNameVer = true)) > 0;
	isFirstNameVer := FirstNameCount > 0;
	isFirstInitialVer := FirstInitialCount > 0;
	isMiddleNameVer := MiddleNameCount > 0;
	isLastNameVer := LastNameCount > 0;
	isFullNameVer := FullNameCount > 0;

	isAddressVer := count(dsVL(isAddrVer = true)) > 0; 
	isFullStreetVer := FullStreetCount > 0;
	isUnitNumberVer := UnitNumberCount > 0;
	isStreetNumberVer := StreetNumberCount > 0;
	isStreetNameVer := StreetNameCount > 0;
	isStreetTypeVer := StreetTypeCount > 0;
	isAzaVer := AzaCount > 0;
	isSuburbVer := SuburbCount > 0;
	isAreaVer := AreaCount > 0;
	isStateVer := StateCount > 0;
	isPostalCodeVer := PostalCodeCount > 0;

	isPhoneNumberVer := PhoneNumberCount > 0;
	isDOBVer := DOBCount > 0;
	isIdNumberVer := IdNumberCount > 0;
	isAMLBureauVer := AMLBureauCount > 0;

	isPhoneFound := count(dsStats(isPhoneVer = true)) > 0;
	isNIDFound := count(dsStats(isNIDVer = true)) > 0;

	GatewayError := if(ri.Response.Header.ErrorMessage <> '' or ri.Response.Header.ErrorCode <> 0, true, false);
	GDCError := if(ri.Response.Header.GDCErrorMessage <> '' or ri.Response.Header.GDCErrorCode <> '', true, false);
	badResponse := ~le.isInputOk or GatewayError or GDCError or SourceCount_Good < 1;

	self.result.isBillable := ~badResponse;
	self.result.BillingCountry := country;
	self.result.BillingCountryCode := IntlIIDFunctions().countryCodeISO3(country);

	self._header.status := if(~badResponse, 0, 1);
	
	self._header.message := if(SourceMessage <> '', 'Data Source Error: ' + SourceMessage, ''); // non fatal error
	
	self._header.Exceptions := CHOOSEN(
		IF(~le.isInputOk and ~(country in Constants.GDCCountries), DATASET([{'ECL', 301,'','Invalid Country'}],iesp.share.t_WsException)) &
		IF(~le.isInputOk, DATASET([{'ECL', 301,'','Insufficient input, missing required fields'}],iesp.share.t_WsException)) &
		IF(GDCError, DATASET([{'GDC Gateway',(integer)ri.Response.Header.GDCErrorCode,'', ri.Response.Header.GDCErrorMessage}],iesp.share.t_WsException)) &
		IF(GatewayError, DATASET([{'Gateway ESP',ri.Response.Header.ErrorCode,'',ri.Response.Header.ErrorMessage}],iesp.share.t_WsException)) &
		IF(SourceCount_Total > 0 and SourceCount_Good = 0, DATASET([{'GDC Gateway ' + SourceErrorSourceID, (integer)SourceErrorCode,'',SourceErrorMessage}],iesp.share.t_WsException))
		, 1); // these fatal error conditions will be mutually exclusive
		
	self._header.queryid := le.user.queryid;	// use this for joining later batch seq number
	self._header.transactionid := le.user.referencecode; // batch account number
	self._header := [];
	self.result.inputecho := le.searchby;	
	
	dob := intformat(le.searchby.dob.year, 4, 1)[3..4] + intformat(le.searchby.dob.month, 2, 1) + intformat(le.searchby.dob.day, 2, 1);
	validPassport := ValidationFunctions().PassportValidation(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2, dob, le.searchby.gender);
	validVisa := ValidationFunctions().VisaValidation(le.searchby.visa.MachineReadableLine1+le.searchby.visa.MachineReadableLine2, dob, le.searchby.gender);
	self.result.PassportNumberValidated := validPassport;
	self.result.VisaNumberValidated := validVisa;

	correctDays(string month, string day) := map((unsigned)month in [1,3,5,7,8,10,12] => (unsigned)day between 1 and 31,
																							 (unsigned)month in [4,6,9,11] => (unsigned)day between 1 and 30,
																							 (unsigned)day between 1 and 29);

	pptrim := trim(stringlib.stringtouppercase(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2));
	isPassportExpired := stringlib.stringfilterout(pptrim[66..71],'0123456789')='' and // check all numeric
											(unsigned)('20'+pptrim[66..71]) < (unsigned)ut.GetDate and 	// check date greater than today
											(unsigned1)pptrim[68..69] between 1 and 12 and correctDays(pptrim[68..69], pptrim[70..71]); // check reasonable dates;

	Vtrim := trim(stringlib.stringtouppercase(le.searchby.visa.MachineReadableLine1+le.searchby.visa.MachineReadableLine2));
	isVisaExpired := stringlib.stringfilterout(Vtrim[66..71],'0123456789')='' and // check all numeric
									(unsigned)('20'+Vtrim[66..71]) < (unsigned)ut.GetDate and 	// check date greater than today
									(unsigned1)Vtrim[68..69] between 1 and 12 and correctDays(Vtrim[68..69], Vtrim[70..71]); // check reasonable dates
	
	self.result.InternationalVerificationIndex := ivi;
	self.result.ComplianceLevel := cl;
	self.result.VerificationIndex.IVI := ivi;
		
	self.result.VerificationResults := dataset([{'FirstName',isFirstNameVer,FirstNameCount},
																							{'FirstInitial',isFirstInitialVer,FirstInitialCount},
																							{'MiddleName',isMiddleNameVer,MiddleNameCount},
																							{'LastName',isLastNameVer,LastNameCount},
																							{'FullName',isFullNameVer,FullNameCount},
																							{'FullStreet',isFullStreetVer,FullStreetCount},
																							{'UnitNumber',isUnitNumberVer,UnitNumberCount},
																							{'StreetNumber',isStreetNumberVer,StreetNumberCount},
																							{'StreetName',isStreetNameVer,StreetNameCount},
																							{'StreetType',isStreetTypeVer,StreetTypeCount},
																							{'Aza',isAzaVer,AzaCount},
																							{'Suburb',isSuburbVer,SuburbCount},
																							{'Area',isAreaVer,AreaCount},
																							{'State',isStateVer,StateCount},
																							{'PostalCode',isPostalCodeVer,PostalCodeCount},
																							{'PhoneNumber',isPhoneNumberVer,PhoneNumberCount},
																							{'DOB',isDOBVer,DOBCount},
																							{'IdNumber',isIdNumberVer,IdNumberCount},
																							{'AMLBureau',isAMLBureauVer,AMLBureauCount}
																							],iesp.iid_international.t_VerificationResult);
	
	self.result.DataSourceResults := dsVerification;

	fnamePop := trim(le.searchby.name.first) <> U'' or country = 'China';
	lnamePop := trim(le.searchby.name.last) <> U'';
	
	fullStreetPop := trim(le.searchby.address.streetAddress1) <> U'';
	streetNamePop := trim(le.searchby.address.streetName) <> U'';
	streetNumberPop := trim(le.searchby.address.streetNumber) <> U'';
	unitNumberPop := trim(le.searchby.address.unitDesignation) <> U'';
	cityPop := trim(le.searchby.address.city) <> U'';
	provincePop := trim(le.searchby.address.province) <> U'';
	postalCodePop := le.searchby.address.postalCode <> U'';
	countryPop := country <> '';
	addressPop := (fullstreetPop or (streetNamePop and streetNumberPop)) and (postalCodePop or (cityPop and provincePop)) and countryPop;

	dobYearPop := le.searchby.dob.year <> 0;
	dobMonthPop := le.searchby.dob.month <> 0;
	dobDayPop := le.searchby.dob.day <> 0;
	dobPop := dobYearPop and dobMonthPop and dobDayPop;
	
	natID := trim(le.searchby.nationalIDNumber);
	nationalIDPop := natID <> '';
	
	phone := 	if(trim(le.searchby.HomePhone) <> '', trim(le.searchby.HomePhone),
						if(trim(le.searchby.MobilePhone) <> '', trim(le.searchby.MobilePhone),
						if(trim(le.searchby.WorkPhone) <> '', trim(le.searchby.WorkPhone), '')));
	phonePop := phone <> '';

	SourceHasNID := if(country = 'China' or 
										(country = 'Canada' and le.options.CreditFlag = '1') or  
										(country = 'South Africa' and le.options.CreditFlag = '1'), 
										true, false);

	ppLen := length(trim(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2));
	vLen := length(trim(le.searchby.visa.MachineReadableLine1+le.searchby.visa.MachineReadableLine2));
	isDeceased := false; // added to MAC_ReturnCodes for GG2
	passportPop := false; // added to MAC_ReturnCodes for GG2
	isPassportVer := false; // added to MAC_ReturnCodes for GG2
	driverPop := false; // added to MAC_ReturnCodes for GG2
	isDriverVer := false; // added to MAC_ReturnCodes for GG2
	rc := MAC_ReturnCodes(iesp.Constants.MaxCountHRI, SourceCount_Good);

	self.result.riskindicators := map(~le.isInputOk => dataset([{'I01',getRCdesc('I01')}],iesp.share.t_RiskIndicator),	// if input missing hardcode to reason code 1
																		rc);	
	
	self.result.watchlist := [];
	self.result.ipaddressinfo := [];	

	self.CountrySettings := if(le.options.CreditFlag = '1', 
															IntlIIDFunctions().dsCountrySetupCredit(CountryName=country), 
															IntlIIDFunctions().dsCountrySetup(CountryName=country));
	
	self := [];	
		
end;
GDCVerify := join(ok_data, gateway_result, trim(left.user.QueryId)=trim(right.response.header.queryid), tran(left,right), left outer);


// output(ok_data, named('OKData'));
// output(GDCVerify_in, named('GDCVerifyInput'));
// output(gateway_result, named('GatewayResult'));
// output(GDCVerify, named('GDCVerify'));

return GDCVerify;
end;
