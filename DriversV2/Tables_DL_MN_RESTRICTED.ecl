// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import ut;

export Tables_DL_MN_RESTRICTED := module

 	export Eye_Color(string strValue) :=
																 map(ut.CleanSpacesAndUpper(strValue) = 'BLK' 																	=> 'I',
																		 ut.CleanSpacesAndUpper(strValue) = 'BLU' 																	=> 'H',
																		 ut.CleanSpacesAndUpper(strValue) = 'BRN' 																	=> 'C',																		 
																		 ut.CleanSpacesAndUpper(strValue) = 'BXB'							 										  => 'J',
																		 ut.CleanSpacesAndUpper(strValue) = 'BXG' 																	=> 'K',
																		 ut.CleanSpacesAndUpper(strValue) = 'BXH' 																	=> 'M',
																		 ut.CleanSpacesAndUpper(strValue) = 'DBR' 																	=> 'F',
																		 ut.CleanSpacesAndUpper(strValue) = 'GRN' 																	=> 'B',
																		 ut.CleanSpacesAndUpper(strValue) = 'GRY' 																	=> 'D',
																		 ut.CleanSpacesAndUpper(strValue) = 'GXB' 																	=> 'L',
																		 ut.CleanSpacesAndUpper(strValue) = 'HZL' 																	=> 'A',																		 
																		 ut.CleanSpacesAndUpper(strValue) = 'HXB' 																	=> 'N',
																		 ut.CleanSpacesAndUpper(strValue) = 'LBR' 																	=> 'E',
																		 ut.CleanSpacesAndUpper(strValue) = 'RBY' 																	=> 'G',
																		 ut.CleanSpacesAndUpper(strValue) = 'WHT' 																	=> 'O',
																		 ''
																		 );

 	export License_Class(string strValue) :=
																 map(ut.CleanSpacesAndUpper(strValue) = 'A-BASIC VEH/COMB.' 										=> 'A',
																		 ut.CleanSpacesAndUpper(strValue) = 'B-SINGLE UNIT VEH' 										=> 'B',
																		 ut.CleanSpacesAndUpper(strValue) = 'C-COMM,HAZ/SCH BUS' 									  => 'C',
																		 ut.CleanSpacesAndUpper(strValue) = 'C-SINGLE,GVWR<26000'							 		  => 'D',
																		 ut.CleanSpacesAndUpper(strValue) = 'CONAX' 																=> 'X',
																		 ut.CleanSpacesAndUpper(strValue) = 'ID CARD' 															=> 'I',
																		 ut.CleanSpacesAndUpper(strValue) = 'M-MOPED' 															=> 'J',
																		 ut.CleanSpacesAndUpper(strValue) = 'R-TRACER/FORMR NAME'							 		  => 'R',
																		 ut.CleanSpacesAndUpper(strValue) = 'T-ID CARD LIFETIME' 									  => 'T',
																		 ''
																		 );
																		 
	export License_RESTRICTED_Type(string strValue) :=
																 map(ut.CleanSpacesAndUpper(strValue) = 'REGULAR' 															=> '1',
																		 ut.CleanSpacesAndUpper(strValue) = 'DUPL REG' 														  => '2',
																		 ut.CleanSpacesAndUpper(strValue) = 'PROVISNL'								 							=> '3',
																		 ut.CleanSpacesAndUpper(strValue) = 'DUP PROV' 														  => '4',
																		 ut.CleanSpacesAndUpper(strValue) = 'PERMIT' 															  => '5',
																		 ut.CleanSpacesAndUpper(strValue) = 'EXAM' 																  => '6',  		
																		 ut.CleanSpacesAndUpper(strValue) = 'FARM' 																  => '7',
																		 ut.CleanSpacesAndUpper(strValue) = 'FARM DUP' 														  => '8',
																		 ut.CleanSpacesAndUpper(strValue) = 'FARM UNDER 21' 												=> '9',		
																		 ut.CleanSpacesAndUpper(strValue) = 'FARM DUP < 21'												  => '0',
																		 ut.CleanSpacesAndUpper(strValue) = 'PROVISIONAL(GDL)'											=> 'P',	
																		 ut.CleanSpacesAndUpper(strValue) = 'DUPL PROVISIONAL(GDL)'							  	=> 'Q',																	 
																		 ut.CleanSpacesAndUpper(strValue)
																		);
																		
	export License_ST_Type(string strValue) :=																	
																  map(ut.CleanSpacesAndUpper(strValue) = 'REGULAR'															=>'1',
	                                    ut.CleanSpacesAndUpper(strValue) = 'DUPL REG'														  =>'2',
																			ut.CleanSpacesAndUpper(strValue) = 'PROVISNL'														  =>'3',
																			ut.CleanSpacesAndUpper(strValue) = 'DUP PROV'														  =>'4',
	                                    ut.CleanSpacesAndUpper(strValue) = 'PERMIT'															  =>'5',
																			ut.CleanSpacesAndUpper(strValue) = 'EXAM'																  =>'11',
																			ut.CleanSpacesAndUpper(strValue) = 'SEASONAL FARM REGULAR'								=>'7',	
																			ut.CleanSpacesAndUpper(strValue) = 'SEASONAL FARM DUPLICATE'							=>'8',
																			ut.CleanSpacesAndUpper(strValue) = 'SEASONAL FARM UNDER21'								=>'9',
	                                    ut.CleanSpacesAndUpper(strValue) = 'SEASONAL FARM DUP UNDER21'						=>'0',
																			ut.CleanSpacesAndUpper(strValue) = 'PROVISIONAL(GRADUATED LIC)'					  =>'P',
																			ut.CleanSpacesAndUpper(strValue) = 'DUPL PROVISIONAL(GARD LIC)'					  =>'Q',
																			''
																			);
																			
	export License_RESTRICTED_Endorsement(string strValue) :=								
																 map(ut.CleanSpacesAndUpper(strValue) = 'SCHOOL BUS' 													  => 'S',
																		 ut.CleanSpacesAndUpper(strValue) = 'DOUBLE TRIPLE TRAILERS' 							  => 'T',  		
																		 ut.CleanSpacesAndUpper(strValue) = 'TANKER HAZARDOUS MATERIAL' 						=> 'X',
																		 ut.CleanSpacesAndUpper(strValue) = 'HAZARDOUS MATERIAL' 									  => 'H',
																		 ut.CleanSpacesAndUpper(strValue) = 'PASSENGER' 														=> 'P',
																		 ut.CleanSpacesAndUpper(strValue) = 'TANKER' 															  => 'N',
																		 ut.CleanSpacesAndUpper(strValue) = 'MOTORCYCLE' 													  => 'M',
																		 ut.CleanSpacesAndUpper(strValue) = 'SPECIAL TRANS' 												=> 'J',
																		 ut.CleanSpacesAndUpper(strValue) = 'SPECIAL TRANSPORTATION' 							  => 'J',
																		 ut.CleanSpacesAndUpper(strValue) = 'SCHOOL BUS WITH SPECIAL TRANSP SERV' 	=> 'Z',
																		 ut.CleanSpacesAndUpper(strValue)
																		);
																		
	export License_ST_Endorsement(string strValue) :=
																 map(((integer)strValue) = 1																						=> 'S',
																		 ((integer)strValue) between  2  	and  3 														=> 'T',
																		 ((integer)strValue) between  4  	and  7 														=> 'X',
																		 ((integer)strValue) between  8  	and  15 													=> 'H',
																		 ((integer)strValue) between  16  and  31 													=> 'P',
																		 ((integer)strValue) between  32  and  63 													=> 'N',
																		 ((integer)strValue) between  64  and  127 													=> 'M',
																		 ((integer)strValue) = 128 																					=> 'J',
																		 ((integer)strValue) = 129 																					=> 'Z',
																		 '0'
																		 );
					 
	export CDL_Status(string strValue) :=	
																 map(ut.CleanSpacesAndUpper(strValue) = 'VALID' 												=> 'V',
																		 ut.CleanSpacesAndUpper(strValue) = 'LIMITED' 		 									=> '1',
																		 ut.CleanSpacesAndUpper(strValue) = 'REVOKED' 											=> '2',
																		 ut.CleanSpacesAndUpper(strValue) = 'SUSPEND' 											=> '3',
																		 ut.CleanSpacesAndUpper(strValue) = 'CANCEL' 												=> '4',
																		 ut.CleanSpacesAndUpper(strValue) = 'CANCELLED'											=> '4',																		 
																		 ut.CleanSpacesAndUpper(strValue) = 'EXPIRED' 											=> '5',																					 
																		 ut.CleanSpacesAndUpper(strValue) = 'OTHER' 												=> '6',
																		 ut.CleanSpacesAndUpper(strValue) = 'DECEASED' 											=> '7',
																		 ut.CleanSpacesAndUpper(strValue) = 'DISQUAL' 											=> '8',
																		 ut.CleanSpacesAndUpper(strValue) = 'DISQUALIFIED' 									=> '8',																		 
																		 ut.CleanSpacesAndUpper(strValue) = 'PENDING' 											=> '9',
																		 ut.CleanSpacesAndUpper(strValue) = 'CANC-IPS' 											=> '',
																		 ut.CleanSpacesAndUpper(strValue) = 'N / A'		 											=> '',																		 
																		 ut.CleanSpacesAndUpper(strValue)
																		);

	export Restriction_ST_Code(string strValue) :=
																map((integer)strValue = 1 																							=> 'Z',
																		(integer)strValue between  2  			and  3			  									=> 'V',
																	  (integer)strValue between  4  			and  7 													=> 'U',
																	  (integer)strValue between  8  			and  15 												=> 'R',
																	  (integer)strValue between  16  			and  31 												=> 'Q',
																	  (integer)strValue between  32  			and  63 												=> 'L',
																	  (integer)strValue between  64  			and  127 												=> 'K',
																	  (integer)strValue between  128  		and  255 												=> 'G',
																	  (integer)strValue between  256  		and  511 												=> 'F',
																	  (integer)strValue between  512  		and  1023 											=> 'E',
																	  (integer)strValue between  1024  		and  2047 											=> 'D',
																	  (integer)strValue between  2048  		and  4095 											=> 'C',
																	  (integer)strValue between  4096  		and  8191 											=> 'A',
																	  (integer)strValue between  8192  		and  16383 											=> 'B',
																	  (integer)strValue between  16384  	and  32767 											=> 'I',
																	  (integer)strValue between  32768  	and  65635 											=> 'J',
																	  (integer)strValue between  65636  	and  131071 										=> 'O',
																	  (integer)strValue between  131072  	and  262143 										=> 'W',
																	  (integer)strValue = 262144 																					=> 'Y',
																		''
																		); 
																		
	export Restriction_RESTRICTED_Code(string strValue) :=	
																 map(ut.CleanSpacesAndUpper(strValue) = 'AUTOMATIC TRANS'								=> 'E', 
																		 ut.CleanSpacesAndUpper(strValue) = 'COMB > 26000 GCWR'							=> 'Y',	
																		 ut.CleanSpacesAndUpper(strValue) = 'COMPLETE HAND CONTROLS'				=> 'C', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'CORRECTIVE LENS'				  			=> 'Z', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'CORRECTIVE LENSES'							=> 'Z',	
																		 ut.CleanSpacesAndUpper(strValue) = 'DAYLIGHT DRIVE ONLY'						=> 'G', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'DRIVE ONLY W/O AIRBRAK'				=> 'L', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'ELEVATED DRIVER SEAT'					=> 'R', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'HAND OPER LIGHT BEAM'					=> 'Q',	
																		 ut.CleanSpacesAndUpper(strValue) = 'HAND OPERATED BRAKES'					=> 'B', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'INTRASTATE ONLY'								=> 'K', 
																		 ut.CleanSpacesAndUpper(strValue) = 'LEFT OUTSIDE MIRROR'						=> 'F', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'MOTORCYC UNDER 261CC'					=> 'V',
																		 ut.CleanSpacesAndUpper(strValue) = 'NO FREEWAY DRIVING'						=> 'U', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'PROSTHETIC AID'								=> 'D', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'TILL AGE 16-FARM/DR ED'				=> 'J',	
																		 ut.CleanSpacesAndUpper(strValue) = 'USE ALCH/DRUGS INV LIC'				=> 'A', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'VALID 3-WHEEL MOTORCYC'				=> 'I',  	
																		 ut.CleanSpacesAndUpper(strValue) = 'VEH < 26001 GVWR, BUS'					=> 'W', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'VEHICLE < 26001 GVWR'					=> 'O',   
																		 ut.CleanSpacesAndUpper(strValue)
																		);
																		
	export Restrictions(string strValue) :=																			
																 map(ut.CleanSpacesAndUpper(strValue) = 'AUTOMATIC TRANS'								=> 'E', 
																		 ut.CleanSpacesAndUpper(strValue) = 'COMB > 26000 GCWR'							=> 'Y',	
																		 ut.CleanSpacesAndUpper(strValue) = 'COMPLETE HAND CONTROLS'				=> 'C', 	
															 			 ut.CleanSpacesAndUpper(strValue) = 'CORRECTIVE LENS'								=> 'Z', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'CORRECTIVE LENSES'							=> 'Z',	
																		 ut.CleanSpacesAndUpper(strValue) = 'DAYLIGHT DRIVE ONLY'						=> 'G', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'DRIVE ONLY W/O AIRBRAK'				=> 'L', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'ELEVATED DRIVER SEAT'					=> 'R', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'HAND OPER LIGHT BEAM'					=> 'Q',	
																		 ut.CleanSpacesAndUpper(strValue) = 'HAND OPERATED BRAKES'					=> 'B', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'INTRASTATE ONLY'								=> 'K', 
																		 ut.CleanSpacesAndUpper(strValue) = 'LEFT OUTSIDE MIRROR'						=> 'F', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'MOTORCYC UNDER 261CC'					=> 'V',
																		 ut.CleanSpacesAndUpper(strValue) = 'NO FREEWAY DRIVING'						=> 'U', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'PROSTHETIC AID'								=> 'D', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'TILL AGE 16-FARM/DR ED'				=> 'J',	
																		 ut.CleanSpacesAndUpper(strValue) = 'USE ALCH/DRUGS INV LIC'				=> 'A', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'VALID 3-WHEEL MOTORCYC'				=> 'I',  	
																		 ut.CleanSpacesAndUpper(strValue) = 'VEH < 26001 GVWR, BUS'					=> 'W', 	
																		 ut.CleanSpacesAndUpper(strValue) = 'VEHICLE < 26001 GVWR'					=> 'O',   
																		 ut.CleanSpacesAndUpper(strValue)
																		 );
																		 
	export State_County(string strValue) :=																			
																 map(ut.CleanSpacesAndUpper(strValue) = '01' 														=> 'AITKIN',
																		 ut.CleanSpacesAndUpper(strValue) = '02' 														=> 'ANOKA',
																		 ut.CleanSpacesAndUpper(strValue) = '03' 														=> 'BECKER',
																		 ut.CleanSpacesAndUpper(strValue) = '04' 														=> 'BELTRAMI',	
																		 ut.CleanSpacesAndUpper(strValue) = '05'		 												=> 'BENTON',	
																		 ut.CleanSpacesAndUpper(strValue) = '06'		 												=> 'BIG STONE',																					 
																		 ut.CleanSpacesAndUpper(strValue) = '07' 														=> 'BLUE EARTH',
																		 ut.CleanSpacesAndUpper(strValue) = '08' 														=> 'BROWN',
																		 ut.CleanSpacesAndUpper(strValue) = '09' 														=> 'CARLTON',
																		 ut.CleanSpacesAndUpper(strValue) = '10' 														=> 'CARVER',
																		 ut.CleanSpacesAndUpper(strValue) = '11' 														=> 'CASS',		
																		 ut.CleanSpacesAndUpper(strValue) = '12' 														=> 'CHIPPEWA',
																		 ut.CleanSpacesAndUpper(strValue) = '13' 														=> 'CHISAGO',
																		 ut.CleanSpacesAndUpper(strValue) = '14' 														=> 'CLAY',
																		 ut.CleanSpacesAndUpper(strValue) = '15' 														=> 'CLEARWATER',
																		 ut.CleanSpacesAndUpper(strValue) = '16' 														=> 'COOK',
																		 ut.CleanSpacesAndUpper(strValue) = '17' 														=> 'COTTONWOOD',		
																		 ut.CleanSpacesAndUpper(strValue) = '18' 														=> 'CROW WING',
																		 ut.CleanSpacesAndUpper(strValue) = '19' 														=> 'DAKOTA',
																		 ut.CleanSpacesAndUpper(strValue) = '20' 														=> 'DODGE',
																		 ut.CleanSpacesAndUpper(strValue) = '21' 														=> 'DOUGLAS',																		 
																		 ut.CleanSpacesAndUpper(strValue) = '22' 														=> 'FARIBAULT',
																		 ut.CleanSpacesAndUpper(strValue) = '23' 														=> 'FILLMORE',
																		 ut.CleanSpacesAndUpper(strValue) = '24' 														=> 'FREEBORN',		
																		 ut.CleanSpacesAndUpper(strValue) = '25' 														=> 'GOODHUE',
																		 ut.CleanSpacesAndUpper(strValue) = '26' 														=> 'GRANT',
																		 ut.CleanSpacesAndUpper(strValue) = '27' 														=> 'HENNEPIN',
																		 ut.CleanSpacesAndUpper(strValue) = '28' 														=> 'HOUSTON',
																		 ut.CleanSpacesAndUpper(strValue) = '29' 														=> 'HUBBARD',
																		 ut.CleanSpacesAndUpper(strValue) = '30' 														=> 'ISANTI',		
																		 ut.CleanSpacesAndUpper(strValue) = '31' 														=> 'ITASCA',
																		 ut.CleanSpacesAndUpper(strValue) = '32' 														=> 'JACKSON',
																		 ut.CleanSpacesAndUpper(strValue) = '33' 														=> 'KANABEC',
																		 ut.CleanSpacesAndUpper(strValue) = '34' 														=> 'KANDIYOHI',
																		 ut.CleanSpacesAndUpper(strValue) = '35' 														=> 'KITTSON',
																		 ut.CleanSpacesAndUpper(strValue) = '36' 														=> 'KOOCHICHING',		
																		 ut.CleanSpacesAndUpper(strValue) = '37' 														=> 'LAC QUI PARLE',
																		 ut.CleanSpacesAndUpper(strValue) = '38' 														=> 'LAKE',
																		 ut.CleanSpacesAndUpper(strValue) = '39' 														=> 'LAKE OF THE WOODS',
																		 ut.CleanSpacesAndUpper(strValue) = '40' 														=> 'LESUEUR',
																		 ut.CleanSpacesAndUpper(strValue) = '41' 														=> 'LINCOLN',
																		 ut.CleanSpacesAndUpper(strValue) = '42' 														=> 'LYON',		
																		 ut.CleanSpacesAndUpper(strValue) = '43' 														=> 'MCLEOD',
																		 ut.CleanSpacesAndUpper(strValue) = '44' 														=> 'MAHNOMEN',																		 
																		 ut.CleanSpacesAndUpper(strValue) = '45' 														=> 'MARSHALL',
																		 ut.CleanSpacesAndUpper(strValue) = '46' 														=> 'MARTIN',
																		 ut.CleanSpacesAndUpper(strValue) = '47' 														=> 'MEEKER',
																		 ut.CleanSpacesAndUpper(strValue) = '48' 														=> 'MILLE LACS',
																		 ut.CleanSpacesAndUpper(strValue) = '49' 														=> 'MORRISON',		
																		 ut.CleanSpacesAndUpper(strValue) = '50' 														=> 'MOWER',
																		 ut.CleanSpacesAndUpper(strValue) = '51' 														=> 'MURRAY',
																		 ut.CleanSpacesAndUpper(strValue) = '52' 														=> 'NICOLLET',
																		 ut.CleanSpacesAndUpper(strValue) = '53' 														=> 'NOBLES',
																		 ut.CleanSpacesAndUpper(strValue) = '54' 														=> 'NORMAN',
																		 ut.CleanSpacesAndUpper(strValue) = '55' 														=> 'OLMSTED',		
																		 ut.CleanSpacesAndUpper(strValue) = '56' 														=> 'OTTERTAIL',
																		 ut.CleanSpacesAndUpper(strValue) = '57' 														=> 'PENNINGTON',
																		 ut.CleanSpacesAndUpper(strValue) = '58' 														=> 'PINE',
																		 ut.CleanSpacesAndUpper(strValue) = '59' 														=> 'PIPESTONE',
																		 ut.CleanSpacesAndUpper(strValue) = '60' 														=> 'POLK',
																		 ut.CleanSpacesAndUpper(strValue) = '61' 														=> 'POPE',		
																		 ut.CleanSpacesAndUpper(strValue) = '62' 														=> 'RAMSEY',
																		 ut.CleanSpacesAndUpper(strValue) = '63' 														=> 'RED LAKE',
																		 ut.CleanSpacesAndUpper(strValue) = '64' 														=> 'REDWOOD',																		 
																		 ut.CleanSpacesAndUpper(strValue) = '65' 														=> 'RENVILLE',
																		 ut.CleanSpacesAndUpper(strValue) = '66' 														=> 'RICE',																		 
																		 ut.CleanSpacesAndUpper(strValue) = '67' 														=> 'ROCK',
																		 ut.CleanSpacesAndUpper(strValue) = '68' 														=> 'ROSEAU',
																		 ut.CleanSpacesAndUpper(strValue) = '69' 														=> 'ST LOUIS',		
																		 ut.CleanSpacesAndUpper(strValue) = '70' 														=> 'SCOTT',
																		 ut.CleanSpacesAndUpper(strValue) = '71' 														=> 'SHERBURNE',
																		 ut.CleanSpacesAndUpper(strValue) = '72' 														=> 'SIBLEY',
																		 ut.CleanSpacesAndUpper(strValue) = '73' 														=> 'STEARNS',
																		 ut.CleanSpacesAndUpper(strValue) = '74' 														=> 'STEELE',
																		 ut.CleanSpacesAndUpper(strValue) = '75' 														=> 'STEVENS',		
																		 ut.CleanSpacesAndUpper(strValue) = '76' 														=> 'SWIFT',
																		 ut.CleanSpacesAndUpper(strValue) = '77' 														=> 'TODD',
																		 ut.CleanSpacesAndUpper(strValue) = '78' 														=> 'TRAVERSE',
																		 ut.CleanSpacesAndUpper(strValue) = '79' 														=> 'WABASHA',
																		 ut.CleanSpacesAndUpper(strValue) = '80' 														=> 'WADENA',
																		 ut.CleanSpacesAndUpper(strValue) = '81' 														=> 'WASECA',		
																		 ut.CleanSpacesAndUpper(strValue) = '82' 														=> 'WASHINGTON',
																		 ut.CleanSpacesAndUpper(strValue) = '83' 														=> 'WATONWAN',		
																		 ut.CleanSpacesAndUpper(strValue) = '84' 														=> 'WILKIN',
																		 ut.CleanSpacesAndUpper(strValue) = '85' 														=> 'WINONA',		
																		 ut.CleanSpacesAndUpper(strValue) = '86' 														=> 'WRIGHT',
																		 ut.CleanSpacesAndUpper(strValue) = '87' 														=> 'YELLOW MEDICINE',
																		 ut.CleanSpacesAndUpper(strValue) = '88' 														=> 'FOREIGN',
																		 ''
																		);  																			 
																		 
	export Status(string strValue) :=																			
																 map(ut.CleanSpacesAndUpper(strValue) = 'VALID' 												=> '0',
																		 ut.CleanSpacesAndUpper(strValue) = 'LIMITED' 											=> '1',
																		 ut.CleanSpacesAndUpper(strValue) = 'REVOKED' 											=> '2',
																		 ut.CleanSpacesAndUpper(strValue) = 'SUSPEND' 											=> '3',	
																		 ut.CleanSpacesAndUpper(strValue) = 'CANCEL'		 										=> '4',	
																		 ut.CleanSpacesAndUpper(strValue) = 'EXPIRED'		 										=> '5',																					 
																		 ut.CleanSpacesAndUpper(strValue) = 'PENDING' 											=> '6',
																		 ut.CleanSpacesAndUpper(strValue) = 'CANC-IPS' 											=> '7',
																		 ut.CleanSpacesAndUpper(strValue) = 'DECEASED' 											=> '8',
																		 ut.CleanSpacesAndUpper(strValue) = 'ID ONLY' 											=> '9',
																		 ut.CleanSpacesAndUpper(strValue) = 'TRACER' 												=> '10',		
																		 ut.CleanSpacesAndUpper(strValue) = 'CONAX' 												=> '11',
																		 ut.CleanSpacesAndUpper(strValue) = 'MOPED' 												=> '12',
																		 ''
																		);  																		 
														 
end;																		