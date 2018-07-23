EXPORT Constants := module


EXPORT ENTITYtype (INTEGER ID) := 
																	map(
																	ID = 0 => 'NONE' ,
																	ID = 1 => 'UNKNOWN',
																	ID = 2 => 'INDIVIDUAL',
																	ID = 3 => 'BUSINESS',
																	ID = 4 => 'VESSEL',
																	ID = 5 => 'COUNTRY',
																	ID = 6 => 'UNSTRUCTURED',
																	ID = 7 => 'TEXT',
																'');

EXPORT ADDRESStype (INTEGER ID) := 
																	map(
																	ID = 0 => 'NONE' ,
																	ID = 1 => 'CURRENT',
																	ID = 2 => 'MAILING',
																	ID = 3 => 'PREVIOUS',
																	ID = 4 => 'UNKNOWN',
																'');

EXPORT AdditionalInfoType (INTEGER ID) := 
								map(
										ID = 0 => 'NONE',
										ID = 1 => 'CITIZENSHIP',
										ID = 2 => 'COMPLEXION',
										ID = 3 => 'DISTINGUISHINGMARKS',
										ID = 4 => 'DOB',
										ID = 5 => 'EYECOLOR',
										ID = 6 => 'HAIRCOLOR',
										ID = 7 => 'HEIGHT',
										ID = 8 => 'MOTHERSNAME',
										ID = 9 => 'NATIONALITY',
										ID = 10 => 'OCCUPATION',
										ID = 11 => 'PLACEOFBIRTH',
										ID = 12 => 'POSITION',
										ID = 13 => 'RACE',
										ID = 14 => 'VESSELCALLSIGN',
										ID = 15 => 'VESSELFLAG',
										ID = 16 => 'VESSELGRT',
										ID = 17 => 'VESSELOWNER',
										ID = 18 => 'VESSELTONNAGE',
										ID = 19 => 'VESSELTYPE',
										ID = 20 => 'WEIGHT',
										ID = 21 => 'INCIDENT',
										ID = 22 => 'OTHER',
										ID = 23 => 'IPADDRESS',
											'');



EXPORT ListType (INTEGER ID) := 
						map(
							ID = 0 => 'UNKNOWN',
							ID = 1 => 'ACCEPT',
							ID = 2 => 'COUNTY',
							ID = 3 => 'COUNTRY',
							ID = 4 => 'ENTITY',
							'');



EXPORT IDType (INTEGER ID) := 
							map(
							ID = 0	=>  'NONE',
							ID = 1	=>	'ACCOUNT',
							ID = 2	=>	'CEDULA',
							ID = 3 	=>	'DRIVERSLICENSE',
							ID = 4	=>	'EIN',
							ID = 5	=>	'MEMBER',
							ID = 6	=>	'MILITARY',
							ID = 7	=>	'NATIONAL',
							ID = 8	=>	'NIT',
							ID = 9	=>	'OTHER',
							ID = 10	=>	'PASSPORT',
							ID = 11	=>	'SSN',
							ID = 12	=>	'TAXID',
							ID = 13	=>	'VISA',
							ID = 14	=>	'EFTCODE',
							ID = 15	=>	'ABAROUTING',
							ID = 16	=>	'ALIENREGISTRATION',
							ID = 17	=>	'CHIPSUID',
							ID = 18	=>	'DUNS',
							ID = 19	=>	'IBAN',
							ID = 20	=>	'SWIFTBIC',
							ID = 21	=>	'BANKIDENTIFIERCODE',
							ID = 22	=>	'BANKPARTYID',
							ID = 23	=>	'CUSTOMERNUMBER',
							ID = 24	=>	'GLN',
							ID = 25	=>	'IBEI',
							ID = 26	=>	'SWIFTBEI',
							ID = 27	=>	'PROPRIETARYUID',
							ID = 28	=>	'GROUPID',
							ID = 29	=>	'PROVIDERID',
							ID = 30	=>	'RTACARDNUMBER',
							ID = 31	=>	'MEDICARENUMBER',
							ID = 32	=>	'MEDICAREREFERENCE',
							'');
							

    

 export AKACategoryType  (INTEGER ID) := 
				map(
        ID = 0	=>	'NONE',
        ID = 1	=>	'STRONG' ,
        ID = 2	=>	'WEAK' ,
						'');

 export CountryLocationType  (INTEGER ID) := 
					map(
				ID = 0	=>	'NONE',	
        ID = 1 	=>	'COUNTRY',	
        ID = 2	=>	'CODE',	
        ID = 3	=>	'ALTERNATENAME',	
        ID = 4	=>	'CITY',	
        ID = 5	=>	'PORT',	
        ID = 6 	=>	'TERM',	
				'');

export PhoneType (INTEGER ID) := 
					map(
							ID = 0	=>	'NONE',	
							ID = 1 	=>	'BUSINESS',	
							ID = 2	=>	'CELL',	
							ID = 3	=>	'FAX',	
							ID = 4	=>	'HOME',	
							ID = 5	=>	'WORK',	
							ID = 6 	=>	'UNKNOWN',	
							'');


  

export BuildStatusType  (INTEGER ID) := 
						map(
							ID = 0	=>	'PENDING',	
							ID = 1 	=>	'IN_PROGRESS',	
							ID = 2	=>	'CREATED',	
							ID = 3	=>	'DEPLOYED',	
							'');


export AKAType (INTEGER ID) := 
						map( ID = 0	=> 'None'	,
								ID = 1	=>  'AKA',
								ID = 2	=>  'FKA',
								ID = 3	=>  'NKa',
									'');

  export	INTEGER	DEF_THRESHOLD					:=	84;
  export	INTEGER	DEF_THRESHOLD_KeyBank	:=	85;
  export	INTEGER	MAX_THRESHOLD					:=	100;
  export	INTEGER	MIN_THRESHOLD					:=	70;
	export	REAL	DEF_THRESHOLD_REAL					:=	.84;
  export	REAL	DEF_THRESHOLD_KeyBank_REAL	:=	.85;
  export	REAL	MAX_THRESHOLD_REAL					:=	1.00;
  export	REAL	MIN_THRESHOLD_REAL					:=	.70;
  export	INTEGER	MaxReturnRecs					:=	100;
	export 	SortResultsByScore 						:= TRUE;
	export 	GenerateResultsOnName 				:= TRUE;
	export 	IncludeAddrinScoreLift 				:= FALSE;
	export 	DOBToleranceYrs 							:= -1; 
	export  VendorRecFlag									:= 'VENDOR';
	export 	OFACSDN												:= 'OFAC SDN.BDF';
	export 	CountryFiles									:= 'CDF';
	export 	ErrorMsg_OFACversion := 'OFAC version does not support ALLV4.';

	export	string	wlALLV4 :=	'ALLV4'; // FROM PRODUCT MANAGEMENT "ALLV4 WILL MEAN ALLV4 AVAILABLE LISTS. For use only when OFACverion is 4."
	
	export DBNames_rec := RECORD
		string dbname;
	end;

	export WCOFACNames := dataset([ 
												 {'OFAC NON-SDN ENTITIES.BDF'},
												 {'OFAC SDN ADDITIONS AND MODIFICATIONS.BDF'},			
												 {'OFAC SDN.BDF'},
												 {'OFAC SANCTIONS.CDF'}	
												 // {'OFAC ENHANCEMENTS - ENTITIES.BDF'}	,		// ROYALTY charge - ACCUITY	not used
												 // {'OFAC ENHANCEMENTS - COUNTRIES.CDF'}			// ROYALTY charge - ACCUITY	not used									
												 ], DBNames_rec);   	//=> 'OFAC'	

 export WCOAddtnlFiles_ALL := WCOFACNames + 
        dataset([{'BANK OF ENGLAND CONSOLIDATED LIST.BDF'},
            {'BUREAU OF INDUSTRY AND SECURITY.BDF'},
            {'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS.BDF'},
            {'COMMODITY FUTURES TRADING COMMISSION SANCTIONS.BDF'},
            {'DTC DEBARRED PARTIES.BDF'},
            {'EU CONSOLIDATED LIST.BDF'},
            {'FBI TOP TEN MOST WANTED.BDF'},
            {'FOREIGN AGENTS REGISTRATIONS.BDF'},
            {'HM TREASURY SANCTIONS.CDF'},
            {'OSFI CONSOLIDATED LIST.BDF'},
            {'OSFI COUNTRY.CDF'},
            {'TERRORIST EXCLUSION LIST.BDF'},
            {'UN CONSOLIDATED LIST.BDF'},
            {'UNAUTHORIZED BANKS.BDF'},
            {'WORLD BANK INELIGIBLE FIRMS.BDF'}												
												], DBNames_rec);

 export WCOAddtnlFiles_ALLV4 := WCOAddtnlFiles_ALL +
          dataset([{'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE.BDF'},												
            {'FATF Financial Action Task Force.CDF'},
            {'FATF DEFICIENT JURISDICTIONS - COUNTRIES.CDF'},
            {'FBI MOST WANTED.BDF'},
            {'FBI HIJACK SUSPECTS.BDF'},
            {'FBI MOST WANTED TERRORISTS.BDF'},
            {'FBI SEEKING INFORMATION.BDF'},
            {'HONG KONG MONETARY AUTHORITY.BDF'},
            {'MONETARY AUTHORITY OF SINGAPORE.BDF'},
            {'OFFSHORE FINANCIAL CENTERS.CDF'},
            {'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS.CDF'},
            {'PRIMARY MONEY LAUNDERING CONCERN.BDF'}								
            ], DBNames_rec);																	

EXPORT PtyKeyPrefix (STRING Sourcename, string ENTITYTYPE = '') := 
												map( 
												 Sourcename = 'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE.BDF'  => 'ADFA',												
												 Sourcename = 'OFAC NON-SDN ENTITIES.BDF'  => 'OFAC',												
												 Sourcename = 'OFAC SDN ADDITIONS AND MODIFICATIONS.BDF'  => 'OFAC',												
												 Sourcename = 'OFAC ENHANCEMENTS - ENTITIES.BDF'  => 'OFAC',
												 Sourcename = 'OFAC SDN.BDF'  => 'OFAC',												
												 Sourcename = 'OFAC SANCTIONS.CDF'  => 'OFAC',												
												 Sourcename = 'OFAC ENHANCEMENTS - COUNTRIES.CDF'  => 'OFAC',												
												 Sourcename = 'COMMODITY FUTURES TRADING COMMISSION SANCTIONS.BDF'  => 'CFT',												
												 Sourcename = 'DTC DEBARRED PARTIES.BDF'		=>  'DTC'	, 									
												 Sourcename =  'BUREAU OF INDUSTRY AND SECURITY.BDF' and ENTITYTYPE = '2'		=>  'DPL'	,								
												 Sourcename =  'BUREAU OF INDUSTRY AND SECURITY.BDF' and ENTITYTYPE <> '2'	=>  'DEL'	,								
												 Sourcename = 'EU CONSOLIDATED LIST.BDF'	and ENTITYTYPE = '2'	=> 'EUI' , 										
												 Sourcename = 'EU CONSOLIDATED LIST.BDF'	and ENTITYTYPE <> '2'	=> 'EUG' , 									
												 Sourcename = 'FBI MOST WANTED.BDF'  => 'FBIW',											
												 Sourcename = 'FBI TOP TEN MOST WANTED.BDF'	=> 'FBI'	,								
												 Sourcename = 'FBI HIJACK SUSPECTS.BDF'   => 'FBIH',												 
												 Sourcename = 'FBI MOST WANTED TERRORISTS.BDF'  => 'FBIT',												
												 Sourcename = 'FBI SEEKING INFORMATION.BDF'  => 'FBIS',											
												 Sourcename = 'FOREIGN AGENTS REGISTRATIONS.BDF'	=> 'FARA' ,										
												 Sourcename = 'HONG KONG MONETARY AUTHORITY.BDF'   => 'HKMA',												
												 Sourcename = 'MONETARY AUTHORITY OF SINGAPORE.BDF'   => 'MASI',												
												 Sourcename = 'OSFI CONSOLIDATED LIST.BDF' and ENTITYTYPE = '2'	=> 'OCI', 
												 Sourcename = 'OSFI CONSOLIDATED LIST.BDF' and ENTITYTYPE <> '2'		=> 'OCE', 
												 Sourcename = 'PRIMARY MONEY LAUNDERING CONCERN.BDF'	=> 'PMLC'	,									
												 Sourcename = 'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS.CDF'   => 'PRMLJ',												
												 Sourcename = 'UNAUTHORIZED BANKS.BDF'		=>  'OCC'		,								
												 Sourcename =  'UN CONSOLIDATED LIST.BDF'	and ENTITYTYPE = '2'	=>  'AQI',  // 'AQO''BRO' 'BROW'										
												 Sourcename =  'UN CONSOLIDATED LIST.BDF'	and ENTITYTYPE <> '2' 	=>  'AQO',  // 'AQO''BRO' 'BROW'										
												 Sourcename =  'WORLD BANK INELIGIBLE FIRMS.BDF'=> 'WBI',
												 Sourcename = 'UK HM TREASURY LIST.BDF' => 'BES',
												 Sourcename = 'OFFSHORE FINANCIAL CENTERS.CDF' => 'OFFC',
												 Sourcename = 'FATF FINANCIAL ACTION TASK FORCE.CDF' => 'FATFC',
												 Sourcename = 'FATF DEFICIENT JURISDICTIONS - COUNTRIES.CDF' => 'FADJC',
												 // Sourcename = 'WorldCompliance - Politically Exposed Persons.BDF' => 'PEP',// too big to search
												 Sourcename = 'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS.BDF' => 'PEP',
												 Sourcename = 'TERRORIST EXCLUSION LIST.BDF'  => 'SDTE',
												 Sourcename = 'HM TREASURY SANCTIONS.CDF'  => 'HMTC',
												 Sourcename = 'OSFI COUNTRY.CDF'  => 'OSFIC',
												'');


EXPORT CountryKey (string country) := 
										map(trim(country) = 'AFGHANISTAN'	=>	'1',
												trim(country) = 'ANDORRA'	=>	'2',
												trim(country) = 'ANGUILLA'	=>	'3',
												trim(country) = 'ARUBA'	=>	'4',
												trim(country) = 'BELARUS'	=>	'5',
												trim(country) = 'BELIZE'	=>	'6',
												trim(country) = 'BERMUDA'	=>	'7',
												trim(country) = 'BOSNIA AND HERZEGOVINA'	=>	'8',
												trim(country) = 'BRITISH VIRGIN ISLANDS'	=>	'9',
												trim(country) = 'CAYMAN ISLANDS'	=>	'10',
												trim(country) = 'CENTRAL AFRICAN REPUBLIC'	=>	'11',
												trim(country) = 'CONGO, DEMOCRATIC REPUBLIC OF THE'	=>	'12',
												trim(country) = 'COOK ISLANDS'	=>	'13',
												trim(country) = 'COTE D`IVOIRE'	=>	'14',
												trim(country) = 'CYPRUS'	=>	'15',
												trim(country) = 'DEMOCRATIC PEOPLE\'S REPUBLIC OF KOREA'	=>	'16',
												trim(country) = 'ERITREA'	=>	'17',
												trim(country) = 'GIBRALTAR'	=>	'18',
												trim(country) = 'GUERNSEY'	=>	'19',
												trim(country) = 'GUYANA'	=>	'20',
												trim(country) = 'IRAN'	=>	'21',
												trim(country) = 'IRAN ISLAMIC REPUBLIC OF'	=>	'22',
												trim(country) = 'IRAQ'	=>	'23',
												trim(country) = 'ISLE OF MAN'	=>	'24',
												trim(country) = 'JERSEY'	=>	'25',
												trim(country) = 'LAO PDR'	=>	'27',
												trim(country) = 'LEBANON'	=>	'28',
												trim(country) = 'LIBERIA'	=>	'29',
												trim(country) = 'LIBYA'	=>	'30',
												trim(country) = 'LIECHTENSTEIN'	=>	'31',
												trim(country) = 'MACAO'	=>	'32',
												trim(country) = 'MALAYSIA'	=>	'33',
												trim(country) = 'MONACO'	=>	'34',
												trim(country) = 'MONTSERRAT'	=>	'35',
												trim(country) = 'MYANMAR'	=>	'36',
												trim(country) = 'NETHERLANDS ANTILLES'	=>	'37',
												trim(country) = 'NORTH KOREA'	=>	'38',
												trim(country) = 'NORTH KOREAN'	=>	'38',
												trim(country) = 'KOREA DEMOCRATIC PEOPLE\'S REPUBLIC'	=>	'38',
												trim(country) = 'NORTH KOREA, DPRK'	=>	'38',
												trim(country) = 'PALAU'	=>	'39',
												trim(country) = 'PANAMA'	=>	'40',
												trim(country) = 'PAPUA NEW GUINEA'	=>	'41',
												trim(country) = 'RUSSIA'	=>	'42',
												trim(country) = 'SAMOA'	=>	'43',
												trim(country) = 'SEYCHELLES'	=>	'44',
												trim(country) = 'SOMALIA'	=>	'45',
												trim(country) = 'SUDAN'	=>	'46',
												trim(country) = 'SUDAN, DARFUR'	=>	'46',
												trim(country) = 'SURINAME'	=>	'47',
												trim(country) = 'SYRIA'	=>	'48',
												trim(country) = 'SYRIAN ARAB REPUBLIC'	=>	'48',
												trim(country) = 'THE BAHAMAS'	=>	'49',
												trim(country) = 'TURKS AND CAICOS ISLANDS'	=>	'50',
												trim(country) = 'UGANDA'	=>	'51',
												trim(country) = 'VANUATU'	=>	'52',
												trim(country) = 'YEMEN'	=>	'53',
												trim(country) = 'ZIMBABWE'	=>	'54',
												trim(country) = 'CUBA'	=>	'55',
												trim(country) = 'UKRAINE'	=>	'56',
												trim(country) = 'UKRAINIAN'	=>	'56',
												trim(country) = 'BURMA'	=>	'57',
																							
												'00');



END;