import doxie, iesp, GBID3, Risk_Indicators, Riskwise, ut;

export getGBID3(DATASET(iesp.instantid.t_InstantIDInternationalRequest) indata, dataset(Risk_Indicators.Layout_Gateways_In) gateways, unsigned1 dppa, unsigned1 glb,
								boolean ofacOnly, unsigned1 ofacVersion, boolean includeOfac, boolean includeOtherWatchlists, real gWatchlistThreshold, unsigned dobRadius) := FUNCTION


gateway_check := gateways (servicename = 'gbgroup')[1].url;
GBID3_gateway_url := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);


isInputOk := IntlIIDFunctions().checkInput(indata);	// check what is input per country, if bad, then dont call gateway



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
	self.searchby.Person.Gender := trim(L.searchby.Gender); //simplified by moving map to passport function
	self.searchby.Person.DOB.Year := L.searchby.DOB.Year;
	self.searchby.Person.DOB.Month := L.searchby.DOB.Month;
	self.searchby.Person.DOB.Day := L.searchby.DOB.Day;
	
	self.searchby.Addresses.Address1.AddressLayout := country;
	self.searchby.Addresses.Address1.BuildingNumber := trim(L.searchby.Address.StreetNumber);
	self.searchby.Addresses.Address1.SubBuildingNumber := trim(L.searchby.Address.UnitDesignation);
	self.searchby.Addresses.Address1.Street := trim(L.searchby.Address.StreetAddress1);
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
working_layout := record
	string100 errormessage;
	// dataset(Layout_ID3CheckResponseResultsDef1B) c;
	iesp.instantid.t_InstantIDInternationalResponse;
end;


working_layout tran(indata le, gateway_result ri) := transform
	self.errormessage := ri.Response.Header.ErrorMessage;
	self._header.queryid := le.user.queryid;	// use this for joining later
	self._header := [];
	
	self.result.inputecho := le.searchby;	
	
	dob := intformat(le.searchby.dob.year, 4, 1)[3..4] + intformat(le.searchby.dob.month, 2, 1) + intformat(le.searchby.dob.day, 2, 1);
	self.result.PassportNumberValidated := intliidFunctions().passportValidation(le.searchby.passport.MachineReadableLine1+le.searchby.passport.MachineReadableLine2, dob, le.searchby.gender);
	
	c := project(ri.response.id3check1bresult.id3checkresponseresults.id3checkresponseresultsdef1bs(uid not in ['0118','0153','0200']), transform(Layout_ID3CheckResponseResultsDef1B, self := left));
	
	badResponse := ri.Response.Header.ErrorMessage <> '';
	self.result.isBillable := ~badResponse and (count(c(c.resultcode='9999')) - count(c(c.uid+resultcode='02009999')) < 1);	// dont bill if 9999 comes back unless it is 02009999, note this will bill if we dont run the gateway per missing input
	
	
	country := IntlIIDFunctions().correctCountry(le.searchby.address.country);
	
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
																							{'StreetNumber',isAddrVer,addrCount},
																							{'UnitDesignation',isAddrVer,addrCount},
																							{'StreetAddress1',isAddrVer,addrCount},
																							{'City',isAddrVer,addrCount},
																							{'Province',isAddrVer,addrCount},
																							{'PostalCode',isAddrVer,addrCount},
																							{'Country',isAddrVer,addrCount},
																							{'HomePhone',isLandVer,landCount},
																							{'MobilePhone',isMobileVer,mobileCount},
																							{'DOB',isDobVer,dobCount},
																							{'NationalIDNumber',isIDVer,idCount}],iesp.instantid.t_VerificationResult);
	
	
	// self.c := c;// can remove when going to production
	
	ivi := IntlIIDFunctions().getIVI(country, firstCount, lastCount, addrCount, landCount+mobileCount, dobCount, idCount);
	self.result.InternationalVerificationIndex := ivi;

	
	addronlymatch := firstCount = 0 and lastCount = 0 and addrCount>0 and landCount = 0 and mobileCount = 0 and dobCount = 0 and idCount = 0;
	
	fnamePop := trim(le.searchby.name.first) <> '';
	lnamePop := trim(le.searchby.name.last) <> '';
	streetPop := trim(le.searchby.address.streetAddress1) <> '';
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
	
	rc := returnCodes(c, 10, country, addronlymatch, le.searchby.gender, isFirstVer, isLastVer, isAddrVer, isDOBVer, isLandVer, isMobileVer, isIDVer, 
										fnamePop, lnamePop, addrPop, dobPop, natIDPop, lPhonePop, mPhonePop);
	self.result.riskindicators := map(~isInputOk => dataset([{'0001',getRCdesc('0001')}],iesp.share.t_RiskIndicator),	// if input missing hardcode to reason code 1
																		badResponse => dataset([{'9999',getRCdesc('9999')}],iesp.share.t_RiskIndicator),// if gateway is down hardcoe to reason code 9999
																		rc);	
	

																							
	self.result.watchlist := [];
	self.result.ipaddressinfo := [];	
		
end;
gbid3 := join(indata, gateway_result, trim(left.user.QueryId)=trim(right.response.header.queryid)/* and right.Response.Header.ErrorMessage = ''*/, tran(left,right), left outer);




// add on IP data
ips := risk_indicators.getNetAcuity(project(indata, transform(riskwise.Layout_IPAI, self.ipaddr:=left.searchby.ipaddress,self.seq:=0)), gateways, dppa, glb);

iesp.instantid.t_InstantIDInternationalResponse addIP(gbid3 le, ips ri) := transform
	self.result.ipaddressinfo.Continent := ri.continent;
	self.result.ipaddressinfo.Country := ri.countrycode;// do I need to expand this?
	self.result.ipaddressinfo.routingtype := ri.iproutingmethod;
	self.result.ipaddressinfo.topleveldomain := ri.topleveldomain;
	self.result.ipaddressinfo.secondleveldomain := ri.secondleveldomain;
	self.result.ipaddressinfo.city := ri.ipcity;
	self.result.ipaddressinfo.regiondescription := ri.ipregion_description;
	self.result.ipaddressinfo.latitude := ri.latitude;
	self.result.ipaddressinfo.longitude := ri.longitude;
	

	ia := DATASET([{'L0IA',getRCdesc('L0IA')}],iesp.share.t_RiskIndicator);
	ie := DATASET([{'L0IE',getRCdesc('L0IE')}],iesp.share.t_RiskIndicator);
	ig := DATASET([{'L0IG',getRCdesc('L0IG')}],iesp.share.t_RiskIndicator);
	self.result.riskindicators := map(Risk_Indicators.rcSet.isCodeIA(le.result.inputecho.ipaddress, ri.ipaddr<>'') => le.result.riskindicators+ia,
																		Risk_Indicators.rcSet.isCodeIE(ri.ipaddr<>'', ri.secondleveldomain, ri.ipType) => le.result.riskindicators+ie,
																		Risk_Indicators.rcSet.isCodeIG(ri.ipType) => le.result.riskindicators+ig,
																		le.result.riskindicators);
	self := le;
end;
wIP := join(gbid3, ips, left.result.inputecho.ipaddress=right.ipaddr, addIP(left,right), left outer);


// now get watchlist data
// check below to do or not do watchlist search
getWatch := risk_indicators.getWatchLists2(group(project(indata, transform(risk_indicators.Layout_Output, 	self.fname:=left.searchby.name.first, 
																																																						self.mname:=left.searchby.name.middle,
																																																						self.lname:=left.searchby.name.last, 
																																																						self.country:=left.searchby.address.country, 
																																																						self.dob:=intformat(left.searchby.dob.year,4,1)+intformat(left.searchby.dob.month,2,1)+
																																																											intformat(left.searchby.dob.day,2,1),
																																																						self.seq:=(unsigned)left.user.QueryId, 
																																																						self:=[])),seq),
																					ofacOnly, false, ofacVersion, includeOfac, includeOtherWatchlists, gWatchlistThreshold, dobRadius);

																																														
																																														
iesp.instantid.t_InstantIDInternationalResponse addWatch(wIp le, getWatch ri) := transform
	self.result.watchlist.table := ri.watchlist_table;
	self.result.watchlist.recordnumber := ri.watchlist_record_number;
	self.result.watchlist.name.full := '';
	self.result.watchlist.name.first := stringlib.stringtouppercase(ri.watchlist_fname);
	self.result.watchlist.name.middle := '';
	self.result.watchlist.name.last := stringlib.stringtouppercase(ri.watchlist_lname);
	self.result.watchlist.name.suffix := '';
	self.result.watchlist.name.prefix := '';
	self.result.watchlist.address.streetname := '';
	self.result.watchlist.address.streetnumber := '';
	self.result.watchlist.address.streetpredirection := '';
	self.result.watchlist.address.streetpostdirection := '';
	self.result.watchlist.address.streetsuffix := '';
	self.result.watchlist.address.unitdesignation := '';
	self.result.watchlist.address.unitnumber := '';
	self.result.watchlist.address.streetaddress1 := stringlib.stringtouppercase(ri.watchlist_address);
	self.result.watchlist.address.streetaddress2 := '';
	self.result.watchlist.address.state := stringlib.stringtouppercase(ri.watchlist_state);
	self.result.watchlist.address.city := stringlib.stringtouppercase(ri.watchlist_city);
	self.result.watchlist.address.zip5 := ri.watchlist_zip[1..5];
	self.result.watchlist.address.zip4 := ri.watchlist_zip[6..9];
	self.result.watchlist.address.county := '';
	self.result.watchlist.address.postalcode := '';
	self.result.watchlist.address.statecityzip := '';
	self.result.watchlist.country := stringlib.stringtouppercase(ri.watchlist_contry);
	self.result.watchlist.entityname := stringlib.stringtouppercase(ri.watchlist_entity_name);
	
	ofac := DATASET([{'L032',getRCdesc('L032')}],iesp.share.t_RiskIndicator);
	wl := DATASET([{'L0WL',getRCdesc('L0WL')}],iesp.share.t_RiskIndicator);
	self.result.riskindicators := map(Risk_Indicators.rcSet.isCode32(ri.watchlist_table, ri.watchlist_record_number) => ofac+le.result.riskindicators,
																		Risk_Indicators.rcSet.isCodeWL(ri.watchlist_table, ri.watchlist_record_number) => wl+le.result.riskindicators,
																		le.result.riskindicators);
	self := le;
end;
wWatch := join(wIP, getWatch, (unsigned)left._header.queryid=right.seq, addWatch(left,right), left outer);

// if doing watch, then join, otherwise dont
watch := if(includeOfac=false and includeOtherWatchlists=false, wIP, wWatch);	

// output(gbid3, named ('gbid3'));
// output(indata, named ('indata'));
return watch;

end;
