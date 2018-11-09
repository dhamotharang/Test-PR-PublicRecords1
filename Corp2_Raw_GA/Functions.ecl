IMPORT corp2, corp2_mapping, ut;

EXPORT Functions := MODULE

	//********************************************************************
		//State_Code: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
	EXPORT StateCode(STRING code) :=FUNCTION
		st  := corp2.t2u(code);
		RETURN MAP (st IN 
									['AB','AF','AL','AK','AS','AZ','AR','CA','CD','CO','CT','DE','DC','FM',
									 'FL','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
									 'MI','MN','MS','MO','MT','NC','NE','NV','NH','NJ','NM','NY','ND','MP',
									 'OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','UK','UT','VT','VI',
									 'VA','WA','WV','WI','WY']      					 => st,
									  st in ['AE','NA','PW','UN','X','XX','']	 => '', // !!as per Rosemary 
							//DF-20911...not only two digit codes, we also receiving full state name from vendor !!
										st ='AFRICA'														 => 'AF',
										st ='ALABAMA' 													 => 'AL',
										st ='ALASKA' 														 => 'AK', 
										st ='AMERICAN SAMOA' 										 => 'AS',
										st ='ARIZONA' 													 => 'AZ',
										st ='ARKANSAS' 													 => 'AR',
										st ='ARMED FORCES AMERICAS EXCEPT CANADA'=> 'AA',
										st ='ARMED FORCES PACIFIC' 							 => 'AP',
										st ='AUSTRALIA' 												 => 'AU',
										st ='BARBADOS' 							 						 => 'BR',
										st ='BELGIUM' 													 => 'BL',
										st ='BERMUDA' 													 => 'BE',
										st ='BRITISH WEST INDIES' 							 => 'BW',
										st ='CALIFORNIA' 												 => 'CA',
										st ='CANADA' 							 							 => 'AB',
										st ='CANADA' 							 							 => 'CD',
										st ='CANAL ZONE' 							 					 => 'CZ',
										st ='CHINA' 							 							 => 'CH',
										st ='COLORADO' 													 => 'CO',
										st ='COLUMBIA' 													 => 'CB',
										st ='CONNECTICUT' 											 => 'CT',
										st ='COOK ISLANDS' 											 => 'CI',
										st ='DELAWARE' 													 => 'DE',
										st ='DISTRICT OF COLUMBIA'							 => 'DC',
										st ='EUROPE' 														 => 'EU',
										st ='FEDERATED STATES OF MICRONESIA'		 => 'FM',
										st ='FLORIDA' 													 => 'FL',
										st ='FRANCE' 							 							 => 'FR',
										st ='GERMANY' 													 => 'GR',
										st ='GREAT BRITAIN' 							 			 => 'GB',
										st ='GUAM' 															 => 'GU',
										st ='HAWAII' 							 							 => 'HI',
										st ='HONG KONG' 							 					 => 'HK',
										st ='IDAHO' 							 							 => 'ID',
										st ='ILLINOIS' 							 						 => 'IL',
										st ='INDIA' 														 => 'II',
										st ='INDIANA' 							 						 => 'IN',
										st ='IOWA' 							 								 => 'IA',
										st ='IRELAND' 							 						 => 'IE',
										st ='JAPAN' 							 							 => 'JA',
										st ='KANSAS' 							 							 => 'KS',
										st ='KENTUCKY' 							 						 => 'KY',
										st ='LOUISIANA' 												 => 'LA',
										st ='LUXEMBOURG' 							 					 => 'LX',
										st ='MAINE' 													   => 'ME',
										st ='MARSHALL ISLANDS' 							 		 => 'MH',
										st ='MARYLAND' 							 						 => 'MD',
										st ='MASSACHUSETTS' 										 => 'MA',
										st ='MEXICO' 							 							 => 'MX',
										st ='MICHIGAN' 													 => 'MI',
										st ='MINNESOTA' 												 => 'MN',
										st ='MISSISSIPPI' 											 => 'MS',
										st ='MISSOURI' 							 						 => 'MO',
										st ='MONTANA' 													 => 'MT',
										st ='NEBRASKA' 							 						 => 'NE',
										st ='NETHERLANDS' 							 				 => 'NL',
										st ='NEVADA' 							 							 => 'NV',
										st ='NEW HAMPSHIRE' 							 			 => 'NH',
										st ='NEW JERSEY' 							 					 => 'NJ',
										st ='NEW MEXICO' 											   => 'NM',
										st ='NEW YORK' 												   => 'NY',
										st ='NORTH CAROLINA' 							 			 => 'NC',
										st ='NORTH DAKOTA' 											 => 'ND',  
										st ='NORTHERN MARIANA ISLANDS' 					 => 'MP',
										st ='NOVA SCOTIA, CANADA' 							 => 'NS',
										st ='OHIO' 															 => 'OH',
										st ='OKLAHOMA' 							 						 => 'OK',
										st ='OREGON' 							 							 => 'OR',
										st ='OTHER ASIA' 												 => 'OA',
										st ='OTHER S&C AMERICAN' 								 => 'SA',
										st ='PANAMA' 							 							 => 'PN',
										st ='PENNSYLVANIA' 							 				 => 'PA',
										st ='PHILIPPINES' 											 => 'PH',
										st ='PUERTO RICO' 							 				 => 'PR',
										st ='RHODE ISLAND' 											 => 'RI',
										st ='SCOTLAND' 							 						 => 'SL',
										st ='SOUTH CAROLINA' 							 			 => 'SC',
										st ='SOUTH DAKOTA' 							 				 => 'SD',
										st ='TENNESSEE' 							 					 => 'TN',
										st ='TEXAS' 														 => 'TX',
										st ='UNITED KINGDOM' 										 => 'UK',
										st ='UNITED STATES' 							 			 => 'US',
										st ='UTAH' 							 								 => 'UT',
										st ='VERMONT' 							 						 => 'VT',
										st ='VIRGIN ISLANDS' 										 => 'VI',
										st ='VIRGINIA' 							 						 => 'VA',
										st ='WASHINGTON' 							 					 => 'WA',
										st ='WEST VIRGINIA' 							 			 => 'WV',
										st ='WISCONSIN' 							 					 => 'WI',
										st ='WYOMING' 							 						 => 'WY',
									  '**');

	End;
								
	EXPORT CountryDesc(STRING code) := FUNCTION
				 uc_s := corp2.t2u(code);
		     RETURN MAP(uc_s = 'AB'                                       => 'ALBERTA',
				            uc_s IN ['AG','ATG']                              => 'ANTIGUA AND BARBUDA',
							      uc_s IN ['ANT','NETHERLANDS ANTILLES']            => 'NETHERLANDS ANTILLES',
							      uc_s = 'AW'                                       => 'ARUBA',
							      uc_s IN ['ARE','UNITED ARAB EMIRATES']            => 'UNITED ARAB EMIRATES',
							      uc_s = 'AUS'                                      => 'AUSTRALIA',
							      uc_s = 'AUT'                                      => 'AUSTRIA',
							      uc_s IN ['BAH','BHS','BS','BAHAMAS']              => 'BAHAMAS',
										uc_s = 'BAHRAIN'                                  => 'BAHRAIN',
							      uc_s = 'BELARUS'                                  => 'BELARUS',
							      uc_s = 'BENIN'                                    => 'BENIN',
							      uc_s = 'BOLIVIA'                                  => 'BOLIVIA',
							      uc_s = 'BOTSWANA'                                 => 'BOTSWANA',
							      uc_s IN ['BDI','BURUNDI']                         => 'BURUNDI',
							      uc_s IN ['BB','BRB','BARBADOS']                   => 'BARBADOS',
							      uc_s IN ['BE','BEL']                              => 'BELGIUM',
							      uc_s = 'BGD'                                      => 'BANGLADESH',
							      uc_s IN ['BGR','BULGARIA']                        => 'BULGARIA',
							      uc_s = 'BLZ'                                      => 'BELIZE',
							      uc_s IN ['BM','BER','BMU','BRM']	                => 'BERMUDA',
							      uc_s = 'BRA'                                      => 'BRAZIL',
										uc_s = 'BC'	                                      => 'BRITISH COLUMBIA',
							      uc_s IN ['IOT','BRITISH INDIAN OCEAN TERRITORY']  => 'BRITISH INDIAN OCEAN TERRITORY',
							      uc_s IN ['BVI','VGB']                             => 'BRITISH VIRGIN ISLANDS',
										uc_s = 'KHM'                                      => 'CAMBODIA',
							      uc_s IN ['CAN','CN']                              => 'CANADA',
							      uc_s IN ['CAY','CYM']                             => 'CAYMAN ISLANDS',
							      uc_s = 'CHL'                                      => 'CHILE',
							      uc_s IN ['CHN','CHINA']                           => 'CHINA',
							      uc_s = 'CIV'                                      => 'COTE D\'IVOIRE', 
							      uc_s = 'COG'                                      => 'CONGO',
							      uc_s = 'COL'                                      => 'COLUMBIA',
							      uc_s = 'COK'                                      => 'COOK ISLANDS',
							      uc_s = 'CRI'                                      => 'COSTA RICA',
										uc_s = 'CUBA'                                     => 'CUBA',
							      uc_s = 'CYP'                                      => 'CYPRUS',
							      uc_s IN ['CZE','CZECH REPUBLIC']                  => 'CZECH REPUBLIC',
							      uc_s IN ['DEN','DNK']                             => 'DENMARK',
							      uc_s = 'DOM'                                      => 'DOMINICAN REPUBLIC',
							      uc_s IN ['EGY','EGYPT']                           => 'EGYPT',
							      uc_s IN ['ECU','ECUADOR']                         => 'ECUADOR',
							      uc_s = 'ERITREA'                                  => 'ERITREA',
							      uc_s IN ['ESP','SPAIN']                           => 'SPAIN',
							      uc_s IN ['ENG','GB']                              => 'ENGLAND',
							      uc_s = 'FIN'                                      => 'FINLAND',
							      uc_s IN ['FR','FRA']                              => 'FRANCE',
							      uc_s IN ['DEU','GR','GER']                        => 'GERMANY',
	                  uc_s = 'GHA'                                      => 'GHANA',
							      uc_s = 'GBR'                                      => 'GREAT BRITAIN',
							      uc_s IN ['GRC','GRE']                             => 'GREECE',
							      uc_s = 'GTM'                                      => 'GUATEMALA',
							      uc_s IN ['GU','GUM']                              => 'GUAM',
							      uc_s = 'GUINEA'                                   => 'GUINEA',
							      uc_s = 'HKG'                                      => 'HONG KONG',
							      uc_s = 'HTI'                                      => 'HAITI',
							      uc_s = 'HON'                                      => 'HONDURAS',
							      uc_s = 'HUN'                                      => 'HUNGARY',
							      uc_s = 'ISL'                                      => 'ICELAND',
							      uc_s = 'IND'                                      => 'INDIA',
							      uc_s = 'IDN'                                      => 'INDONESIA',
							      uc_s IN ['IRE','IRL']                             => 'IRELAND',
							      uc_s = 'ISR'                                      => 'ISRAEL',
							      uc_s IN ['IT','ITA']          	                  => 'ITALY',
							      uc_s IN ['JM','JAM']                              => 'JAMAICA',
							      uc_s IN ['JA','JP','JAP','JPN']                   => 'JAPAN',
							      uc_s = 'JORDAN'                                   => 'JORDAN',
	                  uc_s = 'KAZ'                                      => 'KAZAKHSTAN',
							      uc_s = 'KEN'                                      => 'KENYA',
										uc_s = 'KOR'                                      => 'KOREA',
                    uc_s = 'LAO'                                      => 'LAO PDR',
							      uc_s = 'LBR'                                      => 'LIBERIA',
							      uc_s = 'LIB'                                      => 'LIBYA',
							      uc_s = 'LIE'                                      => 'LIECHTENSTEIN',
							      uc_s = 'LUX'                                      => 'LUXEMBOURG',
							      uc_s = 'MV'                                       => 'MALDIVES',
							      uc_s = 'MLI'                                      => 'MALI',
							      uc_s IN ['MH','MHL']                              => 'MARSHALL ISLANDS',
							      uc_s = 'MUS'                                      => 'MAURITIUS',
										uc_s = 'MAYOTTE'                                  => 'MAYOTTE',
							      uc_s IN ['MEX','MX']                              => 'MEXICO',
							      uc_s = 'MTQ'                                      => 'MARTINIQUE',
							      uc_s IN ['NA','NAMIBIA']                          => 'NAMIBIA',
							      uc_s IN ['NET','NLD','NTH']                       => 'NETHERLANDS',
						        uc_s = 'NEV'                                      => 'NEVADA',
										uc_s = 'NGA'                            					=> 'NIGERIA',
										uc_s = 'NPL'                           						=> 'NEPAL',
										uc_s = 'NOR'                            					=> 'NORWAY',
										uc_s = 'NZL'                            					=> 'NEW ZEALAND',
										uc_s IN ['ONT','ON']                            	=> 'ONTARIO',
										uc_s = 'OC'                                       => 'OUT OF COUNTRY',
							      uc_s IN ['PK','PAK']          	                  => 'PAKISTAN',
										uc_s = 'PAN'                            					=> 'PANAMA',
										uc_s = 'PY'                             					=> 'PARAGUAY',
										uc_s = 'PER'                           						=> 'PERU',
										uc_s = 'PHL'                            					=> 'PHILIPPINES',
										uc_s = 'PN'                             					=> 'PITCAIRN',
							      uc_s IN ['PL','POL']         	                    => 'POLAND',
							      uc_s IN ['PR','PRI','PUERTO RICO']                => 'PUERTO RICO',
							      uc_s = 'PRT'                                      => 'PORTUGAL',
							      uc_s IN ['QAT','QATAR']                           => 'QATAR',
							      uc_s IN ['QUE','QC']                              => 'QUEBEC',
										uc_s = 'KNA'                                      => 'SAINT KITTS AND NERVIS',
							      uc_s = 'LCA'                                      => 'SAINT LUCIA',
							      uc_s = 'MF'                                       => 'SAINT MARTIN FRENCH PART',
							      uc_s = 'VCT'                                      => 'SAINT VINCENT AND THE GRENADINES',
							      uc_s = 'SEN'                                      => 'SENEGAL',
							      uc_s IN ['SGP','SIN']                             => 'SINGAPORE',
										uc_s = 'SVK'                                      => 'SLOVAKIA',
										uc_s = 'ZAF'                            					=> 'SOUTH AFRICA',
										uc_s = 'LKA'                                      => 'SRI LANKA',
										uc_s = 'SUDAN'                                    => 'SUDAN',
							      uc_s = 'SWE'                                      => 'SWEDEN',
							      uc_s IN ['CH','CHE','SWI']     	                  => 'SWITZERLAND',
										uc_s = 'RUS'                                      => 'RUSSIAN FEDERATION',
										uc_s = 'TWN'                            					=> 'TAIWAN',
										uc_s = 'TZA'                            					=> 'TANZANIA',
										uc_s = 'TUR'                            					=> 'TURKEY',
										uc_s = 'TCA'                            					=> 'TURKS AND CAICOS ISLANDS',
										uc_s = 'UMI'                            					=> 'UNITED STATES MINOR OUTLYING',
										uc_s = 'UK'                            						=> 'UNITED KINGDOM',
										uc_s IN ['US','USA']                              => 'US',
										uc_s = 'URY'                            					=> 'URUGUAY',
										uc_s = 'VEN'                            					=> 'VENEZUELA',
										uc_s = 'VNM'                            					=> 'VIETNAM',
										uc_s = 'VG'                             					=> 'VIRGIN ISLANDS BR',
							      uc_s IN ['VI','VIR']                              => 'VIRGIN ISLANDS',
										uc_s = 'YEMEN'                                    => 'YEMEN',
							      uc_s = 'ZMB'                            					=> 'ZAMBIA',
							      uc_s IN ['ZWE','ZIMBABWE']                        => 'ZIMBABWE',
										uc_s = ''                                         => '',
										'**|' + uc_s								
									 );
	END;
  //********************************************************************
		//Phone_No: cleans phone numbers and Returns a hyphenated 7 or 10 digit number 
	//********************************************************************	
  EXPORT PhoneNo(STRING Phone) := FUNCTION

		ph           := (STRING)(INTEGER)ut.CleanPhone(phone); // we have first 3 digits are zeros in phones EX:0003456789 ,0000000000
    phone_number := IF(TRIM(ph)<>'0',IF(LENGTH(ph) = 10, ph[1..3]+'-'+ph[4..6]+'-'+ph[7..10], IF(LENGTH(ph)=7	,	ph[1..3]+'-'+ph[4..7],ph)),''); //only 10 digit and 7 digit will be hyphenated other numbers will not !
		RETURN phone_number;
		
  END;
	
	//********************************************************************
		//StateDesc: Returns full name from "Two digit State_Code" 
	//********************************************************************	
	EXPORT  STRING StateDesc(STRING state) := FUNCTION
		st  := corp2.t2u(state);
		RETURN MAP (st ='AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
								st ='AB' => 'CANADA',
								st ='AE' => '', //MILITARY ADDRESS
								st ='AF' => 'AFRICA',
								st ='AK' => 'ALASKA',
								st ='AL' => 'ALABAMA',
								st ='AP' => 'ARMED FORCES PACIFIC',
								st ='AR' => 'ARKANSAS',
								st ='AS' => 'AMERICAN SAMOA',
								st ='AU' => 'AUSTRALIA',
								st ='AZ' => 'ARIZONA',
								st ='BE' => 'BERMUDA',
								st ='BL' => 'BELGIUM',
								st ='BR' => 'BARBADOS',
								st ='BW' => 'BRITISH WEST INDIES',
								st ='CA' => 'CALIFORNIA',
								st ='CB' => 'COLUMBIA',
								st ='CD' => 'CANADA',
								st ='CH' => 'CHINA',
								st ='CI' => 'COOK ISLANDS',
								st ='CO' => 'COLORADO',
								st ='CT' => 'CONNECTICUT',
								st ='CZ' => 'CANAL ZONE',
								st ='DC' => 'DISTRICT OF COLUMBIA',
								st ='DE' => 'DELAWARE',
								st ='EU' => 'EUROPE',
								st ='FL' => 'FLORIDA',
								st ='FM' => 'FEDERATED STATES OF MICRONESIA',
								st ='FR' => 'FRANCE',
								st ='GA' => 'GEORGIA',
								st ='GB' => 'GREAT BRITAIN',
								st ='GR' => 'GERMANY',
								st ='GU' => 'GUAM',
								st ='HI' => 'HAWAII',
								st ='HK' => 'HONG KONG',
								st ='IA' => 'IOWA',
								st ='ID' => 'IDAHO',
								st ='IE' => 'IRELAND',
								st ='II' => 'INDIA',
								st ='IL' => 'ILLINOIS',
								st ='IN' => 'INDIANA',
								st ='JA' => 'JAPAN',
								st ='KS' => 'KANSAS',
								st ='KY' => 'KENTUCKY',
								st ='LA' => 'LOUISIANA',
								st ='LX' => 'LUXEMBOURG',
								st ='MA' => 'MASSACHUSETTS',
								st ='MD' => 'MARYLAND',
								st ='ME' => 'MAINE',
								st ='MH' => 'MARSHALL ISLANDS',
								st ='MI' => 'MICHIGAN',
								st ='MN' => 'MINNESOTA',
								st ='MO' => 'MISSOURI',
								st ='MP' => 'NORTHERN MARIANA ISLANDS',
								st ='MS' => 'MISSISSIPPI',
								st ='MT' => 'MONTANA',
								st ='MX' => 'MEXICO',
								st ='NC' => 'NORTH CAROLINA',
								st ='ND' => 'NORTH DAKOTA',
								st ='NE' => 'NEBRASKA',
								st ='NH' => 'NEW HAMPSHIRE',
								st ='NJ' => 'NEW JERSEY',
								st ='NL' => 'NETHERLANDS',
								st ='NM' => 'NEW MEXICO',
								st ='NS' => 'NOVA SCOTIA, CANADA',
								st ='NV' => 'NEVADA',
								st ='NY' => 'NEW YORK',
								st ='OA' => 'OTHER ASIA',
								st ='OH' => 'OHIO',
								st ='OK' => 'OKLAHOMA',
								st ='OR' => 'OREGON',
								st ='PA' => 'PENNSYLVANIA',
								st ='PH' => 'PHILIPPINES',
								st ='PN' => 'PANAMA',
								st ='PR' => 'PUERTO RICO',
								st ='PW' => '' , //TYPO - COMPANY IS FROM PUERTO RICO
								st ='RI' => 'RHODE ISLAND',
								st ='SA' => 'OTHER S&C AMERICAN',
								st ='SC' => 'SOUTH CAROLINA',
								st ='SD' => 'SOUTH DAKOTA',
								st ='SL' => 'SCOTLAND',
								st ='TN' => 'TENNESSEE',
								st ='TX' => 'TEXAS',
								st ='UK' => 'UNITED KINGDOM',
								st ='UN' => ''  ,//UNKNOWN
								st ='US' => 'UNITED STATES',
								st ='UT' => 'UTAH',
								st ='VA' => 'VIRGINIA',
								st ='VI' => 'VIRGIN ISLANDS',
								st ='VT' => 'VERMONT',
								st ='WA' => 'WASHINGTON',
								st ='WI' => 'WISCONSIN',
								st ='WV' => 'WEST VIRGINIA',
								st ='WY' => 'WYOMING',    
         //DF-20911...not only two digit codes, we also receiving full state name from vendor !!
								st ='AFRICA'														 =>'AFRICA'	  ,
								st ='ALABAMA'														 =>'ALABAMA' 	,
								st ='ALASKA'														 =>'ALASKA' 	,
								st ='AMERICAN SAMOA'										 =>'AMERICAN SAMOA'	,
								st ='ARIZONA'														 =>'ARIZONA'	,
								st ='ARKANSAS'													 =>'ARKANSAS'	,
								st ='ARMED FORCES AMERICAS EXCEPT CANADA'=>'ARMED FORCES AMERICAS EXCEPT CANADA'	,
								st ='ARMED FORCES PACIFIC'							 =>'ARMED FORCES PACIFIC'	,
								st ='AUSTRALIA'													 =>'AUSTRALIA'	,
								st ='BARBADOS'													 =>'BARBADOS'	,
								st ='BELGIUM'														 =>'BELGIUM'	,
								st ='BERMUDA'														 =>'BERMUDA'	,
								st ='BRITISH WEST INDIES'								 =>'BRITISH WEST INDIES'	,
								st ='CALIFORNIA'												 =>'CALIFORNIA'	,
								st ='CANADA'														 =>'CANADA'	,
								st ='CANADA'														 =>'CANADA'	,
								st ='CANAL ZONE'												 =>'CANAL ZONE'	,
								st ='CHINA'														 	 =>'CHINA'	,
								st ='COLORADO'													 =>'COLORADO'	,
								st ='COLUMBIA'													 =>'COLUMBIA'	,
								st ='CONNECTICUT'												 =>'CONNECTICUT'	,
								st ='COOK ISLANDS'											 =>'COOK ISLANDS'	,
								st ='DELAWARE'													 =>'DELAWARE'	,
								st ='DISTRICT OF COLUMBIA'							 =>'DISTRICT OF COLUMBIA'	,
								st ='EUROPE'														 =>'EUROPE'	,
								st ='FEDERATED STATES OF MICRONESIA'		 =>'FEDERATED STATES OF MICRONESIA'	,
								st ='FLORIDA'														 =>'FLORIDA'	,
								st ='FRANCE'														 =>'FRANCE'	,
								st ='GERMANY'														 =>'GERMANY'	,
								st ='GREAT BRITAIN'											 =>'GREAT BRITAIN'	,
								st ='GUAM'															 =>'GUAM'	,
								st ='HAWAII'														 =>'HAWAII'	,
								st ='HONG KONG'													 =>'HONG KONG'	,
								st ='IDAHO'														 	 =>'IDAHO'	,
								st ='ILLINOIS'													 =>'ILLINOIS'	,
								st ='INDIA'														 	 =>'INDIA'	,
								st ='INDIANA'														 =>'INDIANA'	,
								st ='IOWA'														 	 =>'IOWA'	,
								st ='IRELAND'														 =>'IRELAND'	,
								st ='JAPAN'														 	 =>'JAPAN'	,
								st ='KANSAS'														 =>'KANSAS'	,
								st ='KENTUCKY'													 =>'KENTUCKY'	,
								st ='LOUISIANA'													 =>'LOUISIANA'	,
								st ='LUXEMBOURG'												 =>'LUXEMBOURG'	,
								st ='MAINE'															 =>'MAINE'	,
								st ='MARSHALL ISLANDS'									 =>'MARSHALL ISLANDS'	,
								st ='MARYLAND'													 =>'MARYLAND'	,
								st ='MASSACHUSETTS'											 =>'MASSACHUSETTS'	,
								st ='MEXICO'														 =>'MEXICO'	,
								st ='MICHIGAN'													 =>'MICHIGAN'	,
								st ='MINNESOTA'													 =>'MINNESOTA'	,
								st ='MISSISSIPPI'												 =>'MISSISSIPPI'	,
								st ='MISSOURI'													 =>'MISSOURI'	,
								st ='MONTANA'														 =>'MONTANA'	,
								st ='NEBRASKA'													 =>'NEBRASKA'	,
								st ='NETHERLANDS'												 =>'NETHERLANDS'	,
								st ='NEVADA'														 =>'NEVADA'	,
								st ='NEW HAMPSHIRE'											 =>'NEW HAMPSHIRE'	,
								st ='NEW JERSEY'												 =>'NEW JERSEY'	,
								st ='NEW MEXICO'												 =>'NEW MEXICO'	,
								st ='NEW YORK'													 =>'NEW YORK'	,
								st ='NORTH CAROLINA'										 =>'NORTH CAROLINA'	,
								st ='NORTH DAKOTA'											 =>'NORTH DAKOTA'	,
								st ='NORTHERN MARIANA ISLANDS'					 =>'NORTHERN MARIANA ISLANDS'	,
								st ='NOVA SCOTIA, CANADA'								 =>'NOVA SCOTIA, CANADA'	,
								st ='OHIO'														 	 =>'OHIO'	,
								st ='OKLAHOMA'													 =>'OKLAHOMA'	,
								st ='OREGON'														 =>'OREGON'	,
								st ='OTHER ASIA'												 =>'OTHER ASIA'	,
								st ='OTHER S&C AMERICAN'								 =>'OTHER S&C AMERICAN'	,
								st ='PANAMA'														 =>'PANAMA'	,
								st ='PENNSYLVANIA'											 =>'PENNSYLVANIA'	,
								st ='PHILIPPINES'												 =>'PHILIPPINES'	,
								st ='PUERTO RICO'												 =>'PUERTO RICO'	,
								st ='RHODE ISLAND'											 =>'RHODE ISLAND'	,
								st ='SCOTLAND'													 =>'SCOTLAND'	,
								st ='SOUTH CAROLINA'										 =>'SOUTH CAROLINA'	,
								st ='SOUTH DAKOTA'											 =>'SOUTH DAKOTA'	,
								st ='TENNESSEE'													 =>'TENNESSEE'	,
								st ='TEXAS'														 	 =>'TEXAS'	,
								st ='UNITED KINGDOM'										 =>'UNITED KINGDOM'	,
								st ='UNITED STATES'											 =>'UNITED STATES'	,
								st ='UTAH'															 =>'UTAH'	,
								st ='VERMONT'														 =>'VERMONT'	,
								st ='VIRGIN ISLANDS'										 =>'VIRGIN ISLANDS'	,
								st ='VIRGINIA'													 =>'VIRGINIA'	,
								st ='WASHINGTON'												 =>'WASHINGTON'	,
								st ='WEST VIRGINIA'											 =>'WEST VIRGINIA'	,
								st ='WISCONSIN'													 =>'WISCONSIN'	,
								st ='WYOMING'														 =>'WYOMING'	,
								st =''   																 => '',
								'**|'+ st);
							
		END;													

    //********************************************************************
      //Below date utility to fix the slashed dates into YYYYMMDD
		//********************************************************************
    EXPORT fix_Date(STRING d):= FUNCTION
		
 			dt:= ut.date_slashed_mmddyyyy_to_yyyymmdd(d);
			RETURN dt;

		END;
		
		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//												  input: s -> bus_type
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'ALIEN CORPORATION (RICO)' 											=> uc_s,
											uc_s = 'CABLE/VIDEO FRANCHISE'								          => uc_s, // DF-20387
											uc_s = 'COOPERATIVE MARKETING ASSOCIATION'              => uc_s, // DF-20387
											uc_s = 'DEVELOPMENT AUTHORITY'                          => uc_s, // DF-20387
											uc_s = 'DOCUMENT ORDER'											            => uc_s,
											uc_s = 'DOMESTIC BANK'							                		=> uc_s,
											uc_s = 'DOMESTIC CORPORATION'												    => uc_s,
											uc_s = 'DOMESTIC CREDIT UNION'									        => uc_s,
											uc_s = 'DOMESTIC FORPROFIT COOP'									      => uc_s,
											uc_s = 'DOMESTIC INSURANCE COMPANY'									    => uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY COMPANY'							=> uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP'	=> uc_s,
											uc_s = 'DOMESTIC LIMITED LIABILITY PARTNERSHIP'				  => uc_s,
											uc_s = 'DOMESTIC LIMITED PARTNERSHIP'									  => uc_s,
											uc_s = 'DOMESTIC NON-ENTITY NONFILING'								  => uc_s,
											uc_s = 'DOMESTIC NON-FILING ENTITY'									    => uc_s,
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'									=> uc_s,
											uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'						  => uc_s,
											uc_s = 'DOMESTIC PROFESSIONAL PA'									      => uc_s,
											//uc_s = 'DOMESTIC PROFIT'									      			=> uc_s,				
											uc_s = 'DOMESTIC PROFIT CORPORATION'			              => uc_s,
											uc_s = 'DOMESTIC UNKNOWN'									              => uc_s,
											uc_s = 'FOREIGN BANK'									                  => uc_s,
											uc_s = 'FOREIGN CORPORATION'									          => uc_s,
											uc_s = 'FOREIGN CREDIT UNION'									          => uc_s,
											uc_s = 'FOREIGN INSURANCE COMPANY'									    => uc_s,
											uc_s = 'FOREIGN LIMITED COOPERATIVE ASSOCIATION'				=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY COMPANY'							=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP'	=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY PARTNERSHIP'					=> uc_s,
											uc_s = 'FOREIGN LIMITED PARTNERSHIP'									  => uc_s,
											uc_s = 'FOREIGN NONPROFIT CORPORATION'									=> uc_s,
										  uc_s = 'FOREIGN NON-QUALIFYING ENTITY'									=> uc_s,
											uc_s = 'FOREIGN PROFESSIONAL CORPORATION'							  => uc_s,
											uc_s = 'FOREIGN PROFIT CORPORATION'									    => uc_s,
											uc_s = 'FOREIGN UNKNOWN'									              => uc_s,
											uc_s = 'MARKETING ASSOCIATION'									        => uc_s,
											uc_s = 'MUTUAL AID RESOURCE PACT'									      => uc_s,
											uc_s = 'NAME RESERVATION'									              => uc_s,
											uc_s = 'PRIVATE CHILD SUPPORT COLLECTOR'                => uc_s, // DF-20387
											uc_s = 'TRANSPORTATION/TELECOMMUNICATION/RAILROAD'		  => uc_s,
											'**|'+uc_s 																													//scrubbing for new business types
										 );

		END;
		
		//****************************************************************************
		//ProfitIndicator: returns "Y" or "N".
		//								 input: s -> bus_type
		//****************************************************************************
		EXPORT ProfitIndicator(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'DOMESTIC FORPROFIT COOP'									      => 'Y',
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'DOMESTIC PROFIT'									              => 'Y',
											uc_s = 'DOMESTIC PROFIT CORPORATION'                    => 'Y',
											uc_s = 'FOREIGN NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'FOREIGN PROFIT CORPORATION'									    => 'Y',
											'' 																													 
										 );

		END;
		
		//****************************************************************************
		//CorpStatusDesc: returns the "corp_status_desc".
		//												  input: s -> EntityStatus
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'ABANDONED' 										=> uc_s,
											uc_s = 'ACTIVE'								        => uc_s,
											uc_s = 'ACTIVE PENDING'							  => uc_s,
											uc_s = 'ACTIVE/COMPLIANCE'						=> uc_s,
											uc_s = 'ACTIVE/NONCOMPLIANCE'				  => uc_s,
											uc_s = 'ACTIVE/OWES CURRENT YEAR AR'	=> uc_s,
											uc_s = 'ADMIN. DISSOLVED'						  => uc_s,
											uc_s = 'CANCELLED'									  => uc_s,
											uc_s = 'CONSOLIDATED'							    => uc_s,
											uc_s = 'CONVERTED'	                  => uc_s,
											uc_s = 'DISAPPROVED FILING'				    => uc_s,
											uc_s = 'DISSOLVED'									  => uc_s,
											uc_s = 'DO NOT USE DISAPPROVED'				=> uc_s,
											uc_s = 'ELECTION TO LLC/LP'						=> uc_s,
											uc_s = 'EXPIRED'									    => uc_s,
											uc_s = 'FLAWED/DEFICIENT'						  => uc_s,
											uc_s = 'HOLD'									        => uc_s,
											uc_s = 'INACTIVE'									    => uc_s,
											uc_s = 'JUDICAL DISSOLUTION'					=> uc_s,
											uc_s = 'MERGED'									      => uc_s,
											uc_s = 'NAME RESERVATION REJECTED'		=> uc_s,
											uc_s = 'PENDING'									    => uc_s,
											uc_s = 'PENDING DISSOLUTION'					=> uc_s,
											uc_s = 'PENDING MERGER'				        => uc_s,
											uc_s = 'PENDING TERMINATION'				 	=> uc_s,
											uc_s = 'PENDING WITHDRAWAL'	          => uc_s,
											uc_s = 'REDEEMED'					            => uc_s,
											uc_s = 'REJECTED'									    => uc_s,
											uc_s = 'REVOKED'									    => uc_s,
										  uc_s = 'SEE NOTEPAD'									=> uc_s,
											uc_s = 'TERMINATED'							      => uc_s,
											uc_s = 'TO BE DISSOLVED'						  => uc_s,
											uc_s = 'VOID'									        => uc_s,
											uc_s = 'WITHDRAWN'									  => uc_s,
											uc_s = 'WITHDRAWN/MERGED'						  => uc_s,
											'**|'+uc_s 															//scrubbing for new entity status
										 );
	         END;

		//****************************************************************************
		//ForeignDomesticInd: returns the "corp_foreign_domestic_ind".
		//												  input: s -> 	bus_type
		//												  input: fc-> 	foreigncountry
		
		//****************************************************************************
		EXPORT ForeignDomesticInd(STRING s, STRING fc) := FUNCTION
					 US_list 				:= ['USA','US','UNITEDSTATES','GA','GEORGIA',''];
					 uc_s 					:= corp2.t2u(s);
					 uc_fc					:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters					 
					RETURN MAP(uc_s IN ['CABLE/VIDEO FRANCHISE','DOCUMENT ORDER','DOMESTIC BANK','DOMESTIC CORPORATION','DOMESTIC CREDIT UNION',
															'DOMESTIC FORPROFIT COOP','DOMESTIC INSURANCE COMPANY','DOMESTIC LIMITED LIABILITY COMPANY',
															'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
															'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC NON-ENTITY NONFILING','DOMESTIC NON-FILING ENTITY',
															'DOMESTIC NONPROFIT CORPORATION','DOMESTIC PROFESSIONAL CORPORATION','DOMESTIC PROFESSIONAL PA',
															'DOMESTIC PROFIT CORPORATION','DOMESTIC UNKNOWN','MARKETING ASSOCIATION','MUTUAL AID RESOURCE PACT',	
															'NAME RESERVATION','TRANSPORTATION/TELECOMMUNICATION/RAILROAD']                                                     	=> 'D',
										 uc_s IN ['ALIEN CORPORATION (RICO)','FOREIGN BANK','FOREIGN CORPORATION','FOREIGN CREDIT UNION','FOREIGN INSURANCE COMPANY',	
														 'FOREIGN LIMITED COOPERATIVE ASSOCIATION','FOREIGN LIMITED LIABILITY COMPANY',
														 'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP','FOREIGN LIMITED LIABILITY PARTNERSHIP',
														 'FOREIGN LIMITED PARTNERSHIP','FOREIGN NONPROFIT CORPORATION','FOREIGN NON-QUALIFYING ENTITY',
														 'FOREIGN PROFESSIONAL CORPORATION','FOREIGN PROFIT CORPORATION','FOREIGN UNKNOWN']                                   	=> 'F',
										 uc_fc NOT IN US_list 																																																					=> 'F',
										 ''
										);
		END;
		
		//****************************************************************************
		//Inc_Date: returns the "corp_inc_date" or "corp_forgn_date".
		//					input: fc -> ForeignCountry		
		//					input: bt -> BusinessTypeDesc
		//					input: cd -> CommencementDate
		//					input: ed -> EffectiveDate
		//****************************************************************************
		EXPORT Inc_Date(STRING fc, STRING bt, STRING cd, STRING ed) := FUNCTION
					 US_list	:= ['USA','US','UNITEDSTATES','GA','GEORGIA','']; 
					 uc_fc		:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
					 uc_bt		:= corp2.t2u(bt);
					 uc_cd		:= corp2.t2u(cd);
					 uc_ed		:= corp2.t2u(ed);
					 RETURN MAP(ForeignDomesticInd(uc_bt,uc_fc) = 'D' AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) IN US_list AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> '' 			=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = 'D' AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) IN US_list AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''			=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
 										  ''
										 );
		END;

		//****************************************************************************
		//Forgn_Date: returns the "corp_inc_date" or "corp_forgn_date".
		//						input: fc -> ForeignCountry		
		//						input: bt -> BusinessTypeDesc
		//						input: cd -> CommencementDate
		//						input: ed -> EffectiveDate
		//****************************************************************************
		EXPORT Forgn_Date(STRING fc, STRING bt, STRING cd, STRING ed) := FUNCTION
					 US_list	:= ['USA','US','UNITEDSTATES','GA','GEORGIA','']; 
					 uc_fc		:= corp2.t2u(stringlib.stringfilter(fc,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')); //remove blanks and special characters
					 uc_bt		:= corp2.t2u(bt);
					 uc_cd		:= corp2.t2u(cd);
					 uc_ed		:= corp2.t2u(ed);
					 RETURN MAP(ForeignDomesticInd(uc_bt,uc_fc) = 'F' AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) NOT IN US_list AND Corp2_Mapping.fValidateDate(uc_cd).PastDate <> '' 	=> Corp2_Mapping.fValidateDate(uc_cd).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = 'F' AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''																		=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											ForeignDomesticInd(uc_bt,uc_fc) = ''  AND corp2.t2u(fc) NOT IN US_list AND Corp2_Mapping.fValidateDate(uc_ed).PastDate <> ''	=> Corp2_Mapping.fValidateDate(uc_ed).PastDate,
											''
										 );
		END;

END;		