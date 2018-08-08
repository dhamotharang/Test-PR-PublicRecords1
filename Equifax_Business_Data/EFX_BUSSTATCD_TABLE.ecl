IMPORT codes;

EXPORT EFX_BUSSTATCD_TABLE := 
MODULE
	EXPORT VARSTRING BUSSTATCD(STRING code) :=
	  MAP(		
       code='1' => 'Individual/Sole Proprietor',
       code='2' => 'Partnership',
       code='3' => 'Limited Partnership',
			 code='4' => 'Corporation',
       code='5' => 'Corporation, Subchapter S',
       code='6' => 'Limited Liability Company (LLC)',
       code='7' => 'Limited Liability Partnership (LLP)',
       code='8' => 'Other',
       code='9' => 'Corporation, Subchapter C',
       code='10' => 'Non-Profit',
       code='11' => 'Mutual Company',
       code='12' => 'Trust',
       code='13' => 'Limited Liability Limited Partnership (LLLP)',	
       code='' => '',
			 'INVALID');	 
			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'BUSSTATCD' =>	BUSSTATCD(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='BUSSTATCD',field_name in ['BUSSTATCD']
	),trans(LEFT));
	RETURN p;
		
	END;			 

END;	
