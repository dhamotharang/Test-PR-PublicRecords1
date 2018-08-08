IMPORT Codes;

EXPORT EFX_CORPEMPCD_TABLE := 
MODULE
	EXPORT VARSTRING CORPEMPCD(STRING code) :=
	  MAP(		
       code='A' => '1-4',
       code='B' => '5-9',
       code='C' => '10-19',
       code='D' => '20-49',
       code='E' => '50-99',
       code='F' => '100-249',
       code='G' => '250-499',
       code='H' => '500-999',
       code='I' => '1000-4999',
       code='J' => '5000-9999',
       code='K' => '10000+',       
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORPEMPCD' =>	CORPEMPCD(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CORPEMPCD',field_name in ['CORPEMPCD']
	),trans(LEFT));
	RETURN p;
		
	END;					 		 

END;	
