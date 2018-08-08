IMPORT Codes;

EXPORT EFX_MRKT_TOTALIND_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TOTALIND(STRING code) :=
	  MAP(		
       // code='M' => 'Marketable:  Indicates there\'s recent positive information indicating this business is still operating and can be marketed to, typically the phone number connectivity and/or address has been recently validated.',
       // code='A' => 'Active:  Indicates there\'s insufficient information to reliably determine if this business is still operating or not.',
       // code='OB' => 'Suspected Out Of Business / Non Marketable : Indicates there\'s sufficient information to determine this business is likely no longer operating, or at a minimum is not active.',      
       code='M' => 'Marketable',
       code='A' => 'Active',
			 code='OB' => 'Suspected Out Of Business',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'MRKT_TOTALIND' =>	MRKT_TOTALIND(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='MRKT_TOTALIND',field_name in ['MRKT_TOTALIND']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	