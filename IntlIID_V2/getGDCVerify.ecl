import doxie, iesp, GDCVerify, Risk_Indicators, Riskwise, ut;

export getGDCVerify(DATASET(iesp.iid_international.t_InstantIDInternationalRequest) indata, dataset(Risk_Indicators.Layout_Gateways_In) gateways) := FUNCTION

gateway_check := gateways (servicename = 'gdcverify')[1].url;
GDCVerify_gateway_url := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);

// GDC Best Practice: make names lower case so non ASCII characters match 
GDCVerify.layout_GDCVerify_in prep_for_GDCVerify(indata L) := transform

	country := IntlIIDFunctions().correctCountry(L.searchby.Address.Country);
	countryCode := IntlIIDFunctions().countryCodeISO2(country);
	uppercase := country IN IntlIID_V2.Constants.UCCountries; 
	
	self.user.ReferenceCode := trim(L.user.ReferenceCode);
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.QueryId := trim(L.user.QueryId);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);
	
	self.searchby.Person.FirstName := if(uppercase, trim(L.searchby.Name.First), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Name.First)));
	self.searchby.Person.MiddleName := if(uppercase, trim(L.searchby.Name.Middle), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Name.Middle)));
	self.searchby.Person.LastName := if(uppercase, trim(L.searchby.Name.Last), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Name.Last)));
	
	self.searchby.Person.DOB.Year := L.searchby.DOB.Year;
	self.searchby.Person.DOB.Month := L.searchby.DOB.Month;
	self.searchby.Person.DOB.Day := L.searchby.DOB.Day;
	
	self.searchby.Address.FullStreet := if(uppercase, trim(L.searchby.Address.StreetAddress1), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Address.StreetAddress1)));
	self.searchby.Address.BuildingNumber := trim(L.searchby.Address.StreetNumber);
	self.searchby.Address.SubBuildingNumber := trim(L.searchby.Address.UnitDesignation);
	self.searchby.Address.StreetName := if(uppercase, trim(L.searchby.Address.StreetName), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Address.StreetName)));
	self.searchby.Address.StreetType := trim(L.searchby.Address.StreetSuffix);
	self.searchby.Address.CityTown := if(uppercase, trim(L.searchby.Address.City), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Address.City)));
	self.searchby.Address.StateDistrict := if(uppercase, trim(L.searchby.Address.Province), trim((string)unicodelib.unicodetolowercase((unicode)L.searchby.Address.Province)));
	self.searchby.Address.PostalCode := trim(L.searchby.Address.PostalCode);
	self.searchby.Address.Country := country;
	self.searchby.Address.CountryCode := countryCode;
	
	self.searchby.PhoneNumber := if(trim(L.searchby.HomePhone) <> '', trim(L.searchby.HomePhone),
																if(trim(L.searchby.MobilePhone) <> '', trim(L.searchby.MobilePhone),
																if(trim(L.searchby.WorkPhone) <> '', trim(L.searchby.WorkPhone), '')));
	self.searchby.IdNumber := trim(L.searchby.NationalIDNumber);	

	self := [];
end;
GDCVerify_in := project(indata, prep_for_GDCVerify(left));

isInputOk := IntlIIDFunctions().hasGDCRequiredFields(indata);	// check what is input per country, if bad, then dont call gateway

gateway_result := if(GDCVerify_gateway_url!='' and isInputOk, 
										GDCVerify.GDCVerify_SoapCall_Function(GDCVerify_in, GDCVerify_gateway_url, constants.timeout, constants.retries), 
										dataset([],GDCVerify.Layout_GDCVerify_Out));

dataSources := gateway_result(response.header.queryid = GDCVerify_in[1].user.QueryId)[1].response.datasources;
dataSourceResults := project(dataSources, transform(Layout_DataSource, self.results.idnumber := left.results.idcard, self := left, self := []));
dataSourceErrors := dataSourceResults(errormessage <> '' or errorcode <> '');
dataSourceErrorSource := if(count(dataSourceErrors) > 0 , dataSourceErrors[1].SourceID, '');  
dataSourceErrorCode := if(count(dataSourceErrors) > 0 , dataSourceErrors[1].ErrorCode, '');  
dataSourceErrorMessage := if(count(dataSourceErrors) > 0 , dataSourceErrors[1].ErrorMessage, '');  
dataSourceMessage := if(count(dataSourceErrors) > 0 , dataSourceErrors[1].SourceID + ' ' + dataSourceErrors[1].ErrorCode + ' ' + dataSourceErrors[1].ErrorMessage, '');  
dataSourceCount := count(dataSourceResults) - count(dataSourceErrors);

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
	
	SELF.isCit := SELF.SourceType IN Constants.setCit;
	SELF.isCom := SELF.SourceType IN Constants.setCom; 
	
	// returns -2 unknown, -1 missing, 0 no match, 1 match
	SELF.FirstName := intliidFunctions().setMatchFlag(L.Results.FirstName, dsError);
	SELF.FirstInitial := intliidFunctions().setMatchFlag(L.Results.FirstInitial, dsError);
	SELF.MiddleName := intliidFunctions().setMatchFlag(L.Results.MiddleName, dsError);
	SELF.LastName := intliidFunctions().setMatchFlag(L.Results.LastName, dsError);
	SELF.FullName := intliidFunctions().setMatchFlag(L.Results.FullName, dsError);

	SELF.FullStreet := intliidFunctions().setMatchFlag(L.Results.FullStreet, dsError);
	SELF.UnitNumber := intliidFunctions().setMatchFlag(L.Results.UnitNumber, dsError);
	SELF.StreetNumber := intliidFunctions().setMatchFlag(L.Results.StreetNumber, dsError);
	SELF.StreetName := intliidFunctions().setMatchFlag(L.Results.StreetName, dsError);
	SELF.StreetType := intliidFunctions().setMatchFlag(L.Results.StreetType, dsError);
	SELF.Suburb := intliidFunctions().setMatchFlag(L.Results.Suburb, dsError);
	SELF.Area := intliidFunctions().setMatchFlag(L.Results.Area, dsError);
	SELF.State := intliidFunctions().setMatchFlag(L.Results.State, dsError);
	SELF.PostalCode := intliidFunctions().setMatchFlag(L.Results.PostalCode, dsError);

	SELF.DayOfBirth := intliidFunctions().setMatchFlag(L.Results.DayOfBirth, dsError);
	SELF.MonthOfBirth := intliidFunctions().setMatchFlag(L.Results.MonthOfBirth, dsError);
	SELF.YearOfBirth := intliidFunctions().setMatchFlag(L.Results.YearOfBirth, dsError);
	SELF.DateOfBirth := intliidFunctions().setMatchFlag(L.Results.DateOfBirth, dsError);

	SELF.PhoneNumber := intliidFunctions().setMatchFlag(L.Results.PhoneNumber, dsError);
	SELF.IdNumber := intliidFunctions().setMatchFlag(L.Results.IdNumber, dsError);		
	
	SELF.isNameVer := if(((self.FirstName > 0 or altFirstName) and self.LastName > 0) or self.FullName > 0, true, false);
	SELF.isFirstVer := if(self.FirstName > 0 or altFirstName or self.FullName > 0, true, false);
	SELF.isLastVer := if(self.LastName > 0 or self.FullName > 0, true, false);
	SELF.isAddrVer := intliidFunctions().AddressVerification(self.FullStreet, self.UnitNumber, self.StreetNumber, self.StreetName, self.StreetType, self.Suburb, self.Area, self.State, self.PostalCode);
	SELF.isNIDVer := if(self.IdNumber > 0, true, false);
	SELF.isDOBVer := if(self.DateOfBirth > 0 or (self.DayOfBirth > 0 and self.MonthOfBirth > 0 and self.YearOfBirth > 0), true, false);
	SELF.isPhoneVer := if(self.PhoneNumber > 0, true, false);

	// returns 0-12
	SELF.citVL := if(self.isCit, intliidFunctions().getCitVL(self.isFirstVer, self.isLastVer, self.isAddrVer, self.isNIDVer), 0); 
	SELF.comVL := if(self.isCom, intliidFunctions().getComVL(self.isFirstVer, self.isLastVer, self.isAddrVer, self.isDOBVer, self.isPhoneVer), 0); 
	SELF.VerLevel := if(self.isCit, self.citVL, self.comVL);
	//self := [];
end;					
dsStats := project(dataSourceResults, getStats(left));

iesp.iid_international.t_DataSourceResult  getVerifications(dsStats L) := transform
	SELF.DataSourceName := L.SourceName;
	SELF.DataSourceID := L.SourceID;
	SELF.DataSourceType := L.SourceType;
	SELF.DataSourceError := L.SourceErrorCode;
	SELF.DataSourceMessage := L.SourceErrorMessage;
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
																					{'Suburb',L.Suburb>0,(string)L.Suburb},
																					{'Area',L.Area>0,(string)L.Area},
																					{'State',L.State>0,(string)L.State},
																					{'PostalCode',L.PostalCode>0,(string)L.PostalCode},
																					{'DayOfBirth',L.DayOfBirth>0,(string)L.DayOfBirth},
																					{'MonthOfBirth',L.MonthOfBirth>0,(string)L.MonthOfBirth},
																					{'YearOfBirth',L.YearOfBirth>0,(string)L.YearOfBirth},
																					{'DateOfBirth',L.DateOfBirth>0,(string)L.DateOfBirth},
																					{'PhoneNumber',L.PhoneNumber>0,(string)L.PhoneNumber},
																					{'IdNumber',L.IdNumber>0,(string)L.IdNumber}
																					],iesp.iid_international.t_DataSourceVerification);
  self.DataSourcePhoto := '';
end;					
dsVerification := project(dsStats, getVerifications(left));

dsCit := CHOOSEN(SORT(dsStats(isCit), -citVL), 1);
CitVL := if(count(dsCit) > 0, dsCit[1].citVL, 0);

dsCom := CHOOSEN(SORT(dsStats(isCom), -comVL), 1);
ComVL := if(count(dsCom) > 0, dsCom[1].comVL, 0);

ivi := IntlIIDFunctions().getGDCIVI(ComVL, CitVL);

dsVL := CHOOSEN(SORT(dsStats(VerLevel > 1), -VerLevel), 2);

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
SuburbCount :=  count(dsVL(Suburb > 0));
AreaCount :=  count(dsVL(Area > 0));
StateCount :=  count(dsVL(State > 0));
PostalCodeCount :=  count(dsVL(PostalCode > 0));
PhoneNumberCount :=  count(dsVL(PhoneNumber > 0));
DOBCount :=  count(dsVL(isDOBVer = true));
IdNumberCount :=  count(dsVL(IdNumber > 0));

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
isSuburbVer := SuburbCount > 0;
isAreaVer := AreaCount > 0;
isStateVer := StateCount > 0;
isPostalCodeVer := PostalCodeCount > 0;

isPhoneNumberVer := PhoneNumberCount > 0;
isDOBVer := DOBCount > 0;
isIdNumberVer := IdNumberCount > 0;

iesp.iid_international.t_InstantIDInternationalResponse tran(indata le, gateway_result ri) := transform

	GatewayError := if(ri.Response.Header.ErrorMessage <> '' or ri.Response.Header.ErrorCode <> 0, true, false);
	GDCError := if(ri.Response.Header.GDCErrorMessage <> '' or ri.Response.Header.GDCErrorCode <> '', true, false);
	badResponse := ~isInputOk or GatewayError or GDCError or dataSourceCount < 1;

	self.result.isBillable := ~badResponse;

	country := IntlIIDFunctions().correctCountry(le.searchby.address.country);
	self.result.BillingCountry := country;
	self.result.BillingCountryCode := IntlIIDFunctions().countryCodeISO3(country);
		
	self._header.status := if(~badResponse, 0, 1);
	self._header.message := if(dataSourceMessage <> '', 'Data Source Error: ' + dataSourceMessage, ''); // non fatal error
	
	self._header.Exceptions := CHOOSEN(
		IF(~isInputOk, DATASET([{'ECL', 301,'','Insufficient input'}],iesp.share.t_WsException)) &
		IF(GatewayError, DATASET([{'Gateway ESP',ri.Response.Header.ErrorCode,'',ri.Response.Header.ErrorMessage}],iesp.share.t_WsException)) &
		IF(GDCError, DATASET([{'GDC Gateway',(integer)ri.Response.Header.GDCErrorCode,'', ri.Response.Header.GDCErrorMessage}],iesp.share.t_WsException)) &
		IF(count(dataSourceResults) > 0 and dataSourceCount = 0, DATASET([{'GDC Gateway ' + dataSourceErrorSource,(integer)dataSourceErrorCode,'',dataSourceErrorMessage}],iesp.share.t_WsException))
		, 1); // these fatal error conditions will be mutually exclusive
		
	self._header.queryid := le.user.queryid;	// use this for joining later
	self._header := [];
	
	self.result.inputecho := le.searchby;	
	
	dob := intformat(le.searchby.dob.year, 4, 1)[3..4] + intformat(le.searchby.dob.month, 2, 1) + intformat(le.searchby.dob.day, 2, 1);
	self.result.PassportNumberValidated := intliidFunctions().passportValidation(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2, dob, le.searchby.gender);
	
	self.result.InternationalVerificationIndex := ivi;
	self.result.VerificationIndex.IVI := ivi;
	self.result.VerificationIndex.CitVL := (string)CitVL;
	self.result.VerificationIndex.ComVL := (string)ComVL;
	
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
																							{'Suburb',isSuburbVer,SuburbCount},
																							{'Area',isAreaVer,AreaCount},
																							{'State',isStateVer,StateCount},
																							{'PostalCode',isPostalCodeVer,PostalCodeCount},
																							{'PhoneNumber',isPhoneNumberVer,PhoneNumberCount},
																							{'DOB',isDOBVer,DOBCount},
																							{'IdNumber',isIdNumberVer,IdNumberCount}
																							],iesp.iid_international.t_VerificationResult);
	
	self.result.DataSourceResults := dsVerification;

	fnamePop := trim(le.searchby.name.first) <> '';
	lnamePop := trim(le.searchby.name.last) <> '';
	
	fullStreetPop := trim(le.searchby.address.streetAddress1) <> '';
	streetNamePop := trim(le.searchby.address.streetName) <> '';
	streetNumberPop := trim(le.searchby.address.streetNumber) <> '';
	unitNumberPop := trim(le.searchby.address.unitDesignation) <> '';
	cityPop := trim(le.searchby.address.city) <> '';
	provincePop := trim(le.searchby.address.province) <> '';
	postalCodePop := le.searchby.address.postalCode <> '';
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

	rc := MAC_ReturnCodes(iesp.Constants.MaxCountHRI);

	self.result.riskindicators := map(~isInputOk => dataset([{'I01',getRCdesc('I01')}],iesp.share.t_RiskIndicator),	// if input missing hardcode to reason code 1
																		rc);	
	
	self.result.watchlist := [];
	self.result.ipaddressinfo := [];	

	self.CountrySettings :=  IntlIIDFunctions().dsCountrySetup(CountryName=country);

	self := [];	
		
end;
GDCVerify := join(indata, gateway_result, trim(left.user.QueryId)=trim(right.response.header.queryid)/* and right.Response.Header.ErrorMessage = ''*/, tran(left,right), left outer, ALL);

// use for diagnosing results
//output(GDCVerify_in, named('GDCVerifyInput'));
//output(gateway_result, named('GatewayResult'));
//output(gateway_result[1].response.header.URL, named('URL'));
//output(dataSources, named('DataSources'));
//output(dsStats, named('Statistics'));	
//output(CitVL, named('CitVL'));
//output(ComVL, named('ComVL'));
//output(dsVL, named('VerificationLevel'));
//output(ivi, named('IVI'));
//output(GDCVerify, named('GDCVerify'));

return GDCVerify;

end;
