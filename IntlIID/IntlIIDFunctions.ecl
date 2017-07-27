import address, iesp, risk_indicators, riskwise, ut, Gateway;

export IntlIIDFunctions() := MODULE

export setMatchFlag(string matchState, boolean dsError) := FUNCTION
	matchFlag := MAP(	dsError => -3, // data source error
										matchState = Constants.match => 1,
										matchState = Constants.nomatch => 0,
										matchState = Constants.missing => -1,
										-2); // no tag returned
 return matchFlag;
END;

export getCitVL(boolean isFirstVer, boolean isLastVer, boolean isAddrVer, boolean isNIDVer) := FUNCTION
	citVL := MAP( isFirstVer and isLastVer and isAddrVer and isNIDVer => 12,
								isLastVer and isAddrVer and isNIDVer => 11,
								isFirstVer and isAddrVer and isNIDVer => 10,
								isFirstVer and isLastVer and isNIDVer => 9,
								isFirstVer and isLastVer and isAddrVer => 8,
								isLastVer and isNIDVer => 7,
								isAddrVer and isNIDVer => 6,
								isLastVer and isAddrVer => 5,
								isFirstVer and isNIDVer => 4,
								isFirstVer and isAddrVer => 3,
								isFirstVer and isLastVer => 2,
								isNIDVer => 1,
									0);
									
	return citVL;
END;

export getComVL(boolean isFirstVer, boolean isLastVer, boolean isAddrVer, boolean isDOBVer, boolean isPhoneVer) := FUNCTION
	comVL := MAP( isFirstVer and isLastVer and isAddrVer and (isDOBVer or isPhoneVer) => 12,
								isLastVer and isAddrVer and (isDOBVer or isPhoneVer) => 11,
								isFirstVer and isAddrVer and (isDOBVer or isPhoneVer) => 10,
								isFirstVer and isLastVer and (isDOBVer or isPhoneVer) => 9,
								isFirstVer and isLastVer and isAddrVer => 8,
								isLastVer and (isDOBVer or isPhoneVer) => 7,
								isAddrVer and (isDOBVer or isPhoneVer) => 6,
								isLastVer and isAddrVer => 5,
								isFirstVer and (isDOBVer or isPhoneVer) => 4,
								isFirstVer and isAddrVer => 3,
								isFirstVer and isLastVer => 2,
								isDOBVer or isPhoneVer => 1,
									0);
									
	return comVL;
END;

export addIPs(dataset(riskwise.Layout_IPAI) indata,
							dataset(iesp.iid_international.t_InstantIDInternationalResponse_Unicode) outdata,
							dataset(Gateway.Layouts.Config) gateways) := FUNCTION
	MAC_GetIPs(indata,outdata,gateways,gwOut,wIP);
	
	WithIPResults := RECORD
		DATASET(iesp.iid_international.t_InstantIDInternationalResponse_Unicode) Results;
		DATASET(riskwise.Layout_IP2O) GWResults;
	END;	
	
	WithIPResults withIPOut() := TRANSFORM
		SELF.Results := wIP;
		SELF.GWResults := gwOut;
	END;
		
	RETURN DATASET([withIPOut()]);	
END;

export getIVIMexico(dataset(Layout_DataSourceStats) ds) := FUNCTION

	ivi := map(
						ds[1].isNameVer and ds[1].isNIDVer and ds[1].YearOfBirth = 1 and ds[1].MiddleName = 1 => '40',
						ds[1].isNameVer and ds[1].isNIDVer and ds[1].YearOfBirth = 1 => '30',
						ds[1].isNameVer and (ds[1].isNIDVer or ds[1].YearOfBirth = 1) => '20',
						'00');
	return ivi;
END;

export getIVISingle(dataset(Layout_DataSourceStats) ds, boolean singleSource) := FUNCTION

	dsChinaPhone := ds(SourceID = '60026');

	ivi := map(ds[1].isNameVer and ds[1].isAddrVer and ds[1].isDOBVer => if(singleSource, '50', '40'),
						ds[1].isNameVer and ds[1].isAddrVer and ds[1].isNIDVer => if(singleSource, '50', '40'),
						
						ds[1].isNameVer and ds[1].isAddrVer and ds[1].isPhoneVer => if(singleSource, '40', '30'),
						ds[1].isNameVer and ds[1].isNIDVer and ds[1].isDOBVer => if(singleSource, '40', '30'),		//NEW P4 China
						dsChinaPhone[1].isNameVer and dsChinaPhone[1].isStAddrVer and dsChinaPhone[1].isPhoneVer => if(singleSource, '40', '30'), //NEW P4 China
						
						ds[1].isAddrVer and ds[1].isNIDVer and ds[1].isPhoneVer => if(singleSource, '30', '20'),
						ds[1].isNameVer and ds[1].isAddrVer => if(singleSource, '30', '20'),
						ds[1].isNameVer and ds[1].isDOBVer => if(singleSource, '30', '20'),
						ds[1].isNameVer and ds[1].isNIDVer => if(singleSource, '30', '20'),

						ds[1].isNameVer and ds[1].isStAddrVer => if(singleSource, '20', '10'), //NEW P4 China
						ds[1].isNameVer and ds[1].isPhoneVer => if(singleSource, '20', '10'),
						ds[1].isStAddrVer and ds[1].isDOBVer => if(singleSource, '20', '10'),
						ds[1].isStAddrVer and ds[1].isNIDVer => if(singleSource, '20', '10'),
						ds[1].isStAddrVer and ds[1].isPhoneVer => if(singleSource, '20', '10'),
						'00');
	return ivi;
END;

export getIVIMultiple(dataset(Layout_DataSourceStats) ds) := FUNCTION

	NameCount := count(ds(isNameVer));
	NIDCount := count(ds(isNIDVer));
	DOBCount := count(ds(isDOBVer));
	PhoneCount := count(ds(isPhoneVer));
	AddrCount := count(ds(isAddrVer));
	StAddrCount := count(ds(isStAddrVer));

	FieldMatchCount := 	if(NIDCount > 0, 1, 0) +
											if(DOBCount > 0, 1, 0) +
											if(PhoneCount > 0, 1, 0) +
											if(AddrCount > 0 or StAddrCount > 0, 1, 0);

	ivi := map( count(ds(isNameVer and isAddrVer)) > 1 => '50',
							NameCount > 1 and FieldMatchCount > 3 => '50', //NEW P4 China
							
							count(ds(isNameVer and isAddrVer and isDOBVer)) > 0 => '40',
							count(ds(isNameVer and isAddrVer and isNIDVer)) > 0 => '40',
							NameCount > 1 and FieldMatchCount > 2 => '40', //NEW P4 China
							NameCount > 0 and StAddrCount > 1 and FieldMatchCount > 3	 => '40', // NEW
							
							count(ds(isNameVer and isAddrVer and isPhoneVer)) > 0 => '30',  // in one data source
							count(ds(isNameVer and isAddrVer)) > 0 and AddrCount > 1 => '30',
							NameCount > 1 and FieldMatchCount > 1 => '30', //NEW P4 China
							
							count(ds(isNameVer and isAddrVer)) > 0 => '20',
							count(ds(isNameVer and isDOBVer)) > 0 => '20',
							count(ds(isNameVer and isNIDVer)) > 0 => '20',
							count(ds(isAddrVer and isNIDVer and isPhoneVer)) > 0 => '20',
							count(ds(isStAddrVer and isDOBVer)) > 0 and StAddrCount > 1 => '20',
							count(ds(isStAddrVer and isNIDVer)) > 0 and StAddrCount > 1 => '20',
							count(ds(isStAddrVer and isPhoneVer)) > 0 and StAddrCount > 1 => '20',
							count(ds(isNameVer and isPhoneVer)) > 0 and NameCount > 1 => '20',
	
							count(ds(isStAddrVer and isDOBVer)) > 0  => '10',
							count(ds(isStAddrVer and isNIDVer)) > 0  => '10',
							count(ds(isStAddrVer and isPhoneVer)) > 0 => '10',
							count(ds(isNameVer and isPhoneVer)) > 0 => '10',
							
							'00');
	return ivi;
END;


export correctProvince(string30 province) := FUNCTION

	lprovince := trim(stringlib.stringtolowercase(province));
	correctedProvince := map(
			lprovince = 'alberta' or ut.StringSimilar100('alberta', lprovince) <= 20 => 'AB',  
			lprovince = 'british columbia' or ut.StringSimilar100('british columbia', lprovince) <= 20 => 'BC',  
			lprovince = 'manitoba' or ut.StringSimilar100('manitoba', lprovince) <= 20 => 'MB',  
			lprovince = 'new brunswick' or ut.StringSimilar100('new brunswick', lprovince) <= 20 => 'NB',  
			lprovince = 'newfoundland' or ut.StringSimilar100('newfoundland', lprovince) <= 20 => 'NL', 
			lprovince = 'labrador' or ut.StringSimilar100('labrador', lprovince) <= 20 => 'NL',
			lprovince = 'northwest territories' or ut.StringSimilar100('northwest territories', lprovince) <= 20 => 'NT', 
			lprovince = 'nova scotia' or ut.StringSimilar100('nova scotia', lprovince) <= 20 => 'NS',  
			lprovince = 'nunavut' or ut.StringSimilar100('nunavut', lprovince) <= 20 => 'NU',  
			lprovince = 'ontario' or ut.StringSimilar100('ontario', lprovince) <= 20 => 'ON',  
			lprovince = 'prince edward island' or ut.StringSimilar100('prince edward island', lprovince) <= 20 => 'PE',  
			lprovince = 'quebec' or ut.StringSimilar100('quebec', lprovince) <= 20 => 'QC',  
			lprovince = 'saskatchewan' or ut.StringSimilar100('saskatchewan', lprovince) <= 20 => 'SK', 
			lprovince = 'yukon' or ut.StringSimilar100('yukon', lprovince) <= 20 => 'YT', 
			province);
													
	return correctedProvince;
END;

// take in a lower case country and correct it if necessary
// handles 2 and 3 digit ISO country codes or a close country name match for batch services 
export correctCountry(string30 country) := FUNCTION

	lcountry := trim(stringlib.stringtolowercase(country));

	correctedCountry := map(
													lcountry = 'test' or ut.StringSimilar100('test', lcountry) <= 20 => 'Test',
													lcountry = 'ad' or lcountry = 'and' or lcountry = 'andorra' or ut.StringSimilar100('andorra', lcountry) <= 20 => 'Andorra',
													lcountry = 'at' or lcountry = 'aut' or lcountry = 'austria' or ut.StringSimilar100('austria', lcountry) < 15 => 'Austria', // <= 20 matches Australia
													lcountry = 'au' or lcountry = 'aus' or lcountry = 'australia' or ut.StringSimilar100('australia', lcountry) <= 20 => 'Australia',
													lcountry = 'be' or lcountry = 'bel' or lcountry = 'belgium' or ut.StringSimilar100('belgium', lcountry) <= 20 => 'Belgium',
													lcountry = 'br' or lcountry = 'bra' or lcountry = 'brazil' or ut.StringSimilar100('brazil', lcountry) <= 20 => 'Brazil',
													lcountry = 'ca' or lcountry = 'can' or lcountry = 'canada' or ut.StringSimilar100('canada', lcountry) <= 20 => 'Canada',
													lcountry = 'cz' or lcountry = 'cze' or lcountry = 'czech republic' or ut.StringSimilar100('czech republic', lcountry) <= 20 => 'Czech Republic',
													lcountry = 'cn' or lcountry = 'chn' or lcountry = 'china' or ut.StringSimilar100('china', lcountry) <= 20 => 'China',
													lcountry = 'dk' or lcountry = 'dnk' or lcountry = 'denmark' or ut.StringSimilar100('denmark', lcountry) <= 20 => 'Denmark',
													lcountry = 'fi' or lcountry = 'fin' or lcountry = 'finland' or ut.StringSimilar100('finland', lcountry) <= 20 => 'Finland',
													lcountry = 'fr' or lcountry = 'fra' or lcountry = 'france' or ut.StringSimilar100('france', lcountry) <= 20 => 'France',
													lcountry = 'de' or lcountry = 'deu' or lcountry = 'germany' or ut.StringSimilar100('germany', lcountry) <= 20 => 'Germany',
													lcountry = 'gr' or lcountry = 'grc' or lcountry = 'greece' or ut.StringSimilar100('greece', lcountry) <= 20 => 'Greece',
													lcountry = 'gu' or lcountry = 'gum' or lcountry = 'guam' or ut.StringSimilar100('guam', lcountry) <= 20 => 'Guam',
													lcountry = 'hk' or lcountry = 'hkg' or lcountry = 'hong kong' or ut.StringSimilar100('hong kong', lcountry) <= 20 => 'Hong Kong',
													lcountry = 'hu' or lcountry = 'hun' or lcountry = 'hungary' or ut.StringSimilar100('hungary', lcountry) <= 20 => 'Hungary',
													lcountry = 'ie' or lcountry = 'irl' or lcountry = 'ireland' or ut.StringSimilar100('ireland', lcountry) <= 20 => 'Ireland',
													lcountry = 'it' or lcountry = 'ita' or lcountry = 'italy' or ut.StringSimilar100('italy', lcountry) <= 20 => 'Italy',
													lcountry = 'jp' or lcountry = 'jpn' or lcountry = 'japan' or ut.StringSimilar100('japan', lcountry) <= 20 => 'Japan',
													lcountry = 'lu' or lcountry = 'lux' or lcountry = 'luxembourg' or ut.StringSimilar100('luxembourg', lcountry) <= 20 => 'Luxembourg',
													lcountry = 'mx' or lcountry = 'mex' or lcountry = 'mexico' or ut.StringSimilar100('mexico', lcountry) <= 20 => 'Mexico',
													lcountry = 'mc' or lcountry = 'mco' or lcountry = 'monaco' or ut.StringSimilar100('monaco', lcountry) <= 20 => 'Monaco',
													lcountry = 'ma' or lcountry = 'mar' or lcountry = 'morocco' or ut.StringSimilar100('morocco', lcountry) <= 20 => 'Morocco',
													lcountry = 'nl' or lcountry = 'nld' or lcountry = 'netherlands' or ut.StringSimilar100('netherlands', lcountry) <= 20 => 'Netherlands',
													lcountry = 'nz' or lcountry = 'nzl' or lcountry = 'new zealand' or ut.StringSimilar100('new zealand', lcountry) <= 20 => 'New Zealand',
													lcountry = 'no' or lcountry = 'nor' or lcountry = 'norway' or ut.StringSimilar100('norway', lcountry) <= 20 => 'Norway',
													lcountry = 'pl' or lcountry = 'pol' or lcountry = 'poland' or ut.StringSimilar100('poland', lcountry) <= 20 => 'Poland',
													lcountry = 'pt' or lcountry = 'prt' or lcountry = 'portugal' or ut.StringSimilar100('portugal', lcountry) <= 20 => 'Portugal',
													lcountry = 'pr' or lcountry = 'pri' or lcountry = 'puerto rico' or ut.StringSimilar100('puerto rico', lcountry) <= 20 => 'Puerto Rico',
													lcountry = 'ru' or lcountry = 'rus' or lcountry = 'russia' or ut.StringSimilar100('russia', lcountry) <= 20 => 'Russia',
													lcountry = 'sm' or lcountry = 'smr' or lcountry = 'san marino' or ut.StringSimilar100('san marino', lcountry) <= 20 => 'San Marino',
													lcountry = 'sg' or lcountry = 'sgp' or lcountry = 'singapore' or ut.StringSimilar100('singapore', lcountry) <= 20 => 'Singapore',
													lcountry = 'sk' or lcountry = 'svk' or lcountry = 'slovakia' or ut.StringSimilar100('slovakia', lcountry) <= 20 => 'Slovakia',
													lcountry = 'za' or lcountry = 'zaf' or lcountry = 'south africa' or lcountry = 's africa' or ut.StringSimilar100('south africa', lcountry) <= 20 or ut.StringSimilar100('s africa', lcountry) <= 20 => 'South Africa',
													lcountry = 'es' or lcountry = 'esp' or lcountry = 'spain' or ut.StringSimilar100('spain', lcountry) <= 20 => 'Spain',
													lcountry = 'se' or lcountry = 'swe' or lcountry = 'sweden' or ut.StringSimilar100('sweden', lcountry) <= 20 => 'Sweden',
													lcountry = 'ch' or lcountry = 'che' or lcountry = 'switzerland' or ut.StringSimilar100('switzerland', lcountry) <= 20 => 'Switzerland',
													lcountry = 'tn' or lcountry = 'tun' or lcountry = 'tunisia' or ut.StringSimilar100('tunisia', lcountry) <= 20 => 'Tunisia',
													lcountry = 'gb' or lcountry = 'uk' or lcountry = 'gbr' or lcountry = 'united kingdom' or ut.StringSimilar100('united kingdom', lcountry) <= 20 => 'United Kingdom',
													'');
													
	return correctedCountry;
END;
	
export countryCodeISO2(string30 country) := FUNCTION

	countryCode := map(	
											country = 'Test' => 'AA',
											country = 'Andorra' => 'AD',
											country = 'Australia' => 'AU',
											country = 'Austria' => 'AT',
											country = 'Belgium' => 'BE',
											country = 'Canada' => 'CA',
											country = 'Czech Republic' => 'CZ',
											country = 'China' => 'CN',
											country = 'Denmark' => 'DK',
											country = 'Finland' => 'FI',
											country = 'France' => 'FR',
											country = 'Germany' => 'DE',
											country = 'Greece' => 'GR',
											country = 'Guam' => 'GU',
											country = 'Hong Kong' => 'HK',
											country = 'Hungary' => 'HU',
											country = 'Ireland' => 'IE',
											country = 'Italy' => 'IT',
											country = 'Japan' => 'JP',
											country = 'Luxembourg' => 'LU',
											country = 'Mexico' => 'MX',
											country = 'Monaco' => 'MC',
											country = 'Morocco' => 'MA',
											country = 'Netherlands' => 'NL',
											country = 'New Zealand' => 'NZ',
											country = 'Norway' => 'NO',
											country = 'Poland' => 'PL',
											country = 'Portugal' => 'PT',
											country = 'Puerto Rico' => 'PR',
											country = 'Russia' => 'RU',
											country = 'San Marino' => 'SM',
											country = 'Singapore' => 'SG',
											country = 'Slovakia' => 'SK',
											country = 'South Africa' => 'ZA',
											country = 'Spain' => 'ES',
											country = 'Sweden' => 'SE',
											country = 'Switzerland' => 'CH',
											country = 'Tunisia' => 'TN',
											country = 'United Kingdom' => 'GB',
											'');
											
		return countryCode;
END;
	
export countryCodeISO3(string30 country) := FUNCTION

	countryCode := map(	
											country = 'Test' => 'AAA',
											country = 'Andorra' => 'AND',
											country = 'Australia' => 'AUS',
											country = 'Austria' => 'AUT',
											country = 'Belgium' => 'BEL',
											country = 'Canada' => 'CAN',
											country = 'Czech Republic' => 'CZE',
											country = 'China' => 'CHN',
											country = 'Denmark' => 'DNK',
											country = 'Finland' => 'FIN',
											country = 'France' => 'FRA',
											country = 'Germany' => 'DEU',
											country = 'Greece' => 'GRC',
											country = 'Guam' => 'GUM',
											country = 'Hong Kong' => 'HKG',
											country = 'Hungary' => 'HUN',
											country = 'Ireland' => 'IRL',
											country = 'Italy' => 'ITA',
											country = 'Japan' => 'JPN',
											country = 'Luxembourg' => 'LUX',
											country = 'Mexico' => 'MEX',
											country = 'Monaco' => 'MCO',
											country = 'Morocco' => 'MAR',
											country = 'Netherlands' => 'NLD',
											country = 'New Zealand' => 'NZL',
											country = 'Norway' => 'NOR',
											country = 'Poland' => 'POL',
											country = 'Portugal' => 'PRT',
											country = 'Puerto Rico' => 'PRI',
											country = 'Russia' => 'RUS',
											country = 'San Marino' => 'SMR',
											country = 'Singapore' => 'SGP',
											country = 'Slovakia' => 'SVK',
											country = 'South Africa' => 'ZAF',
											country = 'Spain' => 'ESP',
											country = 'Sweden' => 'SWE',
											country = 'Switzerland' => 'CHE',
											country = 'Tunisia' => 'TUN',
											country = 'United Kingdom' => 'GBR',
											'');
											
		return countryCode;
END;
	
export hasGDCRequiredFields(dataset(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata) := function

	boolean credit := indata[1].options.CreditFlag = '1';
	//SubAccount := trim(indata[1].options.EndUserCompanyId);

// permissible use acknowledgements are handled in the users contract right now but may come back at some point 
	//pua := indata[1].options.PermissibleUse;
	//puaAUSPop := pua = Constants.puaAUS or pua = Constants.puaBatch;
	//puaAUTPop := pua = Constants.puaAUT or pua = Constants.puaBatch;
	//puaCANPop := pua = Constants.puaCAN or pua = Constants.puaBatch;
	//puaCHEPop := pua = Constants.puaCHE or pua = Constants.puaBatch;
	//puaDEUPop := pua = Constants.puaDEU or pua = Constants.puaBatch;
	//puaGBRPop := pua = Constants.puaGBR or pua = Constants.puaBatch;
	//puaNLDPop := pua = Constants.puaNLD or pua = Constants.puaBatch;
	//puaSGPPop := pua = Constants.puaSGP or pua = Constants.puaBatch;
	//puaZAFPop := pua = Constants.puaZAF or pua = Constants.puaBatch;

	input := indata[1].searchby;
	firstPop := trim(input.name.first) <> U'';
	lastPop := trim(input.name.last) <> U'';

	streetNumberPop := trim(input.address.streetNumber) <> U'' or trim(input.address.streetAddress1) <> U'';
	streetNamePop := trim(input.address.streetName) <> U'' or trim(input.address.streetAddress1) <> U'';
  streetPop := streetNumberPop and streetNamePop;
	cityPop := trim(input.address.city) <> U'';
	provincePop := trim(input.address.province) <> U'';
	postalCodePop := trim(input.address.postalCode) <> U'';
	country := correctCountry(trim(input.address.country));
	statePop := trim(input.address.state) <> U'';
	phonePop := trim(input.homePhone) <> '' or trim(input.mobilePhone) <> '' or trim(input.workPhone) <> '';
	idPop := trim(input.nationalIDNumber) <> '';
	dobPop := input.DOB.Year > 0 and input.DOB.Month > 0 and input.DOB.Day > 0;

	// any additions and modifications must also be added to getCountrySetup() below
	isOk := map(//SubAccount=''												=> false, // WAIT TO ENFORCE THIS
							//country='Australia' and credit			=> firstPop and lastPop and postalCodePop,// and puaAUSPop,
							country='Australia'									=> firstPop and lastPop and postalCodePop,
							country='Austria'										=> lastPop,// and puaAUTPop,
							// country='Canada' and credit 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop and provincePop,// and puaCANPop,  	
							country='Canada' 										=> lastPop  and postalCodePop, // and phonePop, 
							country='China' 										=> firstPop and lastPop and idPop and phonePop,  //GDC concats first and last into fullname
							country='Germany'           				=> lastPop  and postalCodePop,// and puaDEUPop,
							country='Japan'											=> lastPop  and postalCodePop,
							country='Ireland' 									=> lastPop and provincePop,  
							country='Hong Kong'									=> lastPop  and provincePop,  
							country='Luxembourg' 								=> lastPop, 
							country='Mexico'		 								=> firstPop and lastPop and dobPop, 
							country='Netherlands' 							=> firstPop and lastPop and postalCodePop and streetNumberPop, //and puaNLDPop, 
							country='New Zealand' 							=> firstPop and lastPop and postalCodePop and streetNamePop and cityPop,  
							country='Singapore' 								=> firstPop and lastPop and postalCodePop and idPop, //and puaSGPPop,
							// country='South Africa' and credit		=> firstPop and lastPop and streetPop and cityPop and postalCodePop and dobPop and idPop,// and puaZAFPop,
							country='South Africa' 							=> firstPop and lastPop and postalCodePop and dobPop and streetPop and cityPop and idPop,
							country='Switzerland' 							=> lastPop and postalCodePop, //and puaCHEPop,
							country='United Kingdom'						=> firstPop and lastPop and postalCodePop,// and puaGBRPop,  
							false);

		return isOk;         
END;

// Implement Minimum Requirements, 'R' - Required, 'D' - Desired 
export dsCountrySetup := DATASET([
	//Country        		 ISO		 ISO		Cre		Per		Nam		Nam		Nam		Nam		Gen		DOB		DOB		DOB		Str		Str		Str		Unt		Unt		Str		Str														NID		Pas		Pas		Pas		Pas		Pas		Pas		Pas		Phn		Hom		Mob		Wrk		IP		
	//Name           		 3 A		 3 N		dit		Use		Ful		Fir		Mid		Las		der		Yr		Mon		Day		Ad1		Ad2		Num		Des		Num		Nam		Suf		Cit		St		PC		Prv		Ctr		NID		Ctr		Num		Yr		Mon		Day		Ctr		MR1		MR1		Num		Phn		Phn		Phn		Add		
	{'Australia'     	,	'AUS'	,	'036'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Austria'       	,	'AUT'	,	'040'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Canada'        	,	'CAN'	,	'124'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	'D'	,	'R'	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'China'         	,	'CHN'	,	'156'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	''	,	'D'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'R'	,	''	,	''	,	''	,	''	}	,
	{'Germany'       	,	'DEU'	,	'276'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Japan'         	,	'JPN'	,	'392'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Ireland'       	,	'IRL'	,	'372'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Hong Kong'     	,	'HKG'	,	'344'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	''	,	'R'	,	'R'	,	''	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Luxembourg'    	,	'LUX'	,	'442'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Mexico'        	,	'MEX'	,	'484'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'R'	,	'D'	,	''	,	''	,	 ''	,	''	,	''	,	''	,	''	,	''	,	''	,	 ''	,	''	,	''	,	''	}	,
	{'Netherlands'   	,	'NLD'	,	'528'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'R'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'New Zealand'   	,	'NZL'	,	'554'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Singapore'     	,	'SGP'	,	'702'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	''	,	'R'	,	''	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'South Africa'  	,	'ZAF'	,	'710'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	'R'	,	''	,	''	,	'R'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Switzerland'   	,	'CHE'	,	'756'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'United Kingdom'	,	'GBR'	,	'826'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	
	], iesp.iid_international.t_CountrySetup);

export dsCountrySetupCredit := DATASET([
	//Country        		 ISO		 ISO		Cre		Per		Nam		Nam		Nam		Nam		Gen		DOB		DOB		DOB		Str		Str		Str		Unt		Unt		Str		Str														NID		Pas		Pas		Pas		Pas		Pas		Pas		Pas		Phn		Hom		Mob		Wrk		IP		
	//Name           		 3 A		 3 N		dit		Use		Ful		Fir		Mid		Las		der		Yr		Mon		Day		Ad1		Ad2		Num		Des		Num		Nam		Suf		Cit		St		PC		Prv		Ctr		NID		Ctr		Num		Yr		Mon		Day		Ctr		MR1		MR1		Num		Phn		Phn		Phn		Add		
	{'Australia'     	,	'AUS'	,	'036'	,	'1'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Austria'       	,	'AUT'	,	'040'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Canada'        	,	'CAN'	,	'124'	,	'1'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	'D'	,	'R'	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'China'         	,	'CHN'	,	'156'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	''	,	'D'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'R'	,	''	,	''	,	''	,	''	}	,
	{'Germany'       	,	'DEU'	,	'276'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Japan'         	,	'JPN'	,	'392'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Ireland'       	,	'IRL'	,	'372'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Hong Kong'     	,	'HKG'	,	'344'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	''	,	'R'	,	'R'	,	''	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Luxembourg'    	,	'LUX'	,	'442'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Mexico'        	,	'MEX'	,	'484'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'R'	,	'D'	,	''	,	''	,	 ''	,	''	,	''	,	''	,	''	,	''	,	''	,	 ''	,	''	,	''	,	''	}	,
	{'Netherlands'   	,	'NLD'	,	'528'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'R'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'New Zealand'   	,	'NZL'	,	'554'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'D'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Singapore'     	,	'SGP'	,	'702'	,	'0'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	''	,	'R'	,	''	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'South Africa'  	,	'ZAF'	,	'710'	,	'1'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	'R'	,	''	,	''	,	'R'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	''	,	'R'	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'Switzerland'   	,	'CHE'	,	'756'	,	'0'	,	''	,	''	,	'D'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	,
	{'United Kingdom'	,	'GBR'	,	'826'	,	'1'	,	''	,	''	,	'R'	,	''	,	'R'	,	''	,	'D'	,	'D'	,	'D'	,	''	,	''	,	'D'	,	''	,	''	,	'D'	,	''	,	'D'	,	''	,	'R'	,	''	,	'R'	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	''	,	'D'	,	''	,	''	,	''	,	''	}	
	], iesp.iid_international.t_CountrySetup);

// restructured function to avoid 9999: Internal Error at /mnt/disk2/builds/64/build_0702_54/ecl/hqlcpp/hqlcppds.cpp(365)
export getCountrySetup(dataset(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata) := function

	iesp.iid_international.t_InstantIDInternationalResponse_Unicode GetResponse(indata l):= transform
		iesp.iid_international.t_CountrySetup GetCountrySettings(iesp.iid_international.t_CountryConfig l):= transform
			country := correctCountry(l.Name);
			countryRequiredFields := if(l.CreditFlag = '1',	dsCountrySetupCredit(CountryName=country), dsCountrySetup(CountryName=country));
			self.CountryName := if(count(countryRequiredFields) > 0, countryRequiredFields[1].CountryName, SKIP);
			self.ISO3Alpha := countryRequiredFields[1].ISO3Alpha;
			self.ISO3Numeric := countryRequiredFields[1].ISO3Numeric;
			self.CreditFlag := l.CreditFlag;
			self.InputFields := countryRequiredFields[1].InputFields;
		end;
		self._header.queryid := l.user.queryid;
		self._header := [];
		self.result.isBillable := false;
		self.result := [];
		self.CountrySettings := sort(project(l.options.Countries,GetCountrySettings(left)), CountryName);
	end;
	return project(indata,GetResponse(left));
END;

END;