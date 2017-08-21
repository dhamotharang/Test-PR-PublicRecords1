EXPORT Functions := Module

	EXPORT string make_clean(String make) :=
			MAP(
					make = 'ACURA'																=> 'ACUR' ,
					make = 'ACUR'																	=> 'ACUR' ,
					make = 'ALFA ROMEO'														=> 'ALFA' ,
					make = 'AMERICAN MOTORS'											=> 'AMER' ,
					make = 'AM GENERAL'														=> 'AMGE' ,
					make = 'AM GENERAL CORP.'											=> 'AMGN' ,
					make = 'ASTON MARTIN'													=> 'ASTO' ,
					make = 'ASUNA'																=> 'ASUN' ,
					make = 'AUDI'																	=> 'AUDI' ,
					make = 'AUTOCAR LLC'													=> 'AUTC' ,
					make = 'AUTOCAR'															=> 'AUTO' ,
					make = 'AVANTI'																=> 'AVTI' ,
					make = 'AZURE DYNAMICS'												=> 'AZU'  ,
					make = 'BENTLEY'															=> 'BENT' ,
					make = 'BMW'																	=> 'BMW'  ,
					make = 'BUGATTI'															=> 'BUGA' ,
					make = 'BUICK'																=> 'BUIC' ,
					make = 'BUIC'																	=> 'BUIC' ,
					make = 'CADILLAC'															=> 'CADI' ,
					make = 'CADI'																	=> 'CADI' ,
					make = 'CATERPILLAR'													=> 'CAT'  ,
					make = 'CHEVROLET'														=> 'CHEV' ,
					make = 'CHEV'																	=> 'CHEV' ,
					make = 'CHRYSLER'															=> 'CHRY' ,
					make = 'CHRY'																	=> 'CHRY' ,
					make = 'CPI MOTOR COMPANY'										=> 'CPIU' ,
					make = 'DAEWOO'																=> 'DAEW' ,
					make = 'DAIHATSU'															=> 'DAIH' ,
					make = 'DATSUN'																=> 'DATS' ,
					make = 'DIAMOND REO'													=> 'DIAR' ,
					make = 'DODGE'																=> 'DODG' ,
					make = 'DODG'																	=> 'DODG' ,
					make = 'EAGLE'																=> 'EAGL' ,
					make = 'FERRARI'															=> 'FERR' ,
					make = 'FIAT'																	=> 'FIAT' ,
					make = 'FORD'																	=> 'FORD' ,
					make = 'FORDCOURIERFORD GOLDLINE CAMPER'			=> 'FORD' ,					
					make = 'FREIGHTLINER'													=> 'FRHT' ,
					make = 'FISKER AUTOMOTIVE'										=> 'FSKR' ,
					make = 'FWD CORPORATION'											=> 'FWD'  ,
					make = 'GEM TRAILERS, INC.'										=> 'GEM'  ,
					make = 'GEO'																	=> 'GEO'  ,
					make = 'GM'																		=> 'GM'   ,
					make = 'GMC'																	=> 'GMC'  ,
					make = 'HARLEY DAVIDSON'											=> 'HD'   ,
					make = 'HINO'																	=> 'HINO' ,
					make = 'HONDA'																=> 'HOND' ,
					make = 'HOND'																	=> 'HOND' ,
					make = 'HUMMER'																=> 'HUMM' ,
					make = 'HYOSUNG'															=> 'HYOS' ,
					make = 'HYUNDAI'															=> 'HYUN' ,
					make = 'HYUN'																	=> 'HYUN' ,
					make = 'INFINITI'															=> 'INFI' ,
					make = 'INTERNATIONAL'												=> 'INTL' ,
					make = 'ISUZU'																=> 'ISU'  ,
					make = 'IVECO-MAGIRUS'												=> 'IVCM' ,
					make = 'IVECO'																=> 'IVEC' ,
					make = 'JAGUAR'																=> 'JAGU' ,
					make = 'JAYCO'																=> 'JAYC' ,
					make = 'JEEP'																	=> 'JEEP' ,
					make = 'Kawasaki'															=> 'KAWK' ,
					make = 'KIA'																	=> 'KIA'  ,
					make = 'KENWORTH'															=> 'KW'   ,
					make = 'LADA'																	=> 'LADA' ,
					make = 'LAMBORGHINI'													=> 'LAMO' ,
					make = 'LAND ROVER'														=> 'LAND' ,
					make = 'LEXUS'																=> 'LEXS' ,
					make = 'LEXS'																	=> 'LEXS' ,
					make = 'LINCLON'															=> 'LINC' ,
					make = 'LINCLONCONTINENTAL'										=> 'LINC' ,
					make = 'LANCIA'																=> 'LNCI' ,
					make = 'LOTUS'																=> 'LOTU' ,
					make = 'MACK'																	=> 'MACK' ,
					make = 'MASERATI'															=> 'MASE' ,
					make = 'MAYBACH'															=> 'MAYB' ,
					make = 'MAZDA'																=> 'MAZD' ,
					make = 'MAZD'																	=> 'MAZD' ,
					make = 'MCLAREN ATUOMOTIVE'										=> 'MCLA' ,
					make = 'MERCURY'															=> 'MERC' ,
					make = 'MERC'																	=> 'MERC' ,
					make = 'MERKUR'																=> 'MERK' ,
					make = 'MERCEDES BENZ'												=> 'MERZ' ,
					make = 'MERCEDESBENZ'													=> 'MERZ' ,
					make = 'MERZ'																	=> 'MERZ' ,
					make = 'MITSUBHISHI FUSO TRUCK OF AMERICA'		=> 'MIFU' , 
					make = 'MINI'																	=> 'MIN'  ,
					make = 'MINI COOPER'													=> 'MINI' ,
					make = 'MITSUBHISHI'													=> 'MITS' ,
					make = 'MITS'																	=> 'MITS' ,
					make = 'NISSAN DIESEL MOTOR CORP.'						=> 'NDMC' ,
					make = 'NISSAN'																=> 'NISS' ,
					make = 'NISS'																	=> 'NISS' ,
					make = 'OLDSMOBILE'														=> 'OLDS' ,
					make = 'OLDS'																	=> 'OLDS' ,
					make = 'OSHKOSH'															=> 'OSHK' ,
					make = 'PASSPORT'															=> 'PASS' ,
					make = 'PEUGEOT'															=> 'PEUG' ,
					make = 'PLYMOUTH'															=> 'PLYM' ,
					make = 'POLAR'																=> 'POLA' ,
					make = 'POLARIS'															=> 'POLS' ,
					make = 'PONI'																	=> 'PONI' ,
					make = 'PONTIAC'															=> 'PONT' ,
					make = 'PONT'																	=> 'PONT' , 
					make = 'PORSCHE'															=> 'PORS' ,
					make = 'PETERBILT'														=> 'PTRB' ,
					make = 'RAM'																	=> 'RAM'  ,
					make = 'RANGE ROVER'													=> 'RANG' ,
					make = 'RENAULT'															=> 'RENA' ,
					make = 'ROLLS-ROYCE'													=> 'ROL'  ,
					make = 'SAAB'																	=> 'SAA'  ,
					make = 'SATURN'																=> 'STRN' ,
					make = 'STRN'																	=> 'STRN' ,
					make = 'SMART'																=> 'SMRT' ,
					make = 'SPRINTER'															=> 'SPNR' ,
					make = 'STERLING'															=> 'STRG' ,
					make = 'SUBARU'																=> 'SUBA' ,
					make = 'SUBA'																	=> 'SUBA' ,
					make = 'SUZUKI'																=> 'SUZI' ,
					make = 'TERRA TIGER'													=> 'TERR' ,
					make = 'TESLA'																=> 'TESL' ,
					make = 'TITAN'																=> 'TITA' ,
					make = 'TOYOTA'																=> 'TOYT' ,
					make = 'TOYT'																	=> 'TOYT' ,
					make = 'TOYOTA MOTOR CO LTD'									=> 'TOYT' ,
					make = 'TOYOTATOYOTA MOTOR CO LTD'						=> 'TOYT' ,
					make = 'TRIUMPH CAR'													=> 'TRIU' ,
					make = 'TRIUMPH MOTORCYCLE'										=> 'TRUM' ,
					make = 'TVR'																	=> 'TVR'  ,
					make = 'NISSAN DIESEL MOTOR CORP'							=> 'UD'   ,
					make = 'VICTORY MOTORCYCLES'									=> 'VCTY' ,
					make = 'VESPA'																=> 'VESP' ,
					make = 'VOLKSWAGEN'														=> 'VOLK' ,
					make = 'VOLK'																	=> 'VOLK' ,
					make = 'VOLVO'																=> 'VOLV' ,
					make = 'WHITE-GMC'														=> 'WHGM' ,
					make = 'YAMAHA'																=> 'YAM'  ,
					'');					

	EXPORT string color_clean (string color)	:= 
		MAP(
					color = 'AMETHYST'						=>  'AME' ,
					color = 'BEIGE'     					=>	'BGE' ,
					color = 'BGE'     						=>	'BGE' ,
					color = 'BLACK'    						=>	'BLK' ,
					color = 'BLK'    							=>	'BLK' ,
					color = 'BLUE'      					=>	'BLU' ,
					color = 'BLU'      						=>	'BLU' ,
					color = 'BROWN'     					=>	'BRO' ,
					color = 'BRO'	     						=>	'BRO' ,
					color = 'BRONZE'    					=>	'BRZ' ,
					color = 'CAMOUFLAGE'					=>	'CAM' ,
					color = 'CHROME'    					=>	'COM' ,
					color = 'COPPER'    					=>	'CPR' ,
					color = 'CREAM'     					=>	'CRM' ,
					color = 'DARK BLUE' 					=>	'DBL' ,
					color = 'BLUE DARK' 					=>	'DBL' ,
					color = 'DBL' 								=>	'DBL' ,
					color = 'DARK GREEN'					=>	'DGR' ,
					color = 'REEN DARK'						=>	'DGR' ,
					color = 'DGR'									=>	'DGR' ,
					color = 'GOLD'      					=>	'GLD' ,
					color = 'GOD'      						=>	'GLD' ,
					color = 'GREEN'     					=>	'GRN' ,
					color = 'GRN'     						=>	'GRN' ,
					color = 'GRAY'      					=>	'GRY' ,
					color = 'GREY'      					=>	'GRY' ,
					color = 'GRY'      						=>	'GRY' ,
					color = 'LAVENDER'  					=>	'LAV' ,
					color = 'LIGHT BLUE'					=>	'LBL' ,
					color = 'LBL'									=>	'LBL' ,
					color = 'LIGHT GREEN'					=>	'LGR' ,
					color = 'BURGUNDY'  					=>	'MAR' ,
					color = 'MAROON'  						=>	'MAR' ,
					color = 'MAR'  								=>	'MAR' ,
					color = 'RED PINK MAROON'  		=>	'MAR' ,
					color = 'MAROON BURGUNDY'  		=>	'MAR' ,
					color = 'MULTICOLORED'				=>	'MUL' ,
					color = 'MAUVE'     					=>	'MVE' ,
					color = 'ORANGE'    					=>	'ONG' ,
					color = 'PURPLE'    					=>	'PLE' ,
					color = 'PINK'      					=>	'PNK' ,
					color = 'RED'       					=>	'RED' ,
					color =	'SILVER'    					=>	'SIL' ,
					color =	'SIL'    							=>	'SIL' ,
					color =	'SILVERALUMINUM'    	=>	'SIL' ,
					color =	'SILVER ALUMINUM'    	=>	'SIL' ,					
					color =	'SILVER OR ALUMINUM'  =>	'SIL' ,
					color = 'TAN'       					=>	'TAN' ,
					color = 'TEAL'      					=>	'TEA' ,
					color = 'TAUPE'     					=>	'TPE' ,
					color = 'TURQUOISE' 					=>	'TRQ' ,
					color = ''            				=>	'UNK' ,
					color = 'WHITE'     					=>	'WHI' ,
					color = 'WHI'	     						=>	'WHI' ,
					color = 'WHT'	     						=>	'WHI' ,
					color = 'WHITE CREAM'	     		=>	'WHI' ,
					color = 'YELLOW'							=>	'YEL' ,
					color = 'YEL'									=>	'YEL' ,
					'');			

	EXPORT string body_clean (string body)	:= 
		MAP(
          body = 'WAGON 2 DOOR'															=> '2W',
          body = 'MOTOR SCOOTER'														=> 'MS',
          body = 'MOTORIZED CUTAWAY'												=> 'MY',
          body = 'EXTENDED CARGO VAN'												=> 'EC',
          body = 'FORWARD CONTROL'													=> 'FC',
          body = 'SPORT VAN'																=> 'SV',
          body = 'CAB AND CHASSIS'													=> '3B',
          body = 'SEDAN 2 DOOR'															=> '2D',
					body = '2D'																				=> '2D',
          body = 'LIFTBACK 5 DOOR'													=> '4L',
          body = 'WAGON 2 DOOR'															=> '2W',
          body = 'ARMORED TRUCK'														=> 'AR',
          body = 'HARDTOP'																	=> 'HT',
          body = 'COUPE'																		=> 'CP',
          body = 'TANDEM'																		=> 'TM',
          body = '4 DOOR EXT CAB PK'												=> '4C',
          body = 'VAN CAMPER'																=> 'VC',
          body = 'TILT CAB'																	=> 'TB',
          body = 'SPORT PICKUP'															=> 'SP',
          body = 'CARGO VAN'																=> 'CG',
          body = 'STATION WAGON'														=> 'SW',
          body = 'MULTI-PURPOSE'														=> 'MP',
          body = 'ROAD / TRAIL MOTORCYCLE'									=> 'RT',
          body = 'CONVENTIONAL CAB'													=> 'ST',
          body = 'SEDAN 5 DOOR'															=> '5D',
          body = 'SPORT COUPE'															=> 'SC',
          body = 'VANETTE (INCLUDING METRO AND HANDY VAN)'	=> 'VT',
          body = 'TRAVELALL'																=> 'XT',
          body = 'PANEL'																		=> 'PN',
          body = 'INCOMPLETE PASSENGER'											=> 'IN',
          body = 'HOPPER'																		=> 'HO',
          body = 'CONCRETE/TRANSIT MIX'											=> 'CM',
          body = 'VAN'																			=> 'VN',
					body = 'VN'																				=> 'VN',
          body = 'HATCHBACK 2 DOOR'													=> 'HB',
          body = 'SUPER CAB/CHASSIS PICKUP'									=> 'CS',
          body = 'HARDTOP 4 DR.'														=> '4T',
          body = 'GARBAGE OR REFUSE'												=> 'GG',
          body = 'PILLARD HARDTOP 4 DOOR'										=> '4P',
          body = 'MINI ROAD / TRAIL'												=> 'MR',
          body = 'ROADSTER'																	=> 'RD',
          body = 'DIRT'																			=> 'T',
          body = 'SPORT HATCHBACK'													=> 'SB',
          body = 'TOW TRUCK WRECKER'												=> 'WK',
          body = 'LOGGER'																		=> 'LG',
          body = 'CRANE'																		=> 'CR',
          body = 'EXTENDED WINDOW VAN'											=> 'EW',
          body = 'INCOMPLETE EXT VAN'												=> 'IE',
          body = 'CREW CHASSIS'															=> 'CH',
          body = 'COUPE 4 DOOR'															=> 'C4',
          body = 'MAXI VAN'																	=> 'MV',
          body = 'GRAIN'																		=> 'GN',
          body = 'ROADSTER'																	=> 'RD',
          body = 'RACER'																		=> 'RC',
          body = 'ROAD / STREET'														=> 'RS',
          body = 'TRAIL/DIRT'																=> 'TL',
          body = 'STEP VAN'																	=> 'SN',
          body = 'EXTENDED VAN'															=> 'EV',
          body = 'SPORT VAN'																=> 'SV',
          body = 'DIRT'																			=> 'MM',
          body = 'CAB AND CHASSIS'													=> 'CB',
          body = 'LIFTBACK 3 DOOR'													=> '2L',
          body = 'LIFTBACK'																	=> 'LB',
          body = 'SUPER CAB PICKUP'													=> 'PS',
          body = 'CONVENTIONAL CAB'													=> 'CC',
          body = 'SEDAN 4 DOOR'															=> '4D',
					body = '4D'																				=> '4D',
					body = '4 DOOR'																		=> '4D',
					body = '4DR AUTOMOBILE'														=> '4D',
					body = '4DOOR'																		=> '4D',
					body = '4DOOR AUTOMOBILE'													=> '4D',
					body = '4 DOOR AUTOMOBILE SEDAN'									=> '4D',
          body = 'TRAIL/DIRT'																=> 'TL',
          body = 'CUTAWAY'																	=> 'YY',
          body = 'RUNABOUT 3 DOOR'													=> '3D',
          body = 'CONVERTIBLE'															=> 'CV',
          body = 'CREW PICKUP'															=> 'CW',
          body = 'CLUB CHASSIS'															=> 'CL',
          body = 'EXTENDED SPORT VAN'												=> 'ES',
          body = 'ENDURO'																		=> 'EN',
          body = 'FORMAL HARDTOP 2 DR.'											=> '2F',
          body = 'GLIDERS'																	=> 'GL',
          body = 'HEARSE'																		=> 'HR',
          body = 'FLAT-BED OR PLATFORM'											=> 'FB',
          body = 'NOTCHBACK'																=> 'NB',
          body = '2 PASSENGER LOW SPEED'										=> 'P2',
          body = 'AMBULANCE'																=> 'AM',
          body = 'PICKUP WITH CAMPER MOUNTE'								=> 'PM',
          body = 'SUBURBAN OR CARRY ALL'										=> 'LL',
					body = 'LL'																				=> 'LL',
          body = 'MOTORIZED HOME'														=> 'MH',
          body = '3 DOOR COUPE'															=> '3P',
          body = 'DISPLAY VAN'															=> 'VD',
          body = 'MOTO CROSS'																=> 'MX',
          body = 'MOTORIZED CUTAWAY'												=> 'MY',
          body = 'SEDAN'																		=> 'SD',
          body = 'WAGON 4 DOOR'															=> '4W',
          body = 'ONE SEAT'																	=> 'S1',
          body = 'PICKUP'																		=> 'PK',
					body = 'PK'																				=> 'PK',
          body = 'TWO SEAT'																	=> 'S2',
          body = 'WIDE WHEEL WAGON'													=> 'WW',
          body = '4 PASSENGER LOW SPEED'										=> 'P4',
          body = 'HATCHBACK 4 DOOR'													=> '4H',
          body = 'CAB AND CHASSIS'													=> 'CB',
          body = 'DUMP'																			=> 'DP',
          body = 'MINI BIKE'																=> 'MK',
          body = 'WINDOW VAN'																=> 'VW',
          body = 'TRACTOR TRUCK'														=> 'TR',
          body = 'LIMOUSINE'																=> 'LM',
          body = '4 DR EXT CAB / CHASS'											=> '4B',
          body = '8 PASSENGER SPORT VAN'										=> '8V',
          body = 'TRACTOR TRUCK'														=> 'DS',
          body = 'ALL TERRAIN'															=> 'AT',
          body = 'LIMOUSINE'																=> 'LM',
          body = 'INCOMPLETE CHASSIS'												=> 'IC',
          body = 'TRACTOR TRUCK'														=> 'TR',
          body = 'TANK'																			=> 'TN',
          body = 'PICKUP'																		=> 'PK',
          body = 'CUSTOM PICKUP'														=> 'CU',
          body = 'PILLARD HARDTOP 2 DOOR'										=> '2P',
          body = 'UTILITY'																	=> 'UT',
          body = 'BUS'																			=> 'BU',
          body = 'CONVERTIBLE'															=> 'CV',
          body = 'WIDE WHEEL WAGON'													=> 'WW',
          body = 'STATION WAGON'														=> 'SW',
          body = 'PANEL'																		=> 'PN',
          body = 'MAXI WAGON'																=> 'MW',
          body = 'MULTI-PURPOSE'														=> 'MP',
          body = 'PARCEL DELIVERY'													=> 'PD',
          body = 'AUTO CARRIER'															=> 'AC',
          body = 'HATCHBACK 2 DOOR'													=> '2H',
          body = 'HARDTOP 2 DOOR'														=> '2T',
          body = '3 DOOR EXT CAB PK'												=> '3C',
          body = 'CLUB CAB PICKUP'													=> 'PC',
          body = 'FIRE TRUCK'																=> 'FT',
          body = 'UTILITY'																	=> 'UT',
          body = 'WAGON 4 DOOR'															=> '4W',
          body = 'CARGO CUTAWAY'														=> 'CY',
					'');			
					
	EXPORT 	BODYCONST    :=  
				DATASET([
				{'2D',		'SEDAN 2 DOOR'															,	'PASSENGER VEHICLES'},
				{'2F',		'FORMAL HARDTOP 2 DR.'											,	'PASSENGER VEHICLES'},
				{'2H',		'HATCHBACK 2 DOOR'													,	'PASSENGER VEHICLES'},
				{'2L',		'LIFTBACK 3 DOOR'														,	'PASSENGER VEHICLES'},
				{'2P',		'PILLARD HARDTOP 2 DOOR'										,	'PASSENGER VEHICLES'},
				{'2T',		'HARDTOP 2 DOOR'														,	'PASSENGER VEHICLES'},
				{'2W',		'WAGON 2 DOOR'															,	'TRUCKS'},
				{'2W',		'WAGON 2 DOOR'															,	'PASSENGER VEHICLES'},
				{'3B',		'CAB AND CHASSIS'														,	'TRUCKS'},
				{'3C',		'3 DOOR EXT CAB PK'													,	'TRUCKS'},
				{'3D',		'RUNABOUT 3 DOOR'														,	'PASSENGER VEHICLES'},
				{'3P',		'3 DOOR COUPE'															,	'PASSENGER VEHICLES'},
				{'4B',		'4 DR EXT CAB / CHASS'											,	'TRUCKS'},
				{'4C',		'4 DOOR EXT CAB PK'													,	'TRUCKS'},
				{'4D',		'SEDAN 4 DOOR'															,	'PASSENGER VEHICLES'},
				{'4H',		'HATCHBACK 4 DOOR'													,	'PASSENGER VEHICLES'},
				{'4L',		'LIFTBACK 5 DOOR'														,	'PASSENGER VEHICLES'},
				{'4P',		'PILLARD HARDTOP 4 DOOR'										,	'PASSENGER VEHICLES'},
				{'4T',		'HARDTOP 4 DR.'															,	'PASSENGER VEHICLES'},
				{'4W',		'WAGON 4 DOOR'															,	'TRUCKS'},
				{'4W',		'WAGON 4 DOOR'															,	'PASSENGER VEHICLES'},
				{'5D',		'SEDAN 5 DOOR'															,	'PASSENGER VEHICLES'},
				{'8V',		'8 PASSENGER SPORT VAN'											,	'TRUCKS'},
				{'AC',		'AUTO CARRIER'															,	'TRUCKS'},
				{'AM',		'AMBULANCE'																	,	'PASSENGER VEHICLES'},
				{'AR',		'ARMORED TRUCK'															,	'TRUCKS'},
				{'AT',		'ALL TERRAIN'																,	'MOTORCYCLES'},
				{'BU',		'BUS'																				,	'TRUCKS'},
				{'C4',		'COUPE 4 DOOR'															,	'PASSENGER VEHICLES'},
				{'CB',		'CAB AND CHASSIS'														,	'TRUCKS'},
				{'CB',		'CAB AND CHASSIS'														,	'PASSENGER VEHICLES'},
				{'CC',		'CONVENTIONAL CAB'													,	'TRUCKS'},
				{'CG',		'CARGO VAN'																	,	'TRUCKS'},
				{'CH',		'CREW CHASSIS'															,	'TRUCKS'},
				{'CL',		'CLUB CHASSIS'															,	'TRUCKS'},
				{'CM',		'CONCRETE/TRANSIT MIX'											,	'TRUCKS'},
				{'CP',		'COUPE'																			,	'PASSENGER VEHICLES'},
				{'CR',		'CRANE'																			,	'TRUCKS'},
				{'CS',		'SUPER CAB/CHASSIS PICKUP'									,	'TRUCKS'},
				{'CU',		'CUSTOM PICKUP'															,	'TRUCKS'},
				{'CV',		'CONVERTIBLE'																,	'PASSENGER VEHICLES'},
				{'CV',		'CONVERTIBLE'																,	'TRUCKS'},
				{'CW',		'CREW PICKUP'																,	'TRUCKS'},
				{'CY',		'CARGO CUTAWAY'															,	'TRUCKS'},
				{'DP',		'DUMP'																			,	'TRUCKS'},
				{'DS',		'TRACTOR TRUCK'															,	'TRUCKS'},
				{'EC',		'EXTENDED CARGO VAN'												,	'TRUCKS'},
				{'EN',		'ENDURO'																		,	'MOTORCYCLES'},
				{'ES',		'EXTENDED SPORT VAN'												,	'TRUCKS'},
				{'EV',		'EXTENDED VAN'															,	'TRUCKS'},
				{'EW',		'EXTENDED WINDOW VAN'												,	'TRUCKS'},
				{'FB',		'FLAT-BED OR PLATFORM'											,	'TRUCKS'},
				{'FC',		'FORWARD CONTROL'														,	'TRUCKS'},
				{'FT',		'FIRE TRUCK'																,	'TRUCKS'},
				{'GG',		'GARBAGE OR REFUSE'													,	'TRUCKS'},
				{'GL',		'GLIDERS'																		,	'TRUCKS'},
				{'GN',		'GRAIN'																			,	'TRUCKS'},
				{'HB',		'HATCHBACK 2 DOOR'													,	'PASSENGER VEHICLES'},
				{'HO',		'HOPPER'																		,	'TRUCKS'},
				{'HR',		'HEARSE'																		,	'PASSENGER VEHICLES'},
				{'HT',		'HARDTOP'																		,	'PASSENGER VEHICLES'},
				{'IC',		'INCOMPLETE CHASSIS'												,	'TRUCKS'},
				{'IE',		'INCOMPLETE EXT VAN'												,	'TRUCKS'},
				{'IN',		'INCOMPLETE PASSENGER'											,	'PASSENGER VEHICLES'},
				{'LB',		'LIFTBACK'																	,	'PASSENGER VEHICLES'},
				{'LG',		'LOGGER'																		,	'TRUCKS'},
				{'LL',		'SUBURBAN OR CARRY ALL'											,	'TRUCKS'},
				{'LM',		'LIMOUSINE'																	,	'PASSENGER VEHICLES'},
				{'LM',		'LIMOUSINE'																	,	'TRUCKS'},
				{'MH',		'MOTORIZED HOME'														,	'TRUCKS'},
				{'MK',		'MINI BIKE'																	,	'MOTORCYCLES'},
				{'MM',		'DIRT'																			,	'MOTORCYCLES'},
				{'MP',		'MULTI-PURPOSE'															,	'TRUCKS'},
				{'MP',		'MULTI-PURPOSE'															,	'MOTORCYCLES'},
				{'MR',		'MINI ROAD / TRAIL'													,	'MOTORCYCLES'},
				{'MS',		'MOTOR SCOOTER'															,	'MOTORCYCLES'},
				{'MV',		'MAXI VAN'																	,	'TRUCKS'},
				{'MW',		'MAXI WAGON'																,	'TRUCKS'},
				{'MX',		'MOTO CROSS'																,	'MOTORCYCLES'},
				{'MY',		'MOTORIZED CUTAWAY'													,	'TRUCKS'},
				{'MY',		'MOTORIZED CUTAWAY'													,	'MOTORCYCLES'},
				{'NB',		'NOTCHBACK'																	,	'PASSENGER VEHICLES'},
				{'P2',		'2 PASSENGER LOW SPEED'											,	'PASSENGER VEHICLES'},
				{'P4',		'4 PASSENGER LOW SPEED'											,	'PASSENGER VEHICLES'},
				{'PC',		'CLUB CAB PICKUP'														,	'TRUCKS'},
				{'PD',		'PARCEL DELIVERY'														,	'TRUCKS'},
				{'PK',		'PICKUP'																		,	'PASSENGER VEHICLES'},
				{'PK',		'PICKUP'																		,	'TRUCKS'},
				{'PM',		'PICKUP WITH CAMPER MOUNTE'									,	'TRUCKS'},
				{'PN',		'PANEL'																			,	'PASSENGER VEHICLES'},
				{'PN',		'PANEL'																			,	'TRUCKS'},
				{'PS',		'SUPER CAB PICKUP'													,	'TRUCKS'},
				{'RC',		'RACER'																			,	'MOTORCYCLES'},
				{'RD',		'ROADSTER'																	,	'TRUCKS'},
				{'RD',		'ROADSTER'																	,	'PASSENGER VEHICLES'},
				{'RS',		'ROAD / STREET'															,	'MOTORCYCLES'},
				{'RT',		'ROAD / TRAIL MOTORCYCLE'										,	'MOTORCYCLES'},
				{'S1',		'ONE SEAT'																	,	'TRUCKS'},
				{'S2',		'TWO SEAT'																	,	'TRUCKS'},
				{'SB',		'SPORT HATCHBACK'														,	'PASSENGER VEHICLES'},
				{'SC',		'SPORT COUPE'																,	'PASSENGER VEHICLES'},
				{'SD',		'SEDAN'																			,	'PASSENGER VEHICLES'},
				{'SN',		'STEP VAN'																	,	'TRUCKS'},
				{'SP',		'SPORT PICKUP'															,	'TRUCKS'},
				{'ST',		'CONVENTIONAL CAB'													,	'TRUCKS'},
				{'SV',		'SPORT VAN'																	,	'TRUCKS'},
				{'SV',		'SPORT VAN'																	,	'PASSENGER VEHICLES'},
				{'SW',		'STATION WAGON'															,	'PASSENGER VEHICLES'},
				{'SW',		'STATION WAGON'															,	'TRUCKS'},
				{'T',			'DIRT'																			,	'MOTORCYCLES'},
				{'TB',		'TILT CAB'																	,	'TRUCKS'},
				{'TL',		'TRAIL/DIRT'																,	'MOTORCYCLES'},
				{'TL',		'TRAIL/DIRT'																,	'TRUCKS'},
				{'TM',		'TANDEM'																		,	'TRUCKS'},
				{'TN',		'TANK'																			,	'TRUCKS'},
				{'TR',		'TRACTOR TRUCK'															,	'TRUCKS'},
				{'TR',		'TRACTOR TRUCK'															,	'MOTORCYCLES'},
				{'UT',		'UTILITY'																		,	'TRUCKS'},
				{'UT',		'UTILITY'																		,	'PASSENGER VEHICLES'},
				{'VC',		'VAN CAMPER'																,	'TRUCKS'},
				{'VD',		'DISPLAY VAN'																,	'TRUCKS'},
				{'VN',		'VAN'																				,	'TRUCKS'},
				{'VT',		'VANETTE (INCLUDING METRO AND HANDY VAN)'		,	'TRUCKS'},
				{'VW',		'WINDOW VAN'																,	'TRUCKS'},
				{'WK',		'TOW TRUCK WRECKER'													,	'TRUCKS'},
				{'WW',		'WIDE WHEEL WAGON'													,	'PASSENGER VEHICLES'},
				{'WW',		'WIDE WHEEL WAGON'													,	'TRUCKS'},
				{'XT',		'TRAVELALL'																	,	'TRUCKS'},
				{'YY',		'CUTAWAY'																		,	'TRUCKS'}]
, { STRING Body_Style,STRING Body_Style_Description,STRING Category});

	EXPORT PHONEPARSE(dstd):= FUNCTIONMACRO
	
	 		Full_base 				:= Bair_composite.Key_MO_EID();
			
			Old_delta					:= Bair_composite.Key_MO_EID(,true);
			
			Full_superfile		:='~thor_data400::key::bair_composite::mo::v2::qa::eid';
			
			Delta_superfile		:='~thor_data400::key::bair_composite::mo::v2::delta::qa::eid';
			
			If(not nothor(fileservices.superfileexists(Delta_superfile)),nothor(fileservices.createsuperfile(Delta_superfile)));
						
			Full_LgFileName		:=nothor(fileservices.GetSuperFileSubName(Full_superfile,1));
			
			Delta_LgFileName	:= nothor(fileservices.GetSuperFileSubName(Delta_superfile,1));
													
			
			rgxVersion				:='([0-9]){8}[_][0-9]{6}';
			
			Full_Version			:=regexfind(rgxVersion,Full_LgFileName,1);
			
			Delta_Version			:=regexfind(rgxVersion,Delta_LgFileName,1);
			
			Delta_base				:= 	If(Delta_Version > Full_Version
														,Dedup(Sort(join(Old_delta,dStd,left.eid=right.eid,transform(bair_composite.layouts.Phone_Parse, self.IsCurrent:=false, self:=left))
														+ dStd
														,eid,phone,-IsCurrent),except IsCurrent)
														,dstd
														);
																			

			Full_Delta_Merge	:= join(Full_base,Delta_base,left.eid=right.eid,transform(bair_composite.layouts.Phone_Parse,self.IsCurrent:=false,self:=left))
													 + Delta_base;

			Phone_Out					:= dedup(sort(Full_Delta_Merge,eid,phone,-IsCurrent),except IsCurrent);
	
		Return Phone_Out;
	ENDMACRO;
End;