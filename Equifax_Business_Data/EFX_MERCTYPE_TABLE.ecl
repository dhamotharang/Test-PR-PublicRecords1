IMPORT Codes; 

EXPORT EFX_MERCTYPE_TABLE := 
MODULE
	EXPORT VARSTRING MERCTYPE(STRING code) :=
	  MAP(		
       code='F' => 'For Profit',
       code='N' => 'NonProfit',	
       code='U' => 'Federal Government',
       code='S' => 'State/Local Government',
       code='O' => 'Other/Foreign',
       'INVALID');       
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'MERCTYPE' =>	MERCTYPE(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='MERCTYPE',field_name in ['MERCTYPE']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;	