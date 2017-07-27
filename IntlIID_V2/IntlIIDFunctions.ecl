import iesp, risk_indicators, riskwise, ut;

export IntlIIDFunctions() := MODULE

export AddressVerification(integer1 FullStreet, integer1 UnitNumber, integer1 StreetNumber, integer1 StreetName, integer1 StreetType, integer1 Suburb, integer1 Area, integer1 State, integer1 PostalCode) := FUNCTION
	
	verified := MAP(FullStreet > 0 and Suburb > 0 => true,
									FullStreet > 0 and PostalCode > 0  => true,
									StreetNumber > 0 and StreetName > 0 and Suburb > 0 => true,
									StreetNumber > 0 and StreetName > 0 and PostalCode > 0  => true,
									false);

 return verified;
END;

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

export addIPs(dataset(iesp.iid_international.t_InstantIDInternationalRequest) indata,
							dataset(iesp.iid_international.t_InstantIDInternationalResponse) outdata,
							dataset(Risk_Indicators.Layout_Gateways_In) gateways) := FUNCTION

	ips := risk_indicators.getNetAcuity(project(indata, transform(riskwise.Layout_IPAI, self.ipaddr:=left.searchby.ipaddress,self.seq:=0)), gateways, (unsigned1)IntlIID_V2.Constants.dppa, (unsigned1)IntlIID_V2.Constants.glb);

	iesp.iid_international.t_InstantIDInternationalResponse addIP(outdata le, ips ri) := transform
		self.result.ipaddressinfo.Continent := ri.continent;
		self.result.ipaddressinfo.Country := ri.countrycode;
		self.result.ipaddressinfo.routingtype := ri.iproutingmethod;
		self.result.ipaddressinfo.topleveldomain := ri.topleveldomain;
		self.result.ipaddressinfo.secondleveldomain := ri.secondleveldomain;
		self.result.ipaddressinfo.city := ri.ipcity;
		self.result.ipaddressinfo.regiondescription := ri.ipregion_description;
		self.result.ipaddressinfo.latitude := ri.latitude;
		self.result.ipaddressinfo.longitude := ri.longitude;
		

		//iIA	The input IP address is unknown	Internal	Current Logic
		//iIB	The input IP address is assigned to a different state/province than the bill-to state/province	Internal	Current Logic
		//iIC	The input IP address is assigned to a different postal code than the bill-to postal code	Internal	Current Logic
		//iID	The input IP address is assigned to a different area code than the Bill-to phone number	Internal	Current Logic
		//iIE	The input IP address second-level domain is unknown	Internal	Current Logic
		//iIF	The input IP address is not assigned to the United States	Internal	Current Logic
		//iIG	The input IP address is non-routable over the internet	Internal	Current Logic
		//iIH	The input IP address is not assigned to Canada	Internal	Current Logic
		//iII	The input IP address is assigned to a different state/province than the input state/province 	Internal	Current Logic
		//iIJ	The input address is assigned to a different postal code than the input postal code	Internal	Current Logic
		//iIK	The input IP address is assigned to a different area code than the input phone number	Internal	Current Logic
		ia := DATASET([{'IIA',getRCdesc('IIA')}],iesp.share.t_RiskIndicator);
		ie := DATASET([{'IIE',getRCdesc('IIE')}],iesp.share.t_RiskIndicator);
		ig := DATASET([{'IIG',getRCdesc('IIG')}],iesp.share.t_RiskIndicator);
		self.result.riskindicators := map(Risk_Indicators.rcSet.isCodeIA(le.result.inputecho.ipaddress, ri.ipaddr<>'') => choosen(le.result.riskindicators, iesp.Constants.MaxCountHRI - 1)+ia,
																			Risk_Indicators.rcSet.isCodeIE(ri.ipaddr<>'', ri.secondleveldomain, ri.ipType) => choosen(le.result.riskindicators, iesp.Constants.MaxCountHRI - 1)+ie,
																			Risk_Indicators.rcSet.isCodeIG(ri.ipType) => choosen(le.result.riskindicators, iesp.Constants.MaxCountHRI - 1)+ig,
																			le.result.riskindicators);
		self := le;
	end;
	wIP := join(outdata, ips, left.result.inputecho.ipaddress=right.ipaddr, addIP(left,right), left outer);

	return wIP;
end;

export getGDCIVI(integer1 ComVL, integer1 CitVL) := FUNCTION
	ivi := CASE(ComVL,
      0 => MAP( CitVL IN [0,1] => '00',
								CitVL IN [2,3,4] => '10',
								CitVL IN [5,6,7,8,9] => '20',
								CitVL IN [10] => '30',
								CitVL IN [11] => '40',
								'50'),
      1 => MAP( CitVL IN [0,1] => '00',
								CitVL IN [2,3,4,5,6,7,8] => '10',
								CitVL IN [9] => '20',
								'30'),
      2 => MAP( CitVL IN [0,1,2,3,4,7] => '10',
								CitVL IN [5,6,8] => '20',
								CitVL IN [9,10] => '30',
								CitVL IN [11] => '40',
								'50'),
      3 => MAP( CitVL IN [0,1,2,3,4] => '10',
								CitVL IN [5,6,7,8] => '20',
								CitVL IN [9,10] => '30',
								CitVL IN [11] => '40',
								'50'),
      4 => MAP( CitVL IN [0,1,2,3,4,5] => '10',
								CitVL IN [6,7,8] => '20',
								CitVL IN [9,10] => '30',
								CitVL IN [11] => '40',
								'50'),
      5 => MAP( CitVL IN [0,1] => '10',
								CitVL IN [2,3,4,5,6] => '20',
								CitVL IN [7,8,9,10] => '30',
								CitVL IN [11,12] => '40',
								'50'),
      6 => MAP( CitVL IN [0,1,2,3,4] => '10',
								CitVL IN [6,7,9] => '20',
								CitVL IN [5,8] => '30',
								CitVL IN [10,11] => '40',
								'50'),
      7 => MAP( CitVL IN [1,2,3] => '10',
								CitVL IN [0,4,6] => '20',
								CitVL IN [5,7,8,9] => '30',
								CitVL IN [10,11] => '40',
								'50'),
      8 => MAP( CitVL IN [1,2,3] => '10',
								CitVL IN [0,4,5] => '20',
								CitVL IN [6,7] => '30',
								CitVL IN [8,9,10,11] => '40',
								'50'),
      9 => MAP( CitVL IN [1,2,3] => '10',
								CitVL IN [0,4,6] => '20',
								CitVL IN [5,7,8,9] => '30',
								'40'),
      10 => MAP(CitVL IN [0,1,2,3] => '10',
								CitVL IN [4,6] => '20',
								CitVL IN [5,7,8,9] => '30',
								CitVL IN [10,11] => '40',
								'50'),
      11 => MAP(CitVL IN [1] => '20',
								CitVL IN [0,2,3,4,5,6,7] => '30',
								CitVL IN [8,9,10,11] => '40',
								'50'),
      12 => MAP(CitVL IN [1] => '20',
								CitVL IN [0,2,3,4,5,6] => '30',
								CitVL IN [7,8,9,10] => '40',
								'50'),
								'00');

	return ivi;
end;



export getGBIVI(string10 country, unsigned1 firstCount, unsigned1 lastCount, unsigned1 addrCount, unsigned1 phoneCount, unsigned1 dobCount, unsigned1 idCount) := FUNCTION

	ivi := CASE(country,
											'Australia' => MAP(firstCount>0 and lastCount>0 and addrCount>0 and phoneCount>0 => '50',
																				 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount>0 => '40',
																				 firstCount>0 and lastCount>0 and addrCount>0 and phoneCount=0 => '40',
																				 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount=0 => '30',
																				 firstCount>0 and lastCount>0 and addrCount=0 and phoneCount>0 => '30',
																				 firstCount=0 and lastCount>0 and addrCount=0 and phoneCount>0 => '20',
																				 firstCount=0 and lastCount=0 and addrCount>0 and phoneCount>0 => '20',
																				 '00'),
											'Germany' => MAP(firstCount>0 and lastCount>0 and addrCount>0 and phoneCount>0 => '50',
																			 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount>0 => '40',
																			 firstCount>0 and lastCount>0 and addrCount>0 and phoneCount=0 => '40',
																			 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount=0 => '30',
																			 firstCount>0 and lastCount>0 and addrCount=0 and phoneCount>0 => '30',
																			 firstCount=0 and lastCount>0 and addrCount=0 and phoneCount>0 => '20',
																			 firstCount=0 and lastCount=0 and addrCount>0 and phoneCount>0 => '20',
																			 '00'),
											'Ireland' => MAP(firstCount>0 and lastCount>0 and addrCount>0 and phoneCount>0 => '50',
																			 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount>0 => '40',
																			 firstCount>0 and lastCount>0 and addrCount>0 and phoneCount=0 => '40',
																			 firstCount=0 and lastCount>0 and addrCount>0 and phoneCount=0 => '30',
																			 firstCount>0 and lastCount>0 and addrCount=0 and phoneCount>0 => '30',
																			 firstCount=0 and lastCount>0 and addrCount=0 and phoneCount>0 => '20',
																			 firstCount=0 and lastCount=0 and addrCount>0 and phoneCount>0 => '20',
																			 '00'),
											'Norway' => MAP(firstCount>0 and lastCount>0 and addrCount>0 and phoneCount>0 => '50',
																			firstCount>0 and lastCount>0 and addrCount>0 and dobCount>0   => '50',
																			firstCount=0 and lastCount>0 and addrCount>0 and phoneCount>0 => '40',
																			firstCount>0 and lastCount>0 and addrCount>0 and phoneCount=0 => '40',
																			firstCount=0 and lastCount>0 and addrCount>0 and phoneCount=0 => '30',
																			firstCount>0 and lastCount>0 and addrCount=0 and phoneCount>0 => '30',
																			firstCount>0 and lastCount>0 and addrCount=0 and dobCount>0   => '30',
																			firstCount=0 and lastCount>0 and addrCount=0 and phoneCount>0 => '20',
																			firstCount=0 and lastCount=0 and addrCount>0 and phoneCount>0 => '20',
																			'00'),
											'Sweden' => MAP(firstCount>0 and lastCount>0 and addrCount>0 and dobCount>0   => '50',
																			firstCount>0 and lastCount>0 and addrCount>0 and dobCount=0   => '40',
																			firstCount=0 and lastCount>0 and addrCount>0 and dobCount=0   => '30',
																			firstCount>0 and lastCount>0 and addrCount=0 and dobCount>0   => '30',
																			firstCount>0 and lastCount>0 and addrCount=0 and dobCount>0   => '30',
																			firstCount=0 and lastCount>0 and addrCount=0 and idCount>0    => '20',// added per todd and jesse
																			'00'),
						'00');

	return ivi;

end;



shared countryCodes := [
												'XOM', // Sovereign Military Order of Malta
												'XXA', // stateless
												'XXB', // refugee per convention
												'XXC', // refugee (non-convention)
												'XXX', // unspecified/unknown
												'ABW', // Aruba
												'AFG', // Afghanistan
												'AGO', // Angola
												'AIA', // Anguilla
												'ALA', // Åland Islands
												'ALB', // Albania
												'AND', // Andorra
												'ANT', // Netherlands Antilles
												'ARE', // United Arab Emirates
												'ARG', // Argentina
												'ARM', // Armenia
												'ASM', // American Samoa
												'ATA', // Antarctica
												'ATF', // French Southern Territories
												'ATG', // Antigua and Barbuda
												'AUS', // Australia
												'AUT', // Austria
												'AZE', // Azerbaijan
												'BDI', // Burundi
												'BEL', // Belgium
												'BEN', // Benin
												'BFA', // Burkina Faso
												'BGD', // Bangladesh
												'BGR', // Bulgaria
												'BHR', // Bahrain
												'BHS', // Bahamas
												'BIH', // Bosnia and Herzegovina
												'BLM', // Saint Barthélemy
												'BLR', // Belarus
												'BLZ', // Belize
												'BMU', // Bermuda
												'BOL', // Bolivia
												'BRA', // Brazil
												'BRB', // Barbados
												'BRN', // Brunei Darussalam
												'BTN', // Bhutan
												'BVT', // Bouvet Island
												'BWA', // Botswana
												'CAF', // Central African Republic
												'CAN', // Canada
												'CCK', // Cocos (Keeling) Islands
												'CHE', // Switzerland
												'CHL', // Chile
												'CHN', // China
												'CIV', // Côte d'Ivoire
												'CMR', // Cameroon
												'COD', // Congo, the Democratic Republic of the
												'COG', // Congo
												'COK', // Cook Islands
												'COL', // Colombia
												'COM', // Comoros
												'CPV', // Cape Verde
												'CRI', // Costa Rica
												'CUB', // Cuba
												'CXR', // Christmas Island
												'CYM', // Cayman Islands
												'CYP', // Cyprus
												'CZE', // Czech Republic
												'DEU', // Germany
												'DJI', // Djibouti
												'DMA', // Dominica
												'DNK', // Denmark
												'DOM', // Dominican Republic
												'DZA', // Algeria
												'ECU', // Ecuador
												'EGY', // Egypt
												'ERI', // Eritrea
												'ESH', // Western Sahara
												'ESP', // Spain
												'EST', // Estonia
												'ETH', // Ethiopia
												'FIN', // Finland
												'FJI', // Fiji
												'FLK', // Falkland Islands (Malvinas)
												'FRA', // France
												'FRO', // Faroe Islands
												'FSM', // Micronesia, Federated States of
												'GAB', // Gabon
												'GBR', // United Kingdom
												'GEO', // Georgia
												'GGY', // Guernsey
												'GHA', // Ghana
												'GIN', // Guinea
												'GIB', // Gibraltar
												'GLP', // Guadeloupe
												'GMB', // Gambia
												'GNB', // Guinea-Bissau
												'GNQ', // Equatorial Guinea
												'GRC', // Greece
												'GRD', // Grenada
												'GRL', // Greenland
												'GTM', // Guatemala
												'GUF', // French Guiana
												'GUM', // Guam
												'GUY', // Guyana
												'HKG', // Hong Kong
												'HMD', // Heard Island and McDonald Islands
												'HND', // Honduras
												'HRV', // Croatia
												'HTI', // Haiti
												'HUN', // Hungary
												'IDN', // Indonesia
												'IMN', // Isle of Man
												'IND', // India
												'IOT', // British Indian Ocean Territory
												'IRL', // Ireland
												'IRN', // Iran, Islamic Republic of
												'IRQ', // Iraq
												'ISL', // Iceland
												'ISR', // Israel
												'ITA', // Italy
												'JAM', // Jamaica
												'JEY', // Jersey
												'JOR', // Jordan
												'JPN', // Japan
												'KAZ', // Kazakhstan
												'KEN', // Kenya
												'KGZ', // Kyrgyzstan
												'KHM', // Cambodia
												'KIR', // Kiribati
												'KNA', // Saint Kitts and Nevis
												'KOR', // Korea, Republic of
												'KWT', // Kuwait
												'LAO', // Lao People's Democratic Republic
												'LBN', // Lebanon
												'LBR', // Liberia
												'LBY', // Libyan Arab Jamahiriya
												'LCA', // Saint Lucia
												'LIE', // Liechtenstein
												'LKA', // Sri Lanka
												'LSO', // Lesotho
												'LTU', // Lithuania
												'LUX', // Luxembourg
												'LVA', // Latvia
												'MAC', // Macao
												'MAF', // Saint Martin (French part)
												'MAR', // Morocco
												'MCO', // Monaco
												'MDA', // Moldova
												'MDG', // Madagascar
												'MDV', // Maldives
												'MEX', // Mexico
												'MHL', // Marshall Islands
												'MKD', // Macedonia, the former Yugoslav Republic of
												'MLI', // Mali
												'MLT', // Malta
												'MMR', // Myanmar
												'MNE', // Montenegro
												'MNG', // Mongolia
												'MNP', // Northern Mariana Islands
												'MOZ', // Mozambique
												'MRT', // Mauritania
												'MSR', // Montserrat
												'MTQ', // Martinique
												'MUS', // Mauritius
												'MWI', // Malawi
												'MYS', // Malaysia
												'MYT', // Mayotte
												'NAM', // Namibia
												'NCL', // New Caledonia
												'NER', // Niger
												'NFK', // Norfolk Island
												'NGA', // Nigeria
												'NIC', // Nicaragua
												'NOR', // Norway
												'NIU', // Niue
												'NLD', // Netherlands
												'NPL', // Nepal
												'NRU', // Nauru
												'NZL', // New Zealand
												'OMN', // Oman
												'PAK', // Pakistan
												'PAN', // Panama
												'PCN', // Pitcairn
												'PER', // Peru
												'PHL', // Philippines
												'PLW', // Palau
												'PNG', // Papua New Guinea
												'POL', // Poland
												'PRI', // Puerto Rico
												'PRK', // Korea, Democratic People's Republic of
												'PRT', // Portugal
												'PRY', // Paraguay
												'PSE', // Palestinian Territory, Occupied
												'PYF', // French Polynesia
												'QAT', // Qatar
												'REU', // Réunion
												'ROU', // Romania
												'RUS', // Russian Federation
												'RWA', // Rwanda
												'SAU', // Saudi Arabia
												'SDN', // Sudan
												'SEN', // Senegal
												'SGP', // Singapore
												'SGS', // South Georgia and the South Sandwich Islands
												'SHN', // Saint Helena
												'SJM', // Svalbard and Jan Mayen
												'SLB', // Solomon Islands
												'SLE', // Sierra Leone
												'SLV', // El Salvador
												'SMR', // San Marino
												'SOM', // Somalia
												'SPM', // Saint Pierre and Miquelon
												'SRB', // Serbia
												'STP', // Sao Tome and Principe
												'SUR', // Suriname
												'SVK', // Slovakia
												'SVN', // Slovenia
												'SWE', // Sweden
												'SWZ', // Swaziland
												'SYC', // Seychelles
												'SYR', // Syrian Arab Republic
												'TCA', // Turks and Caicos Islands
												'TCD', // Chad
												'TGO', // Togo
												'THA', // Thailand
												'TJK', // Tajikistan
												'TKL', // Tokelau
												'TKM', // Turkmenistan
												'TLS', // Timor-Leste
												'TON', // Tonga
												'TTO', // Trinidad and Tobago
												'TUN', // Tunisia
												'TUR', // Turkey
												'TUV', // Tuvalu
												'TWN', // Taiwan, Province of China
												'TZA', // Tanzania, United Republic of
												'UGA', // Uganda
												'UKR', // Ukraine
												'UMI', // United States Minor Outlying Islands
												'URY', // Uruguay
												'USA', // United States
												'UZB', // Uzbekistan
												'VAT', // Holy See (Vatican City State)
												'VCT', // Saint Vincent and the Grenadines
												'VEN', // Venezuela
												'VGB', // Virgin Islands, British
												'VIR', // Virgin Islands, U.S.
												'VNM', // Viet Nam
												'VUT', // Vanuatu
												'WLF', // Wallis and Futuna
												'WSM', // Samoa
												'YEM', // Yemen
												'ZAF', // South Africa
												'ZMB', // Zambia
												'ZWE', // Zimbabwe
												//Exceptional reservations
												//The following alpha-3 codes are subject to an exceptional reservation:
												'ASC', // ? Ascension Island ? Reserved on request of UPU, also used by ITU
												'CPT', // ? Clipperton Island ? Reserved on request of ITU
												'DGA', // ? Diego Garcia ? Reserved on request of ITU
												'FXX', // ? France, Metropolitan ? Reserved on request of France
												'TAA', // ? Tristan da Cunha ? Reserved on request of UPU
												//The following three codes were also under exceptional reservation, until the
												//update from 2006-03-29 included them in the standard:
												'GGY', // ? Guernsey ? Reserved on request of UPU
												'IMN', // ? Isle of Man ? Reserved on request of UPU
												'JEY', // ? Jersey ? Reserved on request of UPU
												//Transitional reservations
												//The following alpha-3 codes are subject to a transitional reservation:
												'BUR', // ? Burma
												'BYS', // ? Byelorussian S.S.R.
												'NTZ', // ? Neutral Zone
												'ROM', // ? Romania ? Now uses ROU
												'SCG', // ? Serbia and Montenegro
												'SUN', // ? U.S.S.R.
												'TMP', // ? East Timor
												'YUG', // ? Yugoslavia
												'ZAR', // ? Zaire
												//Indeterminate reservations
												//The following alpha-3 codes are subject to an indeterminate reservation,
												//having been notified to the United Nations Secretary-General under the 1949
												//and/or 1968 Road Traffic Conventions:
												'ADN', // ? Aden
												'BDS', // ? Barbados
												'BRU', // ? Brunei
												'CDN', // ? Canada
												'EAK', // ? Kenya
												'EAT', // ? Tanganyika
												'EAU', // ? Uganda
												'EAZ', // ? Zanzibar
												'GBA', // ? Alderney
												'GBG', // ? Guernsey
												'GBJ', // ? Jersey
												'GBM', // ? Isle of Man
												'GBZ', // ? Gibraltar
												'GCA', // ? Guatemala
												'HKJ', // ? Jordan
												'MAL', // ? Malaysia
												'RCA', // ? Central African Republic
												'RCB', // ? Republic of the Congo (Brazzaville)
												'RCH', // ? Chile
												'RMM', // ? Mali
												'RNR', // ? Northern Rhodesia
												'ROK', // ? Republic of Korea
												'RSM', // ? San Marino
												'RSR', // ? Southern Rhodesia
												'SLO', // ? Slovenia
												'SME', // ? Suriname
												'TMN', // ? Turkmenistan
												'WAG', // ? Gambia
												'WAL', // ? Sierra Leone
												'ZRE', // ? Zaire
												// The following code has been reassigned:
												'ROU', // ? Uruguay ? Reassigned to Romania
												// Codes currently agreed not to use for the time being, ISO 3166/MA has
												// agreed not to use the following codes, taken from ISO/IEC 7501-1 (machine
												// readable travel documents), as alpha-3 country codes:
												// 'GBD', // ? British Dependent Territories Citizen
												// 'GBN', // ? British National (Overseas)
												// 'GBO', // ? British Overseas Citizen
												// 'GBP', // ? British Protected Person
												// 'GBS', // ? British Subject
												// 'UNA', // ? United Nations Specialized Agency Official
												// 'UNK', // ? Kosovo resident, issued travel document by UNMIK
												// 'UNO', // ? United Nations Official
												// Other withdrawn codes
												// Besides the codes currently transitionally reserved and FXX (now
												// exceptionally reserved), these alpha-3 codes have also been withdrawn from
												// ISO 3166-1:
												'AFI', // ? French Afar and Issas
												'ATB', // ? British Antarctic Territory
												'ATN', // ? Dronning Maud Land
												'CSK', // ? Czechoslovakia
												'CTE', // ? Canton and Enderbury Islands
												'DDR', // ? German Democratic Republic
												'DHY', // ? Dahomey
												'GEL', // ? Gilbert and Ellice Islands
												'HVO', // ? Upper Volta
												'JTN', // ? Johnston Island
												'MID', // ? Midway Islands
												'NHB', // ? New Hebrides
												'PCI', // ? Pacific Islands, Trust Territory of the
												'PCZ', // ? Panama Canal Zone
												'PHI', // ? Philippines ? Now uses PHL
												'PUS', // ? U.S. Miscellaneous Pacific Islands
												'RHO', // ? Southern Rhodesia
												'SKM', // ? Sikkim
												'VDR', // ? Viet-Nam, Democratic Republic of
												'WAK', // ? Wake Island
												'YMD' // ? Yemen, Democratic
												// The following alpha-3 codes can be user-assigned: from AAA to AAZ, from
												// QMA to QZZ, from XAA to XZZ, and from ZZA to ZZZ];
												];



// check passport validation
export passportValidation(string passport, string DOB, string gender) := FUNCTION

	pptrim := trim(stringlib.stringtouppercase(passport));
	pplen := length(pptrim);
	fieldvalue(string1 field) := map(stringlib.stringfilterout(field,'0123456789')='' => (unsigned)field,	//is number, use it
																	 field='<' => 0, // if < then 0
																	 field='A' => 10,
																	 field='B' => 11,
																	 field='C' => 12,
																	 field='D' => 13,
																	 field='E' => 14,
																	 field='F' => 15,
																	 field='G' => 16,
																	 field='H' => 17,
																	 field='I' => 18,
																	 field='J' => 19,
																	 field='K' => 20,
																	 field='L' => 21,
																	 field='M' => 22,
																	 field='N' => 23,
																	 field='O' => 24,
																	 field='P' => 25,
																	 field='Q' => 26,
																	 field='R' => 27,
																	 field='S' => 28,
																	 field='T' => 29,
																	 field='U' => 30,
																	 field='V' => 31,
																	 field='W' => 32,
																	 field='X' => 33,
																	 field='Y' => 34,
																	 field='Z' => 35,	// is alpha, add 10 to it
																	 0);	// default case, should not happen


	isPPlen88 := pplen = 88;	// length must be 88
	isFirstP := pptrim[1] = 'P';	// first byte needs to be a P
	isCountry := pptrim[3..5] in countryCodes;
	isName := Stringlib.StringFilterOut(pptrim[6..44],'ABCDEFGHIJKLMNOPQRSTUVWXYZ<')='';	// Can only be letters or <, how would we check for actual name?
	
	field45 := fieldvalue(pptrim[45]);
	field46 := fieldvalue(pptrim[46]);
	field47 := fieldvalue(pptrim[47]);
	field48 := fieldvalue(pptrim[48]);
	field49 := fieldvalue(pptrim[49]);
	field50 := fieldvalue(pptrim[50]);
	field51 := fieldvalue(pptrim[51]);
	field52 := fieldvalue(pptrim[52]);
	field53 := fieldvalue(pptrim[53]);
	CheckDigitCalc := ((field45*7)+(field46*3)+(field47)+(field48*7)+(field49*3)+(field50)+(field51*7)+(field52*3)+(field53))%10;
	isCheckDigit := (string)CheckDigitCalc = pptrim[54];	// simplified logic -jshaw 9/23/09

	isNationality := pptrim[55..57] in countryCodes;
	isDOB := pptrim[58..63] = DOB[1..2]+DOB[3..4]+DOB[5..6]; // YYMMDD

	field58 := fieldvalue(pptrim[58]);
	field59 := fieldvalue(pptrim[59]);
	field60 := fieldvalue(pptrim[60]);
	field61 := fieldvalue(pptrim[61]);
	field62 := fieldvalue(pptrim[62]);
	field63 := fieldvalue(pptrim[63]);
	CheckDigitCalc2 := ((field58*7)+(field59*3)+(field60)+(field61*7)+(field62*3)+(field63))%10;
	isCheckDigit2 := (string)CheckDigitCalc2 = pptrim[64];	// simplified logic - jshaw 9/23/09

	gender_lc := Map(trim(StringLib.StringToLowerCase(gender)) in ['male','m'] => 'Male',
																		 trim(StringLib.StringToLowerCase(gender)) in ['female','f'] => 'Female',
																		 '(unknown)');												// added to ensure proper case for matching - jshaw 9/23/09
	
	isSex := pptrim[65] = gender_lc[1] or (pptrim[65]='<' and gender_lc[2] = 'u');	// check sex match or unknown
	
	correctDays(string month, string day) := map((unsigned)month in [1,3,5,7,8,10,12] => (unsigned)day between 1 and 31,
																							 (unsigned)month in [4,6,9,11] => (unsigned)day between 1 and 30,
																							 (unsigned)day between 1 and 29);
	isExpire := stringlib.stringfilterout(pptrim[66..71],'0123456789')='' and // check all numeric
							(unsigned)('20'+pptrim[66..71]) >= (unsigned)ut.GetDate and 	// check date greater than today
							(unsigned1)pptrim[68..69] between 1 and 12 and correctDays(pptrim[68..69], pptrim[70..71]); // check reasonable dates

	field66 := fieldvalue(pptrim[66]);
	field67 := fieldvalue(pptrim[67]);
	field68 := fieldvalue(pptrim[68]);
	field69 := fieldvalue(pptrim[69]);
	field70 := fieldvalue(pptrim[70]);
	field71 := fieldvalue(pptrim[71]);
	CheckDigitCalc3 := ((field66*7)+(field67*3)+(field68)+(field69*7)+(field70*3)+(field71))%10;
	isCheckDigit3 := (string)CheckDigitCalc3 = pptrim[72];	// simplified logic - jshaw 9/23/09

	field73 := fieldvalue(pptrim[73]);
	field74 := fieldvalue(pptrim[74]);
	field75 := fieldvalue(pptrim[75]);
	field76 := fieldvalue(pptrim[76]);
	field77 := fieldvalue(pptrim[77]);
	field78 := fieldvalue(pptrim[78]);
	field79 := fieldvalue(pptrim[79]);
	field80 := fieldvalue(pptrim[80]);
	field81 := fieldvalue(pptrim[81]);
	field82 := fieldvalue(pptrim[82]);
	field83 := fieldvalue(pptrim[83]);
	field84 := fieldvalue(pptrim[84]);
	field85 := fieldvalue(pptrim[85]);
	field86 := fieldvalue(pptrim[86]);
	CheckDigitCalc4 := ((field73*7)+(field74*3)+(field75)+(field76*7)+(field77*3)+(field78)+(field79*7)+(field80*3)+(field81)+(field82*7)+(field83*3)+(field84)+(field85*7)+(field86*3))%10;
	isCheckDigit4 := (string)CheckDigitCalc4 = pptrim[87];  // simplified logic -jshaw 9/23/09

	field54 := fieldvalue(pptrim[54]);
	field64 := fieldvalue(pptrim[64]);
	field72 := fieldvalue(pptrim[72]);
	field87 := fieldvalue(pptrim[87]);
	CheckDigitCalc5 := ((field45*7)+(field46*3)+(field47)+(field48*7)+(field49*3)+(field50)+(field51*7)+(field52*3)+(field53)+(field54*7)+
											(field58*3)+(field59)+(field60*7)+(field61*3)+(field62)+(field63*7)+(field64*3)+
											(field66)+(field67*7)+(field68*3)+(field69)+(field70*7)+(field71*3)+(field72)+
											(field73*7)+(field74*3)+(field75)+(field76*7)+(field77*3)+(field78)+(field79*7)+(field80*3)+(field81)+(field82*7)+(field83*3)+(field84)+(field85*7)+(field86*3)+(field87))%10;
	isCheckDigit5 := (string)CheckDigitCalc5= pptrim[88];  // simplified logic -jshaw 9/23/09


	isPPvalid := isPPlen88 and isFirstP and isCountry and isName and isCheckDigit and isNationality and isDOB and isCheckDigit2 and isSex and isExpire and
							 isCheckDigit3 and isCheckDigit4 and isCheckDigit5;  //removed isNumeric from logic jshaw 9/23/09
	
	return isPPvalid;
end;


export PassportCheck(dataset(iesp.iid_international.t_InstantIDInternationalRequest) indata) := FUNCTION

	//Added for standalone passport validation
	iesp.iid_international.t_InstantIDInternationalResponse ValidatePassport(indata l):= transform
		self._header.queryid := l.user.queryid;
		self._header := [];
		self.result.inputecho := l.searchby;	
		dob := intformat(l.searchby.dob.year, 4, 1)[3..4] + intformat(l.searchby.dob.month, 2, 1) + intformat(l.searchby.dob.day, 2, 1);
		self.result.PassportNumberValidated := passportValidation(l.searchby.passport.MachineReadableLine1+l.searchby.passport.MachineReadableLine2, dob, l.searchby.gender);
		self.result := [];
		self.CountrySettings := [];
	end;
	
	passport_only := project(indata, ValidatePassport(left)); 
	
	return passport_only;
end;


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
													lcountry = 'mc' or lcountry = 'mco' or lcountry = 'monaco' or ut.StringSimilar100('monaco', lcountry) <= 20 => 'Monaco',
													lcountry = 'ma' or lcountry = 'mar' or lcountry = 'morocco' or ut.StringSimilar100('morocco', lcountry) <= 20 => 'Morocco',
													lcountry = 'nl' or lcountry = 'nld' or lcountry = 'netherlands' or ut.StringSimilar100('netherlands', lcountry) <= 20 => 'Netherlands',
													lcountry = 'nz' or lcountry = 'nzl' or lcountry = 'new zealand' or ut.StringSimilar100('new zealand', lcountry) <= 20 => 'New Zealand',
													//lcountry = '' or lcountry = '' or lcountry = 'northern ireland' or ut.StringSimilar100('northern ireland', lcountry) <= 20 => 'Northern Ireland',
													lcountry = 'no' or lcountry = 'nor' or lcountry = 'norway' or ut.StringSimilar100('norway', lcountry) <= 20 => 'Norway',
													lcountry = 'pl' or lcountry = 'pol' or lcountry = 'poland' or ut.StringSimilar100('poland', lcountry) <= 20 => 'Poland',
													lcountry = 'pt' or lcountry = 'prt' or lcountry = 'portugal' or ut.StringSimilar100('portugal', lcountry) <= 20 => 'Portugal',
													lcountry = 'pr' or lcountry = 'pri' or lcountry = 'puerto rico' or ut.StringSimilar100('puerto rico', lcountry) <= 20 => 'Puerto Rico',
													lcountry = 'ru' or lcountry = 'rus' or lcountry = 'russia' or ut.StringSimilar100('russia', lcountry) <= 20 => 'Russia',
													lcountry = 'sm' or lcountry = 'smr' or lcountry = 'san marino' or ut.StringSimilar100('san marino', lcountry) <= 20 => 'San Marino',
													lcountry = 'sg' or lcountry = 'sgp' or lcountry = 'singapore' or ut.StringSimilar100('singapore', lcountry) <= 20 => 'Singapore',
													lcountry = 'sk' or lcountry = 'svk' or lcountry = 'slovakia' or ut.StringSimilar100('slovakia', lcountry) <= 20 => 'Slovakia',
													lcountry = 'es' or lcountry = 'esp' or lcountry = 'spain' or ut.StringSimilar100('spain', lcountry) <= 20 => 'Spain',
													lcountry = 'se' or lcountry = 'swe' or lcountry = 'sweden' or ut.StringSimilar100('sweden', lcountry) <= 20 => 'Sweden',
													lcountry = 'ch' or lcountry = 'che' or lcountry = 'switzerland' or ut.StringSimilar100('switzerland', lcountry) <= 20 => 'Switzerland',
													lcountry = 'tn' or lcountry = 'tun' or lcountry = 'tunisia' or ut.StringSimilar100('tunisia', lcountry) <= 20 => 'Tunisia',
													lcountry = 'gb' or lcountry = 'uk' or lcountry = 'gbr' or lcountry = 'united kingdom' or ut.StringSimilar100('united kingdom', lcountry) <= 20 => 'United Kingdom',
													'');
													
	return correctedCountry;
end;
	
	
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
											country = 'Monaco' => 'MC',
											country = 'Morocco' => 'MA',
											country = 'Netherlands' => 'NL',
											country = 'New Zealand' => 'NZ',
											//country = 'Northern Ireland' => ,
											country = 'Norway' => 'NO',
											country = 'Poland' => 'PL',
											country = 'Portugal' => 'PT',
											country = 'Puerto Rico' => 'PR',
											country = 'Russia' => 'RU',
											country = 'San Marino' => 'SM',
											country = 'Singapore' => 'SG',
											country = 'Slovakia' => 'SK',
											country = 'Spain' => 'ES',
											country = 'Sweden' => 'SE',
											country = 'Switzerland' => 'CH',
											country = 'Tunisia' => 'TN',
											country = 'United Kingdom' => 'GB',
											'');
											
		return countryCode;
end;
	
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
											country = 'Monaco' => 'MCO',
											country = 'Morocco' => 'MAR',
											country = 'Netherlands' => 'NLD',
											country = 'New Zealand' => 'NZL',
											//country = 'Northern Ireland' => ,
											country = 'Norway' => 'NOR',
											country = 'Poland' => 'POL',
											country = 'Portugal' => 'PRT',
											country = 'Puerto Rico' => 'PRI',
											country = 'Russia' => 'RUS',
											country = 'San Marino' => 'SMR',
											country = 'Singapore' => 'SGP',
											country = 'Slovakia' => 'SVK',
											country = 'Spain' => 'ESP',
											country = 'Sweden' => 'SWE',
											country = 'Switzerland' => 'CHE',
											country = 'Tunisia' => 'TUN',
											country = 'United Kingdom' => 'GBR',
											'');
											
		return countryCode;
end;
	
	
// check that input was entered with enough info to run the search	
export hasGBRequiredFields(DATASET(iesp.iid_international.t_InstantIDInternationalRequest) indata) := FUNCTION

	input := indata[1].searchby;
	
	country := correctCountry(input.address.country);
	
	firstPop := trim(input.name.first) <> '';
	lastPop := trim(input.name.last) <> '';
	dobYearPop := input.dob.year<>0;
	dobMonthPop := input.dob.month<>0;
	dobDayPop := input.dob.day<>0;
	streetPop := trim(input.address.streetAddress1) <> '' or trim(input.address.streetName) <> '';
	buildPop := trim(input.address.streetNumber) <> '';
	subBuildPop := trim(input.address.unitDesignation) <> '';
	cityPop := trim(input.address.city) <> '';
	provincePop := trim(input.address.province) <> '';
	postalCodePop := input.address.postalCode<>'';
	countryPop := country in IntlIID_V2.Constants.GBCountries;
	natIDPop := trim(input.nationalIDNumber) <> '';
	
	addrPop := streetPop and buildPop and (postalCodePop or cityPop or provincePop) and countryPop;
	
	isOk := map(country='Australia' => firstPop and lastPop and addrPop,
							country='Germany'   => lastPop and addrPop,
							//country='Ireland'   => lastPop and addrPop,		// Ireland is no longer a valid country as of 2/27/2009
							country='Norway'    => lastPop and addrPop,
							country='Sweden'    => lastPop  and addrPop,
							false);
								
	return isOk;
end;


export hasGDCRequiredFields(dataset(iesp.iid_international.t_InstantIDInternationalRequest) indata) := function

	puaUKPop := indata[1].options.PermissibleUse = IntlIID_V2.Constants.puaUK;
	
	input := indata[1].searchby;
	firstPop := trim(input.name.first) <> '';
	lastPop := trim(input.name.last) <> '';

	streetNamePop := trim(input.address.streetName) <> '';
	streetPop := (trim(input.address.streetName) <> '' and trim(input.address.streetNumber) <> '') or trim(input.address.streetAddress1) <> '';
	cityPop := trim(input.address.city) <> '';
	provincePop := trim(input.address.province) <> '';
	postalCodePop := trim(input.address.postalCode) <> '';
	country := correctCountry(trim(input.address.country));
	
	phonePop := trim(input.homePhone) <> '' or trim(input.mobilePhone) <> '' or trim(input.workPhone) <> '';
	idPop := trim(input.nationalIDNumber) <> '';

	// any additions and modifications must also be added to getCountrySetup
	isOk := map(country='Test' 						=> firstPop or lastPop or streetPop or cityPop or provincePop or postalCodePop or idPop, //Fields Primary Match Uses
							//country='Andorra' 				=> firstPop and lastPop and streetPop and cityPop, //First, Last
							//country='Austria' 				=> firstPop and lastPop and streetPop and cityPop  and postalCodePop, 
							country='Australia' 			=> firstPop and lastPop and streetPop and postalCodePop, //any 2 of: Last, Street, Zip
							//country='Belgium' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop, 
							country='Canada' 					=> firstPop and lastPop and streetPop and cityPop and provincePop,  	//Last, State
							//country='Czech Republic' 	=> firstPop and lastPop and streetPop and cityPop  and postalCodePop, //First, Last
							country='China' 					=> firstPop and lastPop and idPop,  //GDC concats first and last into fullname  - First, Last, NatID
							//country='Denmark' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Finland' 				=> firstPop and lastPop and streetPop and cityPop,
							//country='France'  				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  //First, Last, Zip
							country='Germany' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Greece' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop, 
							country='Hong Kong' 			=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Hungary' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  //First, Last
							country='Ireland' 				=> firstPop and lastPop and streetPop and cityPop,  	//First, Last note: county = state
							//country='Italy' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  //First, Last, Zip
							country='Japan' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  
							country='Luxembourg' 			=> firstPop and lastPop and streetPop and cityPop and postalCodePop, 
							//country='Monaco' 					=> firstPop and lastPop and streetPop and cityPop,  //First, Last
							//country='Morocco' 				=> firstPop and lastPop and streetPop and cityPop and provincePop and postalCodePop,
							country='Netherlands' 		=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							country='New Zealand' 		=> firstPop and lastPop and streetPop and postalCodePop,  //any 2 of: Last, Street, Zip
							country='Norway' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Poland' 					=> firstPop and lastPop and streetPop and cityPop and provincePop and postalCodePop,
							//country='Portugal' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  //First, Last
							//country='Russia' 					=> firstPop and lastPop and streetNamePop and cityPop and postalCodePop,
							country='Singapore' 			=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Slovakia' 				=> firstPop and lastPop and streetPop and cityPop and postalCodePop,  //First, Last
							//country='Spain' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							country='Sweden' 					=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							country='Switzerland' 		=> firstPop and lastPop and streetPop and cityPop and postalCodePop,
							//country='Tunisia'				 	=> firstPop and lastPop and streetPop and cityPop and postalCodePop, 
							country='United Kingdom' 	=> firstPop and lastPop and streetPop and cityPop and postalCodePop and puaUKPop,  //Last, Zip
							//country='Puerto Rico'
							//country='San Marino'
							//country='Northern Ireland'
							//country='Guam'
							false);

		return isOk;         
end;

// GDC values will work for GB group also
// 'R' - Required
// 'D' - Desired (not used righ now)
export dsCountrySetup := DATASET([
	//Country	 					ISO		ISO		Cre	Per	Name	Name	Name		Name					DOB		DOB		DOB	Street		Street		Street	Unit 				Unit		Street	Street							Postal										National	National	Passport	Passport	Passport	Passport	Passport	Passport	Passport	Phone		Home	Mobile	Work	IP
	//Name		 					3 A		3 N		dit	Use	Full	First Middle	Last	Gender	Year	Month	Day	Address1	Address2	Number	Designation	Number	Name		Suffix	City	State	Code		Province	Country	ID Number	IDCountry	Number		Year			Month			Day				Country		MRLine1		MRLine1		Number	Phone	Phone		Phone	Address
//{'Andorra', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'',			'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Austria', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Australia', 			'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'',		'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Belgium', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Canada', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'',			'R',			'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Czech Republic', 	'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'China', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'',			'',					'',			'',			'',			'',		'',		'',			'',				'R',		'R',			'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Denmark', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Finland', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'',			'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'France', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Germany', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Greece', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Hong Kong', 			'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Hungary', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Ireland', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'',			'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Italy', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Japan', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Luxembourg', 			'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Monaco', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'',			'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Morocco', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'R',			'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Netherlands', 		'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'New Zealand', 		'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'',		'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Norway', 					'',	'',	'',	'', '',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Poland', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'R',			'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Portugal', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Russia', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'',			'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Singapore', 			'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Slovakia', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Spain', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Sweden', 					'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'Switzerland', 		'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
//{'Tunisia', 				'',	'',	'',	'',	'',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''},
	{'United Kingdom', 	'',	'',	'',	'R','',		'R',	'',			'R',	'',			'',		'',		'',	'',				'',				'R',		'',					'',			'R',		'',			'R',	'',		'R',		'',				'R',		'',				'',				'',				'',				'',				'',				'',				'',				'',				'',			'',		'',			'',		''}
	], iesp.iid_international.t_CountrySetup);

export getCountrySetup(dataset(iesp.iid_international.t_InstantIDInternationalRequest) indata) := function

	iesp.iid_international.t_InstantIDInternationalResponse CountrySettings(indata l):= transform
		self._header.queryid := l.user.queryid;
		self._header := [];
		self.result.isBillable := false;
		self.result := [];
		self.CountrySettings := dsCountrySetup;
	end;
	
	response := project(indata, CountrySettings(left)); 

	return response;         
end;

END;