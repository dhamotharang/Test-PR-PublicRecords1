export DNB_COMPANIES := module

	export varstring OWNS_RENTS(string code) := map(
			code = '0' => '',
			code = '1' => 'Owns',
			code = '2' => 'Rents',
			'');
	
	export varstring STRUCTURE_TYPE(string code) := map(
			code = '0' => '',
			code = '1' => 'Proprietorship',
			code = '2' => 'Partnership',
			code = '3' => 'Corporation',
			'');
			
	export varstring TYPE_OF_ESTABLISHMENT(string code) := map(
			code = '0' => 'Single Location',
			code = '1' => 'Headquarters',
			code = '2' => 'Branch',
			code = '3' => 'Subsidiary and Headquarters',
			code = '4' => 'Subsidiary and Single Location',
			code = '5' => 'Division',
			'');

	export checkChanges := 
	FUNCTION
		
		codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
			TRANSFORM
				translation := map(le.field_name = 'TYPE_OF_ESTABLISHMENT' => type_of_establishment(le.code),
						    le.field_name = 'STRUCTURE_TYPE' 	    => structure_type(le.code),
						    le.field_name = 'OWNS_RENTS'		    => owns_rents(LE.code),
						    '');
				self.code := IF(le.long_desc=translation,SKIP,le.code);
				self := Le;
			end;
		
		p := PROJECT(codes.File_Codes_V3_in(file_name='DNB_COMPANIES'),trans(LEFT));
		RETURN p;
		
	END;

END;