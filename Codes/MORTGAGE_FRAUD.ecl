export MORTGAGE_FRAUD := module
	
	export VARSTRING area_code(string code) := 
		case(code,
				'112' => 'Yes',
				'300' => 'Yes',
				'301' => 'Yes',
				'302' => 'Yes',
				'303' => 'Yes',
				'331' => 'Yes',
				'381' => 'Yes',
				'482' => 'Yes',
				'606' => 'Yes',
				'631' => 'Yes', 
				'770' => 'Yes',    
				'752' => 'Yes',
				'No');
	
	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'AREA_CODE'  =>	AREA_CODE(le.code),
				    '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='MORTGAGE_FRAUD'),trans(LEFT));
	RETURN p;
		
	END;

END;