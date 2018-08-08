IMPORT Codes;

EXPORT EFX_GEOPREC_TABLE := 
MODULE
	EXPORT VARSTRING GEOPREC(STRING code) :=
	  MAP(
		  code='255' => 'Rooftop',
      code='9' => 'Full Zip+4',
      code='7' => 'Zip+2',
      code='6' => 'Canadian full 6 Digit Postal Code',
			code='5' => 'Zip only',       
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'GEOPREC' =>	GEOPREC(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='GEOPREC',field_name in ['GEOPREC']
	),trans(LEFT));
	RETURN p;
		
	END;			 
			
END;