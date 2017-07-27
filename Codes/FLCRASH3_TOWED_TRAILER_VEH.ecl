export FLCRASH3_TOWED_TRAILER_VEH :=
MODULE
     export VARSTRING TOWED_TRAILER_TYPE(string code) := MAP(
			code='01'=>'Single Semi Trailer',  
			code='02'=>'Tandem Semi Trailer(s)',  
			code='03'=>'Tank Trailer',  
			code='04'=>'Saddle Mount / Flatbed',  
			code='05'=>'Boat Trailer',  
			code='06'=>'Utility Trailer',  
			code='07'=>'House Trailer',  
			code='08'=>'Pole Trailer',  
			code='09'=>'Towed Vehicle',  
			code='77'=>'Other',  
               '');

	export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'TOWED_TRAILER_TYPE' =>	TOWED_TRAILER_TYPE(le.code),
				    '');				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='FLCRASH3_TOWED_TRAILER_VEH'),trans(LEFT));
	RETURN p;
		
	END;

END;