import iesp, ut, std;

export ValidationFunctions() := MODULE

shared CountryCodes := [
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
												'D<<', // Germany
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


export PassportValidation(string passport, string DOB, string gender) := FUNCTION

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
	isCountry := pptrim[3..5] in CountryCodes;
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

	isNationality := pptrim[55..57] in CountryCodes;
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
							(unsigned)('20'+pptrim[66..71]) >= (unsigned)Std.Date.Today() and 	// check date greater than today
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
	// isCheckDigit4 := (string)CheckDigitCalc4 = pptrim[87];  // simplified logic -jshaw 9/23/09
	isCheckDigit4 := if(pptrim[87] = '<', true, (string)CheckDigitCalc4 = pptrim[87]);  // update logic per jshaw 02/15/13

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
END;


export PassportCheck(dataset(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata) := FUNCTION

	//Added for standalone passport validation
	iesp.iid_international.t_InstantIDInternationalResponse_Unicode ValidatePassport(indata l):= transform
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
END;


export VisaValidation(string visa, string DOB, string gender) := FUNCTION

	Vtrim := trim(stringlib.stringtouppercase(visa));
	Vlen := length(Vtrim);
	fieldvalue(string1 field) := map(
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
																	 field='Z' => 35,
																	 field='1' => 1,
																	 field='2' => 2,
																	 field='3' => 3,
																	 field='4' => 4,
																	 field='5' => 5,
																	 field='6' => 6,
																	 field='7' => 7,
																	 field='8' => 8,
																	 field='9' => 9,
																	 // is alpha, add 10 to it
																	 0);	// default case, should not happen


	isVlen88 := Vlen = 88;	// length must be 88
	isFirstV := Vtrim[1] = 'V';	// first byte needs to be a V
	isCountry := Vtrim[3..5] in CountryCodes;
	isName := Stringlib.StringFilterOut(Vtrim[6..44],'ABCDEFGHIJKLMNOPQRSTUVWXYZ<')='';	// Can only be letters or <, how would we check for actual name?
	
	field45 := fieldvalue(Vtrim[45]);
	field46 := fieldvalue(Vtrim[46]);
	field47 := fieldvalue(Vtrim[47]);
	field48 := fieldvalue(Vtrim[48]);
	field49 := fieldvalue(Vtrim[49]);
	field50 := fieldvalue(Vtrim[50]);
	field51 := fieldvalue(Vtrim[51]);
	field52 := fieldvalue(Vtrim[52]);
	field53 := fieldvalue(Vtrim[53]);
	CheckDigitSum := ((field45*7)+(field46*3)+(field47)+(field48*7)+(field49*3)+(field50)+(field51*7)+(field52*3)+(field53));
	
	CheckDigitCalc := ((field45*7)+(field46*3)+(field47)+(field48*7)+(field49*3)+(field50)+(field51*7)+(field52*3)+(field53))%10;
	
	isCheckDigit := CheckDigitCalc = (Integer1)Vtrim[54];

	isNationality := Vtrim[55..57] in CountryCodes;
	isDOB := Vtrim[58..63] = DOB[1..2]+DOB[3..4]+DOB[5..6]; // YYMMDD

	field58 := fieldvalue(Vtrim[58]);
	field59 := fieldvalue(Vtrim[59]);
	field60 := fieldvalue(Vtrim[60]);
	field61 := fieldvalue(Vtrim[61]);
	field62 := fieldvalue(Vtrim[62]);
	field63 := fieldvalue(Vtrim[63]);
	CheckDigitCalc2 := ((field58*7)+(field59*3)+(field60)+(field61*7)+(field62*3)+(field63))%10;
	isCheckDigit2 := CheckDigitCalc2 = (Integer1)Vtrim[64];	

	gender_lc := Map(trim(StringLib.StringToLowerCase(gender)) in ['male','m']   => 'Male',
									 trim(StringLib.StringToLowerCase(gender)) in ['female','f'] => 'Female',
																																								'(unknown)');
	
	isSex := Vtrim[65] = gender_lc[1] or (Vtrim[65]='<' and gender_lc[2] = 'u');	

	correctDays(string month, string day) := map((unsigned)month in [1,3,5,7,8,10,12] => (unsigned)day between 1 and 31,
																							 (unsigned)month in [4,6,9,11] => (unsigned)day between 1 and 30,
																							 (unsigned)day between 1 and 29);
	isExpire := stringlib.stringfilterout(Vtrim[66..71],'0123456789')='' and // check all numeric
							(unsigned)('20'+Vtrim[66..71]) >= (unsigned)Std.Date.Today() and 	// check date greater than today
							(unsigned1)Vtrim[68..69] between 1 and 12 and correctDays(Vtrim[68..69], Vtrim[70..71]); // check reasonable dates

	field66 := fieldvalue(Vtrim[66]);
	field67 := fieldvalue(Vtrim[67]);
	field68 := fieldvalue(Vtrim[68]);
	field69 := fieldvalue(Vtrim[69]);
	field70 := fieldvalue(Vtrim[70]);
	field71 := fieldvalue(Vtrim[71]);
	CheckDigitCalc3 := ((field66*7)+(field67*3)+(field68)+(field69*7)+(field70*3)+(field71))%10;
	isCheckDigit3 := (string)CheckDigitCalc3 = Vtrim[72];	

	field73 := fieldvalue(Vtrim[73]);
	field74 := fieldvalue(Vtrim[74]);
	field75 := fieldvalue(Vtrim[75]);
	field76 := fieldvalue(Vtrim[76]);
	field77 := fieldvalue(Vtrim[77]);
	field78 := fieldvalue(Vtrim[78]);
	field79 := fieldvalue(Vtrim[79]);
	field80 := fieldvalue(Vtrim[80]);
	field81 := fieldvalue(Vtrim[81]);
	field82 := fieldvalue(Vtrim[82]);
	field83 := fieldvalue(Vtrim[83]);
	field84 := fieldvalue(Vtrim[84]);
	field85 := fieldvalue(Vtrim[85]);
	field86 := fieldvalue(Vtrim[86]);
	field54 := fieldvalue(Vtrim[54]);
	field64 := fieldvalue(Vtrim[64]);
	field72 := fieldvalue(Vtrim[72]);

	isVvalid := isVlen88 and isFirstV and isCountry and isName and isCheckDigit and isNationality and isDOB and isCheckDigit2 and isSex and isExpire and isCheckDigit3;
	return isVvalid;

end;


export VisaCheck(dataset(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata) := FUNCTION

	//Added for standalone visa validation
	iesp.iid_international.t_InstantIDInternationalResponse_Unicode ValidateVisa(indata l):= transform
		self._header.queryid := l.user.queryid;
		self._header := [];
		self.result.inputecho := l.searchby;	
		dob := intformat(l.searchby.dob.year, 4, 1)[3..4] + intformat(l.searchby.dob.month, 2, 1) + intformat(l.searchby.dob.day, 2, 1);
		self.result.VisaNumberValidated := VisaValidation(l.searchby.visa.MachineReadableLine1+l.searchby.visa.MachineReadableLine2, dob, l.searchby.gender);
		self.result := [];
		self.CountrySettings := [];
	end;
	
	visa_only := project(indata, ValidateVisa(left)); 
	
	return visa_only;

END;

END;