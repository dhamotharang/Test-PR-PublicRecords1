export DEA_REGISTRATION := module

	export VARSTRING BUSINESS_ACTIVITY_CODE(string code) := MAP(
					code = 'A' =>     	'Pharmacy',                                                                                                                                                                                                                                                                                                                                 
					code = 'B' =>     	'Hospital/Clinic',
					code = 'C' =>     	'Practitioner',
					code = 'D' =>     	'Teaching Institution',
					code = 'E' =>     	'Manufacturer',
					code = 'F' =>     	'Distributor',
					code = 'G' =>     	'Researcher',
					code = 'H' =>     	'Analytical Lab',
					code = 'J' =>     	'Importer',
					code = 'K' =>     	'Exporter',
					code = 'M' =>     	'Mid Level Practitioner',
					code = 'N' =>     	'Narcotic Treatment Program',
					code = 'P' =>     	'Narcotic Treatment Program',
					code = 'R' =>     	'Narcotic Treatment Program',
					code = 'S' =>     	'Narcotic Treatment Program',
					code = 'T' =>     	'Narcotic Treatment Program',
					code = 'U' =>     	'Narcotic Treatment Program',
					'');

	export checkChanges := 
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'BUSINESS_ACTIVITY_CODE'	=>	BUSINESS_ACTIVITY_CODE(le.code),
				'');
				    
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='DEA_REGISTRATION'),trans(LEFT));
	RETURN p;
		
	END;

END;
