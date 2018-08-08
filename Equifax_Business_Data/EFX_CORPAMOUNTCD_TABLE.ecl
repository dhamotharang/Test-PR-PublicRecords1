IMPORT Codes;

EXPORT EFX_CORPAMOUNTCD_TABLE := 
MODULE
	EXPORT VARSTRING CORPAMOUNTCD(STRING code) :=
	  MAP(		
       code='A' => '1-499',
       code='B' => '500-999',
       code='C' => '1,000-2,499',
       code='D' => '2,500-4,999',
       code='E' => '5000-9999',
       code='F' => '10000-19999',
       code='G' => '20000-49999',
       code='H' => '50000-99999',
       code='I' => '100000-499999',
       code='J' => '500000-999999',
       code='K' => '1000000+',       
			 code='' => '',
			 'INVALID');	 
			 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORPAMOUNTCD' =>	CORPAMOUNTCD(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='CORPAMOUNTCD',field_name in ['CORPAMOUNTCD']
	),trans(LEFT));
	RETURN p;
		
	END;		

END;	