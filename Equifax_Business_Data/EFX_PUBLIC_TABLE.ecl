IMPORT Codes;

EXPORT EFX_PUBLIC_TABLE := 
MODULE
	EXPORT VARSTRING PUBLIC(STRING code) :=
	  MAP(		
       code='' => 'Unknown',	
			 code=' ' => 'Unknown',
       code='0' => 'Unknown',	
       code='1' => 'Public Company',	
       code='2' => 'Private Company',	
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'PUBLIC' =>	PUBLIC(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='PUBLIC',field_name in ['PUBLIC']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	