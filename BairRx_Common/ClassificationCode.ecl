EXPORT ClassificationCode := MODULE

	EXPORT LookupTable := DATASET([
		 {'EVE', 1, 	'Homicide', 									'1'}		
		,{'EVE', 2, 	'Attempted Homicide', 				'2'}		
		,{'EVE', 3, 	'Death Investigation', 				'3'}		
		,{'EVE', 4, 	'Sexual Assault',							'4'}		
		,{'EVE', 5, 	'Sexual Offense - Other', 		'5'}		
		,{'EVE', 6, 	'Robbery - Commercial', 			'6'}		
		,{'EVE', 7, 	'Robbery - Individual', 			'7'}		
		,{'EVE', 8, 	'Aggravated Assault', 				'8'}		
		,{'EVE', 9, 	'Assault', 										'9'}		
		,{'EVE', 10, 	'Burglary - Commercial', 			'10'}		
		,{'EVE', 11, 	'Burglary - Residential', 		'11'}		
		,{'EVE', 12, 	'Theft', 											'12'}		
		,{'EVE', 13, 	'Fraud', 											'13'}		
		,{'EVE', 14, 	'Shoplifting', 								'14'}		
		,{'EVE', 15, 	'Theft - Other', 							'15'}		
		,{'EVE', 16, 	'Motor Vehicle Theft', 				'16'}		
		,{'EVE', 17, 	'Burglary from Motor Vehicle','17'}		
		,{'EVE', 18, 	'Arson', 											'18'}		
		,{'EVE', 19, 	'DUI', 												'19'}		
		,{'EVE', 20, 	'Alcohol Violation', 					'20'}		
		,{'EVE', 21, 	'Drugs / Narcotics Violation','21'}		
		,{'EVE', 22, 	'Disorderly Conduct', 				'22'}		
		,{'EVE', 23, 	'Traffic Incident', 					'23'}		
		,{'EVE', 24, 	'Vandalism', 									'24'}		
		,{'EVE', 25, 	'Weapons Violation', 					'25'}		
		,{'EVE', 26, 	'All Other - Non-Criminal', 	'26'}		
		,{'EVE', 27, 	'All Other - Criminal', 			'27'}		
		// CFS 
		,{'CFS',  1001,   'Robbery',            		'1001'}
		,{'CFS',  1002,   'Assault/Battery',        '1002'}
		,{'CFS',  1003,   'Burglary of Structure',  '1003'}
		,{'CFS',  1004,   'Theft',            			'1004'}
		,{'CFS',  1005,   'Burglary of Vehicle',    '1005'}
		,{'CFS',  1006,   'Motor Vehicle Theft',    '1006'}
		,{'CFS',  1007,   'Arson',            			'1007'}
		,{'CFS',  1008,   '911 Hang-Up / Open Line','1008'}
		,{'CFS',  1009,   'Alarm Call',            	'1009'}
		,{'CFS',  1010,   'Animal Call',            '1010'}
		,{'CFS',  1011,   'Vandalism or Criminal Damage',     '1011'}
		,{'CFS',  1012,   'Fraudulent or Deceptive Activity', '1012'}
		,{'CFS',  1013,   'Disturbance',            '1013'}
		,{'CFS',  1014,   'Domestic Dispute',       '1014'}
		,{'CFS',  1015,   'Shots Fired',            '1015'}
		,{'CFS',  1016,   'Harassment / Threatening Calls',   '1016'}
		,{'CFS',  1017,   'Indecent Activity / Sex Offense',  '1017'}
		,{'CFS',  1018,   'Suspicious Activity',    '1018'}
		,{'CFS',  1019,   'Building or Area Check', '1019'}
		,{'CFS',  1020,   'Accident - Fatality',    '1020'}
		,{'CFS',  1021,   'Accident - Injury',      '1021'}
		,{'CFS',  1022,   'Accident - Non-Injury',  '1022'}
		,{'CFS',  1023,   'Recovered Property',     '1023'}
		,{'CFS',  1024,   'Drug or Alcohol Violations',       '1024'}
		,{'CFS',  1025,   'Weapons Violation',      '1025'}
		,{'CFS',  1026,   'Subject Stop',           '1026'}
		,{'CFS',  1027,   'Traffic Stop',           '1027'}
		,{'CFS',  1028,   'Loud Party / Music',     '1028'}
		,{'CFS',  1029,   'Fire or Fireworks Call', '1029'}
		,{'CFS',  1030,   'Ordinance or Code Violation',      '1030'}
		,{'CFS',  1031,   'Parking Problem / Motorist Assist','1031'}
		,{'CFS',  1032,   'Civil Matter / Non-Criminal',      '1032'}
		,{'CFS',  1033,   'Medical / Check Welfare','1033'}
		,{'CFS',  1034,   'All Other',            	'1034'}	
		//LPR
		,{'LPR',  600,   'LPR',            					'9999'}
		//CRA
		,{'CRA',  1600,   'Non-Injury',            	'NON'}
		,{'CRA',  1601,   'Injury',            			'INJ'}
		,{'CRA',  1602,   'Fatality',            		'FAT'}
		//INTEL
		,{'INT',  2000,   'CONFIDENTIAL INFORMANT', 'CONF'}
		,{'INT',  2001,   'GANGS',            			'GANG'}
		,{'INT',  2004,   'SUSPICIOUS ACTIVITY',    'SUSP'}
		,{'INT',  2005,   'TERRORISM',            	'TERR'}
		,{'INT',  2006,   'THREATS',            		'THRE'}
		//Shot Spotter
		,{'SHO',  30000,   'Single Shot',           '1'}
		,{'SHO',  30001,   'Multiple Shots',        '2'}
		,{'SHO',  30002,   'Possible Shots',        '19'}
		//Offender
		,{'OFF',  4000,   'Sex Offender',           'SEX'}
		,{'OFF',  4001,   'Gang Member',            'GANG'}
		,{'OFF',  4002,   'Offender - General',     'OFF'}
		,{'OFF',  4003,   'Prolific Offender',      'PROL'}
		,{'OFF',  4004,   'Warrant/Wanted',         'WARR'}
		,{'OFF',  4005,   'Probationer/Parolee',    'PROB'}
	], {string3 mode, integer code, string class, string roxie_code});
	
	// Slight variation of Bair.MapClassCode to support ATACRaids numerical codes
	EXPORT MapClassCode(unsigned t, integer inv) := FUNCTION
		
		// event codes = 1 .. 27
		stdeve := IF(inv>0, 'EVE'+(string)inv, '');
		// cfs codes = 1001..1034
		stdcfs := if(inv>0,'CFS'+(string)inv, '');
		// crash codes: 1600-Non-Injury, 1601-Injury, 1602-Fatality 
		stdcra :=	MAP(
			inv = 1600 => 'CRANON',
			inv = 1601 => 'CRAINJ',
			inv = 1602 => 'CRAFAT',
			'');
		
		// LPR codes: 
		stdlpr :=	IF(inv=600, 'LPR', '');
		
		// Intel: 2000-CONFIDENTIAL INFORMANT, 2001-GANGS, 2002-NARC, 2004-SUSPICIOUS ACTIVITY,2005-TERRORISM, 2006-THREATS  
		stdint := MAP(
			inv=2000 							=> 'INTCONF', 
			inv=2001 							=> 'INTGANG', 
			inv=2002 							=> 'INTNARC', 
			inv=2004 							=> 'INTSUSP', 
			inv=2005 							=> 'INTTERR', 
			inv=2006 							=> 'INTTHRE', 
			'');

		// Shotspotter: 30000-01-Single Shot, 30001-02-Multiple Shots, 30002-19-Possible Shots						
		stdshot :=	MAP(
			inv=30000 => 'SHOSING', 
			inv=30001 => 'SHOMULT', 
			inv=30002 => 'SHOPOSS', 
			'');
		
		// Offender: 4000-SEX, 4001-GANG MEMBER, 4002-OFFENDER GENERAL, 4003-PROLIFIC OFFENDER, 4004-WARRANT/WANTED, 4005-PROBATIONER/PAROLEE
		stdoff :=	MAP(
			inv=4000 => 'OFFSEX',		
			inv=4001 => 'OFFGANG',
			inv=4002 => 'OFFOFF',
			inv=4003 => 'OFFPROL',
			inv=4004 => 'OFFWARR',
			inv=4005 => 'OFFPROB',	
			''
			);
		
		RETURN MAP(
			t = 1 => stdeve,
			t = 2 => stdcfs,
			t = 3 => stdcra,
			t = 4 => stdlpr,
			t = 5 => stdint,
			t = 6 => stdshot,
			t = 7 => stdoff,
			''	
			);
	END;

	EXPORT MapClassCodeOut(unsigned t, string v) := FUNCTION
		
		integer inv := (integer) v;	
		string upperv := stringlib.stringtouppercase(v);	
		
		// crash codes: 1600-CRANON, 1601-CRAINJ, 1602-CRAFAT 
		stdcra :=	MAP(
			upperv = 'CRANON' => 1600,
			upperv[1..3] = 'NON' 		=> 1600,
			upperv = 'CRAINJ' => 1601,
			upperv[1..3] = 'INJ' 		=> 1601,
			upperv = 'CRAFAT' => 1602,
			upperv[1..3] = 'FAT' => 1602,
			0);
		
		// LPR codes: 9999 (fabricated)
		stdlpr :=	IF(inv=9999 OR upperv[1..3]='LPR', 600, 0);
		
		// Intel: 2000-CONFIDENTIAL INFORMANT, 2001-GANGS, 2002-NARC, 2004-SUSPICIOUS ACTIVITY,2005-TERRORISM, 2006-THREATS  
		stdint := MAP(
			upperv[1..4] = 'CONF' => 2000,
			upperv[1..4] = 'GANG' => 2001,
			upperv[1..4] = 'NARC' => 2002,
			upperv[1..4] = 'SUSP' => 2004,
			upperv[1..4] = 'TERR' => 2005,
			upperv[1..4] = 'THRE' => 2006,
			0);		
		
		// Shotspotter: 30000-01-Single Shot, 30001-02-Multiple Shots, 30002-19-Possible Shots						
		stdshot :=	MAP(
			inv=1 		=> 30000, 		
			inv=2 		=> 30001, 		
			inv=19 		=> 30002, 
			0);		
		
		// Offender: 4000-SEX, 4001-GANG MEMBER, 4002-OFFENDER GENERAL, 4003-PROLIFIC OFFENDER, 4004-WARRANT/WANTED, 4005-PROBATIONER/PAROLEE		
		stdoff :=	MAP(
			upperv[1..3] = 'SEX'	=> 4000,		
			upperv[1..4] = 'GANG' => 4001,
			upperv[1..3] = 'OFF'	=> 4002,
			upperv[1..4] = 'PROL'	=> 4003,
			upperv[1..4] = 'WARR'	=> 4004,
			upperv[1..4] = 'PROB'	=> 4005,
			0
			);
			
		RETURN MAP(
			t = 1 => (unsigned) v, // event already numerical
			t = 2 => (unsigned) v, // cfs already numerical
			t = 3 => stdcra,
			t = 4 => stdlpr,
			t = 5 => stdint,
			t = 6 => stdshot,
			t = 7 => stdoff,
			0	
			);
	END;
	
	EXPORT GetClassification(integer inCode) := LookupTable(code = inCode)[1].class;
	EXPORT isValidCode(string3 m, integer c) := exists(LookupTable(mode=m,code = c));

END;