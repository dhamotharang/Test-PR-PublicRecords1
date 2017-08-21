IMPORT	FAA,	STD,	ut;

fn_certification_string(STRING	certification)	:=	FUNCTION
	airworthiness		:=	TRIM(certification,LEFT)[1];
	opertion_codes	:=	TRIM(certification,ALL)[2..];
	cert_string	:=	MAP(
		airworthiness	=	'1'	=>	'Standard'	+	MAP(
			opertion_codes[1]	=	'N'	=>	', '+'Normal',
			opertion_codes[1]	=	'U'	=>	', '+'Utility',
			opertion_codes[1]	=	'A'	=>	', '+'Acrobatic',
			opertion_codes[1]	=	'T'	=>	', '+'Transport',
			opertion_codes[1]	=	'G'	=>	', '+'Glider',
			opertion_codes[1]	=	'B'	=>	', '+'Balloon',
			opertion_codes[1]	=	'C'	=>	', '+'Commuter',
			opertion_codes[1]	=	'O'	=>	', '+'Other',
			''
		),
		airworthiness	=	'2'	=>	'Limited',
		airworthiness	=	'3'	=>	'Restricted'	+
			IF(STD.Str.Contains(opertion_codes[1..7],'0',TRUE),', '+'Other','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'1',TRUE),', '+'Agriculture and Pest Control','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'2',TRUE),', '+'Aerial Surveying','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'3',TRUE),', '+'Aerial Advertising','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'4',TRUE),', '+'Forest','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'5',TRUE),', '+'Patrolling','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'6',TRUE),', '+'Weather Control','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'7',TRUE),', '+'Carriage of Cargo',''),
		airworthiness	=	'4'	=>	'Experimental'	+
			IF(STD.Str.Contains(opertion_codes[1..7],'0',TRUE),', '+'To show compliance with FAR','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'1',TRUE),', '+'Research and Development','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'2',TRUE),', '+'Amateur Built','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'3',TRUE),', '+'Exhibition','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'4',TRUE),', '+'Racing','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'5',TRUE),', '+'Crew Training','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'6',TRUE),', '+'Market Survey','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'7',TRUE),', '+'Operating Kit Built Aircraft','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'8A',TRUE),', '+'Reg. Prior to 01/31/08','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'8B',TRUE),', '+'Operating Light-Sport Kit-Built','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'8C',TRUE),', '+'Operating Light-Sport Previously issued cert under 21.190','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'9A',TRUE),', '+'Unmanned Aircraft - Research and Development','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'9B',TRUE),', '+'Unmanned Aircraft - Market Survey','')	+
			IF(STD.Str.Contains(opertion_codes[1..7],'9C',TRUE),', '+'Unmanned Aircraft - Crew Training',''),
		airworthiness	=	'5'	=>	'Provisional'	+	MAP(
			opertion_codes[1]	=	'1'	=>	' - '+'Class I',
			opertion_codes[1]	=	'2'	=>	' - '+'Class II',
			''
		),
		airworthiness	=	'6'	=>	'Multiple'	+
			IF(STD.Str.Contains(opertion_codes[1..2],'1',TRUE),', '+'Standard','')	+
			IF(STD.Str.Contains(opertion_codes[1..2],'2',TRUE),', '+'Limited','')	+
			IF(STD.Str.Contains(opertion_codes[1..2],'3',TRUE),', '+'Restricted','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'0',TRUE),', '+'Other','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'1',TRUE),', '+'Agriculture and Pest Control','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'2',TRUE),', '+'Aerial Surveying','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'3',TRUE),', '+'Aerial Advertising','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'4',TRUE),', '+'Forest','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'5',TRUE),', '+'Patrolling','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'6',TRUE),', '+'Weather Control','')	+
			IF(STD.Str.Contains(opertion_codes[3..9],'7',TRUE),', '+'Carriage of Cargo',''),
		airworthiness	=	'7'	=>	'Primary',
		airworthiness	=	'8'	=>	'Special Flight Permit'	+
			IF(STD.Str.Contains(opertion_codes[1..9],'1',TRUE),', '+'Ferry flight for repairs, alterations, maintenance or storage','')	+
			IF(STD.Str.Contains(opertion_codes[1..9],'2',TRUE),', '+'Evacuate from area of impending danger','')	+
			IF(STD.Str.Contains(opertion_codes[1..9],'3',TRUE),', '+'Operation in excess of maximum certificated','')	+
			IF(STD.Str.Contains(opertion_codes[1..9],'4',TRUE),', '+'Delivery or export','')	+
			IF(STD.Str.Contains(opertion_codes[1..9],'5',TRUE),', '+'Production flight testing','')	+
			IF(STD.Str.Contains(opertion_codes[1..9],'6',TRUE),', '+'Customer Demo',''),
		airworthiness	=	'9'	=>	'Light Sport'	+	MAP(
			opertion_codes[1]	=	'A'	=>	' - '+'Airplane',
			opertion_codes[1]	=	'G'	=>	' - '+'Glider',
			opertion_codes[1]	=	'L'	=>	' - '+'Lighter than Air',
			opertion_codes[1]	=	'P'	=>	' - '+'Power-Parachute',
			opertion_codes[1]	=	'W'	=>	' - '+'Weight-Shift-Control',
			''
		),
		''
	);
	RETURN	STD.Str.CleanSpaces(cert_string);
END;

dSearchFile								:=	faa.file_aircraft_registration_out(n_number != '' AND certification<>'');
dSearchFileCertifications	:=	DEDUP(SORT(DISTRIBUTE(dSearchFile,HASH(certification)),certification,LOCAL),certification,LOCAL);

Codes.layout_codes_csv	tGetCertifications(dSearchFileCertifications	pInput)	:=	TRANSFORM
	SELF.file_name			:=	'FAA_AIRCRAFT_REF';
	SELF.field_name			:=	'CERTIFICATION';
	SELF.field_name2		:=	'';
	SELF.code						:=	TRIM(pInput.certification,LEFT,RIGHT);
	SELF.desc						:=	fn_certification_string(SELF.code);
END;

EXPORT file_FAA_Codes	:=	DEDUP(SORT(PROJECT(dSearchFileCertifications,tGetCertifications(LEFT)),code),code);