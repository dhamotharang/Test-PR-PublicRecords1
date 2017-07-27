IMPORT Default,Corp2,Address,Lib_AddrClean,
			 Ut,lib_STRINGlib,_Control,VersionControl,
			 _Validate;

/* Necessity of having this functionality comes
	   from the fact that some foreign country codes
		 differ from ISO/Fips
	*/
EXPORT IL_common := MODULE
	EXPORT  ForeignStateFips(STRING pStateCode):= MODULE
      SHARED STRING vStateCode := Corp2.Rewrite_Common.UniformInput(pStateCode,'U');
      EXPORT Code :=  IF(regexfind('[[:alpha:]]',vStateCode) AND
                         regexfind('[[:digit:]]',vStateCode),'', 
	                       IF(regexfind('[[:digit:]]',vStateCode), MAP((INTEGER)vStateCode = 1 => 'ARG',(INTEGER)vStateCode = 2 => 'BEL',
                                                                     (INTEGER)vStateCode = 3 => 'BRA',(INTEGER)vStateCode = 4 => 'CAN',
                                                                     (INTEGER)vStateCode = 5 => 'CHL',(INTEGER)vStateCode = 6 => 'COL',
                                                                     (INTEGER)vStateCode = 7 => 'CRI',(INTEGER)vStateCode = 8 => 'CUB',
                                                                     (INTEGER)vStateCode = 9 => 'ECU',(INTEGER)vStateCode = 10 => 'FRA',
                                                                     (INTEGER)vStateCode = 11 => 'DEU',(INTEGER)vStateCode = 12 => 'GBR',
                                                                     (INTEGER)vStateCode = 13 => 'GTM',(INTEGER)vStateCode = 14 => 'HND',
                                                                     (INTEGER)vStateCode = 15 => 'IRL',(INTEGER)vStateCode = 16 => 'ITA',
                                                                     (INTEGER)vStateCode = 17 => 'MEX',(INTEGER)vStateCode = 18 => 'NLD',
                                                                     (INTEGER)vStateCode = 19 => 'PAN',(INTEGER)vStateCode = 20 => 'PRY',
                                                                     (INTEGER)vStateCode = 21 => 'PER',(INTEGER)vStateCode = 22 => 'PRT',
                                                                     (INTEGER)vStateCode = 23 => 'ESP',(INTEGER)vStateCode = 24 => 'SWZ',
                                                                     (INTEGER)vStateCode = 25 => 'TUR',(INTEGER)vStateCode = 26 => 'URY',
                                                                     (INTEGER)vStateCode = 27 => 'VEN',
												                                             (INTEGER)vStateCode = 57 => 'AO',(INTEGER)vStateCode = 58 => 'AB',
                                                                     (INTEGER)vStateCode = 59 => 'BC',(INTEGER)vStateCode = 60 => 'MB',
                                                                     (INTEGER)vStateCode = 61 => 'MM',(INTEGER)vStateCode = 62 => 'NB',
                                                                     (INTEGER)vStateCode = 63 => 'NS',(INTEGER)vStateCode = 64 => 'ON',
                                                                     (INTEGER)vStateCode = 65 => 'PQ',(INTEGER)vStateCode = 66 => 'SK',
                                                                     (INTEGER)vStateCode = 67 => 'LB',(INTEGER)vStateCode = 68 => 'NF',
                                                                     (INTEGER)vStateCode = 69 => 'NT',(INTEGER)vStateCode = 70 => 'PE',
                                                                     (INTEGER)vStateCode = 71 => 'YT',(INTEGER)vStateCode = 72 => 'HO',
                                                                    ''),''));
																																			
					
			EXPORT Desc :=  IF(regexfind('[[:alpha:]]',vStateCode) AND
                        regexfind('[[:digit:]]',vStateCode),'', 
	                      MAP(regexfind('[[:alpha:]]',vStateCode)=> MAP(vStateCode = 'AO' => 'FOREIGN COUNTRIES',vStateCode = 'AB' => 'ALBERTA',
												                                              vStateCode = 'BC' => 'BRITISH COLUMBIA',vStateCode = 'MB' => 'MANITOBA',
												                                              vStateCode = 'MM' => 'MEXICO',          vStateCode = 'NB' => 'NEW BRUNSWICK',
												                                              vStateCode = 'NS' => 'NOVA SCOTIA',     vStateCode = 'ON' => 'ONTARIO',
												                                              vStateCode = 'PQ' => 'QUEBEC',          vStateCode = 'SK' => 'SASKATCHEWAN',
												                                              vStateCode = 'LB' => 'LABRADOR',        vStateCode = 'NF' => 'NEWFOUNDLAND',
												                                              vStateCode = 'NT' => 'NORTHWEST TERRITORY',vStateCode = 'PE' => 'PRINCE EDWARD ISLAND',
												                                              vStateCode = 'YT' => 'YUKON',              vStateCode = 'HO' => 'HONDURAS',''),
																																			
												   regexfind('[[:digit:]]',vStateCode)=> MAP(	(INTEGER)vStateCode = 57 => 'FOREIGN COUNTRIES',(INTEGER)vStateCode = 58 => 'ALBERTA',
												                                              (INTEGER)vStateCode = 59 => 'BRITISH COLUMBIA',(INTEGER)vStateCode = 60 => 'MANITOBA',
												                                              (INTEGER)vStateCode = 61 => 'MEXICO',          (INTEGER)vStateCode = 62 => 'NEW BRUNSWICK',
												                                              (INTEGER)vStateCode = 63 => 'NOVA SCOTIA',     (INTEGER)vStateCode = 64 => 'ONTARIO',
												                                              (INTEGER)vStateCode = 65 => 'QUEBEC',          (INTEGER)vStateCode = 66 => 'SASKATCHEWAN',
												                                              (INTEGER)vStateCode = 67 => 'LABRADOR',        (INTEGER)vStateCode = 68 => 'NEWFOUNDLAND',
												                                              (INTEGER)vStateCode = 69 => 'NORTHWEST TERRITORY',(INTEGER)vStateCode = 70 => 'PRINCE EDWARD ISLAND',
												                                              (INTEGER)vStateCode = 71 => 'YUKON',             (INTEGER)vStateCode = 67 => 'HONDURAS',
													                                            (INTEGER)vStateCode = 1 => 'AGGENTINA' ,(INTEGER)vStateCode = 2 => 'BELGIUM'    ,
                                                                      (INTEGER)vStateCode = 3 => 'BRAZIL'    ,(INTEGER)vStateCode = 4 => 'CANADA'      ,
                                                                      (INTEGER)vStateCode = 5 => 'CHILE'     ,(INTEGER)vStateCode = 6 => 'COLUMBIA'    ,
                                                                      (INTEGER)vStateCode = 7 => 'COSTA RICA',(INTEGER)vStateCode = 8 => 'CUBA'        ,
                                                                      (INTEGER)vStateCode = 9 => 'EQUADOR'   ,(INTEGER)vStateCode = 10 => 'FRANCE'      ,
                                                                      (INTEGER)vStateCode = 11 => 'GERMANY'   ,(INTEGER)vStateCode = 12 => 'GREAT BRITAIN',
                                                                      (INTEGER)vStateCode = 13 => 'GUATEMALA' ,(INTEGER)vStateCode = 14 => 'HONDURAS'     ,
                                                                      (INTEGER)vStateCode = 15 => 'IRELAND'   ,(INTEGER)vStateCode = 16 => 'ITALY'       ,
                                                                      (INTEGER)vStateCode = 17 => 'MEXICO'    ,(INTEGER)vStateCode = 18 => 'NETHERLANDS' ,
                                                                      (INTEGER)vStateCode = 19 => 'PANAMA'    ,(INTEGER)vStateCode = 20 => 'PARAGUAY'    ,
                                                                      (INTEGER)vStateCode = 21 => 'PERU'      ,(INTEGER)vStateCode = 22 => 'PORTUGAL'    ,
                                                                      (INTEGER)vStateCode = 23 => 'SPAIN'     ,(INTEGER)vStateCode = 24 => 'SWITZERLAND' ,
                                                                      (INTEGER)vStateCode = 25 => 'TURKEY'    ,(INTEGER)vStateCode = 26 => 'URUGUAY'     ,
                                                                      (INTEGER)vStateCode = 27 => 'VENEZUELA',''),''));
			                 
											                                      
	END;//Foreign_State_Fips
	
	EXPORT LookupBusinessCorps(STRING3 pCorpIntent) := FUNCTION
    vCorpIntent := Corp2.Rewrite_Common.UniformInput(pCorpIntent);
    RETURN MAP(vCorpIntent = '001' => 'ADVERTISING',
                vCorpIntent = '002' => 'AGRICULTURE ENTERPRISES',
                vCorpIntent = '003' => 'AMUSEMENTS AND RECREATIONAL',
                vCorpIntent = '004' => 'AUTOMOBILE AND OTHER REPAIR SHOPS',
                vCorpIntent = '005' => 'AUTOMOBILE,TRUCK,IMPLEMENT, AND BOAT DEALERS',
                vCorpIntent = '006' => 'BUILDING OWNERSHIP AND OPERATION',
                vCorpIntent = '007' => 'BUSINESS SERVICES - CREDIT BUREAUS AND COLLECTION AGENCIES; ' + 
								                       'PERSONAL SUPPLY SERVICES;MANAGEMENT, CONSULTING AND PUBLIC RELATIONS; ' +
																			 'DETECTIVE AND PROTECTION AGENCIES, ETC.',
                vCorpIntent = '008' => 'CEMETERIES',
                vCorpIntent = '009' => 'COAL MINING AND SALE OF COAL',
                vCorpIntent = '010' => 'COMMODITIES AND FUTURES BROKERS',
                vCorpIntent = '011' => 'COMMUNICATION-RADIO AND TV BROADCASTING,CABLEVISION',
                vCorpIntent = '012' => 'CONSTRUCTION-GENERAL BUILDING CONTRACTORS',
                vCorpIntent = '013' => 'CONSTRUCTION-SPECIAL TRADE CONTRACTORS - PLUMBING, HEATING ' +
								                        'ELECTRICAL,MASONRY,CARPENTRY,ROOFING,LANDSCAPING, ETC' ,
                vCorpIntent = '014' => 'CURRENCY EXCHANGES',
                vCorpIntent = '015' => 'DISC CORPORATIONS',
                vCorpIntent = '016' => 'FINANCIAL,LENDING AND INVESTMENT INSTITUTIONS OTHER THAN BANKS',
                vCorpIntent = '017' => 'HEALTH SERVICES-PHYSICIANS,DENTISTS, AND OTHER HEALTH PRACTITIONERS',
                vCorpIntent = '018' => 'HEALTH SERVICES-NURSING HOMES,HOSPITALS, AND CLINICS',
                vCorpIntent = '019' => 'HOTELS,MOTELS, AND OTHER LODGING',
                vCorpIntent = '020' => 'IMPROVING AND BREEDING OF STOCK',
                vCorpIntent = '021' => 'INSURANCE AND/OR REAL ESTATE AGENCIES AND BROKERS',
                vCorpIntent = '022' => 'LEASING OR RENTAL-EQUIPMENT,AUTOS, ETC',
                vCorpIntent = '023' => 'MANUFACTURING (ONLY)',
                vCorpIntent = '024' => 'MANUFACTURING AND MERCANTILE (ONLY)',
                vCorpIntent = '025' => 'MERCANTILE (SALES ONLY, NO SERVICE)',
                vCorpIntent = '026' => 'PERSONAL SERVICES - BARBER AND BEAUITY SHOPS, LAUNDRY AND DRY CLEANING ' +
								                       'PHOTOGRAPHIC STUDIOS, HEALTH SPAS, ETC',
                vCorpIntent = '027' => 'PETROLEUM PRODUCTION,METAL MINING, QUARRYING',
                vCorpIntent = '028' => 'PRINTING AND PUBLICATION',
                vCorpIntent = '029' => 'PROFESSIONAL SERVICES - LEGAL, ACCOUNTING, ENGINEERING, ETC. ' +
								                       '(REGISTER WITH REGISTRATION AND EDUCATION)',
                vCorpIntent = '030' => 'REAL ESTATE INVESTMENT',
                vCorpIntent = '031' => 'RESTAURANT AND LOUNGE',
                vCorpIntent = '032' => 'RETAIL SALES AND SERVICE',
                vCorpIntent = '033' => 'SCHOOLS AND OTHER EDUCATIONAL SERVICES',
                vCorpIntent = '034' => 'TRANSPORTATION-FREIGHT',
                vCorpIntent = '035' => 'TRANSPORTATION-PASSENGER',
                vCorpIntent = '036' => 'UTILITIES',
                vCorpIntent = '037' => 'WAREHOUSING,STORAGE AND/OR FREIGHT FORWARDING',
                vCorpIntent = '038' => 'CORPORATION REGISTERED AGENT',
                vCorpIntent = '039' => 'WHOLESALE SALES',
                vCorpIntent = '040' => 'WHOLESALE AND RETAIL',
                vCorpIntent = '041' => 'MEDICAL,X-RAY OR DENTAL LABORATORY',
                vCorpIntent = '044' => 'ALL INCLUSIVE PURPOSE',
                vCorpIntent = '045' => 'BUSINESS CORPORATION',
                vCorpIntent = '046' => 'ATHLETIC',
                vCorpIntent = '047' => 'CHARITABLE OR BENEVOLENT',
                vCorpIntent = '048' => 'CONDOMINIUM ASSOCIATION',
                vCorpIntent = '049' => 'EDUCATIONAL,RESEARCH, OR SCIENTIFIC',
                vCorpIntent = '050' => 'CIVIC OR PATRIOTIC',
                vCorpIntent = '051' => 'POLITICAL',
                vCorpIntent = '052' => 'PROFESSIONAL,COMMERCIAL, OR TRADE ASSOCIATION',
                vCorpIntent = '053' => 'RELIGIOUS',
                vCorpIntent = '054' => 'SOCIAL',
                vCorpIntent = '055' => 'COOPERATIVE HOUSING',
                vCorpIntent = '056' => 'HOMEOWNERS ASSOCIATION-AS DEFINED BY CIVIL PROCEDURE ACT',
                vCorpIntent = '060' => 'NOT FOR PROFIT',
                '');
  END;
	
	EXPORT LookupStatusDesc(STRING2 pStatusCode) := FUNCTION
	 STRING2 vStatusCode := Corp2.Rewrite_Common.UniformInput(pStatusCode);
	 RETURN MAP(vStatusCode = '00'=>'GOOD STANDING',
              vStatusCode = '01'=>'REINSTATED',
              vStatusCode = '02'=>'NOT IN GOOD STANDING',
              vStatusCode = '03'=>'FEIN DELINQUENT',
              vStatusCode = '04'=>'UNACCEPTABLE PAYMENT',
              vStatusCode = '05'=>'AGENT VACATED',
              vStatusCode = '06'=>'WITHDRAWN',
              vStatusCode = '07'=>'REVOKED',
              vStatusCode = '08'=>'DISSOLVED',
              vStatusCode = '09'=>'INVOLUNTARY DISSOLUTION',
              vStatusCode = '10'=>'MERGED',
              vStatusCode = '11'=>'EXPIRED',
              vStatusCode = '12'=>'AB INITIO',
              vStatusCode = '13'=>'BANKRUPCY',
              vStatusCode = '14'=>'SUSPENDED','');
	END; 
	  
	
	EXPORT LookupILCounties(STRING pCntCode) := MODULE
	 STRING3 vCntCode := Corp2.Rewrite_Common.UniformInput(pCntCode);
	 
	 EXPORT Desc :=  IF(regexfind('[[:alpha:]]',vCntCode) AND
                        regexfind('[[:digit:]]',vCntCode),'', 
	                      MAP(regexfind('[[:digit:]]',vCntCode)=> 
												 MAP((INTEGER) vCntCode = 1  => 'ADAMS',      (INTEGER) vCntCode = 2   => 'ALEXANDER',
                             (INTEGER) vCntCode = 3	=> 'BOND',        (INTEGER) vCntCode = 4	=> 'BOONE',
                             (INTEGER) vCntCode = 5	=> 'BROWN',       (INTEGER) vCntCode = 6	=> 'BUREAU',
                             (INTEGER) vCntCode = 7	=> 'CALHOUN',     (INTEGER) vCntCode = 8	=> 'CARROLL',
                             (INTEGER) vCntCode = 9	=> 'CASS',        (INTEGER) vCntCode = 10	=> 'CHAMPAIGN',
                             (INTEGER) vCntCode = 11	=> 'CHRISTIAN', (INTEGER) vCntCode = 12	=> 'CLARK',
                             (INTEGER) vCntCode = 13	=> 'CLAY',      (INTEGER) vCntCode = 14	=> 'CLINTON',
                             (INTEGER) vCntCode = 15	=> 'COLES',     (INTEGER) vCntCode = 16	=> 'COOK',
                             (INTEGER) vCntCode = 17	=> 'CRAWFORD',  (INTEGER) vCntCode = 18	=> 'CUMBERLAND',
                             (INTEGER) vCntCode = 19	=> 'DEKALB',    (INTEGER) vCntCode = 20	=> 'DEWITT',
                             (INTEGER) vCntCode = 21	=> 'DOUGLAS',   (INTEGER) vCntCode = 22	=> 'DU PAGE',
                             (INTEGER) vCntCode = 23	=> 'EDGAR',     (INTEGER) vCntCode = 24	=> 'EDWARDS',
                             (INTEGER) vCntCode = 25	=> 'EFFINGHAM', (INTEGER) vCntCode = 26	=> 'FAYETTE',
                             (INTEGER) vCntCode = 27 => 'FORD',       (INTEGER) vCntCode = 28  => 'FRANKLIN',
                             (INTEGER) vCntCode = 29 => 'FULTON',     (INTEGER) vCntCode = 30  => 'GALLATIN',
                             (INTEGER) vCntCode = 31	=> 'GREENE',    (INTEGER) vCntCode = 32	=> 'GRUNDY',
                             (INTEGER) vCntCode = 33	=> 'HAMILTON',  (INTEGER) vCntCode = 34	=> 'HANCOCK',
                             (INTEGER) vCntCode = 35	=> 'HARDIN',    (INTEGER) vCntCode = 36	=> 'HENDERSON',
                             (INTEGER) vCntCode = 37	=> 'HENRY',     (INTEGER) vCntCode = 38	=> 'IROQUOIS',
                             (INTEGER) vCntCode = 39	=> 'JACKSON',   (INTEGER) vCntCode = 40	=> 'JASPER',
                             (INTEGER) vCntCode = 41	=> 'JEFFERSON', (INTEGER) vCntCode = 42	=> 'JERSEY',
                             (INTEGER) vCntCode = 43	=> 'JO DAVIESS', (INTEGER) vCntCode = 44	=> 'JOHNSON',  
                             (INTEGER) vCntCode = 45	=> 'KANE',      (INTEGER) vCntCode = 46	=> 'KANKAKEE',
                             (INTEGER) vCntCode = 47	=> 'KENDALL',   (INTEGER) vCntCode = 48	=> 'KNOX',
                             (INTEGER) vCntCode = 49	=> 'LAKE',      (INTEGER) vCntCode = 50	=> 'LA SALLE',
                             (INTEGER) vCntCode = 51	=> 'LAWRENCE',  (INTEGER) vCntCode = 52	=> 'LEE',
                             (INTEGER) vCntCode = 53	=> 'LIVINGSTON',(INTEGER) vCntCode = 54	=> 'LOGAN',
                             (INTEGER) vCntCode = 55	=> 'MC DONOUGH',(INTEGER) vCntCode = 56	=> 'MC HENRY',
                             (INTEGER) vCntCode = 57	=> 'MC LEAN',   (INTEGER) vCntCode = 58	=> 'MACON',
                             (INTEGER) vCntCode = 59	=> 'MACOUPIN',  (INTEGER) vCntCode = 60	=> 'MADISON',
                             (INTEGER) vCntCode = 61	=> 'MARION',    (INTEGER) vCntCode = 62	=> 'MARSHALL',
                             (INTEGER) vCntCode = 63	=> 'MASON',     (INTEGER) vCntCode = 64	=> 'MASSAC',
                             (INTEGER) vCntCode = 65	=> 'MENARD',    (INTEGER) vCntCode = 66	=> 'MERCER',
                             (INTEGER) vCntCode = 67	=> 'MONROE',    (INTEGER) vCntCode = 68	=> 'MONTGOMERY',
                             (INTEGER) vCntCode = 69	=> 'MORGAN',    (INTEGER) vCntCode = 70	=> 'MOULTRIE',
                             (INTEGER) vCntCode = 71	=> 'OGLE',      (INTEGER) vCntCode = 72	=> 'PEORIA',
                             (INTEGER) vCntCode = 73	=> 'PERRY',     (INTEGER) vCntCode = 74	=> 'PIATT',
                             (INTEGER) vCntCode = 75	=> 'PIKE',      (INTEGER) vCntCode = 76	=> 'POPE',
                             (INTEGER) vCntCode = 77	=> 'PULASKI',   (INTEGER) vCntCode = 78	=> 'PUTNAM',
                             (INTEGER) vCntCode = 79	=> 'RANDOLPH',  (INTEGER) vCntCode = 80	=> 'RICHLAND',
                             (INTEGER) vCntCode = 81	=> 'ROCK ISLAND',(INTEGER) vCntCode = 82	=> 'ST. CLAIR',
                             (INTEGER) vCntCode = 83	=> 'SALINE',     (INTEGER) vCntCode = 84	=> 'SANGAMON',
                             (INTEGER) vCntCode = 85	=> 'SCHUYLER',   (INTEGER) vCntCode = 86	=> 'SCOTT',
                             (INTEGER) vCntCode = 87	=> 'SHELBY',     (INTEGER) vCntCode = 88	=> 'STARK',
                             (INTEGER) vCntCode = 89	=> 'STEPHENSON', (INTEGER) vCntCode = 90	=> 'TAZEWELL',
                             (INTEGER) vCntCode = 91	=> 'UNION',      (INTEGER) vCntCode = 92	=> 'VERMILION',
                             (INTEGER) vCntCode = 93	=> 'WABASH',     (INTEGER) vCntCode = 94	=> 'WARREN',
                             (INTEGER) vCntCode = 95	=> 'WASHINGTON', (INTEGER) vCntCode = 96	=> 'WAYNE',
                             (INTEGER) vCntCode = 97	=> 'WHITE',      (INTEGER) vCntCode = 98	=> 'WHITESIDE',
                             (INTEGER) vCntCode = 99	=> 'WILL',       (INTEGER) vCntCode = 100=> 'WILLIAMSON',
                             (INTEGER) vCntCode = 101=> 'WINNEBAGO',  (INTEGER) vCntCode = 102=> 'WOODFORD',
                             (INTEGER) vCntCode = 103=> 'CITY OF CHICAGO',''),''));		

	END;
		
END;