import doxie, iesp, GBID3, Risk_Indicators, Riskwise, ut;

export getGBID3(DATASET(iesp.iid_international.t_InstantIDInternationalRequest) indata, dataset(Risk_Indicators.Layout_Gateways_In) gateways) := FUNCTION


gateway_check := gateways (servicename = 'gbgroup')[1].url;
GBID3_gateway_url := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);


isInputOk := IntlIIDFunctions().hasGBRequiredFields(indata);	// check what is input per country, if bad, then dont call gateway



GBID3.layout_GBID3_in prep_for_GBID3(indata L) := transform
	self.user.referenceCode := trim(L.user.referenceCode);
	self.user.BillingCode := trim(L.user.BillingCode);
	self.user.queryId := trim(L.user.QueryId);
	self.user.GLBPurpose := trim(L.user.GLBPurpose);
	self.user.DLPurpose := trim(L.user.DLPurpose);
	
	
	country := IntlIIDFunctions().correctCountry((L.searchby.Address.Country));
	
	self.searchby.RequestDetails.Profile := country;	
	
	// input will only allow 3 bytes - trying to account for all mis-inputs
	self.searchby.Person.Title := map(trim(StringLib.StringToLowerCase(L.searchby.Name.Prefix)) in ['mr','mr.'] => 'Mr',	
																		trim(StringLib.StringToLowerCase(L.searchby.Name.Prefix)) in ['mrs'] => 'Mrs',
																		trim(StringLib.StringToLowerCase(L.searchby.Name.Prefix)) in ['mis','ms','ms.'] => 'Miss',
																		trim(StringLib.StringToLowerCase(L.searchby.Name.Prefix)) in ['dr','dr.'] => 'Dr',
																		'Other');	// default to Other if no input or bad input
	self.searchby.Person.FirstName := trim(L.searchby.Name.First);
	self.searchby.Person.MiddleName := trim(L.searchby.Name.Middle);
	self.searchby.Person.LastName := trim(L.searchby.Name.Last);
	self.searchby.Person.Gender := Map(trim(StringLib.StringToLowerCase(L.searchby.Gender)) in ['male','m'] => 'Male',
																		 trim(StringLib.StringToLowerCase(L.searchby.Gender)) in ['female','f'] => 'Female',
																		 '(unknown)');
	self.searchby.Person.DOB.Year := L.searchby.DOB.Year;
	self.searchby.Person.DOB.Month := L.searchby.DOB.Month;
	self.searchby.Person.DOB.Day := L.searchby.DOB.Day;
	
	self.searchby.Addresses.Address1.AddressLayout := country;
	self.searchby.Addresses.Address1.BuildingNumber := trim(L.searchby.Address.StreetNumber);
	self.searchby.Addresses.Address1.SubBuildingNumber := trim(L.searchby.Address.UnitDesignation);
	self.searchby.Addresses.Address1.Street := if(trim(L.searchby.Address.StreetAddress1) <> '', trim(L.searchby.Address.StreetAddress1), trim(L.searchby.Address.StreetName));
	self.searchby.Addresses.Address1.CityTown := trim(L.searchby.Address.City);
	self.searchby.Addresses.Address1.StateDistrict := trim(L.searchby.Address.Province);
	self.searchby.Addresses.Address1.Country := /*if(country<>'Ireland', */country/*, '')*/;	// ireland was not working when passed in this field
	self.searchby.Addresses.Address1.ZipPCode := trim(L.searchby.Address.PostalCode);
	
	self.searchby.Telephones.HomeTelephone.Number := trim(L.searchby.HomePhone);
	self.searchby.Telephones.HomeTelephone.Published := L.searchby.IsHomePhonePublished;
	self.searchby.Telephones.WorkTelephone.Number := trim(L.searchby.WorkPhone);
	self.searchby.Telephones.WorkTelephone.Published := L.searchby.IsWorkPhonePublished;
	self.searchby.Telephones.MobileTelephone.Number := trim(L.searchby.MobilePhone);
	self.searchby.Telephones.MobileTelephone.Published := L.searchby.IsMobilePhonePublished;
	
	self.searchby.Identity.IDCardNumber := trim(L.searchby.NationalIDNumber);
	
	self := [];
end;
GBID3_in := project(indata, prep_for_GBID3(left));


gateway_result := if(GBID3_gateway_url!='' and isInputOk, 
													GBID3.GBID3_SoapCall_Function(GBID3_in, GBID3_gateway_url, constants.timeout, constants.retries), 
													dataset([],GBID3.Layout_GBID3_Out));
													

Layout_ID3CheckResponseResultsDef1B := RECORD
	string UID ;
	string UIDDescription;
	string ResultCode;
	string ResultDescription;
END;

iesp.iid_international.t_InstantIDInternationalResponse tran(indata le, gateway_result ri) := transform

	c := project(ri.response.id3check1bresult.id3checkresponseresults.id3checkresponseresultsdef1bs(uid not in ['0118','0153','0200']), transform(Layout_ID3CheckResponseResultsDef1B, self := left));
	
	badResponse := ri.Response.Header.ErrorMessage <> '';
	self.result.isBillable := ~badResponse and (count(c(c.resultcode='9999')) - count(c(c.uid+resultcode='02009999')) < 1);	// dont bill if 9999 comes back unless it is 02009999, note this will bill if we dont run the gateway per missing input

	country := IntlIIDFunctions().correctCountry(le.searchby.address.country);
	self.result.BillingCountry := country;
	self.result.BillingCountryCode := IntlIIDFunctions().countryCodeISO3(country);

	self._header.status := if(~badResponse, 0, 1);
	//self._header.message := ri.Response.Header.ErrorMessage;
	self._header.Exceptions := CHOOSEN(
		IF(~isInputOk, DATASET([{'ECL', 301,'','Insufficient input'}],iesp.share.t_WsException)) &
		IF(badResponse, DATASET([{'Gateway Result',ri.Response.Header.ErrorCode,'',ri.Response.Header.ErrorMessage}],iesp.share.t_WsException))
		, 1); // these fatal error conditions will be mutually exclusive
		
	self._header.queryid := le.user.queryid;	// use this for joining later
	self._header := [];
	
	self.result.inputecho := le.searchby;	
	
	dob := intformat(le.searchby.dob.year, 4, 1)[3..4] + intformat(le.searchby.dob.month, 2, 1) + intformat(le.searchby.dob.day, 2, 1);
	self.result.PassportNumberValidated := intliidFunctions().passportValidation(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2, dob, le.searchby.gender);

	fnamePop := trim(le.searchby.name.first) <> '';
	lnamePop := trim(le.searchby.name.last) <> '';
	streetPop := trim(le.searchby.address.streetAddress1) <> '' OR trim(le.searchby.address.streetname) <> '';
	buildPop := trim(le.searchby.address.streetNumber) <> '';
	subBuildPop := trim(le.searchby.address.unitDesignation) <> '';
	cityPop := trim(le.searchby.address.city) <> '';
	provincePop := trim(le.searchby.address.province) <> '';
	postalCodePop := le.searchby.address.postalCode<>'';
	countryPop := country in ['Australia','Germany','Ireland','Norway','Sweden'];
	addrPop := streetPop and buildPop and (postalCodePop or cityPop or provincePop) and countryPop;
	dobYearPop := le.searchby.dob.year<>0;
	dobMonthPop := le.searchby.dob.month<>0;
	dobDayPop := le.searchby.dob.day<>0;
	dobPop := dobYearPop and dobMonthPop and dobDayPop;
	natIDPop := trim(le.searchby.nationalIDNumber) <> '';
	lPhonePop := trim(le.searchby.homephone) <> '';
	mPhonePop := trim(le.searchby.mobilephone) <> '';

	firstCount :=  ut.imin2(count(c(c.uid+resultcode in constants.fnm or c.uid+resultcode in constants.fnp)), 2);					// default to 0, cap at 2
	lastCount := ut.imin2(count(c(c.uid+resultcode in constants.lnm or c.uid+resultcode in constants.lnp)), 2);						// default to 0, cap at 2
	addrCount := ut.imin2(count(c(c.uid+resultcode in constants.addrm or c.uid+resultcode in constants.addrp)), 2);				// default to 0, cap at 2
	landCount := ut.imin2(count(c(c.uid+resultcode in constants.landm or c.uid+resultcode in constants.landp)), 2);				// default to 0, cap at 2
	mobileCount := ut.imin2(count(c(c.uid+resultcode in constants.mobilem or c.uid+resultcode in constants.mobilep)), 2);	// default to 0, cap at 2
	dobCount := ut.imin2(count(c(c.uid+resultcode in constants.DOBm or c.uid+resultcode in constants.DOBp)), 2);					// default to 0, cap at 2
	idCount := ut.imin2(count(c(c.uid+resultcode in constants.idm or c.uid+resultcode in constants.idp)), 2);							// default to 0, cap at 2
	
	isFirstVer := firstCount>0;
	isLastVer := lastCount>0;
	isAddrVer := addrCount>0;
	isLandVer := landCount>0;
	isMobileVer := mobileCount>0;
	isDobVer := dobCount>0;
	isIDVer := idCount>0;

	self.result.VerificationResults := dataset([{'First',isFirstVer,firstCount},
																							{'Last',isLastVer,lastCount},
																							{'StreetNumber',if(buildPop,isAddrVer,false),if(buildPop,addrCount,0)},
																							{'UnitDesignation',if(subBuildPop,isAddrVer,false),if(subBuildPop,addrCount,0)},
																							{'StreetAddress1',if(streetPop,isAddrVer,false),if(streetPop,addrCount,0)},
																							{'City',if(cityPop,isAddrVer,false),if(cityPop,addrCount,0)},
																							{'Province',if(provincePop,isAddrVer,false),if(provincePop,addrCount,0)},
																							{'PostalCode',if(postalCodePop,isAddrVer,false),if(postalCodePop,addrCount,0)},
																							{'Country',if(countryPop,isAddrVer,false),if(countryPop,addrCount,0)},
																							{'HomePhone',isLandVer,landCount},
																							{'MobilePhone',isMobileVer,mobileCount},
																							{'DOB',isDobVer,dobCount},
																							{'NationalIDNumber',isIDVer,idCount}],iesp.iid_international.t_VerificationResult);
	
	self.result.DataSourceResults := [];

	// self.c := c;// can remove when going to production
	
	ivi := IntlIIDFunctions().getGBIVI(country, firstCount, lastCount, addrCount, landCount+mobileCount, dobCount, idCount);
	self.result.InternationalVerificationIndex := ivi;
	self.result.VerificationIndex.IVI := ivi;
	self.result.VerificationIndex.CitVL := '0';
	self.result.VerificationIndex.ComVL := '0';

	
	addronlymatch := firstCount = 0 and lastCount = 0 and addrCount>0 and landCount = 0 and mobileCount = 0 and dobCount = 0 and idCount = 0;
	
	rc := returnCodes(c, 10, country, addronlymatch, le.searchby.gender, isFirstVer, isLastVer, isAddrVer, isDOBVer, isLandVer, isMobileVer, isIDVer, 
										fnamePop, lnamePop, addrPop, dobPop, natIDPop, lPhonePop, mPhonePop);
	self.result.riskindicators := map(~isInputOk => dataset([{'0001',getRCdesc('0001')}],iesp.share.t_RiskIndicator),	// if input missing hardcode to reason code 1
																		badResponse => dataset([{'9999',getRCdesc('9999')}],iesp.share.t_RiskIndicator),// if gateway is down hardcoe to reason code 9999
																		rc);	
	
																			
	self.result.watchlist := [];
	self.result.ipaddressinfo := [];	

	self.CountrySettings := IntlIIDFunctions().dsCountrySetup(CountryName=country);
end;
gbid3 := join(indata, gateway_result, trim(left.user.QueryId)=trim(right.response.header.queryid)/* and right.Response.Header.ErrorMessage = ''*/, tran(left,right), left outer);

//output(gateway_result, named('gateway_result'));
// output(gbid3, named('gbid3'));
return gbid3;

end;
