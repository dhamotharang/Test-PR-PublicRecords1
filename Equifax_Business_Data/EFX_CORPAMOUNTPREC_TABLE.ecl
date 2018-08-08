IMPORT Codes;

EXPORT EFX_CORPAMOUNTPREC_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTPREC(STRING code) :=
	  MAP(		
       code='ACTUAL' => 'Actual',
       code='EST' => 'Estimated',
       code='MDL' => 'Modeled',
       code='OTH' => 'Other',          
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORPAMOUNTPREC' =>	CORPAMOUNTPREC(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CORPAMOUNTPREC',field_name in ['CORPAMOUNTPREC']
	),trans(LEFT));
	RETURN p;
		
	END;					 

END;	