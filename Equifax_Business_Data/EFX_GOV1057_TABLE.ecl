IMPORT Codes;

EXPORT EFX_GOV1057_TABLE := 
MODULE
	EXPORT VARSTRING GOV1057(STRING code) :=
	  MAP(		
       code='U' => 'US Federal Government',
       code='S' => 'State/Local',       
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'GOV1057' =>	GOV1057(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='GOV1057',field_name in ['GOV1057']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	